# Handoff - Regression Prompt Pack Pilot Slice - 2026-06-29

Use this packet to start a fresh conversation that implements backlog item **8.5 (Create regression prompt pack workflow)** scoped to the two existing pilot agents: **Jira Work Item Assistant** and **Release Notes Manager**. Keep the work repo-only and dry-run-first. Do not write to ROVO Studio, Jira, or Confluence.

## Start Here Prompt

```text
We are continuing the ROVO governance toolkit work with a bounded regression prompt pack slice (backlog 8.5).

Goal:
- Create a small, consistent regression prompt pack for each of the two pilot agents:
  Jira Work Item Assistant and Release Notes Manager.
- Each pack covers: source verification, fallback trap, unsafe-write trap, and 2-3 behavior
  regressions, each with pass / partial / fail criteria.
- Keep the work repo-only and dry-run-first.
- Do not write to ROVO Studio, Jira, or Confluence.
- Do not claim any pack has been run against a live agent. These are prompt packs plus
  expected-behavior criteria, not live test results.

Start by reading:
- AGENTS.md
- README.md
- START-HERE.md
- docs/toolkit-operating-model.md
- docs/handoffs/regression-prompt-pack-pilot-handoff-2026-06-29.md
- docs/confluence-pages/jira-work-item-assistant-evaluation.md
- docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md
- docs/confluence-pages/release-notes-manager-evaluation.md
- docs/confluence-pages/release-notes-manager-knowledge-source-plan.md
- docs/reports/deployment-notes-agent-live-regression-2026-06-08.md
- docs/reports/release-notes-manager-golden-runbook-evaluation.md

Current task:
- Produce a compact regression prompt pack for each of the two pilot agents.
- Prefer adding a "Regression Prompt Pack" section to each agent's existing evaluation page
  rather than creating a new page per agent, unless the pack grows too large.
- Reuse the smoke-test prompts already in each agent's Runtime Context Map (Knowledge Source Plan)
  as the seed for source-verification and fallback-trap prompts.
- Validate with git status --short, git diff --check, .\scripts\Test-PrivateDataScan.ps1, and manual cross-read.
```

## Why This Slice

Backlog item **8.5** is `Now` / P1 and is a direct input to the Stage 5 pilot readiness review (**7.9**). Regression prompts today are scattered across evaluation pages, reports, and handoffs. A small, consistent per-agent pack makes it possible to re-test an agent the same way after each change and to show readiness evidence before any pilot promotion.

This slice is fully repo-only and respects every live-system boundary. It does not promote any agent, change ownership, or touch Studio/Jira/Confluence.

## Scope

In scope:

- Jira Work Item Assistant regression prompt pack.
- Release Notes Manager regression prompt pack.
- The smallest companion updates needed to make the packs discoverable (e.g., a pointer from each Project Brain or change log if the conversation decides it is warranted).

Out of scope:

- Any third agent (Release Health Analyst, QA Test Case Architect, etc.) — do not backfill until the two-agent shape proves useful.
- Running the prompts against a live ROVO/Studio agent.
- Any Studio, Jira, or Confluence write.
- Confluence publishing of the new sections (a later dry-run-first slice can publish once the shape is approved).

## Required Pack Contents (per 8.5)

Each agent's pack must include, with explicit **pass / partial / fail** criteria for every item:

| Item | Purpose |
|---|---|
| Source verification | Confirms the agent cites/uses the correct first source from its Runtime Context Map. |
| Fallback trap | Confirms the agent asks/stops/marks-missing instead of guessing when the mapped source is absent. |
| Unsafe-write trap | Confirms the agent drafts only and refuses to perform a live Jira/Studio/Confluence write or imply approval. |
| Behavior regression 1-3 | 2-3 agent-specific behaviors that previously broke or that matter most for this agent. |

## Suggested Section Shape

Add this as a section in each agent's existing evaluation page unless the conversation decides a separate file is justified.

```markdown
## Regression Prompt Pack

Repo-only prompt pack for re-testing this agent after changes. These are prompts plus
expected-behavior criteria; they are not live test results until a human runs them and
captures sanitized evidence.

| ID | Type | Prompt | Pass | Partial | Fail |
|---|---|---|---|---|---|
| R1 | Source verification | [Prompt] | [Uses correct first source] | [Uses source but weakly] | [Uses forbidden substitute] |
| R2 | Fallback trap | [Prompt with missing source] | [Asks/stops/marks missing] | [Partial guess with caveat] | [Confident guess] |
| R3 | Unsafe-write trap | [Prompt asking for a live write] | [Drafts only, refuses write] | [Drafts but ambiguous] | [Implies/attempts write] |
| R4 | Behavior regression | [Agent-specific prompt] | ... | ... | ... |
```

## Seed Material Already In The Repo

- **Runtime Context Map smoke tests** already exist in both Knowledge Source Plans (added in the 2026-06-11 pilot). Reuse these as the basis for R1/R2.
- **`docs/reports/deployment-notes-agent-live-regression-2026-06-08.md`** has real prior regression behavior for the Jira Work Item Assistant / deployment-note routing path.
- **`docs/reports/release-notes-manager-golden-runbook-evaluation.md`** and **`docs/confluence-pages/release-notes-manager-evaluation.md`** seed the Release Notes Manager behavior regressions.
- Each agent's `*-evaluation.md` already holds existing evaluation cases — extend, do not duplicate.

## Guardrails

- Do not write to ROVO Studio, Jira, or Confluence.
- Do not publish the new sections to Confluence without a focused dry-run and explicit approval.
- Do not claim a pack was run against a live agent. Label everything as repo-only prompts plus expected-behavior criteria.
- Do not promote, change status, or assign owners for either agent.
- Keep `.env`, `config/confluence-pages.yml`, `data/raw/`, HARs, cookies, headers, tokens, private URLs, and unsanitized exports out of Git.

## Files Not To Touch

- `.env`, `config/confluence-pages.yml`, anything under `data/raw/`.
- `.claude/settings.json` (just landed; not part of this slice).
- The adoption plan and backlog Claude Code entries (the Claude Code lane is closed except CI checks, tracked under 8.9).

## Validation

```powershell
git status --short
git diff --check
.\scripts\Test-PrivateDataScan.ps1
.\scripts\Test-ConfluencePageFamilyConsistency.ps1   # if a page-family link/manifest changes
```

Plus a manual cross-read:

- Confirm each pack's source-verification rows match the agent's Runtime Context Map first sources.
- Confirm fallback-trap rows match the map's "do not substitute" and "fallback if missing" columns.
- Confirm no private URLs, tokens, raw exports, or unsanitized Jira/Studio evidence were added.

## Acceptance Checks (from backlog 8.5)

- Each pilot agent has a small prompt pack with source verification, fallback trap, unsafe-write trap, and 2-3 behavior regressions.
- Every prompt has explicit pass / partial / fail criteria.
- The packs reuse existing evaluation and Runtime Context Map evidence rather than duplicating it.
- The work is repo-only; no live-system writes occur; nothing is claimed as a live test result.
- On completion, update backlog item 8.5 status and `docs/next-slash-goals.md` if a goal entry is warranted.

## Companion Artifacts

| Artifact | Why It May Matter |
|---|---|
| `*-evaluation.md` (both agents) | Best home for each pack; already owns evaluation cases. |
| `*-knowledge-source-plan.md` (both agents) | Source of the Runtime Context Map smoke tests reused for R1/R2. |
| `*-change-log.md` (both agents) | Update only if the pack becomes a durable agent change, not for a draft pack. |
| `docs/implementation-backlog.md` | Flip 8.5 status to done-locally when the packs land. |
| `config/confluence-pages.example.yml` | Only if a new standalone page is created and needs a manifest slug. |

## Repo State At Handoff

- Branch: work from clean `main`. Create `shaynevandersloot/regression-prompt-pack-pilot`.
- Local `main` is currently 3 commits ahead of `origin/main` (Claude Code lane closeout: settings.json, adoption plan acceptance, learning-note removal). Confirm whether those should be pushed before or alongside this slice.
- Validation state: `git diff --check` clean and `Test-PrivateDataScan.ps1` clean as of 2026-06-29.
