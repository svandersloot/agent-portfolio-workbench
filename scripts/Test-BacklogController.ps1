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

# 1b. One-claim-per-run invariant (issue #100): MaxIssues 2 still selects exactly one.
$r1b = Invoke-Ctl -Issues 101,102 -Max 2
$rep1b = Get-Report $r1b.Out
$sk1b = @{}; foreach ($s in $rep1b.skipped) { $sk1b[[int]$s.number] = ($s.reasons -join '; ') }
Assert 'invariant-max2-selects-one' ($r1b.ExitCode -eq 0 -and $rep1b.selected -eq 101)
Assert 'invariant-max2-second-skipped' ($sk1b[102] -match 'exactly one')

# 1c. Duplicate mandate entries (issue #100): single selection, no duplicate skips.
$r1c = Invoke-Ctl -Issues 101,101 -Max 1
$rep1c = Get-Report $r1c.Out
Assert 'invariant-duplicate-single-selection' ($r1c.ExitCode -eq 0 -and $rep1c.selected -eq 101)
Assert 'invariant-duplicate-no-skips' (@($rep1c.skipped).Count -eq 0)

# 1d. Unknown-mandate-number behavior pinned (issue #103): silent drop, no fix.
$r1d = Invoke-Ctl -Issues 999
$rep1d = Get-Report $r1d.Out
Assert 'unknown-all-exit-2' ($r1d.ExitCode -eq 2)
Assert 'unknown-all-selected-null' ($null -eq $rep1d.selected)
Assert 'unknown-all-skipped-empty' (@($rep1d.skipped).Count -eq 0)
Assert 'unknown-all-message' ($r1d.Out -match 'No eligible work in mandate')
$r1e = Invoke-Ctl -Issues 101,999
$rep1e = Get-Report $r1e.Out
Assert 'unknown-mixed-selects-101' ($r1e.ExitCode -eq 0 -and $rep1e.selected -eq 101)
Assert 'unknown-mixed-999-absent' (@(@($rep1e.skipped) | Where-Object { $_.number -eq 999 }).Count -eq 0 -and $rep1e.selected -ne 999)

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
# 8. Lease-instant normalization (issue #89).
$v = Invoke-Verify 'claim-verify-datetime-typed.json'
Assert 'lease-datetime-typed-confirms' ($v.ExitCode -eq 0 -and $v.Out -match '"outcome":"confirmed"')
$v = Invoke-Verify 'claim-verify-same-instant-offset.json'
Assert 'lease-same-instant-offset-confirms' ($v.ExitCode -eq 0)
$v = Invoke-Verify 'claim-verify-noniso-string.json'
Assert 'lease-noniso-string-confirms' ($v.ExitCode -eq 0)
$v = Invoke-Verify 'claim-verify-null-lease.json'
Assert 'lease-null-failclosed' ($v.ExitCode -eq 3)
$v = Invoke-Verify 'claim-verify-malformed-lease.json'
Assert 'lease-malformed-failclosed' ($v.ExitCode -eq 3)
$v = Invoke-Verify 'claim-verify-wrong-instant.json'
Assert 'lease-wrong-instant-failclosed' ($v.ExitCode -eq 3)

Write-Output '# Backlog controller test results'
foreach ($x in $results) { Write-Output ("{0} {1} {2}" -f ($(if ($x.Pass) {'PASS'} else {'FAIL'})), $x.Name, $x.Detail) }
Write-Output ("Total: {0}/{1} passed" -f (@($results | Where-Object Pass).Count), $results.Count)
if ($fail -gt 0) { exit 1 }
exit 0
