@AGENTS.md

## Claude Code

Start each planning or implementation task by also reading:

1. README.md
2. START-HERE.md
3. docs/toolkit-operating-model.md
4. The task-specific source docs, handoff, report, schema, or Confluence page source

Keep Claude-specific work bounded. Do not treat Claude Code migration as approval to write to ROVO Studio, Jira, or Confluence.

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

A write-capable Atlassian MCP connector may be present in local Claude Code tooling. Its
presence does not change these boundaries. MCP read/search tools support read-first work;
MCP write tools stay draft or dry-run only and require explicit human approval per action.
The connector has no delete/trash tool, so MCP writes are not self-reversible; any write
plan must include a manual UI cleanup step.
See `docs/reports/atlassian-mcp-integration-2026-07-09.md`.

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
