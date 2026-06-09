<#
.SYNOPSIS
Checks Confluence page-family source links against the tracked example manifest.

.DESCRIPTION
Runs read-only checks over config/confluence-pages.example.yml and docs/confluence-pages.
It verifies source paths, parentSlug references, missing manifest entries, and expected
Project Brain child artifacts.

.PARAMETER ConfigPath
Manifest path to inspect. Defaults to the tracked example manifest, not private config.

.PARAMETER RepoRoot
Repository root used to resolve source paths.

.PARAMETER WarnOnly
Return success even when error-level issues are found.
#>
[CmdletBinding()]
param(
    [string] $ConfigPath = ".\config\confluence-pages.example.yml",
    [string] $RepoRoot = ".",
    [switch] $WarnOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Read-ConfluencePageConfig {
    param([Parameter(Mandatory = $true)][string] $Path)

    $resolvedPath = Resolve-Path -LiteralPath $Path
    $spaceKey = $null
    $pages = @()
    $current = $null
    $currentList = $null

    foreach ($line in Get-Content -LiteralPath $resolvedPath) {
        $trimmed = $line.Trim()
        if ([string]::IsNullOrWhiteSpace($trimmed) -or $trimmed.StartsWith("#")) { continue }

        if ($trimmed -match "^spaceKey:\s*(.+)$") {
            $spaceKey = $Matches[1].Trim().Trim('"')
            continue
        }

        if ($trimmed -eq "pages:") { continue }

        if ($line -match "^\s{2}-\s+slug:\s*(.+)$") {
            if ($null -ne $current) { $pages += [pscustomobject] $current }
            $current = [ordered]@{
                slug = $Matches[1].Trim().Trim('"')
                labels = @()
            }
            $currentList = $null
            continue
        }

        if ($null -eq $current) { continue }

        if ($line -match "^\s{4}([A-Za-z][A-Za-z0-9]*):\s*(.*)$") {
            $key = $Matches[1]
            $value = $Matches[2].Trim()
            $currentList = $null
            if ($value -eq "null") { $current[$key] = $null }
            elseif ($value -eq "") {
                $current[$key] = if ($key -eq "labels") { @() } else { $null }
                $currentList = $key
            }
            else {
                $current[$key] = $value.Trim('"')
            }
            continue
        }

        if ($line -match "^\s{6}-\s+(.+)$" -and $currentList) {
            $current[$currentList] = @($current[$currentList]) + $Matches[1].Trim().Trim('"')
        }
    }

    if ($null -ne $current) { $pages += [pscustomobject] $current }

    return [pscustomobject]@{
        spaceKey = $spaceKey
        pages = $pages
    }
}

function Test-HasLabel {
    param(
        [Parameter(Mandatory = $true)][psobject] $Page,
        [Parameter(Mandatory = $true)][string] $Label
    )

    return @($Page.labels) -contains $Label
}

function Add-Issue {
    param(
        [System.Collections.Generic.List[object]] $Issues,
        [Parameter(Mandatory = $true)][string] $Severity,
        [Parameter(Mandatory = $true)][string] $Family,
        [Parameter(Mandatory = $true)][string] $Slug,
        [Parameter(Mandatory = $true)][string] $Issue,
        [Parameter(Mandatory = $true)][string] $Evidence
    )

    $Issues.Add([pscustomobject]@{
        severity = $Severity
        family = $Family
        slug = $Slug
        issue = $Issue
        evidence = $Evidence
    }) | Out-Null
}

function Get-ExpectedSourcePath {
    param([Parameter(Mandatory = $true)][string] $Slug)
    return "docs/confluence-pages/$Slug.md"
}

function Test-AnyChildMatches {
    param(
        [Parameter(Mandatory = $true)][object[]] $Children,
        [Parameter(Mandatory = $true)][scriptblock] $Predicate
    )

    foreach ($child in $Children) {
        if (& $Predicate $child) { return $true }
    }
    return $false
}

$resolvedRoot = Resolve-Path -LiteralPath $RepoRoot
$config = Read-ConfluencePageConfig -Path $ConfigPath
$pages = @($config.pages)
$issues = [System.Collections.Generic.List[object]]::new()

$bySlug = @{}
foreach ($page in $pages) {
    if ($bySlug.ContainsKey($page.slug)) {
        Add-Issue $issues "error" "(manifest)" $page.slug "Duplicate manifest slug." "Slug appears more than once in $ConfigPath."
        continue
    }
    $bySlug[$page.slug] = $page
}

$bySourcePath = @{}
foreach ($page in $pages) {
    if (-not $page.PSObject.Properties.Name.Contains("sourcePath") -or [string]::IsNullOrWhiteSpace($page.sourcePath)) {
        Add-Issue $issues "error" "(manifest)" $page.slug "Missing sourcePath." "Every published page entry must point at a repo source file."
        continue
    }

    $normalizedSourcePath = $page.sourcePath.Replace("\", "/")
    if ($bySourcePath.ContainsKey($normalizedSourcePath)) {
        Add-Issue $issues "error" "(manifest)" $page.slug "Duplicate sourcePath." "$normalizedSourcePath is also used by $($bySourcePath[$normalizedSourcePath])."
    }
    else {
        $bySourcePath[$normalizedSourcePath] = $page.slug
    }

    $absoluteSourcePath = Join-Path -Path $resolvedRoot -ChildPath $page.sourcePath
    if (-not (Test-Path -LiteralPath $absoluteSourcePath -PathType Leaf)) {
        Add-Issue $issues "error" "(manifest)" $page.slug "sourcePath does not exist." $page.sourcePath
    }

    $expectedPath = Get-ExpectedSourcePath -Slug $page.slug
    if ($normalizedSourcePath -ne $expectedPath) {
        Add-Issue $issues "warning" "(manifest)" $page.slug "sourcePath does not match slug convention." "Expected $expectedPath, found $normalizedSourcePath."
    }

    if ($page.PSObject.Properties.Name.Contains("parentSlug") -and -not [string]::IsNullOrWhiteSpace($page.parentSlug)) {
        if (-not $bySlug.ContainsKey($page.parentSlug)) {
            Add-Issue $issues "error" "(manifest)" $page.slug "parentSlug is not present in manifest." $page.parentSlug
        }
    }
}

$sourceFiles = Get-ChildItem -LiteralPath (Join-Path -Path $resolvedRoot -ChildPath "docs/confluence-pages") -Filter "*.md" -File
foreach ($sourceFile in $sourceFiles) {
    $relativePath = "docs/confluence-pages/$($sourceFile.Name)"
    if (-not $bySourcePath.ContainsKey($relativePath)) {
        Add-Issue $issues "warning" "(unparented)" $sourceFile.BaseName "Confluence source file is missing from manifest." $relativePath
    }
}

$projectBrains = $pages | Where-Object {
    (Test-HasLabel -Page $_ -Label "project-brain") -or ($_.slug -like "*-project-brain")
}

$requiredFamilyChecks = @(
    [pscustomobject]@{
        name = "agent design record"
        test = { param($page) (Test-HasLabel -Page $page -Label "agent-design-record") -or ($page.slug -like "*-agent-design-record") }
    },
    [pscustomobject]@{
        name = "knowledge source plan"
        test = { param($page) (Test-HasLabel -Page $page -Label "knowledge-source-plan") -or ($page.slug -like "*-knowledge-source-plan") }
    },
    [pscustomobject]@{
        name = "runtime or subagent settings"
        test = { param($page) (Test-HasLabel -Page $page -Label "subagent-settings") -or ($page.slug -like "*-subagent-settings") }
    },
    [pscustomobject]@{
        name = "setup or ROVO Studio configuration"
        test = { param($page) (Test-HasLabel -Page $page -Label "rovo-studio-configuration") -or (Test-HasLabel -Page $page -Label "agent-setup") -or ($page.slug -like "*-studio-setup") -or ($page.slug -like "*-rovo-studio-configuration") }
    },
    [pscustomobject]@{
        name = "evaluation"
        test = { param($page) (Test-HasLabel -Page $page -Label "agent-evaluation") -or ($page.slug -like "*-evaluation") }
    },
    [pscustomobject]@{
        name = "measurement plan"
        test = { param($page) (Test-HasLabel -Page $page -Label "agent-measurement") -or ($page.slug -like "*-measurement-plan") }
    },
    [pscustomobject]@{
        name = "change log"
        test = { param($page) (Test-HasLabel -Page $page -Label "agent-change-log") -or ($page.slug -like "*-change-log") }
    }
)

foreach ($brain in $projectBrains) {
    $children = @($pages | Where-Object {
        $_.PSObject.Properties.Name.Contains("parentSlug") -and $_.parentSlug -eq $brain.slug
    })

    if ($children.Count -eq 0) {
        Add-Issue $issues "error" $brain.slug $brain.slug "Project Brain has no linked child artifacts." "No manifest entries use parentSlug: $($brain.slug)."
        continue
    }

    foreach ($check in $requiredFamilyChecks) {
        if (-not (Test-AnyChildMatches -Children $children -Predicate $check.test)) {
            Add-Issue $issues "warning" $brain.slug $brain.slug "Project Brain family is missing $($check.name)." "No child page under $($brain.slug) matched the expected label or slug pattern."
        }
    }
}

Write-Output "# Confluence Page Family Consistency Check"
Write-Output ""
Write-Output "Config: $ConfigPath"
Write-Output "Pages checked: $($pages.Count)"
Write-Output "Project Brain families checked: $($projectBrains.Count)"
Write-Output "Issues found: $($issues.Count)"
Write-Output ""

if ($issues.Count -gt 0) {
    Write-Output "| Severity | Family | Slug | Issue | Evidence |"
    Write-Output "|---|---|---|---|---|"
    foreach ($issue in $issues) {
        Write-Output "| $($issue.severity) | $($issue.family) | $($issue.slug) | $($issue.issue) | $($issue.evidence) |"
    }
}
else {
    Write-Output "No consistency issues found."
}

$errorIssues = @($issues | Where-Object { $_.severity -eq "error" })
if ($errorIssues.Count -gt 0 -and -not $WarnOnly) {
    exit 1
}
