<#
.SYNOPSIS
Scans tracked or candidate commit files for secrets and private-data hazards.

.DESCRIPTION
Runs a repo-only, read-only scan over candidate commit files by default. Candidate
files include staged, unstaged, and untracked non-ignored files. Use -Scope AllTracked
to audit all tracked files.

.PARAMETER Scope
Candidate scans pending commit files. AllTracked scans files already tracked by Git.

.PARAMETER RepoRoot
Repository root used for Git and path resolution.

.PARAMETER WarnOnly
Return success even when high-risk findings are found.
#>
[CmdletBinding()]
param(
    [ValidateSet("Candidate", "AllTracked")]
    [string] $Scope = "Candidate",
    [string] $RepoRoot = ".",
    [switch] $WarnOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Add-Finding {
    param(
        [System.Collections.Generic.List[object]] $Findings,
        [Parameter(Mandatory = $true)][string] $Severity,
        [Parameter(Mandatory = $true)][string] $Path,
        [Parameter(Mandatory = $true)][string] $Signal,
        [Parameter(Mandatory = $true)][string] $Evidence,
        [Parameter(Mandatory = $true)][string] $Recommendation
    )

    $Findings.Add([pscustomobject]@{
        severity = $Severity
        path = $Path
        signal = $Signal
        evidence = $Evidence
        recommendation = $Recommendation
    }) | Out-Null
}

function Get-CandidateFiles {
    param([Parameter(Mandatory = $true)][string] $Root)

    $files = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    $commands = @(
        @("diff", "--name-only", "--diff-filter=ACMRT", "--cached"),
        @("diff", "--name-only", "--diff-filter=ACMRT"),
        @("ls-files", "--others", "--exclude-standard")
    )

    foreach ($args in $commands) {
        $output = & git -C $Root @args
        if ($LASTEXITCODE -ne 0) { throw "git $($args -join ' ') failed." }
        foreach ($line in $output) {
            if (-not [string]::IsNullOrWhiteSpace($line)) {
                $files.Add($line.Trim().Replace("\", "/")) | Out-Null
            }
        }
    }

    return @($files | Sort-Object)
}

function Get-StagedFiles {
    param([Parameter(Mandatory = $true)][string] $Root)

    $output = & git -C $Root diff --name-only --diff-filter=ACMRT --cached
    if ($LASTEXITCODE -ne 0) { throw "git diff --name-only --cached failed." }
    return @($output | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | ForEach-Object { $_.Trim().Replace("\", "/") } | Sort-Object)
}

function Get-TrackedFiles {
    param([Parameter(Mandatory = $true)][string] $Root)

    $output = & git -C $Root ls-files
    if ($LASTEXITCODE -ne 0) { throw "git ls-files failed." }
    return @($output | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | ForEach-Object { $_.Trim().Replace("\", "/") } | Sort-Object)
}

function Test-BinaryFile {
    param([Parameter(Mandatory = $true)][string] $Path)

    $bytes = [System.IO.File]::ReadAllBytes($Path)
    $sampleLength = [Math]::Min($bytes.Length, 4096)
    for ($i = 0; $i -lt $sampleLength; $i++) {
        if ($bytes[$i] -eq 0) { return $true }
    }
    return $false
}

function Test-TextContent {
    param(
        [System.Collections.Generic.List[object]] $Findings,
        [Parameter(Mandatory = $true)][string] $Path,
        [Parameter(Mandatory = $true)][string] $Content,
        [object[]] $Patterns,
        [Parameter(Mandatory = $true)][string] $Recommendation
    )

    foreach ($entry in $Patterns) {
        $matches = @([regex]::Matches($Content, $entry.pattern))
        if ($matches.Count -eq 0) { continue }

        $first = $matches[0].Value
        if ($first.Length -gt 120) { $first = $first.Substring(0, 120) + "..." }
        Add-Finding $Findings $entry.severity $Path $entry.signal $first.Trim() $Recommendation
    }
}

$resolvedRoot = (Resolve-Path -LiteralPath $RepoRoot).Path
$findings = [System.Collections.Generic.List[object]]::new()

$files = @(if ($Scope -eq "AllTracked") {
    Get-TrackedFiles -Root $resolvedRoot
}
else {
    Get-CandidateFiles -Root $resolvedRoot
})
$stagedFiles = if ($Scope -eq "Candidate") { @(Get-StagedFiles -Root $resolvedRoot) } else { @() }

$forbiddenPathPatterns = @(
    @{ pattern = '(^|/)\.env(\..+)?$'; allow = '(^|/)\.env\.example$'; signal = 'Environment file must not be committed.' },
    @{ pattern = '^config/confluence-pages\.yml$'; signal = 'Private Confluence page manifest must not be committed.' },
    @{ pattern = '^data/raw/'; signal = 'Raw Studio capture path must not be committed.' },
    @{ pattern = '\.har$'; signal = 'HAR file can contain cookies, headers, tokens, or private URLs.' },
    @{ pattern = '(^|/)(cookies?|headers?|tokens?|secrets?|auth)[^/]*\.(json|txt|csv|md|yml|yaml)$'; signal = 'Filename suggests private auth or session material.' },
    @{ pattern = '(^|/)(raw|export|unsanitized)[^/]*\.(json|csv|zip)$'; signal = 'Filename suggests raw or unsanitized export material.' }
)

$contentPatterns = @(
    @{ severity = 'error'; pattern = '(?im)^\s*authorization\s*:\s*bearer\s+(?!<|redacted|REDACTED)[A-Za-z0-9._~+/=-]{20,}'; signal = 'Bearer authorization header.' },
    @{ severity = 'error'; pattern = '(?im)^\s*(cookie|set-cookie)\s*:\s*(?!<|redacted|REDACTED).{20,}'; signal = 'Cookie header.' },
    @{ severity = 'error'; pattern = '(?i)\bAKIA[0-9A-Z]{16}\b'; signal = 'AWS access key pattern.' },
    @{ severity = 'error'; pattern = '(?i)\beyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\b'; signal = 'JWT-like token.' },
    @{ severity = 'error'; pattern = '(?im)^\s*(api[_-]?token|access[_-]?token|refresh[_-]?token|client[_-]?secret|password|passwd|private[_-]?key|secret)\s*[:=]\s*["'']?(?!<|redacted|REDACTED|example|changeme|placeholder)[^"''\s]{12,}'; signal = 'Secret-looking assignment.' },
    @{ severity = 'warning'; pattern = '(?i)https://[A-Za-z0-9.-]*atlassian\.net/[^\s)<>"'']+'; signal = 'Atlassian URL; verify it is approved for repo-backed docs.' },
    @{ severity = 'warning'; pattern = '(?im)^\s*(x-[A-Za-z0-9_-]*token|x-[A-Za-z0-9_-]*auth[A-Za-z0-9_-]*)\s*:\s*(?!<|redacted|REDACTED).{12,}'; signal = 'Auth-related header.' }
)

foreach ($relativePath in $files) {
    $normalizedPath = $relativePath.Replace("\", "/")
    foreach ($entry in $forbiddenPathPatterns) {
        $allowed = $entry.ContainsKey("allow") -and $normalizedPath -match $entry.allow
        if (-not $allowed -and $normalizedPath -match $entry.pattern) {
            Add-Finding $findings "error" $normalizedPath $entry.signal "Path matched $($entry.pattern)." "Remove this file from the commit slice and keep sanitized derivatives only."
        }
    }

    $absolutePath = Join-Path -Path $resolvedRoot -ChildPath $relativePath
    if (-not (Test-Path -LiteralPath $absolutePath -PathType Leaf)) { continue }
    if (Test-BinaryFile -Path $absolutePath) {
        Add-Finding $findings "warning" $normalizedPath "Binary or non-text file skipped." "Content was not scanned." "Manually verify the file is sanitized before committing."
        continue
    }

    $content = Get-Content -LiteralPath $absolutePath -Raw
    Test-TextContent $findings $normalizedPath $content $contentPatterns "Redact, remove, or move the private value to ignored local config before committing."

    if ($Scope -eq "Candidate" -and $stagedFiles -contains $normalizedPath) {
        $stagedContent = & git -C $resolvedRoot show ":$normalizedPath" 2>$null
        if ($LASTEXITCODE -eq 0 -and $null -ne $stagedContent) {
            Test-TextContent $findings "$normalizedPath (staged)" ($stagedContent -join "`n") $contentPatterns "Unstage, redact, and restage the sanitized content before committing."
        }
    }
}

Write-Output "# Private Data Commit Scan"
Write-Output ""
Write-Output "Scope: $Scope"
Write-Output "Files checked: $($files.Count)"
Write-Output "Findings: $($findings.Count)"
Write-Output ""

if ($findings.Count -gt 0) {
    Write-Output "| Severity | Path | Signal | Evidence | Recommendation |"
    Write-Output "|---|---|---|---|---|"
    foreach ($finding in $findings) {
        Write-Output "| $($finding.severity) | $($finding.path) | $($finding.signal) | $($finding.evidence.Replace('|', '\|')) | $($finding.recommendation) |"
    }
}
else {
    Write-Output "No private-data findings found."
}

$blockingFindings = @($findings | Where-Object { $_.severity -eq "error" })
if ($blockingFindings.Count -gt 0 -and -not $WarnOnly) {
    exit 1
}
