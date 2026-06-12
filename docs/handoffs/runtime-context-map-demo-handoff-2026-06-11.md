# Handoff - Runtime Context Map Demo Slice - 2026-06-11

Use this packet to start a fresh conversation that demonstrates the Runtime Context Map concept without claiming it is already implemented for all governed agents.

## Start Here Prompt

```text
We are continuing the ROVO governance toolkit work with a bounded Runtime Context Map demo slice.

Goal:
- Explain and prototype a lightweight Runtime Context Map pattern for governed ROVO agents.
- Keep the work repo-only and dry-run-first.
- Do not write to ROVO Studio, Jira, or Confluence.
- Do not claim Runtime Context Maps are already implemented for all agents.
- Start with one or two pilot agents that already have strong knowledge source and Studio setup evidence.

Start by reading:
- AGENTS.md
- README.md
- START-HERE.md
- docs/toolkit-operating-model.md
- docs/handoffs/runtime-context-map-demo-handoff-2026-06-11.md
- docs/reports/runtime-context-map-plain-english-preview.html
- docs/confluence-pages/agent-bootstrap-pattern.md
- docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md
- docs/confluence-pages/jira-work-item-assistant-studio-setup.md
- docs/confluence-pages/release-notes-manager-knowledge-source-plan.md
- docs/confluence-pages/release-notes-manager-studio-setup.md
- docs/confluence-pages/release-health-analyst-rovo-studio-configuration.md

Current task:
- Produce a small repo-only Runtime Context Map prototype for 1-2 agents.
- Prefer adding a compact "Runtime Context Map" section to each pilot agent's Knowledge Source Plan rather than creating a new page per agent unless the map grows.
- Include a table for user/task intent, source to use first, forbidden substitutes, fallback behavior, and smoke test prompt.
- Update only the smallest companion files needed for the demo.
- Validate with git diff --check, private-data scan, and manual cross-read.
```

## Plain-English Model

Runtime Context Map means:

> A small routing guide that helps a live ROVO agent use the right source for the right task, instead of trying to read every governance page every time.

The model has three practical deliverables:

| Deliverable | Plain-English Purpose | Who Uses It |
|---|---|---|
| Agent Lab | Builder workshop for iteration, scoring, regression testing, and promotion prep. | Builders and owners |
| Runtime Context Map | Small routing map that tells the live agent which source to use for which task. | Agent runtime and setup reviewers |
| Studio Promotion Packet | Copy-ready Studio config, knowledge sources, test prompts, and human setup checklist. | Human configuring Studio |

Key message:

> The goal is not to make live agents read everything. The goal is to let builders maintain a rich workshop while live agents retrieve only the specific context needed.

## Current State

Do not say the repo already has formal Runtime Context Maps.

The concept currently exists across multiple artifacts:

- Knowledge Source Plans identify trusted sources.
- Studio setup/configuration pages identify required knowledge sources, source precedence, fallback behavior, and smoke tests.
- Project Brain page families connect design, setup, evaluation, measurement, and change history.
- Some agent pages and handoffs already discuss source routing, forbidden substitutes, and fallback behavior.

The proposed improvement is to make this routing explicit and lightweight.

## Recommended Pilot Agents

Start with one or two agents where the source-routing evidence is already strong:

| Candidate | Why It Fits |
|---|---|
| Jira Work Item Assistant | Has Studio setup, knowledge source plan, deployment-note routing evidence, and regression prompts. |
| Release Notes Manager | Has Studio setup, knowledge source plan, deployment-note source-routing issues, and recent regression evidence. |
| Release Health Analyst | Has assessment prompts/configuration and strong release-readiness proof-point value, but may need careful source review. |

Avoid broad backfill across all agents until the table shape proves useful.

## Suggested Runtime Context Map Shape

Add this as a section in the pilot agent's Knowledge Source Plan unless the conversation decides a separate child page is justified.

```markdown
## Runtime Context Map

Use this map to keep runtime retrieval narrow. The live agent should use the smallest trusted source that matches the user's task and should not substitute adjacent governance pages when the mapped source is missing.

| User or task intent | Use this source first | Do not substitute | Fallback if missing | Smoke test prompt |
|---|---|---|---|---|
| [Intent] | [Named page/source] | [Forbidden substitute] | [Ask/stop/mark missing] | [Prompt] |
```

Example rows:

| User or task intent | Use this source first | Do not substitute | Fallback if missing | Smoke test prompt |
|---|---|---|---|---|
| Draft deployment notes | Deployment Notes Standard | Generic Jira hygiene or ticket-polish guidance | Ask for the release scope and standard link | Ask for a deployment-note draft for a story with known evidence. |
| Review ticket quality | Team Jira Standards | Deployment Notes Standard | Ask which team or project standard applies | Ask for a ticket-quality review. |
| Assess release readiness | Release assessment template and Jira evidence | Unlinked assumptions or stale release notes | Mark evidence missing instead of guessing | Ask for a release-readiness assessment with known gaps. |

## Guardrails

- Do not write to ROVO Studio.
- Do not write to Jira.
- Do not publish or update Confluence without a focused dry-run and explicit approval.
- Do not describe Runtime Context Maps as already live unless a human has applied and verified the Studio/source changes.
- Do not add a new required governance artifact across every agent until the pilot proves it reduces drift.
- Do not broaden Studio knowledge access to compensate for missing routing.
- Keep `.env`, `config/confluence-pages.yml`, `data/raw/`, HARs, cookies, headers, tokens, private URLs, and unsanitized exports out of Git.

## Suggested Slice

Smallest useful demo:

1. Add a `Runtime Context Map` section to `docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md`.
2. Add a matching note to `docs/confluence-pages/jira-work-item-assistant-studio-setup.md` only if the setup checklist needs to tell the human which mapped sources to configure.
3. Run a manual cross-read against the existing deployment-note bootstrap handoff.
4. Decide whether Release Notes Manager should receive the same section in the same slice or a follow-up slice.

Do not touch the pitch deck in this implementation slice unless the user explicitly asks.

## Acceptance Checks

- The map is small enough to help runtime routing instead of becoming another giant governance page.
- Each row names a source, forbidden substitute, fallback, and smoke test.
- The map does not imply the live Studio agent has already been updated.
- Any Studio setup update remains a human checklist, not an automated write.
- The final answer clearly says this is a repo-only prototype until manually configured and verified.

## Validation

Run:

```powershell
git status --short
git diff --check
.\scripts\Test-PrivateDataScan.ps1
```

Also run a manual cross-read:

- Confirm the map rows agree with the existing Knowledge Source Plan.
- Confirm any Studio setup wording names only required knowledge sources and smoke tests.
- Confirm no private URLs, tokens, raw exports, or unsanitized Jira/Studio evidence were added.

## Companion Artifacts

Likely companions for a pilot implementation:

| Artifact | Why It May Matter |
|---|---|
| Pilot agent Knowledge Source Plan | Best home for the initial map because it already owns source intent. |
| Pilot agent Studio Setup page | Needed only if the map changes which knowledge sources a human must configure. |
| Evaluation or regression prompt file | Needed only if new smoke tests are added beyond existing prompts. |
| Project Brain change log | Needed only after the pattern becomes a durable agent change, not for a demo-only note. |

No schema, publisher config, or repo-wide policy change should be required for the first demo.
