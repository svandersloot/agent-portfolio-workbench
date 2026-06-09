# ROVO Governance Agent Operating Contract

Use this file as the front door for Codex and other AI-assisted work in this repo. This repo is a governance workbench and audit trail for ROVO agent artifacts; ROVO Studio, Confluence, and Jira remain live systems with explicit approval boundaries.

## Operating Posture

- Keep work read-only-first and dry-run-first.
- Prefer the smallest reviewable slice.
- Treat Git-backed docs, templates, schemas, scripts, reports, and publish history as the local audit trail.
- Do not let prompts, chat history, or unsanitized exports override repo truth.
- State assumptions when evidence is incomplete.
- Stop instead of guessing when the work touches approval authority, visibility, owners, readiness, live publishing, Studio configuration, Jira writes, secrets, raw exports, or privacy-sensitive data.

## Read First

Start planning or implementation with:

1. `AGENTS.md`
2. `README.md`
3. `START-HERE.md`
4. `docs/toolkit-operating-model.md`
5. The task-specific source docs, handoff, report, schema, or Confluence page source

Use `docs/next-slash-goals.md` when choosing or updating the active queue. Use `docs/implementation-backlog.md` when the work changes backlog status, roadmap sequencing, or milestone handling.

## Source Of Truth

Default authority order:

1. Repo source docs, schemas, templates, scripts, reports, and publish history.
2. Published Confluence pages as live human-facing copies of approved repo-backed content.
3. ROVO Studio as the manually configured runtime.
4. Jira as an external work system and source context, not repo governance authority.

When Git, Confluence, Studio, or Jira disagree in a way that affects current truth, readiness, status, ownership, approval, or runtime behavior, stop and report drift. Recommend the smallest reconciliation path instead of silently choosing one surface.

## Live-System Boundaries

Never automate these actions from this repo unless a future accepted governance decision changes the boundary:

- ROVO Studio writes, saves, visibility changes, or permission changes.
- Jira create, update, transition, assign, rank, sprint, or comment actions.
- Confluence publish, update, move, or archive actions without a focused dry-run and explicit approval.

Allowed support:

- Prepare Studio copy packets and guide a human through manual copy steps.
- Capture and normalize Studio configuration after a human saves it.
- Run Confluence dry-runs and prepare publish-history records.
- Draft Jira work item content or comments for human review without posting them.

Keep `.env`, `config/confluence-pages.yml`, `data/raw/`, HARs, cookies, headers, tokens, private URLs, and unsanitized exports out of Git.

## Human-Owned Decisions

Do not promote, approve, or imply final approval for:

- `Active`, broadly `Ready`, or broad pilot status.
- Pilot or broad visibility.
- Primary owner or backup owner assignment.
- Agent retirement, deprecation, archive, duplicate merge, or resurrection.
- Jira write capability.
- Studio visibility or permission changes.
- Policy exceptions or approval-authority changes.

The Design Agent may recommend not building an agent. Treat `prompt`, `automation`, `existing-agent extension`, `Confluence template`, `agent candidate`, and `not ready` as valid intake outcomes when the evidence supports them.

## Current Agent Posture

- Jira Work Item Assistant owns active Jira ticket drafting, Ticket Review / Polish, standards alignment, gap checking, draft status comments, proposed team standards, and common-task guidance.
- Jira Ticket Polisher is archived / superseded history. Do not configure or promote it as a separate active user-facing agent unless a new governed decision reopens it.
- ROVO Design Agent is the primary builder-facing front door for new agent ideas.
- Agent Doc Steward works with the Design Agent on governance documentation quality, context readiness, and Doc Health support.
- Stage 5 uses this repo as the behind-the-scenes control plane while normal pilot users consume approved agents through Jira, Confluence, and ROVO/Studio workflows.

## Risk Scan

Before calling a slice ready to execute, check whether it touches:

- Confluence publishing, page moves, page archival, or live page status.
- ROVO Studio configuration, visibility, permissions, knowledge sources, tools, skills, or activation.
- Jira behavior, especially any write, comment, transition, or create path.
- Owner, backup owner, lifecycle status, readiness status, pilot approval, or retirement.
- Agent behavior that may influence user action or imply governance approval.
- Raw Studio exports, HARs, private URLs, tokens, cookies, headers, secrets, or unsanitized evidence.
- Schemas, normalized output contracts, publisher config, or validation scripts.

If the risk changes approval, visibility, policy, trust, privacy, or write authority, stop for a human decision or produce a decision brief instead of implementing.

## Workflow

Use planning mode when the request is broad, decision-heavy, or still being shaped. Planning output should be a recommendation, decision brief, handoff, or bounded execution packet.

Use implementation mode only when the slice has:

- One observable outcome.
- In-scope and out-of-scope boundaries.
- Source docs or files to update.
- Live-system boundaries.
- Validation or manual checks.

Keep Confluence source pages, Studio setup/configuration pages, evaluation pages, measurement plans, change logs, inventory rows, handoffs, reports, config examples, and publish-history records aligned when a durable governance decision affects them. Use the smallest coherent companion set.

## Branches And Worktrees

After the current `main` state is clean, use named branches for durable slices. The preferred shape is:

```text
shaynevandersloot/<short-slice-description>
```

Use worktrees when parallel work starts or when another conversation owns the active branch. Do not edit files in a branch or worktree owned by another active conversation unless the user explicitly hands it over.

## Validation

Run the smallest truthful checks for the changed surface:

- `git status --short`
- `git diff --check`
- `.\scripts\Test-ConfluencePageFamilyConsistency.ps1` for governed-agent page families or publishing plans
- JSON schema or fixture parsing when schemas, examples, or CSV/JSON evidence changed
- script help or dry-run mode when scripts changed
- manual cross-read for docs-only governance changes

Do not claim a command, publish, Studio save, Jira action, capture, or live verification happened unless it actually happened. If validation is partial, blocked, or manual-only, say so plainly.

## Done State

A slice is done when:

- Scope stayed bounded.
- Live-system boundaries were respected.
- Companion artifacts that would otherwise drift were updated.
- Validation ran or gaps were named.
- Final handoff states changed files, validation, risks, and follow-ups.
