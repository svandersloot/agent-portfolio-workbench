<#
.SYNOPSIS
Offline test suite for the Deny-SecretRead PreToolUse hook.

.DESCRIPTION
Runs every fixture in .claude/hooks/tests/fixtures/deny-secret-read-cases.json
against .claude/hooks/Deny-SecretRead.ps1 by piping the fixture's stdin into a
fresh pwsh process, then asserts the decision, exit code, and reason format.
Also asserts the exact exec-form hooks configuration in .claude/settings.json.

Fully offline: no live Claude session, no network, no file mutations. Deny
reasons are asserted to match the generic anchored format and to contain no
fragment of the input command.

.EXAMPLE
pwsh -NoProfile -File ./scripts/Test-DenySecretReadHook.ps1
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$hookPath = Join-Path $repoRoot '.claude/hooks/Deny-SecretRead.ps1'
$fixturePath = Join-Path $repoRoot '.claude/hooks/tests/fixtures/deny-secret-read-cases.json'
$settingsPath = Join-Path $repoRoot '.claude/settings.json'

if (-not (Test-Path $hookPath)) { throw "Hook not found: $hookPath" }
if (-not (Test-Path $fixturePath)) { throw "Fixtures not found: $fixturePath" }

$reasonFormat = '^Blocked by Deny-SecretRead hook: protected-path rule P[1-5] \([a-z-]+\)\. See \.claude/hooks/README\.md\.$'

$hookTimeoutMs = 10000   # mirrors the configured hook timeout of 10 seconds

function Invoke-Hook {
    param([string] $StdinText)
    $psi = [System.Diagnostics.ProcessStartInfo]::new()
    $psi.FileName = 'pwsh'
    $psi.ArgumentList.Add('-NoProfile')
    $psi.ArgumentList.Add('-File')
    $psi.ArgumentList.Add($hookPath)
    $psi.RedirectStandardInput = $true
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.UseShellExecute = $false
    $proc = [System.Diagnostics.Process]::Start($psi)
    $proc.StandardInput.Write($StdinText)
    $proc.StandardInput.Close()
    $stdoutTask = $proc.StandardOutput.ReadToEndAsync()
    $stderrTask = $proc.StandardError.ReadToEndAsync()
    if (-not $proc.WaitForExit($hookTimeoutMs)) {
        try { $proc.Kill($true) } catch { }
        return @{ TimedOut = $true; ExitCode = -1; StdOut = ''; StdErr = '' }
    }
    return @{
        TimedOut = $false
        ExitCode = $proc.ExitCode
        StdOut   = $stdoutTask.Result.Trim()
        StdErr   = $stderrTask.Result.Trim()
    }
}

$fixtures = Get-Content -Raw -Path $fixturePath | ConvertFrom-Json
$results = @()
$failures = 0

foreach ($fx in $fixtures) {
    $stdin = $null
    if ($fx.PSObject.Properties['stdinRaw']) {
        $stdin = [string]$fx.stdinRaw
    }
    else {
        $toolName = 'Bash'
        if ($fx.PSObject.Properties['toolName']) { $toolName = [string]$fx.toolName }
        $stdin = @{ hook_event_name = 'PreToolUse'; tool_name = $toolName; tool_input = @{ command = [string]$fx.command } } | ConvertTo-Json -Depth 5 -Compress
    }

    $r = Invoke-Hook -StdinText $stdin
    $problems = @()

    if ($r.TimedOut) {
        $problems += "hook exceeded the configured ${hookTimeoutMs}ms timeout and was killed"
    }
    else {
        switch ([string]$fx.expect.mode) {
            'allow' {
                if ($r.ExitCode -ne 0) { $problems += "expected exit 0, got $($r.ExitCode)" }
                if ($r.StdOut -ne '') { $problems += 'expected no stdout' }
                if ($r.StdErr -ne '') { $problems += 'expected empty stderr' }
            }
            'deny' {
                if ($r.ExitCode -ne 0) { $problems += "expected exit 0, got $($r.ExitCode)" }
                if ($r.StdErr -ne '') { $problems += 'expected empty stderr' }
                $reason = $null
                try {
                    $decision = $r.StdOut | ConvertFrom-Json -ErrorAction Stop
                    if ($decision.hookSpecificOutput.permissionDecision -ne 'deny') { $problems += 'permissionDecision is not deny' }
                    if ($decision.hookSpecificOutput.hookEventName -ne 'PreToolUse') { $problems += 'hookEventName is not PreToolUse' }
                    $reason = [string]$decision.hookSpecificOutput.permissionDecisionReason
                }
                catch { $problems += 'stdout is not valid decision JSON' }
                if ($null -ne $reason) {
                    if ($reason -notmatch $reasonFormat) { $problems += 'reason does not match the generic anchored format' }
                    if ($fx.expect.PSObject.Properties['rule'] -and $reason -notmatch "rule $($fx.expect.rule) ") { $problems += "reason does not cite rule $($fx.expect.rule)" }
                    if ($fx.PSObject.Properties['command'] -and -not [string]::IsNullOrWhiteSpace([string]$fx.command)) {
                        if ($reason.Contains([string]$fx.command)) { $problems += 'reason echoes the input command' }
                    }
                }
            }
            'error' {
                if ($r.ExitCode -ne 2) { $problems += "expected exit 2, got $($r.ExitCode)" }
                if ($r.StdErr -ne 'Deny-SecretRead hook: malformed or unsupported input; failing closed.') { $problems += 'stderr is not exactly the generic fail-closed message' }
                if ($fx.PSObject.Properties['stdinRaw'] -and -not [string]::IsNullOrWhiteSpace([string]$fx.stdinRaw)) {
                    if ($r.StdErr.Contains([string]$fx.stdinRaw)) { $problems += 'stderr echoes fixture input' }
                }
                if ($r.StdOut -ne '') { $problems += 'expected no stdout' }
            }
            default { $problems += "unknown expect.mode '$($fx.expect.mode)'" }
        }
    }

    $pass = ($problems.Count -eq 0)
    if (-not $pass) { $failures++ }
    $results += [pscustomobject]@{
        Name = $fx.name; Category = $fx.category; Pass = $pass
        Detail = if ($pass) { '' } else { ($problems -join '; ') }
    }
}

# --- Exact exec-form settings assertion -----------------------------------

$settingsProblems = @()
try {
    $settings = Get-Content -Raw -Path $settingsPath | ConvertFrom-Json -ErrorAction Stop
    $matcherGroups = @($settings.hooks.PreToolUse)
    if ($matcherGroups.Count -ne 1) { $settingsProblems += "expected exactly 1 PreToolUse matcher group, found $($matcherGroups.Count)" }
    $entry = $matcherGroups[0]
    if ($entry.matcher -ne 'Bash') { $settingsProblems += "matcher is '$($entry.matcher)', expected 'Bash'" }
    $handlers = @($entry.hooks)
    if ($handlers.Count -ne 1) { $settingsProblems += "expected exactly 1 handler, found $($handlers.Count)" }
    $h = $handlers[0]
    if ($h.type -ne 'command') { $settingsProblems += "hook type is '$($h.type)', expected 'command'" }
    if ($h.command -ne 'pwsh') { $settingsProblems += "hook command is '$($h.command)', expected 'pwsh'" }
    foreach ($forbidden in @('shell', 'async')) {
        if ($h.PSObject.Properties[$forbidden]) { $settingsProblems += "forbidden handler property '$forbidden' present" }
    }
    $expectedArgs = @('-NoProfile', '-File', '${CLAUDE_PROJECT_DIR}/.claude/hooks/Deny-SecretRead.ps1')
    $actualArgs = @($h.args)
    if ($actualArgs.Count -ne $expectedArgs.Count) { $settingsProblems += 'hook args count mismatch' }
    else {
        for ($i = 0; $i -lt $expectedArgs.Count; $i++) {
            if ($actualArgs[$i] -ne $expectedArgs[$i]) { $settingsProblems += "hook args[$i] is '$($actualArgs[$i])', expected '$($expectedArgs[$i])'" }
        }
    }
    foreach ($a in $actualArgs) {
        if ($a -match '(?i)executionpolicy|bypass') { $settingsProblems += "forbidden arg content: '$a'" }
    }
    if ($h.timeout -ne 10) { $settingsProblems += "hook timeout is '$($h.timeout)', expected 10" }
}
catch { $settingsProblems += "settings.json parse/shape failure: $($_.Exception.Message)" }

$settingsPass = ($settingsProblems.Count -eq 0)
if (-not $settingsPass) { $failures++ }
$results += [pscustomobject]@{
    Name = 'settings-exec-form-structure'; Category = 'config'; Pass = $settingsPass
    Detail = if ($settingsPass) { '' } else { ($settingsProblems -join '; ') }
}

# --- Report ----------------------------------------------------------------

Write-Output '# Deny-SecretRead hook test results'
Write-Output ''
foreach ($group in ($results | Group-Object Category)) {
    $passed = @($group.Group | Where-Object Pass).Count
    Write-Output ("{0}: {1}/{2} passed" -f $group.Name, $passed, $group.Count)
    foreach ($fail in ($group.Group | Where-Object { -not $_.Pass })) {
        Write-Output ("  FAIL {0}: {1}" -f $fail.Name, $fail.Detail)
    }
}
Write-Output ''
Write-Output ("Total: {0}/{1} passed" -f (@($results | Where-Object Pass).Count), $results.Count)

if ($failures -gt 0) { exit 1 }
exit 0
