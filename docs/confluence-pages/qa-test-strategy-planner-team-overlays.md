# Team Overlays - QA Test Strategy Planner

## Purpose

Use this page as the index and operating guide for QA Test Strategy Planner team overlays.

A team overlay is optional team-specific context that helps the agent ask better questions and interpret local source packets. It must not change the reusable core agent behavior unless a separate governed decision updates the runtime contract.

## Overlay Status Labels

Use these labels inside each overlay:

| Label | Meaning | Runtime use |
|---|---|---|
| `Observed Pattern` | Pattern found in historical Jira, Confluence, or team evidence. | May guide follow-up questions. Must not be treated as policy. |
| `Candidate Overlay Field` | Field that may be useful if the QA lead validates it. | May appear in draft overlay or intake checklist. |
| `Validated Team Standard` | QA lead or accountable owner confirmed the field/pattern as team standard. | May be used as team-specific context, still subject to current story evidence. |
| `Data Incomplete` | Evidence is missing, conflicting, stale, or not accessible. | Agent must ask for source or mark the output incomplete. |

## Studio Use

Team overlay pages are conditional knowledge sources.

Configure the core QA Test Strategy Planner sources first. Add a team overlay page only when the pilot or request is for that team/workstream.

Runtime rule:

```text
Use team overlay pages only as team-specific context. Treat unvalidated overlay content as observed pattern, not policy. Do not infer owners, environments, test data, readiness, or approvals unless explicitly supplied by the user or confirmed as a validated team standard.
```

Overlay selection rule:

```text
When the request or source packet references MR26, Mobi Rangers, or the Mobi Rangers board/workstream, use Team Overlay - Mobi Rangers as optional context.

When the request or source packet references M26, Mobilizers, or the Mobilizers board/workstream, use Team Overlay - Mobilizers M26 as optional context.

When the request or source packet references Payment Ninjas, PN, the PN workstream, or the DPT initiative, use Team Overlay - Payment Ninjas as optional context.

If multiple overlays might apply, ask the user which team/workstream to use.

If no team/workstream is clear, do not apply a team overlay. Ask for the team, project key, board, or workstream.
```

## Evidence Gathering Method

When preparing a new team overlay:

1. Review a bounded sample of recent Jira stories, QA tasks, child tasks, and linked requirement sources.
2. Record the sample size, date range, projects/boards, and release/fixVersion scope.
3. Identify recurring planning gaps.
4. Identify common systems, integrations, test types, environments, data needs, automation references, dependencies, and release/readiness signals.
5. Separate observed history from validated standards.
6. Draft candidate overlay fields.
7. Ask the QA lead to validate, reject, or revise the fields before treating anything as team standard.

## Minimum Overlay Sections

Each team overlay should include:

- Status and source scope.
- How Studio should use the overlay.
- Recurring QA planning gaps.
- Common systems and workstreams.
- Common test types.
- Environment and data patterns.
- Automation and suite ownership patterns.
- Release and readiness signals.
- Candidate overlay fields.
- QA lead validation questions.
- Guardrails and non-assumptions.

## Current Draft Overlays

| Overlay | Status | Use |
|---|---|---|
| Team Overlay - Mobi Rangers | Draft / Pilot Evidence Only | Use as observed-pattern context for MR26/Mobi Rangers pilot prompts. |
| Team Overlay - Mobilizers M26 | Draft / Pilot Evidence Only | Use as observed-pattern context for M26/Mobilizers pilot prompts. |
| Team Overlay - Payment Ninjas | Draft / Design-session evidence only | Use as observed-pattern context for Payment Ninjas / PN / DPT prompts; fields pending QA lead validation. |

## Guardrails

- Do not turn observed patterns into policy without QA lead validation.
- Do not infer owner, backup owner, QA sign-off authority, environment, data availability, release readiness, or automation coverage from history.
- Do not use one team's overlay for another team unless the user explicitly asks for structural inspiration only.
- Keep the reusable QA Test Strategy Planner runtime contract team-neutral.
- If a current story conflicts with a team overlay, prefer the current story/source packet and mark the conflict.
