# Deny-SecretRead PreToolUse Hook

Defense-in-depth for protected paths: denies `Bash` tool commands that reference protected files, closing the gap that file-tool `deny` rules do not stop an equivalent shell read (`cat .env`). Implements issue #45.

## Primary protection remains the permission rules

This hook is scoped to the **`Bash` tool only**. The `Read`/`Edit`/`Write` deny rules in `.claude/settings.json` remain the primary protection: **`@` file references do not trigger PreToolUse**, so the direct `Read` deny rules must stay in place and must never be weakened on the strength of this hook. `deny`/`ask` permission rules always take precedence over hook pass-through; the hook only ever adds protection.

The direct-tool keyword deny rules (`**/*token*.json` etc.) are currently **narrower** than this hook's basename matching; issue #44 tracks evaluating parity. This hook does not change any permission rule.

## Decision order

1. Malformed input — invalid JSON, missing `tool_name`/`tool_input`, or a Bash event with a missing/non-string/empty `command` — generic stderr + **exit 2** (fail closed).
2. Valid non-Bash event — exit 0 silently.
3. Sanctioned-script exception (strict grammar below) — exit 0 silently. Pass-through never counts as permission approval; `ask` rules still apply.
4. Protected-reference scan — any path-like candidate matching a rule below — exit 0 with `permissionDecision: "deny"` JSON. **Protected-reference-first:** a command containing a protected target is denied regardless of the read mechanism; no verb list gates the boundary.
5. Otherwise — exit 0, no output.

## Protected rules

| Rule | Category | Matches |
|---|---|---|
| P1 | env-file | basename `.env` or `.env.*` |
| P2 | protected-config | `config/confluence-pages.yml`, `config/studio-agents.yml`, `config/atlassian-knowledge-inventory.yml` |
| P3 | protected-directory | any `data/raw/`, `data/exports/`, `docs/private-overlays/` segment |
| P4 | har-archive | `.har` extension only (substrings such as `shared`/`chart` never match) |
| P5 | sensitive-basename | path-like candidate whose basename contains `cookie`, `token`, `secret`, or `credential` |

Candidates are extracted from whitespace/quote tokens, every quoted literal (covers `pwsh -Command`, `python -c`, .NET calls, nested `cmd /c`), and delimiter-exploded parts; each is normalized (quotes stripped, `\`→`/`, lowercased, drive letters removed, `..` traversal collapsed) before matching. A candidate is path-like when it has a separator, a dot (extensions of any length, including none — `client_secret`, `credentials.properties`), or contains a sensitive keyword as part of a **longer** basename. Exact bare keywords (`token`, `secret`, `cookie`, `credential`) alone are not path-like — the deliberate false-positive guard. Longer prose words containing a keyword (e.g. `tokens`, `credentials`) are denied by design: fail-closed bias.

**Exemptions (exact paths only):** this hook's own tooling necessarily carries rule keywords in its filenames and is exempt by exact normalized path: `.claude/hooks/Deny-SecretRead.ps1`, `.claude/hooks/tests/fixtures/deny-secret-read-cases.json`, `scripts/Test-DenySecretReadHook.ps1`. Nothing else is exempt; `...ps1.bak` variants are not.

## Sanctioned-script exception grammar

Applies only when the **entire** command is a single `pwsh -NoProfile -File <script> …` invocation with no chaining, pipelines, redirection, command substitution, PowerShell backtick, variable expansion (`$`, `%`), or nested shells (ordinary backslashes in Windows paths are fine), no duplicate or unknown parameters, and no positional arguments:

| Script | Parameters accepted | Constraints |
|---|---|---|
| `scripts/Test-PrivateDataScan.ps1` | `-Scope Candidate\|AllTracked`, `-WarnOnly`, `-RepoRoot .` | `-RepoRoot` literal `.` only |
| `scripts/Normalize-StudioExport.ps1` | `-RawPath`, `-OutDir`, `-IncludeStableIds` | `RawPath`: single file in `data/raw/`; `OutDir`: `agents` subtree |
| `scripts/Inspect-StudioHar.ps1` | `-HarPath`, `-OutPath` | `HarPath`: single `*.har` in `data/raw/`; `OutPath`: inside `data/raw/` |
| `scripts/Extract-StudioResponsesFromHar.ps1` | `-HarPath`, `-OutPath` | both constrained to `data/raw/` |

Values must match `[A-Za-z0-9._-]` path segments with no wildcards or `..`. Legacy `powershell -ExecutionPolicy Bypass` forms are intentionally not covered by the exception — they fall through to the protected-reference scan.

## Denial output

Deny reasons are generic by design — rule ID and category only, never the command, matched token, absolute path, or any user-controlled input, because hook stdout/stderr can enter debug logs:

```
Blocked by Deny-SecretRead hook: protected-path rule P3 (protected-directory). See .claude/hooks/README.md.
```

## Configuration (exec-form)

`.claude/settings.json` wires the hook without a shell and without bare env-var interpolation:

```json
"hooks": {
  "PreToolUse": [
    {
      "matcher": "Bash",
      "hooks": [
        {
          "type": "command",
          "command": "pwsh",
          "args": ["-NoProfile", "-File", "${CLAUDE_PROJECT_DIR}/.claude/hooks/Deny-SecretRead.ps1"],
          "timeout": 10
        }
      ]
    }
  ]
}
```

No `-ExecutionPolicy Bypass` is set; adding it requires a demonstrated failure and separate human approval.

## Testing

Offline suite (no live session, no file mutations, fixtures use dummy paths and contain no secrets):

```powershell
pwsh -NoProfile -File ./scripts/Test-DenySecretReadHook.ps1
```

Post-merge live integration smoke (required before #45 is complete): the **human** creates the disposable, secret-free `.env.hook-test` and `data/raw/hook-test.har` **outside the hooked Claude session**, and the human deletes them afterward. In the Claude Code session, Claude only *attempts* the two reads (`cat .env.hook-test`, `Get-Content data/raw/hook-test.har` — both must be blocked with the hook's deny reason) and runs `git status` (must be permitted). Claude must never be asked to create or clean up protected test paths. Never smoke-test against a real `.env` or real raw export.

## Residual limitations

The script can fail closed only after it starts: **process-launch failure, hook timeout, disabled hooks, or an event that never fires cannot be trapped by the script itself.** `@` file references and non-Bash tools do not pass through PreToolUse. Environment-variable indirection and content-encoding tricks are only partially detectable: a keyword-bearing variable name (`cat $SECRET_FILE`) is caught by P5, but a neutral name (`cat $HIDDEN_FILE`) is not — a pinned fixture documents the known-allowed case. **Filesystem aliases — symlinks, junctions, hardlinks — and runtime-computed paths may hide the protected target**, because the hook intentionally inspects command text only and never resolves or opens files. This hook is defense-in-depth beneath permission rules, sandboxing, and human review — never a substitute for them.
