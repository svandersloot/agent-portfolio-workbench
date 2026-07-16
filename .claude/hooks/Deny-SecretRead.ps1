<#
.SYNOPSIS
Claude Code PreToolUse hook: deny Bash commands that reference protected paths.

.DESCRIPTION
Defense-in-depth beneath the permission rules in .claude/settings.json.
Reads the PreToolUse event JSON from stdin and evaluates the Bash command:

  1. Malformed input (invalid JSON, missing tool_name/tool_input, or a Bash
     event with a missing/non-string/empty command) -> generic stderr + exit 2
     (fail closed).
  2. Valid non-Bash event -> exit 0 silently.
  3. Sanctioned-script exception (strict grammar) -> exit 0 silently.
     Pass-through never counts as permission approval; ask rules still apply.
  4. Protected-reference scan (the security boundary): any path-like candidate
     matching a protected rule -> exit 0 with permissionDecision "deny" JSON.
     The reason names only a generic rule ID/category - never the command,
     matched token, or any user-controlled input.
  5. Otherwise -> exit 0 with no output.

The hook never opens or reads any file; it inspects the command string only.
See .claude/hooks/README.md for rules, grammar, tests, and residual limits.
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Exit-Malformed {
    [Console]::Error.WriteLine('Deny-SecretRead hook: malformed or unsupported input; failing closed.')
    exit 2
}

function Get-CommandTokens {
    param([string] $Text)
    # Quote-aware whitespace tokenizer. Preserves quoted spans as single tokens.
    $tokens = New-Object System.Collections.Generic.List[string]
    $sb = New-Object System.Text.StringBuilder
    $quote = $null
    foreach ($ch in $Text.ToCharArray()) {
        if ($null -ne $quote) {
            if ($ch -eq $quote) { $quote = $null } else { [void]$sb.Append($ch) }
        }
        elseif ($ch -eq '"' -or $ch -eq "'") { $quote = $ch }
        elseif ([char]::IsWhiteSpace($ch)) {
            if ($sb.Length -gt 0) { $tokens.Add($sb.ToString()); [void]$sb.Clear() }
        }
        else { [void]$sb.Append($ch) }
    }
    if ($sb.Length -gt 0) { $tokens.Add($sb.ToString()) }
    return $tokens
}

function Get-ScanCandidates {
    param([string] $Text)
    # Candidates = whitespace/quote tokens
    #            + every quoted literal anywhere in the string (covers
    #              pwsh -Command, python -c, .NET calls, nested cmd /c)
    #            + each of those exploded on structural delimiters.
    $set = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
    foreach ($t in (Get-CommandTokens -Text $Text)) { [void]$set.Add($t) }
    foreach ($m in [regex]::Matches($Text, "'([^']*)'"))  { [void]$set.Add($m.Groups[1].Value) }
    foreach ($m in [regex]::Matches($Text, '"([^"]*)"'))  { [void]$set.Add($m.Groups[1].Value) }
    $exploded = New-Object System.Collections.Generic.List[string]
    foreach ($c in $set) {
        foreach ($part in ($c -split '[\(\)\[\]\{\}<>\|&;,=`"''\s]+')) {
            if ($part.Length -gt 0) { $exploded.Add($part) }
        }
    }
    foreach ($p in $exploded) { [void]$set.Add($p) }
    return @($set)
}

function ConvertTo-NormalizedPath {
    param([string] $Candidate)
    $n = $Candidate.Trim().Trim('"').Trim("'").Trim()
    $n = $n -replace '\\', '/'
    $n = $n.ToLowerInvariant()
    $n = $n -replace '^[a-z]:', ''       # strip drive letter
    $n = $n.TrimStart('/')
    while ($n.StartsWith('./')) { $n = $n.Substring(2) }
    # Collapse . and .. segments so traversal cannot hide a protected target.
    $stack = New-Object System.Collections.Generic.List[string]
    foreach ($seg in ($n -split '/')) {
        if ($seg -eq '' -or $seg -eq '.') { continue }
        if ($seg -eq '..') {
            if ($stack.Count -gt 0) { $stack.RemoveAt($stack.Count - 1) }
        }
        else { $stack.Add($seg) }
    }
    return ($stack -join '/')
}

# Exact repo files whose basenames necessarily contain rule keywords
# (this hook's own tooling). Matched as normalized-path suffixes only.
$script:ExemptSuffixes = @(
    '.claude/hooks/deny-secretread.ps1',
    '.claude/hooks/tests/fixtures/deny-secret-read-cases.json',
    'scripts/test-denysecretreadhook.ps1'
)

function Test-ExemptCandidate {
    param([string] $Normalized)
    foreach ($suffix in $script:ExemptSuffixes) {
        if ($Normalized -eq $suffix) { return $true }
        if ($Normalized.EndsWith('/' + $suffix)) { return $true }
    }
    return $false
}

function Find-ProtectedReference {
    param([string] $CommandText)
    # Collect all normalized, path-like, non-exempt candidates first, then
    # evaluate the rules in fixed priority order (P1..P5) across all of them,
    # so the cited rule is deterministic regardless of candidate-set order.
    $paths = New-Object System.Collections.Generic.List[object]
    foreach ($cand in (Get-ScanCandidates -Text $CommandText)) {
        $n = ConvertTo-NormalizedPath -Candidate $cand
        if ($n.Length -eq 0) { continue }
        $base = if ($n.Contains('/')) { $n.Substring($n.LastIndexOf('/') + 1) } else { $n }
        # Path-like gate: separator, leading dot, any dot (covers extensions of
        # any length), or a sensitive keyword as part of a LONGER basename
        # (client_secret, credentials). Exact bare keywords (token) stay
        # non-path-like by design - the deliberate false-positive guard.
        $keywordInLongerBase = ($base -match '(cookie|token|secret|credential)') -and
                               ($base -notin @('cookie', 'token', 'secret', 'credential'))
        $isPathLike = ($n.Contains('/')) -or ($n.StartsWith('.')) -or ($n.Contains('.')) -or $keywordInLongerBase
        if (-not $isPathLike) { continue }
        if (Test-ExemptCandidate -Normalized $n) { continue }
        $paths.Add(@{ N = $n; Base = $base })
    }
    foreach ($p in $paths) {
        if ($p.Base -match '^\.env(\..+)?$') { return @{ Id = 'P1'; Category = 'env-file' } }
    }
    foreach ($p in $paths) {
        if ($p.N -match '(^|/)config/(confluence-pages|studio-agents|atlassian-knowledge-inventory)\.yml$') { return @{ Id = 'P2'; Category = 'protected-config' } }
    }
    foreach ($p in $paths) {
        if ($p.N -match '(^|/)(data/raw|data/exports|docs/private-overlays)(/|$)') { return @{ Id = 'P3'; Category = 'protected-directory' } }
    }
    foreach ($p in $paths) {
        if ($p.Base -match '\.har$') { return @{ Id = 'P4'; Category = 'har-archive' } }
    }
    foreach ($p in $paths) {
        if ($p.Base -match '(cookie|token|secret|credential)') { return @{ Id = 'P5'; Category = 'sensitive-basename' } }
    }
    return $null
}

# --- Sanctioned-script exception (strict grammar) ------------------------

$script:SanctionedSpecs = @{
    'test-privatedatascan'           = @{
        '-scope'            = @{ Kind = 'value';  Pattern = '^(candidate|alltracked)$' }
        '-reporoot'         = @{ Kind = 'value';  Pattern = '^\.$' }
        '-warnonly'         = @{ Kind = 'switch' }
    }
    'normalize-studioexport'         = @{
        '-rawpath'          = @{ Kind = 'value';  Pattern = '^(\./)?data/raw/[a-z0-9._-]+$' }
        '-outdir'           = @{ Kind = 'value';  Pattern = '^(\./)?agents(/[a-z0-9._-]+)*$' }
        '-includestableids' = @{ Kind = 'switch' }
    }
    'inspect-studiohar'              = @{
        '-harpath'          = @{ Kind = 'value';  Pattern = '^(\./)?data/raw/[a-z0-9._-]+\.har$' }
        '-outpath'          = @{ Kind = 'value';  Pattern = '^(\./)?data/raw/[a-z0-9._-]+$' }
    }
    'extract-studioresponsesfromhar' = @{
        '-harpath'          = @{ Kind = 'value';  Pattern = '^(\./)?data/raw/[a-z0-9._-]+\.har$' }
        '-outpath'          = @{ Kind = 'value';  Pattern = '^(\./)?data/raw(/[a-z0-9._-]+)+$' }
    }
}

function Test-SanctionedInvocation {
    param([string] $CommandText)
    # Reject metacharacters outright: chaining, pipelines, redirection,
    # command substitution, variable expansion, nested shells, PowerShell
    # backtick. Ordinary backslashes (Windows separators) remain supported.
    if ($CommandText -match '[;|&<>]') { return $false }
    if ($CommandText.Contains('`'))    { return $false }
    if ($CommandText -match '\$')      { return $false }
    if ($CommandText -match '%')       { return $false }

    $tokens = @(Get-CommandTokens -Text $CommandText)
    if ($tokens.Count -lt 4) { return $false }
    if ($tokens[0] -notmatch '^(?i)pwsh(\.exe)?$') { return $false }
    if ($tokens[1] -ne '-NoProfile') { return $false }
    if ($tokens[2] -ne '-File') { return $false }

    $scriptPath = ($tokens[3] -replace '\\', '/').ToLowerInvariant()
    while ($scriptPath.StartsWith('./')) { $scriptPath = $scriptPath.Substring(2) }
    if ($scriptPath -notmatch '^scripts/(test-privatedatascan|normalize-studioexport|inspect-studiohar|extract-studioresponsesfromhar)\.ps1$') {
        return $false
    }
    $scriptName = $Matches[1]
    $spec = $script:SanctionedSpecs[$scriptName]

    # No nested shells anywhere after the leading pwsh.
    for ($i = 1; $i -lt $tokens.Count; $i++) {
        if ($tokens[$i] -match '^(?i)(pwsh|powershell|cmd)(\.exe)?$') { return $false }
    }

    $seen = New-Object 'System.Collections.Generic.HashSet[string]'
    $i = 4
    while ($i -lt $tokens.Count) {
        $name = $tokens[$i].ToLowerInvariant()
        if (-not $name.StartsWith('-')) { return $false }          # positional arg
        if (-not $spec.ContainsKey($name)) { return $false }       # unknown parameter
        if (-not $seen.Add($name)) { return $false }               # duplicate parameter
        $entry = $spec[$name]
        if ($entry.Kind -eq 'switch') { $i++ ; continue }
        if ($i + 1 -ge $tokens.Count) { return $false }            # value missing
        $value = ($tokens[$i + 1] -replace '\\', '/').ToLowerInvariant()
        if ($value.Contains('..')) { return $false }               # traversal
        if ($value -notmatch $entry.Pattern) { return $false }
        $i += 2
    }
    return $true
}

# --- Main -----------------------------------------------------------------

try {
    $raw = [Console]::In.ReadToEnd()
    if ([string]::IsNullOrWhiteSpace($raw)) { Exit-Malformed }

    try { $evt = $raw | ConvertFrom-Json -ErrorAction Stop } catch { Exit-Malformed }
    if ($null -eq $evt -or $evt -isnot [System.Management.Automation.PSCustomObject]) { Exit-Malformed }

    if (-not $evt.PSObject.Properties['tool_name'] -or [string]::IsNullOrWhiteSpace([string]$evt.tool_name)) { Exit-Malformed }
    if (-not $evt.PSObject.Properties['tool_input'] -or $null -eq $evt.tool_input) { Exit-Malformed }

    if ([string]$evt.tool_name -ne 'Bash') { exit 0 }

    $command = $null
    if ($evt.tool_input.PSObject.Properties['command']) { $command = $evt.tool_input.command }
    if ($null -eq $command -or $command -isnot [string] -or [string]::IsNullOrWhiteSpace($command)) { Exit-Malformed }

    if (Test-SanctionedInvocation -CommandText $command) { exit 0 }

    $hit = Find-ProtectedReference -CommandText $command
    if ($null -ne $hit) {
        $reason = "Blocked by Deny-SecretRead hook: protected-path rule $($hit.Id) ($($hit.Category)). See .claude/hooks/README.md."
        $decision = @{
            hookSpecificOutput = @{
                hookEventName            = 'PreToolUse'
                permissionDecision       = 'deny'
                permissionDecisionReason = $reason
            }
        } | ConvertTo-Json -Depth 5 -Compress
        [Console]::Out.WriteLine($decision)
        exit 0
    }

    exit 0
}
catch {
    Exit-Malformed
}
