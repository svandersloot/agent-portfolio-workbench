<#
.SYNOPSIS
Confirms the named source inputs for the repo-only governance reports are present.

.DESCRIPTION
Read-only preflight for the governance report generation process
(docs/reports/governance-report-generation-process.md). For each report
(completeness, duplicate, snapshot) it lists the named source inputs and whether
each is present. It performs no writes, calls no live system, and runs no git,
Confluence, Studio, or Jira command. Required inputs that are missing produce an
error-level result; optional inputs (such as normalized Studio captures) are
reported but never fail the run.

.PARAMETER Report
Limit the check to one report: completeness, duplicate, or snapshot. Defaults to all.

.PARAMETER RepoRoot
Repository root used to resolve input paths.

.PARAMETER WarnOnly
Return success even when a required input is missing.

.EXAMPLE
.\scripts\Test-GovernanceReportInputs.ps1

.EXAMPLE
.\scripts\Test-GovernanceReportInputs.ps1 -Report snapshot -WarnOnly
#>
[CmdletBinding()]
param(
    [ValidateSet("all", "completeness", "duplicate", "snapshot")]
    [string] $Report = "all",
    [string] $RepoRoot = ".",
    [switch] $WarnOnly
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$resolvedRoot = (Resolve-Path -LiteralPath $RepoRoot).Path

# Report -> named inputs. Kind is File, Dir, or Glob. Required inputs fail the run.
$inputMap = [ordered]@{
    completeness = @(
        @{ Path = "docs/agent-governance-completeness-contract.md"; Kind = "File"; Required = $true },
        @{ Path = "schemas/agent-governance-record.schema.json"; Kind = "File"; Required = $true },
        @{ Path = "docs/confluence-pages/agent-inventory.md"; Kind = "File"; Required = $true },
        @{ Path = "docs/confluence-pages/*-project-brain.md"; Kind = "Glob"; Required = $false },
        @{ Path = "agents"; Kind = "Dir"; Required = $false }
    )
    duplicate = @(
        @{ Path = "docs/confluence-pages/agent-inventory.md"; Kind = "File"; Required = $true },
        @{ Path = "docs/reports/inventory-cleanup-dry-run.md"; Kind = "File"; Required = $false }
    )
    snapshot = @(
        @{ Path = "docs/confluence-pages/agent-inventory.md"; Kind = "File"; Required = $true },
        @{ Path = "templates/confluence/monthly-governance-snapshot-template.md"; Kind = "File"; Required = $true },
        @{ Path = "docs/publish-history"; Kind = "Dir"; Required = $true },
        @{ Path = "docs/reports/governance-completeness-dry-run.md"; Kind = "File"; Required = $true },
        @{ Path = "docs/reports/duplicate-agent-discovery-dry-run.md"; Kind = "File"; Required = $true },
        @{ Path = "agents"; Kind = "Dir"; Required = $false }
    )
}

function Test-InputPresent {
    param(
        [Parameter(Mandatory = $true)][string] $Path,
        [Parameter(Mandatory = $true)][string] $Kind,
        [Parameter(Mandatory = $true)][string] $Root
    )

    $absolute = Join-Path -Path $Root -ChildPath $Path
    switch ($Kind) {
        "File" { return Test-Path -LiteralPath $absolute -PathType Leaf }
        "Dir"  { return Test-Path -LiteralPath $absolute -PathType Container }
        "Glob" {
            $matches = @(Get-ChildItem -Path $absolute -File -ErrorAction SilentlyContinue)
            return $matches.Count -gt 0
        }
    }
    return $false
}

$reportsToCheck = if ($Report -eq "all") { @($inputMap.Keys) } else { @($Report) }
$rows = [System.Collections.Generic.List[object]]::new()
$missingRequired = 0

foreach ($reportName in $reportsToCheck) {
    foreach ($input in $inputMap[$reportName]) {
        $present = Test-InputPresent -Path $input.Path -Kind $input.Kind -Root $resolvedRoot
        $requirement = if ($input.Required) { "required" } else { "optional" }

        $status = if ($present) {
            "present"
        }
        elseif ($input.Required) {
            $missingRequired++
            "MISSING"
        }
        else {
            "absent (optional)"
        }

        $rows.Add([pscustomobject]@{
            report = $reportName
            input = $input.Path
            kind = $input.Kind
            requirement = $requirement
            status = $status
        }) | Out-Null
    }
}

Write-Output "# Governance Report Inputs Check"
Write-Output ""
Write-Output "Repo root: $resolvedRoot"
Write-Output "Reports checked: $([string]::Join(', ', $reportsToCheck))"
Write-Output "Missing required inputs: $missingRequired"
Write-Output ""
Write-Output "| Report | Input | Kind | Requirement | Status |"
Write-Output "|---|---|---|---|---|"
foreach ($row in $rows) {
    Write-Output "| $($row.report) | $($row.input) | $($row.kind) | $($row.requirement) | $($row.status) |"
}
Write-Output ""

if ($missingRequired -gt 0) {
    Write-Output "Result: required inputs are missing. Regenerate reports only after the inputs exist."
    if (-not $WarnOnly) { exit 1 }
}
else {
    Write-Output "Result: all required inputs are present."
}
