<#
.SYNOPSIS
Flags stale or superseded handoff packets using repo-local evidence.

.DESCRIPTION
Runs read-only checks over docs/handoffs. The check reports handoffs that are
explicitly superseded, missing a date signal, reference missing repo files, or
reference files with newer repo evidence than the handoff packet date.

.PARAMETER HandoffDir
Directory containing handoff Markdown files.

.PARAMETER RepoRoot
Repository root used to resolve referenced files.

.PARAMETER WarnOnly
Return success even when error-level issues are found.
#>
[CmdletBinding()]
param(
    [string] $HandoffDir = ".\docs\handoffs",
    [string] $RepoRoot = ".",
    [switch] $WarnOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function ConvertTo-RepoPath {
    param(
        [Parameter(Mandatory = $true)][string] $Path,
        [Parameter(Mandatory = $true)][string] $Root
    )

    $normalized = $Path.Trim().Trim("`"").Trim("'").Replace("\", "/")
    if ($normalized.StartsWith("./")) { $normalized = $normalized.Substring(2) }
    if ([string]::IsNullOrWhiteSpace($normalized)) { return $null }
    if ($normalized -match "^[a-z]+://" -or $normalized -match "^[A-Za-z]:/") { return $null }

    $absolute = Join-Path -Path $Root -ChildPath $normalized
    return [pscustomobject]@{
        relative = $normalized
        absolute = $absolute
    }
}

function Get-HandoffDate {
    param(
        [Parameter(Mandatory = $true)][System.IO.FileInfo] $File,
        [Parameter(Mandatory = $true)][string] $Content
    )

    if ($File.BaseName -match "(20\d{2}-\d{2}-\d{2})") {
        return [datetime]::ParseExact($Matches[1], "yyyy-MM-dd", $null)
    }

    $dateMatches = [regex]::Matches($Content, "(20\d{2}-\d{2}-\d{2})")
    if ($dateMatches.Count -gt 0) {
        $dates = @($dateMatches | ForEach-Object {
            [datetime]::ParseExact($_.Groups[1].Value, "yyyy-MM-dd", $null)
        } | Sort-Object)
        return $dates[-1]
    }

    return $null
}

function Get-ReferencedRepoPaths {
    param(
        [Parameter(Mandatory = $true)][string] $Content,
        [Parameter(Mandatory = $true)][string] $Root
    )

    $paths = [System.Collections.Generic.List[string]]::new()
    $patterns = @(
        '`([^`]+)`',
        '(?m)(?:^|\s)((?:docs|scripts|schemas|templates|config|agents|agent-portfolio-lab)/[A-Za-z0-9._/\-]+)'
    )

    foreach ($pattern in $patterns) {
        foreach ($match in [regex]::Matches($Content, $pattern)) {
            $candidate = $match.Groups[1].Value
            if ($candidate -notmatch "^(docs|scripts|schemas|templates|config|agents|agent-portfolio-lab)/") { continue }
            if ($candidate -match "[`r`n]") { continue }
            if ($candidate.EndsWith("/")) { continue }

            $repoPath = ConvertTo-RepoPath -Path $candidate -Root $Root
            if ($null -ne $repoPath -and -not $paths.Contains($repoPath.relative)) {
                $paths.Add($repoPath.relative) | Out-Null
            }
        }
    }

    return @($paths)
}

function Test-PrivateLocalReference {
    param([Parameter(Mandatory = $true)][string] $RelativePath)

    return $RelativePath -match '(^|/)\.env(\..+)?$' `
        -or $RelativePath -eq 'config/confluence-pages.yml' `
        -or $RelativePath -match '^data/raw/' `
        -or $RelativePath -match '\.har$'
}

function Get-RepoLastChangedDate {
    param(
        [Parameter(Mandatory = $true)][string] $RelativePath,
        [Parameter(Mandatory = $true)][string] $Root
    )

    $gitDate = $null
    $gitOutput = & git -C $Root log -1 --format=%cs -- $RelativePath 2>$null
    if ($LASTEXITCODE -eq 0 -and -not [string]::IsNullOrWhiteSpace($gitOutput)) {
        $gitDate = [datetime]::ParseExact($gitOutput.Trim(), "yyyy-MM-dd", $null)
    }

    if ($null -ne $gitDate) { return $gitDate }

    $absolute = Join-Path -Path $Root -ChildPath $RelativePath
    if (Test-Path -LiteralPath $absolute -PathType Leaf) {
        return (Get-Item -LiteralPath $absolute).LastWriteTime.Date
    }

    return $null
}

function Add-Issue {
    param(
        [System.Collections.Generic.List[object]] $Issues,
        [Parameter(Mandatory = $true)][string] $Severity,
        [Parameter(Mandatory = $true)][string] $Handoff,
        [Parameter(Mandatory = $true)][string] $Signal,
        [Parameter(Mandatory = $true)][string] $Evidence,
        [Parameter(Mandatory = $true)][string] $Recommendation
    )

    $Issues.Add([pscustomobject]@{
        severity = $Severity
        handoff = $Handoff
        signal = $Signal
        evidence = $Evidence
        recommendation = $Recommendation
    }) | Out-Null
}

$resolvedRoot = (Resolve-Path -LiteralPath $RepoRoot).Path
$resolvedHandoffDir = Resolve-Path -LiteralPath $HandoffDir
$handoffs = @(Get-ChildItem -LiteralPath $resolvedHandoffDir -Filter "*.md" -File | Sort-Object Name)
$issues = [System.Collections.Generic.List[object]]::new()

$datedByStem = @{}
foreach ($handoff in $handoffs) {
    if ($handoff.BaseName -match "^(.*?)-?(20\d{2}-\d{2}-\d{2})$") {
        $stem = $Matches[1]
        if (-not $datedByStem.ContainsKey($stem)) { $datedByStem[$stem] = @() }
        $datedByStem[$stem] = @($datedByStem[$stem]) + $handoff
    }
}

foreach ($stem in $datedByStem.Keys) {
    $versions = @($datedByStem[$stem] | Sort-Object Name)
    if ($versions.Count -le 1) { continue }

    $latest = $versions[-1].Name
    foreach ($old in $versions[0..($versions.Count - 2)]) {
        Add-Issue $issues "warning" $old.Name "Newer same-stem handoff exists." "$latest appears to supersede or refresh this packet." "Review the newer packet before using this one; do not delete the older handoff without a separate decision."
    }
}

foreach ($handoff in $handoffs) {
    $content = Get-Content -LiteralPath $handoff.FullName -Raw
    $handoffDate = Get-HandoffDate -File $handoff -Content $content
    $references = @(Get-ReferencedRepoPaths -Content $content -Root $resolvedRoot)

    if ($content -match '(?i)superseded by\s+(`?[^`.\r\n]+`?)') {
        Add-Issue $issues "warning" $handoff.Name "Explicit supersession marker." $Matches[0].Trim() "Use the superseding packet unless preserving this one as historical evidence."
    }
    elseif ($content -match '(?i)\bsuperseded on\s+(20\d{2}-\d{2}-\d{2})') {
        Add-Issue $issues "warning" $handoff.Name "Explicit superseded date." $Matches[0].Trim() "Use only as historical context unless a newer decision reopens it."
    }

    if ($null -eq $handoffDate) {
        Add-Issue $issues "warning" $handoff.Name "No handoff date found." "No YYYY-MM-DD in filename or body." "Add a reviewed date or regenerate the handoff before relying on it."
    }

    foreach ($relativePath in $references) {
        if (Test-PrivateLocalReference -RelativePath $relativePath) { continue }

        $absolute = Join-Path -Path $resolvedRoot -ChildPath $relativePath
        if (-not (Test-Path -LiteralPath $absolute)) {
            Add-Issue $issues "error" $handoff.Name "Referenced file is missing." $relativePath "Update the handoff reference or document that the artifact moved."
            continue
        }
        if (-not (Test-Path -LiteralPath $absolute -PathType Leaf)) { continue }

        if ($null -ne $handoffDate) {
            $lastChanged = Get-RepoLastChangedDate -RelativePath $relativePath -Root $resolvedRoot
            if ($null -ne $lastChanged -and $lastChanged.Date -gt $handoffDate.Date) {
                Add-Issue $issues "warning" $handoff.Name "Referenced file is newer than handoff date." "$relativePath changed $($lastChanged.ToString('yyyy-MM-dd')); handoff date is $($handoffDate.ToString('yyyy-MM-dd'))." "Re-read the referenced file before executing the handoff; refresh or supersede the packet if behavior changed."
            }
        }
    }
}

Write-Output "# Stale Handoff Check"
Write-Output ""
Write-Output "Handoff directory: $HandoffDir"
Write-Output "Handoffs checked: $($handoffs.Count)"
Write-Output "Issues found: $($issues.Count)"
Write-Output ""

if ($issues.Count -gt 0) {
    Write-Output "| Severity | Handoff | Signal | Evidence | Recommendation |"
    Write-Output "|---|---|---|---|---|"
    foreach ($issue in $issues) {
        Write-Output "| $($issue.severity) | $($issue.handoff) | $($issue.signal) | $($issue.evidence) | $($issue.recommendation) |"
    }
}
else {
    Write-Output "No stale handoff signals found."
}

$errorIssues = @($issues | Where-Object { $_.severity -eq "error" })
if ($errorIssues.Count -gt 0 -and -not $WarnOnly) {
    exit 1
}
