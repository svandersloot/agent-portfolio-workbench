<#
.SYNOPSIS
Per-issue engineering loop MVP (S10, issue #54): stage-gated transition engine.

.DESCRIPTION
Implements the per-issue level of docs/governed-backlog-execution-loop.md as a
stage-gated transition engine over the docs/loop-state-machine.md model:
claim -> inspect/plan -> branch -> implement -> test -> self-review -> commit ->
draft PR -> bounded CI/review feedback -> complete or hand off.

Each invocation performs exactly one transition after verifying:
  1. the claim token matches (revalidated before EVERY state write; fail closed),
  2. the transition is legal from the current state (T3/T4/T5/T6 agent edges),
  3. the bounded-recovery budget (max 2 CI/review correction cycles) is respected.

Default mode is DRY-RUN (prints the decision, writes nothing). -Apply performs
the live field write + receipt. -FixturePath evaluates against an offline JSON
fixture and never calls gh; fixture mode refuses -Apply.

Transitions (agent-ownable only; everything else is human-owned per the spec):
  Start     : Claimed            -> In Progress        (T3)
  ToReview  : In Progress        -> Awaiting CI/Review (T4)
  FixCycle  : Awaiting CI/Review -> In Progress        (T5; counts a correction cycle)
  Escalate  : nonterminal active -> Blocked-Decision   (T6; requires -Reason)

Exit codes: 0 = transition permitted (dry-run) or performed (apply);
3 = fail-closed (token mismatch, illegal transition, or budget exhausted -> escalate).

.EXAMPLE
pwsh -NoProfile -File ./scripts/Invoke-IssueLoop.ps1 -Repo o/r -ProjectOwner o -ProjectNumber 1 -IssueNumber 41 -ActorId claude -RunId r1 -Transition Start
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string] $Repo,
    [Parameter(Mandatory)][string] $ProjectOwner,
    [Parameter(Mandatory)][int]    $ProjectNumber,
    [Parameter(Mandatory)][int]    $IssueNumber,
    [Parameter(Mandatory)][string] $ActorId,
    [Parameter(Mandatory)][string] $RunId,
    [Parameter(Mandatory)][ValidateSet('Start','ToReview','FixCycle','Escalate')][string] $Transition,
    [string] $Reason,
    [string] $Branch = 'n/a',
    [string] $Evidence = '',
    [int]    $LeaseHours = 24,
    [int]    $CycleCount = 0,
    [switch] $Apply,
    [string] $FixturePath
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$spec = @{
    Start    = @{ From = @('Claimed');            To = 'In Progress' }
    ToReview = @{ From = @('In Progress');        To = 'Awaiting CI/Review' }
    FixCycle = @{ From = @('Awaiting CI/Review'); To = 'In Progress' }
    Escalate = @{ From = @('Claimed','In Progress','Awaiting CI/Review'); To = 'Blocked-Decision' }
}
$maxCycles = 2
$token = "$($ActorId):$($RunId)"

function Fail([string]$Msg) { Write-Output "FAIL-CLOSED: $Msg"; exit 3 }

# --- Read current item state -------------------------------------------------
if ($FixturePath) {
    $item = Get-Content -Raw -LiteralPath $FixturePath | ConvertFrom-Json
}
else {
    $items = gh project item-list $ProjectNumber --owner $ProjectOwner --format json --limit 300 | ConvertFrom-Json
    $raw = $items.items | Where-Object { $_.content.number -eq $IssueNumber } | Select-Object -First 1
    if ($null -eq $raw) { Fail "issue #$IssueNumber not found on project board" }
    $item = [pscustomobject]@{
        loopState = if ($raw.PSObject.Properties['loop State'])    { $raw.'loop State' }    else { $null }
        claimedBy = if ($raw.PSObject.Properties['claimed By'])    { $raw.'claimed By' }    else { $null }
        itemId    = $raw.id
    }
}

# --- Gate 1: claim-token revalidation (before EVERY state-changing action) ---
if ([string]$item.claimedBy -ne $token) {
    Fail "claim token mismatch (held: '$($item.claimedBy)', mine: '$token'); no state change"
}

# --- Gate 2: legal transition from current state ------------------------------
$t = $spec[$Transition]
if ($t.From -notcontains [string]$item.loopState) {
    Fail "illegal transition $Transition from '$($item.loopState)' (legal from: $($t.From -join ', '))"
}

# --- Gate 3: bounded recovery ------------------------------------------------
if ($Transition -eq 'FixCycle' -and $CycleCount -ge $maxCycles) {
    Fail "correction-cycle budget exhausted ($CycleCount/$maxCycles); required action: Escalate to Blocked-Decision with receipt"
}
if ($Transition -eq 'Escalate' -and [string]::IsNullOrWhiteSpace($Reason)) {
    Fail 'Escalate requires -Reason naming the human decision needed'
}

$seq = $CycleCount + 2   # event sequence: claim was :1
$eventId = "$($token):$seq"
$decision = [ordered]@{
    mode = if ($Apply) { 'apply' } else { 'dry-run' }
    issue = $IssueNumber; transition = $Transition
    from = [string]$item.loopState; to = $t.To
    eventId = $eventId; token = $token; cycleCount = $CycleCount
}
$decision | ConvertTo-Json

if (-not $Apply) { exit 0 }
if ($FixturePath) { throw 'Fixture mode cannot -Apply.' }

# --- Live write: state (+ lease renewal on active transitions) + receipt -----
$fields = gh project field-list $ProjectNumber --owner $ProjectOwner --format json | ConvertFrom-Json
$fLoop  = $fields.fields | Where-Object { $_.name -eq 'Loop State' }
$fLease = $fields.fields | Where-Object { $_.name -eq 'Lease Expires' }
$opt = ($fLoop.options | Where-Object { $_.name -eq $t.To }).id
$projectId = (gh project view $ProjectNumber --owner $ProjectOwner --format json | ConvertFrom-Json).id

if ($Transition -in @('Start','ToReview','FixCycle')) {
    $lease = (Get-Date).ToUniversalTime().AddHours($LeaseHours).ToString('yyyy-MM-ddTHH:mm:ssZ')
    gh project item-edit --id $item.itemId --project-id $projectId --field-id $fLease.id --text $lease | Out-Null
}
gh project item-edit --id $item.itemId --project-id $projectId --field-id $fLoop.id --single-select-option-id $opt | Out-Null

$body = "### Loop receipt $eventId`n- Event ID: $eventId`n- Transition: $([string]$item.loopState) -> $($t.To)`n- Actor: $ActorId`n- Timestamp: $((Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ'))`n- Branch: $Branch`n- Evidence: $(if ($Evidence) { $Evidence } elseif ($Reason) { "escalation: $Reason" } else { 'n/a' })"
if ($Transition -eq 'Escalate') {
    gh issue edit $IssueNumber --repo $Repo --add-label decision-gate | Out-Null
}
gh issue comment $IssueNumber --repo $Repo --body $body | Out-Null
Write-Output "APPLIED $Transition on #$IssueNumber ($eventId)"
exit 0
