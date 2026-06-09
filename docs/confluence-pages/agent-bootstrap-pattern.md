# Agent Bootstrap Pattern And Studio Setup Checklist

## Status And Ownership

| Field | Value |
|---|---|
| Status | Draft for Deployment Notes pilot |
| Primary owner | Shayne Vandersloot |
| Applies to | Governed ROVO agents that should use Confluence as the versioned source of truth |
| First pilot agents | Jira Work Item Assistant, Release Notes Manager |
| Last reviewed | 2026-06-08 |

## Purpose

Use this page when manually configuring ROVO Studio for governed agents.

The goal is to keep Studio instructions thin and stable while Confluence holds the versioned runtime behavior, standards, evaluation prompts, and setup evidence. Studio should tell the agent who it is, where to route work, which sources are authoritative, what to do when sources are unavailable, and which tools or skills are allowed. It should not copy every detailed rule from the runtime pages.

## Page Types

| Page type | Audience | Purpose |
|---|---|---|
| Runtime/source page | Agent and human reviewer | Defines behavior, standards, examples, anti-patterns, source precedence, and fallback rules. |
| Studio setup page | Human configuring Studio | Lists manual Studio steps, paste-ready bootstrap text, knowledge sources, skills/tools, and smoke tests. |
| Knowledge source plan | Agent owner and reviewer | Defines source authority, allowed use, fallback, and forbidden substitutes. |
| Evaluation or pilot page | Agent owner and stakeholder reviewer | Stores regression prompts, rubrics, expected outputs, and promotion criteria. |
| Repo source | Maintainer | Versioned Markdown source for Confluence pages, reports, and handoffs. |

Do not make an agent depend on a setup page as its behavior source. The setup page explains how to wire Studio; the runtime/source page tells the agent how to behave.

## Manual Setup Workflow

Use this workflow for each governed agent.

1. Confirm the runtime/source pages are published and current.
2. Confirm the knowledge source plan names the authoritative sources, reference-only sources, and forbidden substitutes.
3. Paste only the thin parent-agent bootstrap into Studio.
4. Configure subagents with short identity, trigger, routing, and source-reference instructions.
5. Add the required Confluence pages as explicit Studio knowledge sources.
6. Audit parent skills and each subagent's skills separately; parent skills can be zero while subagents still have write-capable skills.
7. Enable only the read tools and skills needed for the workflow.
8. Disable or leave unconfigured write tools unless a governed write workflow exists.
9. Confirm knowledge source coverage by source type: Confluence can use all content, selected spaces, or selected content under a parent; Jira may be project/space-level rather than page-level.
10. Run the source-verification smoke test.
11. Run two or three behavior regressions.
12. Record pass, partial, or fail before broadening the agent.

For field-level details, use `ROVO Studio Configuration Field Guide`.

## Thin Bootstrap Rules

Studio bootstrap text should include:

- Agent identity and job-to-be-done.
- Primary routing boundaries and handoff targets.
- Links to authoritative runtime/source pages.
- A requirement to retrieve or reference those pages when available.
- Fallback behavior when a source is inaccessible.
- Human approval and write-action boundaries.
- Configured knowledge source reminders.
- Tool and skill stance.

Studio bootstrap text should not include:

- Full templates that already live in Confluence runtime pages.
- Long examples and anti-pattern libraries.
- Historical backtest detail.
- Release-specific issue lists.
- Detailed deployment-note rewrite rules beyond minimal fallback safety.
- Duplicated parent/subagent behavior that can be referenced from a runtime page.

## Deployment Notes Pilot Runtime Sources

| Source | Role | Required knowledge source? |
|---|---|---|
| Deployment Notes Standard for Jira Work Items | Authoritative runtime behavior for Deployment Notes decisions, formatting, source precedence, and inference limits. | Yes, for Jira Work Item Assistant and Release Notes Manager. |
| Deployment Notes Agent Pilot | Evaluation prompts, smoke tests, scoring rubric, and promotion criteria. | Yes, for pilot testing. |
| Knowledge Source Plan - Jira Work Item Assistant | Source authority and fallback plan for Jira Work Item Assistant. | Yes, for agent owner setup and optional agent reference. |
| Knowledge Source Plan - Release Notes Manager | Source authority and fallback plan for Release Notes Manager. | Yes, for agent owner setup and optional agent reference. |
| Jira issue Deployment Notes field | Story-specific system of record evidence. | Use through read-only Jira access. |
| Linked runbook or Confluence page in a Jira issue | Story-specific source evidence when explicitly linked. | Add only when needed or retrieve through approved read access. |

Forbidden substitutes for Deployment Notes behavior:

- MOBRM Team Jira Standards.
- Organization-Wide Jira Ticket Quality Standard.
- Other Jira hygiene or ticket-quality pages.
- Studio memory from prior drafts when the Confluence standard is available.

Those pages can still be useful for general ticket quality, but they are not authoritative for Deployment Notes behavior.

## Jira Work Item Assistant Studio Setup

### Parent Bootstrap

Paste a short parent instruction block like this into Studio after confirming the knowledge sources are configured.

```text
You are Jira Work Item Assistant, a governed Jira work-intake agent.

Help users draft, review, and improve Jira work items from explicit Jira, Kanban, release, Confluence, and user-provided evidence. Keep all Jira create, update, transition, assignment, ranking, and comment-posting actions disabled unless a separately approved write workflow exists and the user approves the exact target and content.

Use the current Confluence runtime/source pages as the source of truth for detailed behavior. For Jira Deployment Notes work, retrieve or reference "Deployment Notes Standard for Jira Work Items" at https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5362778187 before drafting when available. Treat that page as authoritative over this Studio configuration.

Do not substitute MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, or other Jira hygiene pages for the Deployment Notes Standard. If the Deployment Notes Standard is inaccessible, say so clearly and ask the user to provide the page content or approve limited fallback behavior.

Use read-only Jira and Confluence retrieval when available. Work from source evidence, mark missing details as Data Incomplete, keep unresolved questions outside Jira field drafts, and keep final decisions human-owned.
```

### Subagent Scope

Keep subagent setup short.

| Subagent | Trigger | Thin setup stance |
|---|---|---|
| Work Item Drafter | User asks to create, draft, split, or prepare Jira tickets. | Use Jira ticket quality sources and team overlays only when explicitly sourced. Route Deployment Notes behavior to the Deployment Notes Standard. |
| Common Task Guide Builder | User wants repeatable task guidance inside a ticket. | Use approved process pages and user-provided SME context. Do not invent missing steps. |
| Team Standards Resolver/Drafter | Team standard is unknown, missing, ambiguous, or requested. | Separate approved standards from proposed drafts and observed patterns. |
| Status Comment Drafter | User provides progress, blocker, validation, or handoff text for a Jira issue. | Draft only from supplied or visible evidence. Do not post comments during the pilot. |
| Work Item Gap Checker | User asks what is missing or whether a work item is ready. | Return gaps and Data Incomplete flags. Do not certify release readiness. |

### Required Knowledge Sources

Configure these explicitly in Studio where supported:

- Deployment Notes Standard for Jira Work Items: `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5362778187`
- Deployment Notes Agent Pilot: `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5363007530`
- Knowledge Source Plan - Jira Work Item Assistant: `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5348655107`
- Organization-Wide Jira Ticket Quality Standard.
- Team Jira Standards index.
- MOBRM Team Jira Standards only as a MOBRM team overlay, not as a Deployment Notes standard.

### Tools And Skills

Enable:

- Read-only Jira issue retrieval.
- Read-only Confluence page retrieval.
- Approved source search limited to the configured pages and current Jira context.

Do not enable during this pilot:

- Jira create, update, transition, assign, rank, move, or comment actions.
- Confluence publish, create, or update actions.
- Unattended write or approval actions.

### Smoke Tests

Run these after any Studio or source change:

- Jira Work Item Assistant source routing test with `M26-788`.
- Fallback trap test with `M26-788`.
- No-notes test with `MOBPXD-1399`.
- Coordinator test with `MR26-3076`.

Use the prompts and pass/fail criteria from `Deployment Notes Agent Pilot`.

## Release Notes Manager Studio Setup

### Parent Bootstrap

Paste a short parent instruction block like this into Studio after confirming the knowledge sources are configured.

```text
You are Release Notes Manager, a governed release/change agent.

Help users draft, review, synchronize, and organize release notes or deployment work packages from exact release evidence. Do not publish release notes, update Confluence, update Jira, or present content as approved unless a separately approved write workflow exists and a human release owner approves the exact target and content.

Use the current Confluence runtime/source pages as the source of truth for detailed behavior. For Deployment Notes cleanup, deployment runbooks, or release-level deployment coordination, retrieve or reference "Deployment Notes Standard for Jira Work Items" at https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5362778187 before drafting when available. Treat that page as authoritative over this Studio configuration.

Do not substitute MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, or other Jira hygiene pages for the Deployment Notes Standard. If the Deployment Notes Standard is inaccessible, say so clearly and ask the user to provide the page content or approve limited fallback behavior.

Use exact release identifiers, fixVersions, issue lists, release plans, Jira Deployment Notes, and approved source pages. Mark missing release scope, branch/tag, AWS account or role, admin URL, validation, source artifact, or sequencing as Data Incomplete. Keep release approval and deployment execution human-owned.
```

### Subagent Scope

Keep subagent setup short.

| Subagent | Trigger | Thin setup stance |
|---|---|---|
| Technical Release Notes Drafter | User asks for engineering-facing release notes or implementation summaries. | Use exact release scope and approved evidence. Do not invent implementation detail. |
| Technical Deployment Runbook Drafter | User asks for deployment runbook, deployment checklist, or deployment-note rollup. | Use Deployment Notes Standard and produce work packages, not a flat story list. |
| Business Release Summary Drafter | User asks for business-facing or executive summary. | Translate approved evidence without overstating impact or readiness. |
| Release Notes Sync Checker | User asks to compare, reconcile, validate, or find gaps. | Compare against exact release evidence and return conflicts for owner decision. |

### Required Knowledge Sources

Configure these explicitly in Studio where supported:

- Deployment Notes Standard for Jira Work Items: `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5362778187`
- Deployment Notes Agent Pilot: `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5363007530`
- Knowledge Source Plan - Release Notes Manager: `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5300158474`
- Approved release-plan or release-note page family.
- Release Health Analyst outputs only as reference evidence, not as a replacement for release-owner approval.

When auditing Confluence knowledge, do not mark a required child page missing if Studio selected a parent page through `Select content under` and the child is under that parent. Mark the page `Covered by selected parent` instead. Mark it missing only when it is neither directly selected nor covered by a selected parent.

### Tools And Skills

Enable:

- Read-only Jira issue retrieval.
- Read-only Confluence page retrieval.
- Approved source search limited to the configured pages and supplied release scope.

Do not enable during this pilot:

- Confluence publish, create, or update actions.
- Jira update or comment actions.
- Release approval or go/no-go actions.
- Unattended write actions.

Audit these at both parent and subagent level. A parent with no skills can still have subagents that can create or edit Confluence pages, change labels, append content, or modify Jira records.

### Smoke Tests

Run these after any Studio or source change:

- Release Notes Manager batch regression with the ten-story Deployment Notes issue list.
- Source verification check confirming the agent used `Deployment Notes Standard for Jira Work Items`.
- No-action handling check confirming `MOBPXD-1399` stays outside deployment work packages.

Use the prompts and pass/fail criteria from `Deployment Notes Agent Pilot`.

## Source Verification Record

After each manual Studio update, capture:

```text
Manual Studio Setup Record
- Date:
- Agent:
- Studio owner:
- Studio config page used:
- Runtime/source pages configured as knowledge sources:
- Knowledge sources intentionally excluded:
- Tools/skills enabled:
- Tools/skills disabled:
- Smoke test prompt:
- Source verification result:
- Behavior regression result: Pass / Partial / Fail
- Follow-up needed:
```

## Rollout Checklist For Remaining Agents

Use this sequence after the Deployment Notes pilot is proven.

1. Identify the detailed behavior currently copied into Studio.
2. Move durable behavior into a runtime/source page.
3. Create or update the knowledge source plan.
4. Create or update the Studio setup section for the agent.
5. Replace bulky Studio instructions with thin bootstrap text.
6. Configure explicit knowledge sources.
7. Scope tools and skills to read-only or approved write paths.
8. Add a source-verification smoke test.
9. Add two or three behavior regression tests.
10. Record pass, partial, or fail before broadening usage.
