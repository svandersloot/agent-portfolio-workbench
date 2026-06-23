# Agent Modernization Handoff - Thin Studio Setup And Runtime Contract Pattern

Date: 2026-06-17

## Purpose

Continue the legacy-agent modernization work in a separate conversation while the QA Test Strategy Planner pilot continues in its own thread.

This packet is intentionally scoped away from the QA Test Strategy Planner implementation. Treat that agent as a reference example only. Do not modify its pages, prompt dataset, publish history, Studio setup, runtime contract, overlays, or pilot evidence unless the user explicitly hands that work back to the new conversation.

## First Instruction For The Next Conversation

Open a new branch from latest `main` before making edits.

Recommended command flow:

```powershell
git fetch --prune origin
git switch main
git pull --ff-only origin main
git switch -c shaynevandersloot/agent-modernization-patterns
```

If the active workspace is already occupied by another conversation, use a worktree instead:

```powershell
git fetch --prune origin
git worktree add .codex-worktrees/agent-modernization-patterns main
Set-Location .codex-worktrees/agent-modernization-patterns
git switch -c shaynevandersloot/agent-modernization-patterns
```

If that branch name already exists, choose a similarly specific branch name such as `shaynevandersloot/qa-architect-runtime-modernization`.

## Operating Boundaries

- Keep work read-only-first and dry-run-first.
- Do not write to ROVO Studio.
- Do not create, update, transition, assign, rank, sprint, or comment on Jira issues.
- Do not publish, update, move, or archive Confluence pages without a focused dry-run and explicit user approval.
- Do not claim an agent is `Active`, broadly `Ready`, approved for broad pilot, retired, deprecated, or assigned to an owner unless that decision is already recorded by a human-owned source.
- Keep `.env`, `config/confluence-pages.yml`, `data/raw/`, HARs, cookies, headers, tokens, private URLs, and unsanitized exports out of Git.
- Keep this work separate from the QA Test Strategy Planner branch and pilot thread.

## Context

The QA Test Strategy Planner work established a newer governed-agent documentation pattern:

- `Project Brain - <Agent>`
- `Runtime Contract - <Agent>`
- `Studio Setup - <Agent>`
- `Knowledge Source Plan - <Agent>`
- `Subagent Settings - <Agent>` or an explicit single-agent decision
- `Evaluation - <Agent>`
- `Measurement Plan - <Agent>`
- `Change Log - <Agent>`
- `Prompt Library - <Agent>` when reusable end-user prompting guidance adds value
- A thin Studio setup page that tells the human configurator exactly what to configure in ROVO Studio
- A runtime contract page that owns behavior, routing, guardrails, refusal boundaries, and output expectations
- A parent/subagent matrix that lists scoped skills, tools, and knowledge sources

The older naming `ROVO Studio Configuration - <Agent>` should be assessed agent by agent. In many cases it should be renamed, reframed, or split so manual setup lives in `Studio Setup - <Agent>` and runtime behavior lives in `Runtime Contract - <Agent>`.

## Backlog Anchor

Use `docs/implementation-backlog.md` as the backlog source. The relevant modernization item is:

```text
8.12 - Align legacy agents to thin Studio setup and runtime contract pattern
```

Expected assessment from prior work:

- QA Test Strategy Planner is aligned and should be treated as the reference example, not as in-scope edit work.
- QA Test Case Architect v2 has a Studio Setup page pattern, but older `ROVO Studio Configuration` naming and runtime behavior pages may still need to be renamed, reframed, or repo-backed.
- Jira Work Item Assistant and Release Notes Manager appear to have Studio Setup pages but may still need the thin setup/runtime contract split and the parent/subagent skills and knowledge-source matrix.
- Release Drift Monitor, Release Health Analyst, ROVO Design Agent vNext, and Jira Ticket Polisher need assessment before changes. Jira Ticket Polisher is archived/superseded history and should not be promoted as a separate active user-facing agent unless a new governed decision reopens it.

## Recommended Priority

1. QA Test Case Architect v2
2. Jira Work Item Assistant
3. Release Drift Monitor
4. Release Health Analyst
5. Release Notes Manager
6. ROVO Design Agent vNext
7. Archived or superseded agents only after confirming whether they should be left as history

Start with QA Test Case Architect v2 because QA Test Strategy Planner routes test case generation, RTM, coverage mapping, and XRAY CSV requests to it.

## Suggested First Slice

Assess QA Test Case Architect v2 only.

Read current repo and Confluence-backed source artifacts first, then decide the smallest coherent update. Do not modernize multiple agents in one slice unless the user explicitly asks for a broader sweep.

Expected questions to answer:

- Which QA Test Case Architect v2 pages exist locally?
- Which pages are published in Confluence?
- Is there a `Project Brain` source?
- Is there a separate `Studio Setup` page?
- Is there a page currently named `ROVO Studio Configuration` that should become or feed a `Runtime Contract`?
- Is the test artifact generation boundary clear: test cases, coverage maps, RTMs, XRAY CSV, and artifact packs?
- Are all outputs draft-only, with no Jira, XRAY, Confluence, or Studio writes?
- Are downstream and upstream routing boundaries clear with QA Test Strategy Planner, Jira Work Item Assistant, Release Health Analyst, Release Drift Monitor, and Performance Test Report Agent?
- Does the Studio setup include a clear matrix of parent/subagent skills, tools, and knowledge sources?
- Does the evaluation page include prompt cases for source discipline, routing, refusal boundaries, XRAY/RTM generation, and Data Incomplete behavior?

## Likely Companion Artifacts

For each modernized agent, expect to review or update the smallest useful subset of:

- `docs/confluence-pages/<agent>-project-brain.md`
- `docs/confluence-pages/<agent>-runtime-contract.md`
- `docs/confluence-pages/<agent>-studio-setup.md`
- `docs/confluence-pages/<agent>-knowledge-source-plan.md`
- `docs/confluence-pages/<agent>-subagent-settings.md`
- `docs/confluence-pages/<agent>-evaluation.md`
- `docs/confluence-pages/<agent>-measurement-plan.md`
- `docs/confluence-pages/<agent>-change-log.md`
- `docs/confluence-pages/<agent>-prompt-library.md`, when useful
- `docs/confluence-pages/agent-inventory.md`, only if inventory fields truly change
- `config/confluence-pages.example.yml`, if a new repo-backed page source needs a publish manifest entry
- `docs/publish-history/`, only after an approved Confluence apply
- `docs/implementation-backlog.md`, if backlog status or sequencing changes

## Reference Files

Read these first in the new conversation:

- `AGENTS.md`
- `README.md`
- `START-HERE.md`
- `docs/toolkit-operating-model.md`
- `docs/implementation-backlog.md`

Use these QA Test Strategy Planner files only as examples of the new pattern:

- `docs/confluence-pages/qa-test-strategy-planner-project-brain.md`
- `docs/confluence-pages/qa-test-strategy-planner-runtime-contract.md`
- `docs/confluence-pages/qa-test-strategy-planner-studio-setup.md`
- `docs/confluence-pages/qa-test-strategy-planner-prompt-library.md`
- `docs/confluence-pages/qa-test-strategy-planner-evaluation.md`
- `docs/publish-history/2026-06-17-qa-test-strategy-planner-governance.md`

## Acceptance Criteria

- The new conversation starts from latest `main` and creates its own branch or worktree branch.
- The QA Test Strategy Planner work is not edited unless explicitly brought into scope.
- Current state is assessed before any rename or page split.
- Only one agent modernization slice is changed at a time unless the user approves a broader batch.
- Old naming drift is documented clearly.
- `Studio Setup - <Agent>` remains a thin human configuration page.
- `Runtime Contract - <Agent>` owns behavior, routing, output contracts, and guardrails.
- Parent/subagent skills, tools, and knowledge sources are visible in a matrix.
- Evaluation includes source discipline, routing, refusal/write boundaries, and manual Studio test prompts.
- Confluence publishing, if needed, happens only after dry-run and explicit approval.

## Validation

Run the smallest truthful checks for the touched surface:

```powershell
git status --short
git diff --check
.\scripts\Test-ConfluencePageFamilyConsistency.ps1
.\scripts\Test-PrivateDataScan.ps1
```

If prompt CSVs or JSON fixtures change, parse them with an appropriate local parser. If Confluence pages are prepared for publishing, run the publisher in dry-run mode first and capture/update publish history only after the user approves the live apply.

## Suggested Prompt For The New Conversation

```text
Continue the agent modernization backlog from docs/handoffs/agent-modernization-new-pattern-handoff-2026-06-17.md. Start from latest main, create a new branch, assess QA Test Case Architect v2 first, and do not modify QA Test Strategy Planner except as reference.
```
