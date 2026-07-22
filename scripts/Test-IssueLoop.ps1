<#
.SYNOPSIS
Offline test suite for the per-issue loop MVP (S10, issue #54).

.EXAMPLE
pwsh -NoProfile -File ./scripts/Test-IssueLoop.ps1
#>
[CmdletBinding()]
param()
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$loop = Join-Path $repoRoot 'scripts/Invoke-IssueLoop.ps1'
$fxDir = Join-Path $repoRoot 'scripts/tests/fixtures'
New-Item -ItemType Directory -Force -Path $fxDir | Out-Null

function Invoke-Loop {
    param([string]$State, [string]$ClaimedBy, [string]$Transition, [int]$Cycles = 0, [string]$Reason, [int]$ReceiptCount = 1, [switch]$Apply)
    $fx = Join-Path $fxDir 'issue-loop-item.tmp.json'
    @{ loopState = $State; claimedBy = $ClaimedBy; itemId = 'FX_ITEM'; receiptCount = $ReceiptCount } | ConvertTo-Json | Set-Content -LiteralPath $fx
    $a = @('-NoProfile','-File',$loop,'-Repo','fixture/repo','-ProjectOwner','fixture','-ProjectNumber','1',
        '-IssueNumber','41','-ActorId','test-actor','-RunId','run1','-Transition',$Transition,'-CycleCount',$Cycles,'-FixturePath',$fx)
    if ($Reason) { $a += @('-Reason',$Reason) }
    if ($Apply)  { $a += '-Apply' }
    $out = & pwsh @a 2>&1
    Remove-Item -LiteralPath $fx -ErrorAction SilentlyContinue
    return @{ ExitCode = $LASTEXITCODE; Out = ($out | Out-String) }
}

$results = @(); $fail = 0
function Assert([string]$Name, [bool]$Cond, [string]$Detail = '') {
    $script:results += [pscustomobject]@{ Name = $Name; Pass = $Cond; Detail = $Detail }
    if (-not $Cond) { $script:fail++ }
}
$tok = 'test-actor:run1'

# Legal agent transitions (dry-run, exit 0)
$r = Invoke-Loop -State 'Claimed' -ClaimedBy $tok -Transition Start
Assert 'T3-start-ok' ($r.ExitCode -eq 0 -and $r.Out -match '"to": "In Progress"')
$r = Invoke-Loop -State 'In Progress' -ClaimedBy $tok -Transition ToReview
Assert 'T4-review-ok' ($r.ExitCode -eq 0 -and $r.Out -match 'Awaiting CI/Review')
$r = Invoke-Loop -State 'Awaiting CI/Review' -ClaimedBy $tok -Transition FixCycle -Cycles 1
Assert 'T5-cycle2-ok' ($r.ExitCode -eq 0)
$r = Invoke-Loop -State 'In Progress' -ClaimedBy $tok -Transition Escalate -Reason 'needs owner decision'
Assert 'T6-escalate-ok' ($r.ExitCode -eq 0 -and $r.Out -match 'Blocked-Decision')
$r = Invoke-Loop -State 'Claimed' -ClaimedBy $tok -Transition Escalate -Reason 'needs owner decision'
Assert 'T6-escalate-from-claimed-ok' ($r.ExitCode -eq 0 -and $r.Out -match 'Blocked-Decision')
$r = Invoke-Loop -State 'Awaiting CI/Review' -ClaimedBy $tok -Transition Escalate -Reason 'needs owner decision'
Assert 'T6-escalate-from-awaiting-ok' ($r.ExitCode -eq 0 -and $r.Out -match 'Blocked-Decision')

# Fail-closed gates (exit 3)
$r = Invoke-Loop -State 'Claimed' -ClaimedBy 'other:run9' -Transition Start
Assert 'token-mismatch-3' ($r.ExitCode -eq 3 -and $r.Out -match 'token mismatch')
$r = Invoke-Loop -State 'Eligible' -ClaimedBy $tok -Transition Start
Assert 'illegal-from-eligible-3' ($r.ExitCode -eq 3 -and $r.Out -match 'illegal transition')
$r = Invoke-Loop -State 'Done' -ClaimedBy $tok -Transition Escalate -Reason 'x'
Assert 'no-escalate-from-done-3' ($r.ExitCode -eq 3)
$r = Invoke-Loop -State 'Awaiting CI/Review' -ClaimedBy $tok -Transition FixCycle -Cycles 2
Assert 'budget-exhausted-3' ($r.ExitCode -eq 3 -and $r.Out -match 'budget exhausted')
$r = Invoke-Loop -State 'In Progress' -ClaimedBy $tok -Transition Escalate
Assert 'escalate-needs-reason-3' ($r.ExitCode -eq 3 -and $r.Out -match 'requires -Reason')
$r = Invoke-Loop -State 'Claimed' -ClaimedBy '' -Transition Start
Assert 'empty-claim-3' ($r.ExitCode -eq 3)

# Fixture mode refuses -Apply
$r = Invoke-Loop -State 'Claimed' -ClaimedBy $tok -Transition Start -Apply
Assert 'fixture-apply-refused' ($r.ExitCode -ne 0 -and $r.Out -match 'Fixture mode cannot -Apply')

# Monotonic event IDs (issue #77): sequence from receipt count, never CycleCount.
# Same-cycle regression: Start then ToReview at cycle 0 -> distinct IDs :2 then :3.
$r = Invoke-Loop -State 'Claimed' -ClaimedBy $tok -Transition Start -Cycles 0 -ReceiptCount 1
Assert 'seq-start-is-2' ($r.Out -match 'test-actor:run1:2')
$r = Invoke-Loop -State 'In Progress' -ClaimedBy $tok -Transition ToReview -Cycles 0 -ReceiptCount 2
Assert 'seq-toreview-is-3-same-cycle' ($r.Out -match 'test-actor:run1:3')
$r = Invoke-Loop -State 'Awaiting CI/Review' -ClaimedBy $tok -Transition FixCycle -Cycles 1 -ReceiptCount 3
Assert 'seq-fixcycle-is-4' ($r.Out -match 'test-actor:run1:4')
$r = Invoke-Loop -State 'In Progress' -ClaimedBy $tok -Transition Escalate -Reason 'x' -Cycles 0 -ReceiptCount 4
Assert 'seq-escalate-is-5' ($r.Out -match 'test-actor:run1:5')

Write-Output '# Issue loop test results'
foreach ($x in $results) { Write-Output ("{0} {1} {2}" -f ($(if ($x.Pass) {'PASS'} else {'FAIL'})), $x.Name, $x.Detail) }
Write-Output ("Total: {0}/{1} passed" -f (@($results | Where-Object Pass).Count), $results.Count)
if ($fail -gt 0) { exit 1 }
exit 0
