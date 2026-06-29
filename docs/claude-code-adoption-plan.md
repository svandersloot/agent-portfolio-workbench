# Claude Code Adoption Plan

Date: 2026-06-25
Accepted: 2026-06-29
Status: Accepted — governance reference for Claude Code use in this repo

The read-only permission allowlist and deny paths in this plan are implemented in `.claude/settings.json`. CI/automated checks remain a future slice (see backlog item 8.9).

This plan defines how Claude Code should be adopted for this repo's governance workflow. It is scoped to the local repo workbench. It does not approve changes to ROVO Studio, Jira, Confluence, or any other live system.

---

## Recommended Surface

Use Claude Code CLI as the primary surface. It is the lowest-risk, most controllable option for this workflow.

| Surface | Use | Rationale |
|---|---|---|
| **Claude Code CLI** | Primary | Full local execution, version-pinnable, no computer use, no GUI attack surface, approvable under standard dev-tools policy |
| **Claude Code Desktop** | Optional / secondary | Adds visual diff review, automatic worktrees, and split-pane layout; materially useful but not required; blocked on Linux; computer use capability widens enterprise attack surface |
| **Claude web/chat** | Fallback for drafting only | No local execution, no script runs, no git validation; suitable for reviewing pasted content but cannot replace automated validation loop |

Do not use web/chat as the primary surface for any workflow that requires running validation scripts, inspecting git state, or confirming dry-run outputs.

---

## Permission Posture

### Default posture

Start each session from the repo root so per-directory trust persists across sessions. Claude Code restricts write operations to the working directory and its subdirectories by default; do not override this.

Approve operations one-at-a-time until a session's behavior is understood. Do not bulk-approve shell commands at the start of a session.

### Read-only allowlist

The following commands may run without per-call approval. Configure in `settings.json` under `permissions.allow`:

```json
{
  "permissions": {
    "allow": [
      "Bash(git status*)",
      "Bash(git diff*)",
      "Bash(git log*)",
      "Bash(git branch*)",
      "Bash(git show*)",
      "Bash(ls*)",
      "Bash(cat*)",
      "Bash(Get-Content*)",
      "Bash(Test-Path*)"
    ]
  }
}
```

### Explicit approval required

These actions must be approved individually, per-call:

- Any `git add`, `git commit`, `git push`, `git merge`, or `git rebase`
- Any PowerShell script that writes, moves, or deletes files
- Any Confluence publisher script run (`Publish-ConfluencePages.ps1`)
- Any JSON or YAML write
- Any curl, wget, or network-fetching command
- Any shell command that modifies system state outside the repo

### Deny-list paths

Never auto-approve file writes to:

- `.env`
- `config/confluence-pages.yml`
- `data/raw/` (any path)
- Any path containing `har`, `cookie`, `token`, `secret`, or `credential` in the filename

---

## Data Handling Rules

1. **No secrets in prompts.** Do not paste `.env`, `config/confluence-pages.yml`, authentication headers, API tokens, cookies, or private URLs into any Claude session.
2. **No raw exports in repo.** `data/raw/` is Git-ignored. Keep Studio responses, HAR files, and unsanitized captures there until normalized and sanitized.
3. **Normalize before committing.** Run `Normalize-StudioExport.ps1` before committing any Studio configuration data. Commit only the normalized output under `agents/`.
4. **API key via environment variable only.** Set `ANTHROPIC_API_KEY` in the shell environment or system keychain. Never write it into CLAUDE.md, a script, or a committed config file.
5. **Scan before staging.** Run `.\scripts\Test-PrivateDataScan.ps1` before every `git add` or `git commit`. If the scan flags anything, stop and resolve before proceeding.
6. **Enterprise plan note.** If your org uses Anthropic's enterprise plan, enable the Compliance API integration and configure DLP and SIEM integrations through approved providers. Verify data retention settings match your org's policy before starting sensitive governance work.

---

## Approved and Disallowed Actions

### Approved

- Read any repo file
- Edit Markdown, YAML, JSON, and PowerShell scripts within the working directory
- Run `git status`, `git diff`, `git log`, `git branch`, and other read-only git commands
- Run PowerShell dry-run scripts (`-WhatIf`, `-DryRun`, or read-only modes)
- Run `.\scripts\Test-ConfluencePageFamilyConsistency.ps1`
- Run `.\scripts\Test-PrivateDataScan.ps1`
- Run `.\scripts\Test-StaleHandoffs.ps1`
- Run `.\scripts\Normalize-StudioExport.ps1` on data that has already been placed in `data/raw/`
- Validate JSON against schemas in `schemas/`
- Prepare Studio copy packets, Confluence-ready drafts, Jira draft text, and handoff instructions
- Create, switch, and push branches following the `shaynevandersloot/<short-slice-description>` convention
- Stage and commit normalized, sanitized, repo-backed artifacts after explicit approval

### Disallowed without explicit human approval

- `git push` to `main` directly (always push to a named branch and open a PR or review)
- Running `Publish-ConfluencePages.ps1` in apply mode (dry-run is always first)
- Committing anything under `data/raw/`, `.env`, or `config/confluence-pages.yml`
- Any write, update, transition, assign, comment, or create action in Jira
- Any save, visibility change, permission change, or configuration edit in ROVO Studio
- Any publish, update, move, or archive action in Confluence outside of an approved dry-run-first workflow

### Never

- Marking any agent `Active`, broadly `Ready`, or approved for broad pilot
- Assigning or changing an agent owner or backup owner
- Retiring, deprecating, archiving, merging duplicates, or resurrecting agents
- Changing Studio visibility, team assignment, or permissions
- Posting to Jira (any action that modifies Jira state)
- Pushing credentials, tokens, cookies, raw exports, or private URLs to Git

---

## Logging and Audit Expectations

### Git as primary audit trail

Every durable change should be committed with a clear message. Commit messages should state what changed and why. Do not batch unrelated changes into a single commit.

Publish history records go in `docs/publish-history/` using the date-slug pattern already established in the repo (e.g., `2026-06-25-<short-description>.md`).

### Session-level logging

Claude Code CLI exposes OpenTelemetry metrics when configured. For enterprise deployments, enable this and route to your SIEM. See [Anthropic's monitoring docs](https://code.claude.com/docs/en/monitoring-usage) for configuration.

If your org has an enterprise Anthropic plan, the Compliance API provides programmatic access to Claude activity data. Configure it through your approved DLP or SIEM integration before using Claude Code for sensitive governance work.

### What to record manually

For any slice that touches a governed agent, Confluence page family, or publish plan, record in the commit message or an associated handoff:

- What files changed
- What validation ran and what it returned
- What live-system actions remain for human execution
- Whether any companion artifacts need updating in a follow-up

---

## Human Approval Gates

The following actions require a human decision and explicit approval before Claude Code proceeds:

| Gate | Trigger | Minimum evidence required |
|---|---|---|
| Confluence dry-run review | Before any `Publish-ConfluencePages.ps1` apply run | Dry-run output reviewed and confirmed |
| Confluence apply approval | After dry-run, before actual publish | Named approver confirms scope and target pages |
| Agent status change | Any move to `Active`, `Ready`, or pilot-visible | Governance steward approval, readiness evidence |
| Owner or backup owner assignment | First assignment or change | Named person has acknowledged ownership |
| Studio configuration change | Any instruction, knowledge source, tool, or visibility edit | Copy packet reviewed; human executes manually in Studio |
| Jira draft posting | Any Jira action from draft text prepared by Claude | Human reviews draft and posts independently |
| Agent retirement or archive | Any lifecycle status change away from active | Governance steward decision; companion pages updated |
| Broad audience expansion | Any change expanding agent visibility beyond current team | Pilot metrics, issue log, expansion rationale reviewed |
| CLAUDE.md or AGENTS.md edits | Changes to the operating contract itself | Explicit review before committing |

---

## Branch and Git Practices

### Branch naming

```
shaynevandersloot/<short-slice-description>
```

Examples:
- `shaynevandersloot/claude-code-adoption-plan`
- `shaynevandersloot/jira-work-item-assistant-measurement-update`
- `shaynevandersloot/confluence-publish-governance-safety`

### Starting a slice

```powershell
git fetch --prune origin
git switch main
git pull --ff-only origin main
git switch -c shaynevandersloot/<short-slice-description>
```

### Worktrees

Use worktrees when two conversations need to work simultaneously, or when the main working directory is occupied by another active branch:

```powershell
git fetch --prune origin
git worktree add .codex-worktrees/<slice-name> main
Set-Location .codex-worktrees/<slice-name>
git switch -c shaynevandersloot/<slice-name>
```

Do not edit a branch or worktree owned by another active conversation without explicit handoff.

### Commit slice pattern

Keep commits small and reviewable. Preferred separation:

1. Source docs and manifest updates
2. Read-only checks, reports, or report templates
3. Publish-history records (after approved Confluence applies)
4. Studio capture normalization (after manual Studio saves)
5. Backlog, roadmap, or next-goal status updates

Do not batch live-system preparation artifacts (copy packets, dry-run outputs) with source doc changes in the same commit unless they are inextricably linked.

### Before any commit

```powershell
git status --short
git diff --check
.\scripts\Test-PrivateDataScan.ps1
```

---

## Validation Commands Before Handoff

Run the minimum truthful checks for the changed surface. Do not claim validation passed unless the command actually ran and returned clean output.

| Changed surface | Command |
|---|---|
| Any files being staged or committed | `git status --short` |
| Any text edits | `git diff --check` |
| Any files being staged | `.\scripts\Test-PrivateDataScan.ps1` |
| Governed-agent page family or publish plan | `.\scripts\Test-ConfluencePageFamilyConsistency.ps1` |
| Handoff packets | `.\scripts\Test-StaleHandoffs.ps1` |
| Schemas, examples, or JSON fixtures | `python -m json.tool <file>` or PowerShell `ConvertFrom-Json` |
| YAML files | PowerShell `ConvertFrom-Yaml` (if available) or `yq` |
| Scripts changed | Run with `-WhatIf` or `-DryRun` and review output |
| Docs-only governance changes | Manual cross-read; state "validation was manual" in handoff |

If validation is partial, blocked, or manual-only, say so explicitly in the handoff. Do not imply a check ran if it did not.

---

## Preventing Accidental Live-System Writes

### Architectural prevention

The repo contains no scripts that write to Jira, Confluence (except the dry-run-first publisher), or ROVO Studio. This is intentional. The boundary is structural, not just policy.

- `Publish-ConfluencePages.ps1` requires `-Apply` to do anything beyond a dry run. The default mode is read-only.
- No repo script holds Jira write credentials or calls Jira mutation APIs.
- No repo script calls Studio write endpoints.

### Session-level prevention

1. CLAUDE.md (see next section) explicitly lists disallowed live-system actions at session start.
2. Do not configure MCP servers that expose Jira write, Studio write, or Confluence write APIs in this repo's Claude Code settings.
3. If a Confluence or Jira MCP is needed for read-only context retrieval, configure it with read-only scopes only and document the scope in `config/`.
4. Review every shell command Claude proposes before approval. If a proposed command reaches toward a live system unexpectedly, treat it as a prompt injection signal and report it.

### Drift detection

If Git, Confluence, Studio, or Jira disagree about an agent's status, readiness, ownership, or runtime behavior, stop and report the drift. Do not choose one surface as truth silently. Use the source-of-truth order: repo → Confluence → Studio → Jira.

---

## What Should Go in CLAUDE.md

The current `CLAUDE.md` correctly references `@AGENTS.md` and adds Claude Code session instructions. The following block is the recommended addition. Apply it to CLAUDE.md after review.

```markdown
## Session Start

Before planning or editing anything, read these files in order:

1. AGENTS.md
2. README.md
3. START-HERE.md
4. docs/toolkit-operating-model.md
5. The task-specific source docs, handoff, report, schema, or Confluence page source

Use docs/next-slash-goals.md when choosing or updating the active queue.
Use docs/implementation-backlog.md when the work changes backlog status or roadmap sequencing.

## Posture

- Read-only-first. Dry-run-first. Smallest reviewable slice.
- State assumptions when evidence is incomplete.
- Stop and report drift when Git, Confluence, Studio, or Jira disagree on status,
  readiness, ownership, approval, or runtime behavior.

## Hard Live-System Boundaries

Never automate these actions from this repo:

- Write, save, visibility change, or permission change in ROVO Studio
- Create, update, transition, assign, rank, sprint, or comment in Jira
- Publish, update, move, or archive in Confluence without a focused dry-run and
  explicit approval

Allowed: prepare Studio copy packets, dry-run Confluence outputs, draft Jira text for
human review, normalize Studio exports, produce handoff instructions.

## Human-Owned Decisions — Do Not Imply Approval For

- Marking any agent Active, broadly Ready, or approved for broad pilot
- Owner or backup owner assignment
- Agent retirement, deprecation, archive, duplicate merge, or resurrection
- Studio visibility, team assignment, or permission changes
- Policy exceptions or approval-authority changes
- Jira write capability

## Validation Before Handoff

Run the minimum truthful checks for the changed surface:

  git status --short
  git diff --check
  .\scripts\Test-PrivateDataScan.ps1
  .\scripts\Test-ConfluencePageFamilyConsistency.ps1   # page-family or publish changes
  .\scripts\Test-StaleHandoffs.ps1                    # when handoffs are involved
  JSON/schema validation for touched schemas or fixtures
  Script help or dry-run mode when scripts changed
  Manual cross-read for docs-only changes; state "validation was manual"

Never claim a command, publish, Studio save, Jira action, or live verification happened
unless it actually happened.

## Data Handling

- No secrets, tokens, cookies, headers, private URLs, or raw exports in prompts.
- No commits to data/raw/, .env, or config/confluence-pages.yml.
- Run Test-PrivateDataScan.ps1 before every git add or commit.
- API key via ANTHROPIC_API_KEY environment variable only.

## Branches

Named branches: shaynevandersloot/<short-slice-description>
Start from clean main. Use worktrees only when parallel work starts or another
conversation owns the active branch.

## Handoff Format

State: what changed | what validation ran | what risks or boundaries were respected |
any follow-ups or blocked items.
```

---

## Related Files

- `AGENTS.md` — operating contract (authoritative)
- `CLAUDE.md` — session bootstrap (references AGENTS.md)
- `START-HERE.md` — common workflow entry points
- `docs/toolkit-operating-model.md` — strategic direction and source-of-truth model
- `docs/stage-5-pilot-boundaries.md` — approved and prohibited workflows for first team pilot
- `.\scripts\Test-PrivateDataScan.ps1` — pre-commit private data scan
- `.\scripts\Test-ConfluencePageFamilyConsistency.ps1` — page family and publish plan checks
- `.\scripts\Test-StaleHandoffs.ps1` — handoff freshness check
