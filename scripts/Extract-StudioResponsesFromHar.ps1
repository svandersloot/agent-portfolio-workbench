[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string] $HarPath,

    [Parameter(Mandatory = $true)]
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

function Merge-StudioData {
    param(
        [Parameter(Mandatory = $true)] $Target,
        [Parameter(Mandatory = $true)] $Source
    )

    $data = Get-JsonProperty -Object $Source -Name "data"
    if ($null -eq $data) { return }

    foreach ($name in @("agentStudio_agentById", "agentStudio_scenarioListByContainerId")) {
        $value = Get-JsonProperty -Object $data -Name $name
        if ($null -ne $value) {
            $Target.data[$name] = $value
        }
    }
}

$resolvedHarPath = Resolve-Path -LiteralPath $HarPath
$har = Get-Content -LiteralPath $resolvedHarPath -Raw | ConvertFrom-Json
$entries = Get-JsonProperty -Object (Get-JsonProperty -Object $har -Name "log") -Name "entries"

if ($null -eq $entries) {
    throw "Could not find log.entries in $HarPath"
}

$combined = [ordered]@{
    data = [ordered]@{}
    source = [ordered]@{
        harPath = $resolvedHarPath.Path
        matchedEntryCount = 0
    }
}

foreach ($entry in @($entries)) {
    $response = Get-JsonProperty -Object $entry -Name "response"
    $content = Get-JsonProperty -Object $response -Name "content"
    $text = ConvertFrom-HarContentText -Content $content
    if ([string]::IsNullOrWhiteSpace($text)) { continue }
    if ($text -notmatch "agentStudio_agentById|agentStudio_scenarioListByContainerId") { continue }

    try {
        $payload = $text | ConvertFrom-Json
    }
    catch {
        continue
    }

    Merge-StudioData -Target $combined -Source $payload
    $combined.source.matchedEntryCount += 1
}

if ($null -eq (Get-JsonProperty -Object $combined.data -Name "agentStudio_agentById")) {
    throw "Could not find a Studio response containing agentStudio_agentById in $HarPath"
}

$directory = Split-Path -Parent $OutPath
if (-not [string]::IsNullOrWhiteSpace($directory)) {
    New-Item -ItemType Directory -Force -Path $directory | Out-Null
}

$combined | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $OutPath -Encoding UTF8

[ordered]@{
    outputPath = (Resolve-Path -LiteralPath $OutPath).Path
    matchedEntryCount = $combined.source.matchedEntryCount
    hasAgent = $null -ne (Get-JsonProperty -Object $combined.data -Name "agentStudio_agentById")
    hasScenarios = $null -ne (Get-JsonProperty -Object $combined.data -Name "agentStudio_scenarioListByContainerId")
} | ConvertTo-Json -Depth 4
