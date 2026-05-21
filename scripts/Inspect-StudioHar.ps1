[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string] $HarPath,

    [string] $OutPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-JsonProperty {
    param($Object, [Parameter(Mandatory = $true)][string] $Name)

    if ($Object -is [System.Collections.IDictionary]) {
        if (-not $Object.Contains($Name)) { return $null }
        return $Object[$Name]
    }
    if ($null -eq $Object -or $null -eq $Object.PSObject) { return $null }
    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property) { return $null }
    return $property.Value
}

function Get-RequestUrl {
    param($Entry)

    $request = Get-JsonProperty -Object $Entry -Name "request"
    $url = Get-JsonProperty -Object $request -Name "url"
    if ($null -eq $url) { return "" }
    return [string] $url
}

function Get-OperationName {
    param([string] $Text)

    if ([string]::IsNullOrWhiteSpace($Text)) { return $null }
    if ($Text -match '"operationName"\s*:\s*"([^"]+)"') { return $Matches[1] }
    return $null
}

function ConvertFrom-HarContentText {
    param($Content)

    $text = Get-JsonProperty -Object $Content -Name "text"
    if ([string]::IsNullOrWhiteSpace($text)) { return $null }

    $encoding = Get-JsonProperty -Object $Content -Name "encoding"
    if ($encoding -eq "base64") {
        $bytes = [Convert]::FromBase64String([string] $text)
        return [System.Text.Encoding]::UTF8.GetString($bytes)
    }

    if ($text.Length -ge 2 -and [int][char]$text[0] -eq 0x1f -and [int][char]$text[1] -eq 0x8b) {
        $bytes = [byte[]]::new($text.Length)
        for ($index = 0; $index -lt $text.Length; $index++) {
            $bytes[$index] = [byte]([int][char]$text[$index] -band 0xff)
        }

        $inputStream = [System.IO.MemoryStream]::new($bytes)
        $gzipStream = [System.IO.Compression.GzipStream]::new($inputStream, [System.IO.Compression.CompressionMode]::Decompress)
        $reader = [System.IO.StreamReader]::new($gzipStream, [System.Text.Encoding]::UTF8)
        try {
            return $reader.ReadToEnd()
        }
        finally {
            $reader.Dispose()
            $gzipStream.Dispose()
            $inputStream.Dispose()
        }
    }

    return [string] $text
}

$resolvedHarPath = Resolve-Path -LiteralPath $HarPath
$har = Get-Content -LiteralPath $resolvedHarPath -Raw | ConvertFrom-Json
$entries = Get-JsonProperty -Object (Get-JsonProperty -Object $har -Name "log") -Name "entries"

if ($null -eq $entries) {
    throw "Could not find log.entries in $HarPath"
}

$fieldPatterns = [ordered]@{
    agent = "agentStudio_agentById"
    scenarios = "agentStudio_scenarioListByContainerId"
    instructions = '"instructions"'
    invocationDescription = '"invocationDescription"'
    conversationStarters = '"conversationStarters"'
    knowledgeSources = '"knowledgeSources"'
    tools = '"tools"'
    webSearch = '"isWebSearchEnabled"'
    deepResearch = '"isDeepResearchEnabled"'
    description = '"description"'
}

$matchedEntries = @()
$candidateRequestsWithoutBodies = @()
$index = 0
foreach ($entry in @($entries)) {
    $index += 1
    $url = Get-RequestUrl -Entry $entry
    $request = Get-JsonProperty -Object $entry -Name "request"
    $method = Get-JsonProperty -Object $request -Name "method"
    $response = Get-JsonProperty -Object $entry -Name "response"
    $content = Get-JsonProperty -Object $response -Name "content"
    $text = ConvertFrom-HarContentText -Content $content
    if ([string]::IsNullOrWhiteSpace($text) -and $url -match "graphql|assist/rovo|operation=detailsQuery|operation=layout_mainQuery") {
        $candidateRequestsWithoutBodies += [pscustomobject]@{
            entry = $index
            method = $method
            status = Get-JsonProperty -Object $response -Name "status"
            mimeType = Get-JsonProperty -Object $content -Name "mimeType"
            url = $url
        }
    }

    if ([string]::IsNullOrWhiteSpace($text)) { continue }

    $fields = @()
    foreach ($name in $fieldPatterns.Keys) {
        if ($text -match [regex]::Escape($fieldPatterns[$name])) {
            $fields += $name
        }
    }

    if (@($fields).Count -eq 0) { continue }

    $matchedEntries += [pscustomobject]@{
        entry = $index
        fields = @($fields)
        operationName = Get-OperationName -Text $text
        url = $url
        responseBytes = $text.Length
    }
}

$summary = [pscustomobject]@{
    harPath = $resolvedHarPath.Path
    matchedEntryCount = @($matchedEntries).Count
    matches = @($matchedEntries)
    candidateRequestWithoutBodyCount = @($candidateRequestsWithoutBodies).Count
    candidateRequestsWithoutBodies = @($candidateRequestsWithoutBodies)
}

if (-not [string]::IsNullOrWhiteSpace($OutPath)) {
    $directory = Split-Path -Parent $OutPath
    if (-not [string]::IsNullOrWhiteSpace($directory)) {
        New-Item -ItemType Directory -Force -Path $directory | Out-Null
    }
    $summary | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $OutPath -Encoding UTF8
}

$summary | ConvertTo-Json -Depth 20
