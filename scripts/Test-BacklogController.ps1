<#
.SYNOPSIS
Offline test suite for the backlog controller MVP (S9, issue #53).

.DESCRIPTION
Runs Invoke-BacklogController.ps1 in fixture mode (fully offline; fixture mode
never calls gh) across selection, skip-reason, concurrency, mandate, and
apply-refusal scenarios, asserting exit codes and report contents.

.EXAMPLE
pwsh -NoProfile -File ./scripts/Test-BacklogController.ps1
#>
[CmdletBinding()]
param()
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$ctl = Join-Path $repoRoot 'scripts/Invoke-BacklogController.ps1'
$fx  = Join-Path $repoRoot 'scripts/tests/fixtures/backlog-controller-issues.json'

function Invoke-Ctl {
    param([int[]]$Issues, [int]$Max = 1, [string]$Actor = 'test-actor', [switch]$Apply)
    $args2 = @('-NoProfile','-File',$ctl,'-Repo','fixture/repo','-ProjectOwner','fixture','-ProjectNumber','1',
        '-EligibleIssueList',($Issues -join ','),'-MaxIssues',$Max,'-ActorId',$Actor,'-RunId','run1','-FixturePath',$fx)
    if ($Apply) { $args2 += '-Apply' }
    $out = & pwsh @args2 2>&1
    return @{ ExitCode = $LASTEXITCODE; Out = ($out | Out-String) }
}

function Get-Report([string]$Text) {
    $i = $Text.IndexOf('{'); $j = $Text.LastIndexOf('}')
    if ($i -lt 0 -or $j -le $i) { return $null }
    return $Text.Substring($i, $j - $i + 1) | ConvertFrom-Json
}

$results = @(); $fail = 0
function Assert([string]$Name, [bool]$Cond, [string]$Detail = '') {
    $script:results += [pscustomobject]@{ Name = $Name; Pass = $Cond; Detail = $Detail }
    if (-not $Cond) { $script:fail++ }
}

# 1. Selection: lowest eligible wins; every ineligible has the right reason.
$r = Invoke-Ctl -Issues 101,102,103,104,105,106,107,108,109,110,112,113,114
$rep = Get-Report $r.Out
Assert 'select-exit-0' ($r.ExitCode -eq 0) "exit=$($r.ExitCode)"
Assert 'select-101' ($rep.selected -eq 101)
$sk = @{}; foreach ($s in $rep.skipped) { $sk[[int]$s.number] = ($s.reasons -join '; ') }
Assert 'skip-102-mandate-one' ($sk[102] -match 'exactly one')
Assert 'skip-103-risk' ($sk[103] -match 'risk:low')
Assert 'skip-104-blocked' ($sk[104] -match 'blocked')
Assert 'skip-105-decision-gate' ($sk[105] -match 'decision-gate')
Assert 'skip-106-acceptance' ($sk[106] -match 'acceptance-criteria')
Assert 'skip-107-scope' ($sk[107] -match 'no declared path scope')
Assert 'skip-108-protected' ($sk[108] -match 'protected paths')
Assert 'skip-109-loopstate' ($sk[109] -match 'must be Eligible')
Assert 'skip-110-claimed' ($sk[110] -match 'claim fields not empty')
Assert 'skip-112-empty-scope' ($sk[112] -match 'empty path scope')
Assert 'skip-113-validation' ($sk[113] -match 'no validation section')
Assert 'skip-114-closed' ($sk[114] -match 'not open')
Assert 'dry-run-token-preview' ($rep.wouldClaim.token -eq 'test-actor:run1')

# 2. No eligible work -> exit 2.
$r2 = Invoke-Ctl -Issues 103,104,105
Assert 'none-exit-2' ($r2.ExitCode -eq 2) "exit=$($r2.ExitCode)"

# 3. Concurrency guard: own existing claim (fixture 111) -> fail closed exit 3.
$r3 = Invoke-Ctl -Issues 101,111
Assert 'concurrency-exit-3' ($r3.ExitCode -eq 3) "exit=$($r3.ExitCode)"
Assert 'concurrency-message' ($r3.Out -match 'one active claim per mandate')

# 4. Exhausted mandate -> exit 2.
$r4 = Invoke-Ctl -Issues 101 -Max 0
Assert 'mandate-exit-2' ($r4.ExitCode -eq 2) "exit=$($r4.ExitCode)"

# 5. Apply refused in fixture mode (no writes possible offline).
$r5 = Invoke-Ctl -Issues 101 -Apply
Assert 'fixture-apply-refused' ($r5.ExitCode -ne 0 -and $r5.Out -match 'Fixture mode cannot -Apply')

# 6. Other actor's claim does NOT trip the own-claim guard (110 skipped, 101 still selected).
$r6 = Invoke-Ctl -Issues 101,110
$rep6 = Get-Report $r6.Out
Assert 'other-claim-no-guard' ($r6.ExitCode -eq 0 -and $rep6.selected -eq 101)

# 7. Claim-verification retry harness (issue #76): three outcome fixtures.
function Invoke-Verify([string]$Fx) {
    $a = @('-NoProfile','-File',$ctl,'-Repo','fixture/repo','-ProjectOwner','fixture','-ProjectNumber','1',
        '-EligibleIssueList','101','-MaxIssues','1','-ActorId','test-actor','-RunId','run1',
        '-VerifyOnlyFixture',(Join-Path $repoRoot "scripts/tests/fixtures/$Fx"))
    $out = & pwsh @a 2>&1
    return @{ ExitCode = $LASTEXITCODE; Out = ($out | Out-String) }
}
$v = Invoke-Verify 'claim-verify-delayed.json'
Assert 'verify-delayed-confirmed-after-retry' ($v.ExitCode -eq 0 -and $v.Out -match 'confirmed-after-retry' -and $v.Out -match '"attempts":2')
$v = Invoke-Verify 'claim-verify-collision.json'
Assert 'verify-true-collision-immediate' ($v.ExitCode -eq 3 -and $v.Out -match 'true-collision' -and $v.Out -match '"attempts":1')
$v = Invoke-Verify 'claim-verify-exhausted.json'
Assert 'verify-retry-exhausted-failclosed' ($v.ExitCode -eq 3 -and $v.Out -match 'retry-exhausted' -and $v.Out -match '"attempts":3')
Write-Output '# Backlog controller test results'
foreach ($x in $results) { Write-Output ("{0} {1} {2}" -f ($(if ($x.Pass) {'PASS'} else {'FAIL'})), $x.Name, $x.Detail) }
Write-Output ("Total: {0}/{1} passed" -f (@($results | Where-Object Pass).Count), $results.Count)
if ($fail -gt 0) { exit 1 }
exit 0
