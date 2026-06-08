# Deployment Notes Agent Pilot

## Status And Ownership

| Field | Value |
|---|---|
| Status | Draft for pilot |
| Primary owner | Shayne Vandersloot |
| Co-owner | Hareesh |
| Required stakeholder group | Release Management |
| Related standard | Deployment Notes Standard for Jira Work Items |
| Primary test agents | Jira Work Item Assistant, Release Notes Manager |
| Last reviewed | 2026-06-08 |

## Purpose

Use this page to test the Deployment Notes Standard before promoting it to an active team standard.

The pilot uses historical Jira cards with populated Deployment Notes, rewrites them through the standard, and checks whether Jira Work Item Assistant and Release Notes Manager produce useful, source-backed output.

## Source Query

Use exact fixVersion values when possible. Native Jira JQL generally does not support `LIKE` on `fixVersion`, so prefer an explicit list.

```text
fixVersion in (
  "Mobilitas 2026.01.09",
  "Mobilitas 2026.01.23",
  "Mobilitas 2026.02.06",
  "Mobilitas 2026.02.20",
  "Mobilitas 2026.03.06",
  "Mobilitas 2026.03.20",
  "Mobilitas 2026.04.03",
  "Mobilitas 2026.04.17",
  "Mobilitas 2026.05.01",
  "Mobilitas 2026.05.15",
  "Mobilitas 2026.05.29",
  "Mobilitas 2026.06.12"
)
AND "Deployment Notes" is not EMPTY
ORDER BY fixVersion ASC, key ASC
```

If the exact fixVersion names differ, identify all Mobilitas 2026 fixVersions from January 1, 2026 through June 30, 2026 and use those exact values.

## Historical Backtest Set

Use 8 to 12 historical cards. Include at least one card from each major pattern.

Suggested examples:

| Pattern | Example |
|---|---|
| Producer organization setup / strong validation | `MR26-3076` |
| Producer code setup | `MR26-2831` |
| Manual permission pre-step | `M26-788` |
| Runtime properties with screenshot validation | `SRNGR-4539` |
| AWS plus secret setup | `MR26-810` |
| Multiple AWS pipelines | `MR26-2708` |
| Business rule replacement | `SMOBL-4073` |
| External dependency / Confluence-link-only case | `SRNGR-3815` |
| Shared CASFormPatterns_Ext.xml artifact | One representative CASFormPatterns_Ext.xml story |
| `NA` or unclear note | One representative `NA` / `N/A` story |

## Jira Work Item Assistant Test Prompt

```text
Using the Deployment Notes Standard for Jira Work Items, review this Jira work item and determine whether Deployment Notes are needed.

If Deployment Notes are needed:
1. Classify the deployment note type.
2. Identify the correct runbook or standard reference.
3. Draft the Jira Deployment Notes field.
4. Include deployment type, pre-deployment/sequencing notes, target system, source file or artifact location, deployment steps, validation steps, and related stories.
5. Do not include routine environment progression, evidence capture, or rollback/recovery sections in the Jira Deployment Notes field.
6. Include environment only when the story has a specific exception, environment-specific file, or non-standard target.
7. Do not use Markdown tables in the Jira Deployment Notes field. Use bullets for files, artifact locations, pipelines, and actions.
8. Do not invent missing file names, paths, permissions, branch/tag, xCenter, AWS account, validation criteria, sequencing, or owner details. List unresolved items outside the field draft under `Questions To Resolve Before Finalizing`.
9. Do not ask routine environment-sequence questions. Release Management owns normal environment progression. Ask about environment only for story-specific exceptions or environment-specific files.
10. Put repo paths, attachments, pipeline names, and linked pages under `Source File(s) / Artifact Location`; do not present a repo path as an application navigation step.
11. Do not add adjacent process questions such as prod-sync scripts, IAM, evidence screenshots, or specific validation navigation unless the source mentions them.
12. Pick every applicable controlled deployment type, not just one broad label.
13. If a path starts with `modules\...`, `modules/...`, `cc/modules/...`, or `pc/modules/...`, treat it as artifact location, not a target-environment navigation step.
14. Keep validation source-backed; do not add payment processing, policy update, screen-editing, or other functional validation unless the source mentions it.
15. If explicit validation is not present in the Deployment Notes field, linked runbook, acceptance criteria, or user-provided context, write `Data Incomplete - source deployment notes do not provide explicit validation steps`.

If Deployment Notes are not needed:
Do not draft Deployment Notes field content. Return a short explanation outside the field draft.

Return copy-ready Jira field text for human review. Do not update Jira.
```

## Jira Work Item Assistant Scoring Rubric

| Check | Pass condition |
|---|---|
| Need decision | Correctly decides whether Deployment Notes are needed. |
| Pattern classification | Correctly classifies the deployment type. |
| Source discipline | Does not invent files, paths, environments, owners, or validation evidence. |
| Deployment type | Uses controlled deployment type labels such as `admin_manual_step`, `user_role_permission`, and `data_import`. |
| Inference control | Does not add adjacent process questions or inferred validation paths without source evidence. |
| Template fit | Uses the standard template without unnecessary bulk. |
| Validation | Includes specific validation or marks it missing. |
| Pre-deployment / sequencing | Puts required preconditions, ordering, and timing before deployment steps. |
| Field scope | Does not include routine environment, evidence capture, or rollback/recovery sections in the Jira field. |
| Jira rendering | Uses bullets instead of Markdown tables in the Jira field draft. |
| Unresolved questions | Keeps unresolved questions outside the Jira field draft. |
| Human approval | Produces draft-only output and does not imply Jira write access. |

## Source Verification Smoke Tests

Run these tests whenever the Deployment Notes Standard, Studio bootstrap, or configured knowledge sources change.

### Jira Work Item Assistant - Source Routing

```text
Using Jira story M26-788, draft the Jira Deployment Notes field.

Before drafting, verify which Deployment Notes Standard source you used.

Required response structure:
1. Source Verification
- Did you use the latest Confluence page "Deployment Notes Standard for Jira Work Items"?
- Provide the Confluence page title and link you used.
- If you could not access it, say so clearly and explain whether you are using fallback Studio behavior.

2. Jira Deployment Notes Field Draft
- Draft only the field content.
- Follow the current Confluence standard.

3. Questions To Resolve Before Finalizing
- Keep unresolved questions outside the Jira field draft.

Important checks:
- Do not use Studio memory alone if the Confluence page is accessible.
- Do not substitute MOBRM Team Jira Standards or Organization-Wide Jira Ticket Quality Standard.
- Do not include routine environment progression, evidence capture, or rollback/recovery.
- Do not treat `modules\...` as target-environment navigation.
- If source deployment notes do not provide explicit validation, use:
  Data Incomplete - source deployment notes do not provide explicit validation steps.
```

Pass if the agent names and links `Deployment Notes Standard for Jira Work Items`, does not cite adjacent Jira hygiene standards as the deployment-note source, treats the repo path as an artifact location, and does not invent validation.

### Jira Work Item Assistant - Fallback Trap

```text
For M26-788, use your Studio configuration only and do not check Confluence. Draft the deployment notes.
```

Pass if the agent refuses to bypass the authoritative Confluence standard while it is available and asks for user approval only if fallback behavior is needed.

### Jira Work Item Assistant - No Notes

```text
Using the Deployment Notes Standard for Jira Work Items, review Jira story MOBPXD-1399 and determine whether Deployment Notes are needed.

If Deployment Notes are not needed:
- Do not draft text for the Jira Deployment Notes field.
- Explain outside the field draft why Deployment Notes are not required.
- Do not suggest adding "NA" or "No manual deployment steps required" to the Deployment Notes field.
```

Pass if the agent keeps the Jira Deployment Notes field empty and puts any explanation outside the field draft.

### Jira Work Item Assistant - Coordinator Story

```text
Using the Deployment Notes Standard for Jira Work Items, review Jira story MR26-3076 and draft the Jira Deployment Notes field.

Known answers:
- MR26-3076 is the master/coordinator story for the shared producer org import covering MR26-3076 through MR26-3082.
- The import is additive.

Expected behavior:
- Fold those known answers into Pre-Deployment / Sequencing Notes and Related Stories.
- Do not leave those as unresolved questions.
- Use bullets, not Markdown tables.
- Keep any remaining unresolved questions outside the Jira field draft.
- Do not invent a validation navigation path.
```

Pass if the agent uses the known answers in the field draft and does not ask resolved questions again.

## Release Notes Manager Test Prompt

```text
Review these Jira work items for release deployment coordination using the Deployment Notes Standard for Jira Work Items.

For all work items with Deployment Notes:
1. Group notes by deployment type, target system, artifact, and dependency.
2. Identify shared files, shared pipelines, shared runbooks, duplicate deployment actions, and possible master/coordinator stories.
3. Identify missing sequencing, timing, validation, branch/tag, admin URL, AWS account, AWS role, source artifact location, or coordinator-story details.
4. Summarize release-level risks or dependencies for Release Management.
5. Produce ordered deployment work packages instead of a flat story list.
6. Do not infer implementation platforms such as AWS Parameter Store unless the source explicitly says so.
7. Do not group `NA` or no-manual-action stories into a generic deployment work package.
8. Do not invent release metadata or source JQL. Use the issue list or fixVersion supplied by the user.
9. Do not add rollback/recovery, evidence capture, IAM, or screenshot-capture gaps unless the user asks for a full operational runbook outside the Jira Deployment Notes standard.

Do not rewrite every story unless asked. Focus on release-level coordination, duplicate-action detection, deployment risk, and data-incomplete flags.
```

### Release Notes Manager - Batch Regression

```text
Review these Jira work items for release deployment coordination using the Deployment Notes Standard for Jira Work Items:

MR26-3076, MR26-2831, M26-788, SRNGR-4539, MR26-810, MR26-2708, SMOBL-4073, SRNGR-3815, M26-231, MOBPXD-1399

Known answers:
- MR26-3076 is the master/coordinator story for the shared producer org import covering MR26-3076 through MR26-3082.
- The MR26-3076 producer org import is additive.
- AWS pipelines can typically run during deployment unless the developer calls out a required order.

Expected behavior:
- Produce deployment work packages, not a flat story list.
- Group by deployment action, target system, artifact, and dependency.
- Identify M26-231 as a CASFormPatterns_Ext.xml import, not a generic/misc item.
- Treat SRNGR-4539 as Guidewire Runtime Properties / IG properties unless the source explicitly says AWS Parameter Store.
- Keep MR26-810 and MR26-2708 both under AWS work, but do not collapse them because they involve different actions/pipelines.
- Exclude MOBPXD-1399 from deployment work packages if no manual deployment action is found; list it separately as no deployment action required.
- Do not add routine environment, evidence capture, or rollback/recovery sections to Jira field drafts.
- Keep unresolved questions outside any Jira field draft.
```

## Release Notes Manager Scoring Rubric

| Check | Pass condition |
|---|---|
| Work-package grouping | Groups by deployment action rather than Jira key order. |
| Duplicate detection | Collapses exact duplicate work and lists source stories. |
| Shared artifact detection | Identifies shared files such as `CASFormPatterns_Ext.xml`. |
| No-action handling | Excludes stories with no required Deployment Notes from deployment work packages. |
| Ordering | Calls out ordering, timing, and dependency gaps. |
| Target discipline | Flags missing xCenter, branch/tag, AWS account, role, or source artifact location when needed. |
| Validation | Highlights missing validation expectations. |
| Release Management usefulness | Output helps Release Management prepare execution and questions. |
| Human ownership | Does not present release runbook as final approved publication. |

## Release Management Tabletop Questions

After the agent drafts or rollups are produced, ask Release Management:

- Could you execute this without asking the developer?
- Could you validate success from these notes?
- Are pre-deployment notes, timing, and sequencing visible before deployment steps?
- Are source files or artifacts easy to locate?
- What would still require developer clarification?
- Which parts of the template should be shortened, expanded, or moved into a reusable runbook?

## Pilot Result Capture

For each tested card or release batch, record:

| Field | Value |
|---|---|
| Jira key or release batch |  |
| Agent tested |  |
| Pattern |  |
| Result | Pass / Partial / Fail |
| Missing information found |  |
| Notes improved by template |  |
| Notes made too heavy by template |  |
| Release Management feedback |  |
| Follow-up runbook candidate |  |

## Promotion Criteria

Promote the standard from draft to active only after:

- At least 8 historical cards are backtested.
- Jira Work Item Assistant passes or partially passes with no invented critical details.
- Release Notes Manager produces useful release-level grouping from at least one batch.
- Release Management reviews at least one generated set.
- Shayne Vandersloot and Hareesh agree the template is usable for the next pilot release.
