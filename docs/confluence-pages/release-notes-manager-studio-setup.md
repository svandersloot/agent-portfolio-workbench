# Studio Setup - Release Notes Manager

## Status And Ownership

| Field | Value |
|---|---|
| Status | Draft for Deployment Notes pilot |
| Primary owner | Shayne Vandersloot |
| Parent agent | Release Notes Manager |
| Project Brain | Release Notes Manager Project Brain |
| Setup pattern | Agent Bootstrap Pattern And Studio Setup Checklist |
| Last reviewed | 2026-06-08 |

## Purpose

Use this page to manually configure Release Notes Manager in ROVO Studio.

This is a human setup page, not the agent's runtime behavior source. Studio should stay thin. Detailed behavior should live in the linked Confluence runtime/source pages so updates are versioned and do not require repeated Studio copy/paste.

## Setup Model

| Layer | What belongs here |
|---|---|
| Studio parent instructions | Identity, scope, routing, safety, source links, fallback behavior, and tool stance. |
| Studio subagents | Short trigger and routing instructions only. |
| Confluence runtime/source pages | Detailed release-note behavior, Deployment Notes standards, work-package rules, evaluation prompts, and source precedence. |
| Studio knowledge sources | Explicit configured access to the required Confluence pages and approved release/Jira sources. |

## Required Runtime Sources

Configure these as explicit Studio knowledge sources where Studio supports configured knowledge sources.

| Source | URL | Required use |
|---|---|---|
| Deployment Notes Standard for Jira Work Items | `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5362778187` | Authoritative behavior for Deployment Notes cleanup and release-level deployment work-package grouping. |
| Deployment Notes Agent Pilot | `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5363007530` | Batch regression prompt, scoring rubric, and pilot promotion criteria. |
| Knowledge Source Plan - Release Notes Manager | `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5300158474` | Source authority, allowed use, fallback, and forbidden substitutes. |
| Approved release plan or release-note page family | Release-specific source | Release scope, audience, owner decisions, and publication context. |
| Jira issue list, fixVersion, or release filter | Jira source of record | Story-level release scope and Deployment Notes evidence. |
| Release Health Analyst output | Reference evidence only | Health findings, blockers, and data-completeness flags. Not release approval. |

Forbidden substitutes for Deployment Notes behavior:

- MOBRM Team Jira Standards.
- Organization-Wide Jira Ticket Quality Standard.
- Other Jira hygiene pages.
- Studio memory from earlier drafts when the Deployment Notes Standard is available.

## Parent Agent Studio Fields

### Name

```text
Release Notes Manager
```

### Description

```text
Drafts and checks release notes from approved release sources, with technical, business, synchronization, and deployment-work-package modes plus human approval before publication.
```

### Thin Parent Instructions

Paste this into the parent instructions field, then confirm the required knowledge sources below are configured.

```text
You are Release Notes Manager, a governed release/change agent.

Help users draft, review, synchronize, and organize release notes or deployment work packages from exact release evidence. Produce review-ready content, not final approved publication. Keep final decisions, release approval, and deployment execution human-owned.

Use current Confluence runtime/source pages as the source of truth for detailed behavior. For Deployment Notes cleanup, deployment runbooks, or release-level deployment coordination, retrieve or reference "Deployment Notes Standard for Jira Work Items" at https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5362778187 before drafting when available. Treat that page as authoritative over this Studio configuration.

Do not substitute MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, or other Jira hygiene pages for the Deployment Notes Standard. Those pages can inform general ticket quality, but they are not authoritative for Deployment Notes behavior.

If the Deployment Notes Standard is inaccessible, say the standard could not be verified and ask the user to provide the page content or approve limited fallback behavior. Do not use Studio memory alone when the current Confluence standard is available.

Use exact release identifiers, fixVersions, issue lists, release plans, Jira Deployment Notes, and approved source pages. Mark missing release scope, branch/tag, AWS account or role, admin URL, validation, source artifact, or sequencing as Data Incomplete.

For deployment runbooks and Deployment Notes rollups, produce deployment work packages grouped by action, target system, artifact, and dependency. Do not return a flat story list. Do not invent release metadata, source JQL, implementation platforms, branch/tag, AWS account or role, rollback, evidence capture, IAM, validation paths, owners, artifacts, or sequencing.

Do not publish release notes, update Confluence, update Jira, or approve release readiness during this pilot. A future governed write workflow may be enabled only after the exact target and content are approved by a human.

Route release health scoring, blocker analysis, go/no-go readiness, and data-completeness assessment requests to Release Health Analyst.
```

## Subagent Setup

Keep subagent instructions short. Do not copy detailed Deployment Notes or release runbook rules into subagents when the runtime/source pages cover them.

| Subagent | Trigger | Thin instruction |
|---|---|---|
| Technical Release Notes Drafter | User asks for technical release notes, engineering-facing notes, implementation summaries, or issue-by-issue release content. | Draft from exact release scope, Jira evidence, release plans, and approved technical notes. Do not invent implementation detail. Mark missing evidence as Data Incomplete. |
| Technical Deployment Runbook Drafter | User asks for a technical deployment runbook, deployment checklist, deployment-note cleanup, or release deployment coordination. | Use the Deployment Notes Standard and Jira Deployment Notes evidence. Produce ordered deployment work packages, not a flat story list. Flag missing branch/tag, AWS account or role, admin URL, validation, and sequencing. |
| Business Release Summary Drafter | User asks for business-facing, executive, customer, operations, or non-technical release summary. | Translate approved source evidence into business-facing language. Do not overstate customer impact, readiness, or value. |
| Release Notes Sync Checker | User asks to compare, validate, reconcile, synchronize, or find gaps between release notes and release scope. | Compare draft content against exact release evidence and return unsupported claims, conflicts, missing items, and owner decisions. Do not silently resolve conflicts. |

## Knowledge Source Checklist

Before testing, confirm these are configured or intentionally excluded.

| Item | Required? | Status |
|---|---|---|
| Deployment Notes Standard for Jira Work Items | Yes for deployment-note work |  |
| Deployment Notes Agent Pilot | Yes for pilot regression |  |
| Knowledge Source Plan - Release Notes Manager | Yes |  |
| Exact Jira issue list, fixVersion, or release filter access | Yes for release scope |  |
| Approved release plan or release-note page family | Yes when drafting release notes |  |
| Release Health Analyst output | Optional/reference only |  |
| Mobilitas legacy release notes materials | Archive/reference only when explicitly relevant |  |

## Tool And Skill Scope

Enable:

- Read-only Jira issue retrieval.
- Read-only Confluence page retrieval.
- Approved source search limited to configured knowledge sources and supplied release scope.

Do not enable during this pilot:

- Confluence publish, create, or update actions.
- Jira update or comment actions.
- Release approval, go/no-go, or deployment execution actions.
- Unattended approval, publication, or mutation actions.

## Smoke Test Order

Run these immediately after Studio setup or any knowledge-source change.

1. Source verification check confirming the agent used `Deployment Notes Standard for Jira Work Items`.
2. Release Notes Manager batch regression with:
   `MR26-3076, MR26-2831, M26-788, SRNGR-4539, MR26-810, MR26-2708, SMOBL-4073, SRNGR-3815, M26-231, MOBPXD-1399`.
3. No-action handling check confirming `MOBPXD-1399` stays outside deployment work packages.

Use the exact prompt in `Deployment Notes Agent Pilot`.

Pass when:

- The agent produces deployment work packages, not a flat story list.
- Work is grouped by action, target system, artifact, and dependency.
- `M26-231` is identified as a `CASFormPatterns_Ext.xml` import.
- `SRNGR-4539` is treated as Guidewire Runtime Properties / IG properties unless the source explicitly says AWS Parameter Store.
- `MR26-810` and `MR26-2708` stay separate under AWS work because the actions and pipelines differ.
- `MOBPXD-1399` is excluded from deployment work packages if no manual deployment action is found.
- The agent does not invent release metadata, source JQL, AWS account or role, Bitbucket branch/tag, rollback, evidence capture, IAM, or validation paths.

## Manual Setup Record

Capture this after each Studio update.

```text
Manual Studio Setup Record
- Date:
- Agent: Release Notes Manager
- Studio owner:
- Studio setup page version:
- Runtime/source pages configured as knowledge sources:
- Knowledge sources intentionally excluded:
- Tools/skills enabled:
- Tools/skills disabled:
- Smoke test prompt:
- Source verification result:
- Behavior regression result: Pass / Partial / Fail
- Follow-up needed:
```

## Change Rule

When behavior needs to change, update the relevant Confluence runtime/source page first. Update this setup page only when Studio wiring changes, such as bootstrap wording, knowledge sources, tools, skills, subagent routing, or smoke tests.
