# Handoff - Release Health Analyst Automation Workflow

## Current Answer

Set up Release Health Analyst with the same safe automation pattern proven for Release Drift Monitor:

```text
Scheduled or manual trigger
-> Use agent
-> Publish new page
```

Do not let the Rovo agent create, edit, append, or update Confluence pages directly during the pilot. Keep `allowAgentToExecuteActions` disabled for the agent. Let the deterministic Confluence Automation `Publish new page` action create a draft child page from `{{agentResponse}}`.

The canonical Release Health Analyst assessment page should remain human-curated. A human reviews the draft child page, copies the useful replacement assessment content into the canonical page, and preserves normal Confluence version history on the reviewed page.

## Why This Packet Exists

The Release Drift Monitor automation showed that:

- The agent can generate useful release evidence output from Jira and Confluence context.
- Agent-planned Confluence writes may remain `planned` unless write execution is enabled.
- Direct append/update is awkward for canonical pages because it can clutter or overwrite reviewed structure.
- Creating draft child pages under the canonical page is a safer review buffer.
- Raw Confluence Automation exports contain live Atlassian IDs and should not be committed.

Use this packet to start a new conversation focused on configuring the Release Health Analyst automation workflow without rediscovering those details.

## Live Source Pages To Inspect First

Use these repo-backed governance pages before configuring the workflow:

| Source | Purpose |
|---|---|
| `docs/confluence-pages/release-health-analyst-rovo-studio-configuration.md` | Current Release Health Analyst Studio instructions and permission stance. |
| `docs/confluence-pages/release-health-analyst-assessment-template.md` | Canonical assessment page structure. |
| `docs/confluence-pages/release-health-analyst-assessment-prompts.md` | Initial assessment and rerun prompt workflows. |
| `docs/confluence-pages/release-health-analyst-remediation-plan.md` | Boundary between Release Health Analyst and Release Drift Monitor. |
| `docs/reports/release-drift-monitor-automation-rule-sanitized-2026-06-02.json` | Sanitized reference for the working draft-child-page automation pattern. |

Also inspect the current live Confluence assessment page that the user wants to use for the June release.

## Recommended Automation Shape

### Trigger

Use one of these:

| Trigger | Recommended use |
|---|---|
| `Manual trigger from page` | Best for Release Health Analyst reruns because readiness assessments are review events, not daily drift pulses. |
| `Scheduled` with weekday cron | Acceptable during a short active readiness window when the user wants fresh draft pages without manually starting the run. |

If using `Scheduled`, prefer weekdays only. Weekend runs are not useful for the Mobilitas pilot because release evidence generally does not change on Saturday/Sunday.

Known Confluence limitation from the pilot: the scheduled trigger UI may not support "run until this date." For the July drift pulse, disable the automation manually at code freeze on `2026-06-23`, or add a separate operational reminder/checklist item to pause it. Do not rely on the rule stopping itself unless a future UI exposes an end date.

### Action 1: Use Agent

Select Release Health Analyst.

Keep the agent read-only for page writes. The agent should return copy-ready content only.

Use this prompt for a rerun of an existing June assessment page:

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

Use this prompt for the July release when ready:

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

### Action 2: Publish New Page

Use the normal Confluence Automation action, not an agent action.

| Field | Value |
|---|---|
| Space | Select the target space explicitly. Do not rely on `Same space as trigger` if the parent dropdown stays disabled. |
| Parent | Select the current Release Health Analyst assessment page for the release. |
| Page title | Use a draft title with release, local time, and UTC. |
| Page content | `{{agentResponse}}` |
| Create page as | Current Flow Actor, unless governance requires a service owner. |

Suggested June title:

```text
Release Health Assessment Draft - Mobilitas 2026.06.12 - {{now.convertToTimeZone("America/Phoenix").format("yyyy-MM-dd HH:mm")}} MST UTC-07 - {{now.format("HH:mm")}} UTC
```

Suggested July title:

```text
Release Health Assessment Draft - Mobilitas 2026.07.10 - {{now.convertToTimeZone("America/Phoenix").format("yyyy-MM-dd HH:mm")}} MST UTC-07 - {{now.format("HH:mm")}} UTC
```

If Confluence rejects `convertToTimeZone`, fall back to:

```text
Release Health Assessment Draft - [Release] - {{now.format("yyyy-MM-dd HH:mm")}} UTC
```

and keep the timezone explanation in the agent output.

## Suggested Operating Model

For June:

1. Use the user's existing June Release Health Analyst page as the parent.
2. Prefer a manual trigger from that page for the first run.
3. Generate a draft child page.
4. Review the child page.
5. Copy the `Fully Updated Page Body` or selected sections into the canonical assessment page.
6. Archive the draft child page after the canonical page has been updated.

For July:

1. Continue Release Drift Monitor weekday draft pulses until code freeze on `2026-06-23`.
2. Disable or pause the drift automation at code freeze unless a human wants post-freeze drift history.
3. Create the July Release Health Analyst assessment page when the release owner is ready.
4. Run Release Health Analyst against the July assessment page and include the latest drift page/draft as evidence.
5. Treat drift findings as source evidence, not final readiness decisions.

## Validation Checklist

- [ ] Automation has exactly the intended trigger, `Use agent`, and `Publish new page` steps.
- [ ] Release Health Analyst agent action does not have write execution enabled.
- [ ] Agent prompt says not to edit, append, create, or update Confluence pages.
- [ ] `Publish new page` uses `{{agentResponse}}`.
- [ ] Parent page is the correct current assessment page.
- [ ] First run creates a child page, not an edit to the parent page.
- [ ] Parent page version does not change until the human manually updates it.
- [ ] Draft child page contains a complete copy-ready assessment body.
- [ ] Final go/no-go language remains human-owned.
- [ ] Jira, PR, release status, and deployment records are not mutated.

## Export And Version Control Guidance

After the workflow is proven:

1. Export the Confluence Automation rule JSON.
2. Do not commit the raw export.
3. Create a sanitized capture under `docs/reports/`.
4. Redact account IDs, cloud IDs, connection IDs, rule/component UUIDs, checksums, ARIs, page IDs, space IDs, and private page URLs.
5. Add a publish-history note under `docs/publish-history/`.
6. Validate JSON with:

```powershell
python -m json.tool docs\reports\<sanitized-file>.json
```

The repo now ignores raw `automation-rule-*.json` exports.

## Slash Goal For New Conversation

```text
/goal Set up a Release Health Analyst Confluence Automation workflow using docs/handoffs/release-health-analyst-automation-handoff.md. First inspect the handoff packet, the Release Health Analyst Studio configuration, assessment template, assessment prompt library, remediation plan, and current git status. Do not write to Studio directly from Codex. Guide me through configuring a Confluence Automation rule that keeps the Release Health Analyst agent write-disabled, runs the agent against the current June Mobilitas assessment page, and publishes the result as a draft child page using {{agentResponse}}. Prefer a manual trigger from the assessment page for the first run; use a weekday scheduled trigger only if I explicitly choose it. Confirm the first run creates a child page and does not edit the parent. Then prepare a July-ready variant that can consume the Release Drift Monitor page/history as source evidence after verifying exact release identity, branch, source freshness, unresolved WARN/BLOCK/UNKNOWN findings, and accepted exceptions. If I export the rule JSON, sanitize it before committing; never commit raw automation exports.
```

Acceptance checks:

- Uses the current June assessment page as the parent for draft child pages.
- Keeps the canonical assessment page human-curated.
- Uses `{{agentResponse}}` in `Publish new page`.
- Does not enable direct Rovo agent page writes.
- Includes timezone in draft child page titles when Confluence smart values support it.
- Documents the July path where Release Health Analyst consumes Release Drift Monitor history as source evidence.
- Notes that Confluence scheduled triggers may need manual disabling at code freeze because no end date is available in the observed UI.
