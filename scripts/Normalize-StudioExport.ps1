[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string] $RawPath,

    [string] $OutDir = ".\agents",

    [switch] $IncludeStableIds
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function ConvertTo-Slug {
    param([Parameter(Mandatory = $true)][string] $Value)

    $slug = $Value.ToLowerInvariant()
    $slug = $slug -replace "[^a-z0-9]+", "-"
    $slug = $slug.Trim("-")
    if ([string]::IsNullOrWhiteSpace($slug)) {
        return "unnamed-agent"
    }
    return $slug
}

function ConvertTo-YamlScalar {
    param([AllowNull()] $Value)

    if ($null -eq $Value) { return "null" }
    if ($Value -is [bool]) { return $Value.ToString().ToLowerInvariant() }
    $text = [string] $Value
    if ($text -eq "") { return "''" }
    if ($text -match "^[A-Za-z0-9_./:-]+$") { return $text }
    return "'" + ($text -replace "'", "''") + "'"
}

function Get-StableReference {
    param([AllowNull()][string] $Value)

    if ([string]::IsNullOrWhiteSpace($Value)) { return $null }
    if ($Value -match "space/([^/:]+)$") { return "space/$($Matches[1])" }
    if ($Value -match "project/([^/:]+)$") { return "project/$($Matches[1])" }
    if ($Value -match "page/([^/:]+)$") { return "page/$($Matches[1])" }
    return $Value
}

function ConvertTo-FilterSummary {
    param([AllowNull()] $Filters)

    $summary = [ordered]@{}
    if ($null -eq $Filters) { return $summary }

    foreach ($property in $Filters.PSObject.Properties) {
        if ($property.Name -like "__*") { continue }
        $value = $property.Value
        if ($null -eq $value) {
            $summary[$property.Name] = $null
            continue
        }

        if ($value -is [System.Array]) {
            $items = @()
            foreach ($item in $value) {
                $stable = Get-StableReference -Value ([string] $item)
                if ($IncludeStableIds -and $stable) {
                    $items += $stable
                }
                elseif ($stable) {
                    $items += ($stable -replace "/.+$", "/<redacted>")
                }
            }
            $summary[$property.Name] = $items
            continue
        }

        $summary[$property.Name] = [string] $value
    }

    return $summary
}

function ConvertTo-KnowledgeSources {
    param([AllowNull()] $KnowledgeSources)

    $sources = @()
    if ($null -ne $KnowledgeSources -and $null -ne $KnowledgeSources.sources) {
        foreach ($source in $KnowledgeSources.sources) {
            $sources += [ordered]@{
                source = [string] $source.source
                enabled = Get-JsonProperty -Object $source -Name "enabled"
                resourceType = Get-JsonProperty -Object $source -Name "resourceType"
                filters = ConvertTo-FilterSummary -Filters (Get-JsonProperty -Object $source -Name "filters")
            }
        }
    }

    return [ordered]@{
        enabled = if ($null -eq $KnowledgeSources) { $null } else { Get-JsonProperty -Object $KnowledgeSources -Name "enabled" }
        sources = @($sources)
    }
}

function Get-ToolRiskTier {
    param([AllowNull()][string] $DisplayName, [AllowNull()][string] $Description)

    $combined = (($DisplayName, $Description) -join " ").ToLowerInvariant()
    if ($combined -match "\b(delete|remove|update|edit|create|send|approve|transition|merge|write|publish)\b") {
        return "high"
    }
    if ($combined -match "\b(get|find|search|read|view|lookup)\b") {
        return "low"
    }
    return "unknown"
}

function ConvertTo-Tools {
    param([AllowNull()] $Tools)

    $items = @()
    if ($null -eq $Tools) { return $items }

    foreach ($tool in $Tools) {
        $displayName = [string] $tool.displayName
        $description = if ($null -eq $tool.description) { $null } else { [string] $tool.description }
        $item = [ordered]@{
            displayName = $displayName
            definitionSource = $tool.definitionSource
            configured = $tool.configured
            riskTier = Get-ToolRiskTier -DisplayName $displayName -Description $description
            description = $description
        }
        if ($IncludeStableIds) {
            $item.definitionId = $tool.definitionId
        }
        $items += $item
    }

    return @($items)
}

function Get-JsonProperty {
    param($Object, [Parameter(Mandatory = $true)][string] $Name)

    if ($null -eq $Object -or $null -eq $Object.PSObject) { return $null }
    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property) { return $null }
    return $property.Value
}

function Get-FirstJsonProperty {
    param($Object, [Parameter(Mandatory = $true)][string[]] $Names)

    foreach ($name in $Names) {
        $value = Get-JsonProperty -Object $Object -Name $name
        if ($null -ne $value) { return $value }
    }

    return $null
}

function Write-SimpleYaml {
    param(
        [Parameter(Mandatory = $true)] $Value,
        [Parameter(Mandatory = $true)][string] $Path
    )

    function Write-Node {
        param($Node, [int] $Indent = 0)

        $prefix = " " * $Indent
        if ($null -eq $Node) {
            return @("${prefix}null")
        }

        if ($Node -is [System.Collections.IDictionary]) {
            $lines = @()
            foreach ($key in $Node.Keys) {
                $child = $Node[$key]
                if ($child -is [System.Collections.IDictionary] -or $child -is [System.Array]) {
                    $lines += "${prefix}${key}:"
                    $lines += Write-Node -Node $child -Indent ($Indent + 2)
                }
                else {
                    $lines += "${prefix}${key}: $(ConvertTo-YamlScalar $child)"
                }
            }
            return $lines
        }

        if ($Node -is [System.Array]) {
            if ($Node.Count -eq 0) { return @("${prefix}[]") }
            $lines = @()
            foreach ($item in $Node) {
                if ($item -is [System.Collections.IDictionary]) {
                    $first = $true
                    foreach ($key in $item.Keys) {
                        $child = $item[$key]
                        if ($first) {
                            if ($child -is [System.Collections.IDictionary] -or $child -is [System.Array]) {
                                $lines += "${prefix}- ${key}:"
                                $lines += Write-Node -Node $child -Indent ($Indent + 4)
                            }
                            else {
                                $lines += "${prefix}- ${key}: $(ConvertTo-YamlScalar $child)"
                            }
                            $first = $false
                        }
                        else {
                            if ($child -is [System.Collections.IDictionary] -or $child -is [System.Array]) {
                                $lines += "$(" " * ($Indent + 2))${key}:"
                                $lines += Write-Node -Node $child -Indent ($Indent + 4)
                            }
                            else {
                                $lines += "$(" " * ($Indent + 2))${key}: $(ConvertTo-YamlScalar $child)"
                            }
                        }
                    }
                }
                else {
                    $lines += "${prefix}- $(ConvertTo-YamlScalar $item)"
                }
            }
            return $lines
        }

        return @("${prefix}$(ConvertTo-YamlScalar $Node)")
    }

    $directory = Split-Path -Parent $Path
    if (-not [string]::IsNullOrWhiteSpace($directory)) {
        New-Item -ItemType Directory -Force -Path $directory | Out-Null
    }
    Set-Content -LiteralPath $Path -Value (Write-Node -Node $Value) -Encoding UTF8
}

function Write-Markdown {
    param(
        [Parameter(Mandatory = $true)][string] $Path,
        [Parameter(Mandatory = $true)][string] $Content
    )

    $directory = Split-Path -Parent $Path
    New-Item -ItemType Directory -Force -Path $directory | Out-Null
    Set-Content -LiteralPath $Path -Value $Content.TrimEnd() -Encoding UTF8
}

function Find-StudioPayload {
    param([Parameter(Mandatory = $true)] $Json)

    if ($Json -is [System.Array]) {
        for ($index = $Json.Count - 1; $index -ge 0; $index--) {
            $candidate = Find-StudioPayload -Json $Json[$index]
            if ($null -ne $candidate) { return $candidate }
        }
        return $null
    }

    if ($Json -is [string]) {
        if ($Json -notmatch "agentStudio_agentById") { return $null }
        try {
            return Find-StudioPayload -Json ($Json | ConvertFrom-Json)
        }
        catch {
            return $null
        }
    }

    $data = Get-JsonProperty -Object $Json -Name "data"
    if ($null -ne $data -and $null -ne (Get-JsonProperty -Object $data -Name "agentStudio_agentById")) {
        return $Json
    }

    $text = Get-JsonProperty -Object $Json -Name "text"
    if ($null -ne $text) {
        try {
            return Find-StudioPayload -Json ($text | ConvertFrom-Json)
        }
        catch {
            return $null
        }
    }

    $response = Get-JsonProperty -Object $Json -Name "response"
    $content = Get-JsonProperty -Object $response -Name "content"
    $responseText = Get-JsonProperty -Object $content -Name "text"
    if ($null -ne $responseText) {
        $candidate = Find-StudioPayload -Json ([string] $responseText)
        if ($null -ne $candidate) { return $candidate }
    }

    $log = Get-JsonProperty -Object $Json -Name "log"
    $entries = Get-JsonProperty -Object $log -Name "entries"
    if ($null -ne $entries) {
        return Find-StudioPayload -Json @($entries)
    }

    if ($Json -is [pscustomobject]) {
        foreach ($property in $Json.PSObject.Properties) {
            if ($property.Name -like "__*") { continue }
            $value = $property.Value
            if ($null -eq $value) { continue }
            if ($value -is [string] -and $value -notmatch "agentStudio_agentById") { continue }
            $candidate = Find-StudioPayload -Json $value
            if ($null -ne $candidate) { return $candidate }
        }
    }

    return $null
}

$resolvedRawPath = Resolve-Path -LiteralPath $RawPath
$raw = Get-Content -LiteralPath $resolvedRawPath -Raw | ConvertFrom-Json
$payload = Find-StudioPayload -Json $raw

if ($null -eq $payload) {
    throw "Could not find data.agentStudio_agentById in $RawPath"
}

$agent = $payload.data.agentStudio_agentById

$missingAgentFields = @()
foreach ($field in @("description", "instructions", "conversationStarters", "knowledgeSources")) {
    if ($null -eq $agent.PSObject.Properties[$field]) {
        $missingAgentFields += $field
    }
}

if (@($missingAgentFields).Count -gt 0) {
    throw @"
The Studio response in $RawPath contains agentStudio_agentById, but it is only a partial agent shell.
Missing fields: $($missingAgentFields -join ", ")

Capture a fuller GraphQL response that includes agent instructions/configuration, or export a HAR with response bodies and run scripts/Extract-StudioResponsesFromHar.ps1.
"@
}

$scenarioEdges = @()
if ($null -ne $payload.data.agentStudio_scenarioListByContainerId -and $null -ne $payload.data.agentStudio_scenarioListByContainerId.edges) {
    $scenarioEdges = @($payload.data.agentStudio_scenarioListByContainerId.edges)
}

$slug = ConvertTo-Slug -Value ([string] $agent.name)
$agentDir = Join-Path $OutDir $slug
$subagentDir = Join-Path $agentDir "subagents"
New-Item -ItemType Directory -Force -Path $subagentDir | Out-Null

$subagents = @()
foreach ($edge in $scenarioEdges) {
    $node = $edge.node
    $nodeTools = Get-FirstJsonProperty -Object $node -Names @("tools", "actions")
    $subagents += [ordered]@{
        name = [string] $node.name
        slug = ConvertTo-Slug -Value ([string] $node.name)
        active = [bool] $node.isActive
        default = [bool] $node.isDefault
        webSearchEnabled = Get-JsonProperty -Object $node -Name "isWebSearchEnabled"
        deepResearchEnabled = Get-JsonProperty -Object $node -Name "isDeepResearchEnabled"
        invocationDescriptionCaptured = $null -ne (Get-JsonProperty -Object $node -Name "invocationDescription")
        instructionsCaptured = $null -ne (Get-JsonProperty -Object $node -Name "instructions")
        knowledgeSources = ConvertTo-KnowledgeSources -KnowledgeSources (Get-JsonProperty -Object $node -Name "knowledgeSources")
        tools = @(ConvertTo-Tools -Tools $nodeTools)
    }
}

$agentTools = Get-FirstJsonProperty -Object $agent -Names @("tools", "actions")

$normalized = [ordered]@{
    schemaVersion = 1
    name = [string] $agent.name
    slug = $slug
    description = [string] $agent.description
    isPublished = Get-JsonProperty -Object $agent -Name "isPublished"
    responseStrategy = Get-JsonProperty -Object $agent -Name "responseStrategy"
    conversationStarters = @($agent.conversationStarters)
    parent = [ordered]@{
        webSearchEnabled = Get-JsonProperty -Object $agent -Name "isWebSearchEnabled"
        deepResearchEnabled = Get-JsonProperty -Object $agent -Name "isDeepResearchEnabled"
        knowledgeSources = ConvertTo-KnowledgeSources -KnowledgeSources $agent.knowledgeSources
        tools = @(ConvertTo-Tools -Tools $agentTools)
    }
    subagents = $subagents
    captureNotes = [ordered]@{
        parentToolsCaptured = $null -ne $agentTools
        subagentInstructionsMayRequireSeparateCapture = $true
    }
}

Write-SimpleYaml -Value $normalized -Path (Join-Path $agentDir "agent.yml")
Write-SimpleYaml -Value $normalized.parent.knowledgeSources -Path (Join-Path $agentDir "knowledge-sources.yml")
Write-SimpleYaml -Value $normalized.parent.tools -Path (Join-Path $agentDir "tools.yml")
Write-SimpleYaml -Value $subagents -Path (Join-Path $agentDir "subagents.yml")

Write-Markdown -Path (Join-Path $agentDir "parent-instructions.md") -Content "# Parent Instructions`n`n$($agent.instructions)"
Write-Markdown -Path (Join-Path $agentDir "conversation-starters.md") -Content ("# Conversation Starters`n`n" + (($agent.conversationStarters | ForEach-Object { "- $_" }) -join "`n"))

foreach ($edge in $scenarioEdges) {
    $node = $edge.node
    $scenarioSlug = ConvertTo-Slug -Value ([string] $node.name)
    $frontMatter = [ordered]@{
        name = [string] $node.name
        active = [bool] $node.isActive
        default = [bool] $node.isDefault
        studioType = "scenario"
        webSearchEnabled = Get-JsonProperty -Object $node -Name "isWebSearchEnabled"
        deepResearchEnabled = Get-JsonProperty -Object $node -Name "isDeepResearchEnabled"
        invocationDescriptionCaptured = $null -ne (Get-JsonProperty -Object $node -Name "invocationDescription")
        instructionsCaptured = $null -ne (Get-JsonProperty -Object $node -Name "instructions")
    }
    $frontMatterPath = Join-Path $subagentDir "$scenarioSlug.meta.yml"
    Write-SimpleYaml -Value $frontMatter -Path $frontMatterPath

    $tools = @(ConvertTo-Tools -Tools (Get-FirstJsonProperty -Object $node -Names @("tools", "actions")))
    $toolLines = if (@($tools).Count -eq 0) { "_None captured._" } else { ($tools | ForEach-Object { "- $($_.displayName) ($($_.riskTier))" }) -join "`n" }
    $knowledge = ConvertTo-KnowledgeSources -KnowledgeSources (Get-JsonProperty -Object $node -Name "knowledgeSources")
    $knowledgeLines = if (@($knowledge.sources).Count -eq 0) { "_None captured._" } else { (@($knowledge.sources) | ForEach-Object { "- $($_.source), enabled=$($_.enabled)" }) -join "`n" }
    $invocationDescription = Get-JsonProperty -Object $node -Name "invocationDescription"
    $instructions = Get-JsonProperty -Object $node -Name "instructions"
    $instructionText = if ($null -eq $instructions) { "_Not captured in this Studio response._" } else { [string] $instructions }

    $content = @"
# $($node.name)

## Invocation

$invocationDescription

## Instructions

$instructionText

## Knowledge Sources

$knowledgeLines

## Tools

$toolLines
"@
    Write-Markdown -Path (Join-Path $subagentDir "$scenarioSlug.md") -Content $content
}

$summary = [ordered]@{
    agent = [string] $agent.name
    slug = $slug
    outputDirectory = (Resolve-Path -LiteralPath $agentDir).Path
    subagentCount = @($subagents).Count
    parentToolCount = @($normalized.parent.tools).Count
    parentKnowledgeSourceCount = @($normalized.parent.knowledgeSources.sources).Count
}

$summary | ConvertTo-Json -Depth 6
