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
                enabled = $source.enabled
                resourceType = $source.resourceType
                filters = ConvertTo-FilterSummary -Filters $source.filters
            }
        }
    }

    return [ordered]@{
        enabled = if ($null -eq $KnowledgeSources) { $null } else { $KnowledgeSources.enabled }
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

    if ($null -ne $Json.data -and $null -ne $Json.data.agentStudio_agentById) {
        return $Json
    }

    if ($null -ne $Json.text) {
        try {
            return Find-StudioPayload -Json ($Json.text | ConvertFrom-Json)
        }
        catch {
            return $null
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
    $subagents += [ordered]@{
        name = [string] $node.name
        slug = ConvertTo-Slug -Value ([string] $node.name)
        active = [bool] $node.isActive
        default = [bool] $node.isDefault
        webSearchEnabled = $node.isWebSearchEnabled
        deepResearchEnabled = $node.isDeepResearchEnabled
        knowledgeSources = ConvertTo-KnowledgeSources -KnowledgeSources $node.knowledgeSources
        tools = @(ConvertTo-Tools -Tools $node.tools)
    }
}

$normalized = [ordered]@{
    schemaVersion = 1
    name = [string] $agent.name
    slug = $slug
    description = [string] $agent.description
    isPublished = $agent.isPublished
    responseStrategy = $agent.responseStrategy
    conversationStarters = @($agent.conversationStarters)
    parent = [ordered]@{
        webSearchEnabled = $agent.isWebSearchEnabled
        deepResearchEnabled = $agent.isDeepResearchEnabled
        knowledgeSources = ConvertTo-KnowledgeSources -KnowledgeSources $agent.knowledgeSources
        tools = @(ConvertTo-Tools -Tools $agent.tools)
    }
    subagents = $subagents
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
        webSearchEnabled = $node.isWebSearchEnabled
        deepResearchEnabled = $node.isDeepResearchEnabled
    }
    $frontMatterPath = Join-Path $subagentDir "$scenarioSlug.meta.yml"
    Write-SimpleYaml -Value $frontMatter -Path $frontMatterPath

    $tools = @(ConvertTo-Tools -Tools $node.tools)
    $toolLines = if (@($tools).Count -eq 0) { "_None captured._" } else { ($tools | ForEach-Object { "- $($_.displayName) ($($_.riskTier))" }) -join "`n" }
    $knowledge = ConvertTo-KnowledgeSources -KnowledgeSources $node.knowledgeSources
    $knowledgeLines = if (@($knowledge.sources).Count -eq 0) { "_None captured._" } else { (@($knowledge.sources) | ForEach-Object { "- $($_.source), enabled=$($_.enabled)" }) -join "`n" }

    $content = @"
# $($node.name)

## Invocation

$($node.invocationDescription)

## Instructions

$($node.instructions)

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
