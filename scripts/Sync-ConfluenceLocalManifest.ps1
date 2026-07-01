[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [string] $Slug,

    [string] $PublicConfigPath = ".\config\confluence-pages.example.yml",
    [string] $LocalConfigPath = ".\config\confluence-pages.yml"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Get-PageBlock {
    param(
        [Parameter(Mandatory = $true)][AllowEmptyString()][string[]] $Lines,
        [Parameter(Mandatory = $true)][string] $Slug
    )

    $escapedSlug = [regex]::Escape($Slug)
    $start = -1
    for ($index = 0; $index -lt $Lines.Count; $index++) {
        if ($Lines[$index] -match "^  - slug:\s*`"?$escapedSlug`"?\s*$") {
            $start = $index
            break
        }
    }

    if ($start -lt 0) {
        return $null
    }

    $end = $Lines.Count
    for ($index = $start + 1; $index -lt $Lines.Count; $index++) {
        if ($Lines[$index] -match "^  - slug:\s*") {
            $end = $index
            break
        }
    }

    return @($Lines[$start..($end - 1)])
}

if (-not (Test-Path -LiteralPath $PublicConfigPath)) {
    throw "Public config not found: $PublicConfigPath"
}

if (-not (Test-Path -LiteralPath $LocalConfigPath)) {
    throw "Local config not found: $LocalConfigPath. Copy the example config locally first, then rerun this script."
}

$publicLines = @(Get-Content -LiteralPath $PublicConfigPath)
$localLines = @(Get-Content -LiteralPath $LocalConfigPath)

$publicBlock = Get-PageBlock -Lines $publicLines -Slug $Slug
if ($null -eq $publicBlock -or @($publicBlock).Count -eq 0) {
    throw "Slug '$Slug' not found in $PublicConfigPath"
}
$publicBlock = @($publicBlock)

$localBlock = Get-PageBlock -Lines $localLines -Slug $Slug
if ($null -ne $localBlock -and @($localBlock).Count -gt 0) {
    [pscustomobject]@{
        status = "exists"
        slug = $Slug
        changed = $false
        localConfigPath = $LocalConfigPath
    } | ConvertTo-Json -Depth 5
    return
}

if (-not ($localLines | Where-Object { $_ -match "^pages:\s*$" })) {
    throw "Local config is missing a pages: section: $LocalConfigPath"
}

$newLines = New-Object System.Collections.Generic.List[string]
$newLines.AddRange([string[]] $localLines)
if ($newLines.Count -gt 0 -and -not [string]::IsNullOrWhiteSpace($newLines[$newLines.Count - 1])) {
    $newLines.Add("")
}
$newLines.AddRange([string[]] $publicBlock)

if ($PSCmdlet.ShouldProcess($LocalConfigPath, "Add Confluence page slug '$Slug' from public manifest")) {
    Set-Content -LiteralPath $LocalConfigPath -Value $newLines -Encoding UTF8
    $changed = $true
}
else {
    $changed = $false
}

[pscustomobject]@{
    status = if ($changed) { "added" } else { "planned" }
    slug = $Slug
    changed = $changed
    localConfigPath = $LocalConfigPath
} | ConvertTo-Json -Depth 5
