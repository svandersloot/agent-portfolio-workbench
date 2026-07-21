<#
.SYNOPSIS
Governed backlog controller MVP (S9, issue #53): select and claim exactly one eligible issue.

.DESCRIPTION
Implements the backlog-controller level of docs/governed-backlog-execution-loop.md
under a human-authorized mandate (§3): explicit repository, project, eligible issue
set, and maximum issue count. Enforces the §4 conjunctive eligibility rule in code,
the single-active-claim rule, and the docs/loop-state-machine.md §5 ordered claim
protocol with fail-closed collision detection.

Default mode is DRY-RUN: prints the selection report and performs no writes.
-Apply performs the live claim (S8-governed; per-call approval still applies while
the adapter allowlist is narrower than S8). -FixturePath runs fully offline against
a JSON fixture of candidate issues for testing; fixture mode never calls gh.

Exit codes: 0 = selected (dry-run) or claimed (apply); 2 = no eligible work;
3 = fail-closed (claim collision, tuple mismatch, or concurrency refusal).

.EXAMPLE
pwsh -NoProfile -File ./scripts/Invoke-BacklogController.ps1 -Repo owner/name -ProjectOwner owner -ProjectNumber 1 -EligibleIssueList 41,42 -MaxIssues 1 -ActorId claude -RunId r1
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string] $Repo,
    [Parameter(Mandatory)][string] $ProjectOwner,
    [Parameter(Mandatory)][int]    $ProjectNumber,
    [Parameter(Mandatory)][string] $EligibleIssueList,
    [Parameter(Mandatory)][int]    $MaxIssues,
    [Parameter(Mandatory)][string] $ActorId,
    [Parameter(Mandatory)][string] $RunId,
    [int]    $LeaseHours = 24,
    [switch] $Apply,
    [string] $FixturePath,
    [string] $VerifyOnlyFixture
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# -File invocation binds one token per parameter; parse the mandate list here.
[int[]] $EligibleIssues = @($EligibleIssueList -split ',' | ForEach-Object { [int]$_.Trim() })

# Claim-tuple verification with bounded retry/backoff (issue #76).
# Reads is a provider returning successive observed tuples; outcomes:
#   confirmed | confirmed-after-retry (exit 0) | true-collision | retry-exhausted (exit 3)
$script:VerifyMaxAttempts = 3
$script:VerifyDelaySeconds = 5
function Resolve-ClaimVerification {
    param([string]$Token, [string]$Lease, [scriptblock]$ReadTuple)
    for ($attempt = 1; $attempt -le $script:VerifyMaxAttempts; $attempt++) {
        $r = & $ReadTuple $attempt
        $ok = ([string]$r.claimedBy -eq $Token) -and ([string]$r.leaseExpires -eq $Lease) -and ([string]$r.loopState -eq 'Claimed')
        if ($ok) {
            return @{ Outcome = $(if ($attempt -eq 1) { 'confirmed' } else { 'confirmed-after-retry' }); Attempts = $attempt }
        }
        # Foreign non-empty token = true collision: fail closed immediately, no retry.
        if (-not [string]::IsNullOrWhiteSpace([string]$r.claimedBy) -and ([string]$r.claimedBy -ne $Token)) {
            return @{ Outcome = 'true-collision'; Attempts = $attempt }
        }
        # Stale/partial read: retry after backoff (except after final attempt).
        if ($attempt -lt $script:VerifyMaxAttempts -and -not $VerifyOnlyFixture) { Start-Sleep -Seconds $script:VerifyDelaySeconds }
    }
    return @{ Outcome = 'retry-exhausted'; Attempts = $script:VerifyMaxAttempts }
}

# Offline verification harness: simulate successive re-reads from a fixture and exit.
if ($VerifyOnlyFixture) {
    $sim = Get-Content -Raw -LiteralPath $VerifyOnlyFixture | ConvertFrom-Json
    $i = 0
    $reads = @($sim.reads)
    $res = Resolve-ClaimVerification -Token $sim.token -Lease $sim.lease -ReadTuple {
        param($attempt)
        $idx = [Math]::Min($attempt - 1, $reads.Count - 1)
        $reads[$idx]
    }
    @{ outcome = $res.Outcome; attempts = $res.Attempts } | ConvertTo-Json -Compress
    if ($res.Outcome -in @('confirmed', 'confirmed-after-retry')) { exit 0 } else { exit 3 }
}

$script:ProtectedPathPattern = '(AGENTS\.md|CLAUDE\.md|governed-backlog-execution-loop|claude-code-adoption-plan|\.claude[/\\]settings|\.claude[/\\]hooks|CODEOWNERS|\.github[/\\]workflows)'

function Get-Candidates {
    if ($FixturePath) {
        return @(Get-Content -Raw -LiteralPath $FixturePath | ConvertFrom-Json)
    }
    $items = gh project item-list $ProjectNumber --owner $ProjectOwner --format json --limit 300 | ConvertFrom-Json
    $out = @()
    foreach ($n in $EligibleIssues) {
        $issue = gh issue view $n --repo $Repo --json number,state,labels,body | ConvertFrom-Json
        $item = $items.items | Where-Object { $_.content.number -eq $n } | Select-Object -First 1
        $out += [pscustomobject]@{
            number      = $issue.number
            state       = $issue.state
            labels      = @($issue.labels.name)
            body        = $issue.body
            loopState   = if ($item -and $item.PSObject.Properties['loop State'])   { $item.'loop State' }   else { $null }
            claimedBy   = if ($item -and $item.PSObject.Properties['claimed By'])   { $item.'claimed By' }   else { $null }
            leaseExpires= if ($item -and $item.PSObject.Properties['lease Expires']){ $item.'lease Expires' }else { $null }
            itemId      = if ($item) { $item.id } else { $null }
        }
    }
    return $out
}

function Test-Eligibility {
    param($Issue)
    $reasons = @()
    if ($Issue.state -ne 'OPEN')                          { $reasons += 'not open' }
    if ($Issue.labels -notcontains 'agent:draft-pr')      { $reasons += 'missing agent:draft-pr label' }
    if ($Issue.labels -notcontains 'risk:low')            { $reasons += 'missing risk:low label' }
    if ($Issue.labels -contains 'blocked')                { $reasons += 'blocked label present' }
    if ($Issue.labels -contains 'decision-gate')          { $reasons += 'decision-gate label present' }
    if ($Issue.body -notmatch '(?im)^#{2,3}\s*acceptance criteria') { $reasons += 'no acceptance-criteria section' }
    if ($Issue.body -notmatch '(?im)^#{2,3}\s*validation')          { $reasons += 'no validation section' }
    # Declared path scope: required, and fail-closed against protected paths.
    $scopeMatch = [regex]::Match($Issue.body, '(?ims)^#{2,3}\s*path scope\s*$(.*?)(?=^#{2,3}\s|\z)')
    if (-not $scopeMatch.Success) {
        $reasons += 'no declared path scope'
    }
    else {
        $scope = $scopeMatch.Groups[1].Value.Trim()
        if ([string]::IsNullOrWhiteSpace($scope))             { $reasons += 'empty path scope (fail closed)' }
        elseif ($scope -match $script:ProtectedPathPattern)   { $reasons += 'path scope touches protected paths' }
    }
    if ([string]$Issue.loopState -ne 'Eligible')          { $reasons += "Loop State is '$($Issue.loopState)' (must be Eligible)" }
    if (-not [string]::IsNullOrWhiteSpace([string]$Issue.claimedBy)) { $reasons += 'claim fields not empty' }
    return $reasons
}

# --- Mandate + selection ----------------------------------------------------

if ($MaxIssues -lt 1) { Write-Output 'Mandate exhausted (MaxIssues < 1).'; exit 2 }

$candidates = @(Get-Candidates | Where-Object { $EligibleIssues -contains $_.number } | Sort-Object number)

# Single-active-claim guard: refuse if this actor already holds any claim.
$ownClaims = @($candidates | Where-Object {
    -not [string]::IsNullOrWhiteSpace([string]$_.claimedBy) -and ([string]$_.claimedBy).StartsWith("$($ActorId):")
})
if ($ownClaims.Count -gt 0) {
    Write-Output ("FAIL-CLOSED: actor already holds claim on #{0}; one active claim per mandate." -f $ownClaims[0].number)
    exit 3
}

$selected = $null
$skipped = @()
foreach ($c in $candidates) {
    $reasons = @(Test-Eligibility -Issue $c)
    if ($reasons.Count -eq 0 -and $null -eq $selected) { $selected = $c }
    elseif ($reasons.Count -gt 0) { $skipped += [pscustomobject]@{ number = $c.number; reasons = $reasons } }
    else { $skipped += [pscustomobject]@{ number = $c.number; reasons = @('eligible but mandate claims exactly one per run') } }
}

$report = [ordered]@{
    mode      = if ($Apply) { 'apply' } else { 'dry-run' }
    mandate   = [ordered]@{ repo = $Repo; project = $ProjectNumber; eligibleIssues = $EligibleIssues; maxIssues = $MaxIssues }
    selected  = if ($selected) { $selected.number } else { $null }
    skipped   = $skipped
}

if ($null -eq $selected) {
    $report | ConvertTo-Json -Depth 6
    Write-Output 'No eligible work in mandate.'
    exit 2
}

$token = "$($ActorId):$($RunId)"
$lease = (Get-Date).ToUniversalTime().AddHours($LeaseHours).ToString('yyyy-MM-ddTHH:mm:ssZ')
$report['wouldClaim'] = [ordered]@{ token = $token; leaseExpires = $lease; eventId = "$($token):1" }
$report | ConvertTo-Json -Depth 6

if (-not $Apply) { exit 0 }

# --- Live claim: docs/loop-state-machine.md §5 ordered protocol -------------

if ($FixturePath) { throw 'Fixture mode cannot -Apply.' }

$fields = gh project field-list $ProjectNumber --owner $ProjectOwner --format json | ConvertFrom-Json
$fLoop  = $fields.fields | Where-Object { $_.name -eq 'Loop State' }
$fClaim = $fields.fields | Where-Object { $_.name -eq 'Claimed By' }
$fLease = $fields.fields | Where-Object { $_.name -eq 'Lease Expires' }
$optClaimed = ($fLoop.options | Where-Object { $_.name -eq 'Claimed' }).id
$projectId = (gh project view $ProjectNumber --owner $ProjectOwner --format json | ConvertFrom-Json).id

# Step 1: re-read Eligible + empty claim fields (done above via candidates).
# Steps 2-4: token, lease, state LAST.
gh project item-edit --id $selected.itemId --project-id $projectId --field-id $fClaim.id --text $token | Out-Null
gh project item-edit --id $selected.itemId --project-id $projectId --field-id $fLease.id --text $lease | Out-Null
gh project item-edit --id $selected.itemId --project-id $projectId --field-id $fLoop.id --single-select-option-id $optClaimed | Out-Null

# Step 5: re-read with bounded retry/backoff; accept only on complete tuple match.
$res = Resolve-ClaimVerification -Token $token -Lease $lease -ReadTuple {
    param($attempt)
    $v = (gh project item-list $ProjectNumber --owner $ProjectOwner --format json --limit 300 | ConvertFrom-Json).items |
        Where-Object { $_.content.number -eq $selected.number } | Select-Object -First 1
    @{ claimedBy = $v.'claimed By'; leaseExpires = $v.'lease Expires'; loopState = $v.'loop State' }
}

$receiptBase = "### Loop receipt $($token):1`n- Event ID: $($token):1`n- Actor: $ActorId`n- Timestamp: $((Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ'))`n- Branch: n/a (claim)"
switch ($res.Outcome) {
    'confirmed' {
        gh issue comment $selected.number --repo $Repo --body "$receiptBase`n- Transition: Eligible -> Claimed`n- Evidence: claim tuple verified on first re-read" | Out-Null
        Write-Output ("CLAIMED #{0} (token {1}, lease {2})" -f $selected.number, $token, $lease)
        exit 0
    }
    'confirmed-after-retry' {
        gh issue comment $selected.number --repo $Repo --body "$receiptBase`n- Transition: Eligible -> Claimed`n- Evidence: claim tuple verified after retry (attempt $($res.Attempts); earlier reads stale - API eventual consistency)" | Out-Null
        Write-Output ("CLAIMED #{0} after retry attempt {1}" -f $selected.number, $res.Attempts)
        exit 0
    }
    'true-collision' {
        gh issue comment $selected.number --repo $Repo --body "$receiptBase`n- Transition: claim-collision (true; foreign token observed)`n- Evidence: fail-closed; no further state-changing action; human recovery required" | Out-Null
        Write-Output ("FAIL-CLOSED: true collision on #{0} (foreign token); receipt posted." -f $selected.number)
        exit 3
    }
    default {
        gh issue comment $selected.number --repo $Repo --body "$receiptBase`n- Transition: claim-verification retry-exhausted (tuple never confirmed after $($res.Attempts) attempts)`n- Evidence: fail-closed; no further state-changing action; human recovery required if ownership ambiguous" | Out-Null
        Write-Output ("FAIL-CLOSED: retry budget exhausted verifying #{0}; receipt posted." -f $selected.number)
        exit 3
    }
}
