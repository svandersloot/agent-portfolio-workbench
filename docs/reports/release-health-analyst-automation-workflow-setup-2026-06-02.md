# Release Health Analyst Automation Workflow Setup - 2026-06-02

## Source Review

Reviewed local source artifacts:

| Artifact | Relevant finding |
|---|---|
| `docs/handoffs/release-health-analyst-automation-handoff.md` | Use the proven safe automation shape: trigger, `Use agent`, then `Publish new page`; keep the agent write-disabled and publish a draft child page from `{{agentResponse}}`. |
| `docs/confluence-pages/release-health-analyst-rovo-studio-configuration.md` | Release Health Analyst may provide copy-ready output and must keep final readiness human-owned; page writes require preview and explicit human confirmation if performed through Studio. |
| `docs/confluence-pages/release-health-analyst-assessment-template.md` | Canonical assessment structure includes Assessment Fingerprint, readiness summary, issue classification, source completeness, blockers, risks, accepted exceptions, resolved/superseded items, and next assessment instructions. |
| `docs/confluence-pages/release-health-analyst-assessment-prompts.md` | Reruns should use the current page as prior state, preserve useful content, move cleared items to resolved/superseded, and return a fully updated copy-ready body. |
| `docs/confluence-pages/release-health-analyst-remediation-plan.md` | Release Drift Monitor history is source evidence only; verify exact release identity, branch, source freshness, unresolved `BLOCK`/`WARN`/`UNKNOWN`, and accepted exceptions before use. |
| `docs/reports/release-drift-monitor-automation-rule-sanitized-2026-06-02.json` | Reference sanitized automation pattern uses `allowAgentToExecuteActions: false` and a deterministic Confluence `Publish new page` action with `{{agentResponse}}`. |

Current local git status at setup time: clean on `main...origin/main`.

No raw Confluence Automation export was present in the worktree at setup time. Raw exports matching `automation-rule-*.json` are ignored by `.gitignore` and must not be committed.

After the June automation export was provided from Downloads, a sanitized capture was created at `docs/reports/release-health-analyst-automation-rule-sanitized-2026-06-02.json`. The raw export was not copied into the repo.

## June First-Run Rule

Use a manual trigger from the current June assessment page for the first run.

Rule name:

```text
Release Health Analyst - June 2026 Assessment Draft
```

Automation shape:

```text
Manual trigger from page
-> Use agent
-> Publish new page
```

### Trigger

| Field | Value |
|---|---|
| Trigger | Manual trigger from page |
| Page where first run starts | Current June Release Health Analyst assessment page |
| Parent page for draft child | Same current June Release Health Analyst assessment page |

The local reusable structure reference is `Release Health Analyst Assessment: Mobilitas 2026.06.12 v2`, but the live current page must be treated as authoritative for the actual run.

### Use Agent

| Field | Value |
|---|---|
| Agent | Release Health Analyst |
| Allow agent to execute actions | Disabled / false |
| Purpose | Return copy-ready assessment content only |

Prompt:

```text
Rerun the Release Health Analyst assessment for the existing June Mobilitas release assessment page.

Current assessment page:
[PASTE CURRENT JUNE RELEASE HEALTH ANALYST ASSESSMENT PAGE LINK]

Release identity:
Mobilitas 2026.06.12

Release stage:
[After code freeze / release readiness / post-freeze - confirm from current page]

Code freeze date:
[confirm from current page or release plan]

Source-truth branch:
[confirm from current page or release plan]

Use the current assessment page as prior state and use current accessible evidence from Jira, Confluence, QA/testing, deployment/change, release notes, and any release drift handoff/history if present.

Do not edit, append, create, or update any Confluence page.
Do not plan Confluence actions.
Return only copy-ready content for a draft child page.

Follow:
- Template - Release Health Analyst Assessment Page
- Prompt Library - Release Health Analyst Assessment Pages
- Rerun Existing Assessment Page workflow

Preserve useful existing blockers, risks, accepted exceptions, source gaps, questions, and follow-up items unless new evidence supersedes them.
Move cleared items to Resolved Or Superseded Items with evidence.
Keep final readiness human-owned.

Include:
- Assessment Fingerprint
- Previous State From Current Page
- New Evidence Reviewed
- What Changed Since The Current Page
- Updated Readiness Summary
- P1 Blockers
- P2/P3 Risks And Cleanup Items
- Accepted Exceptions And Caveats
- Resolved Or Superseded Items
- Source Completeness
- Questions For Release Owner
- Fully Updated Page Body
- Next Assessment Instructions

Do not make the final human go/no-go decision.
Do not transition Jira issues.
Do not approve or merge PRs.
Do not change release status.
```

### Publish New Page

Use the Confluence Automation `Publish new page` action, not an agent write action.

| Field | Value |
|---|---|
| Space | Select the target space explicitly |
| Parent | Current June Release Health Analyst assessment page |
| Page title | `Release Health Assessment Draft - Mobilitas 2026.06.12 - {{now.convertToTimeZone("America/Phoenix").format("yyyy-MM-dd HH:mm")}} MST UTC-07 - {{now.format("HH:mm")}} UTC` |
| Page content | `{{agentResponse}}` |
| Create page as | Current Flow Actor unless governance requires a service owner |

Fallback title if Confluence rejects `convertToTimeZone`:

```text
Release Health Assessment Draft - Mobilitas 2026.06.12 - {{now.format("yyyy-MM-dd HH:mm")}} UTC
```

## First-Run Confirmation

Before enabling broader use, confirm:

- The rule has exactly the intended trigger, `Use agent`, and `Publish new page` steps.
- The Release Health Analyst step has agent action execution disabled.
- The agent prompt explicitly prohibits editing, appending, creating, or updating Confluence pages.
- `Publish new page` uses `{{agentResponse}}`.
- The parent is the current June assessment page.
- Running the manual trigger creates a child page below the June assessment page.
- The June parent page version does not change from the automation run.
- The child page contains a complete copy-ready assessment body.
- Final readiness remains human-owned.
- Jira, pull requests, release status, deployment records, and the parent page are not mutated.

## July-Ready Variant

Rule name:

```text
Release Health Analyst - July 2026 Assessment Draft
```

Use the same automation shape:

```text
Manual trigger from page
-> Use agent
-> Publish new page
```

Prompt:

```text
Create or rerun the Release Health Analyst assessment for Mobilitas 2026.07.10.

Current assessment page:
[PASTE JULY RELEASE HEALTH ANALYST ASSESSMENT PAGE LINK IF ONE EXISTS]

Release identity:
Mobilitas 2026.07.10

Release stage:
[Before code freeze / At code freeze / After code freeze]

Code freeze date:
2026-06-23

Source-truth branch:
[develop before freeze / release branch at or after freeze once confirmed]

Release Drift evidence:
[PASTE CANONICAL JULY RELEASE DRIFT PAGE OR LATEST DRAFT CHILD PAGE LINK]

Use Release Drift Monitor output as source evidence only after verifying exact release identity, source-truth branch, unresolved WARN/BLOCK/UNKNOWN findings, accepted exceptions, and source freshness.

Do not treat Release Drift Monitor findings as automatic go/no-go decisions.
Do not edit, append, create, or update any Confluence page.
Do not plan Confluence actions.
Return only copy-ready content for a draft child page.

Follow:
- Template - Release Health Analyst Assessment Page
- Prompt Library - Release Health Analyst Assessment Pages
- Rerun With Release Drift Handoff rules when drift evidence is provided

Keep final readiness human-owned and keep source completeness visible.
```

Publish title:

```text
Release Health Assessment Draft - Mobilitas 2026.07.10 - {{now.convertToTimeZone("America/Phoenix").format("yyyy-MM-dd HH:mm")}} MST UTC-07 - {{now.format("HH:mm")}} UTC
```

July evidence gate before using Release Drift Monitor history:

- Exact release identity must be `Mobilitas 2026.07.10`.
- Source-truth branch must match the July release stage or a documented override.
- Source freshness must be acceptable for the assessment run date.
- Unresolved `BLOCK`, `WARN`, and `UNKNOWN` findings must be identified and carried as evidence.
- Accepted exceptions must be documented as human-owned caveats.
- Drift findings must not become automatic readiness decisions.

If the July variant becomes scheduled during the active readiness window, prefer weekdays only and manually pause/disable at code freeze on `2026-06-23` unless Confluence exposes a verified end-date control.

## Export Handling

If the rule is exported after a successful pilot:

1. Do not commit the raw Confluence Automation JSON export.
2. Create a sanitized capture under `docs/reports/`.
3. Redact account IDs, cloud IDs, connection IDs, rule/component UUIDs, checksums, ARIs, page IDs, space IDs, and private page URLs.
4. Preserve only the governed automation shape, selected agent name, `allowAgentToExecuteActions: false`, redacted parent/page placeholders, and `{{agentResponse}}` body usage.
5. Add a publish-history note under `docs/publish-history/`.
6. Validate sanitized JSON with:

```powershell
python -m json.tool docs\reports\<sanitized-file>.json
```

Current sanitized export:

```powershell
python -m json.tool docs\reports\release-health-analyst-automation-rule-sanitized-2026-06-02.json
```

Known export finding: the schedule contains both cron and RRULE representations. Verify the UI-displayed run time in Confluence Automation after every schedule edit and treat the UI as authoritative.
