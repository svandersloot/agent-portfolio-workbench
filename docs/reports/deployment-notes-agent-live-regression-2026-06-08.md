# Deployment Notes Agent Live Regression Packet - 2026-06-08

## Purpose

Record the live Jira evidence and pass/partial/fail expectations for proving the Confluence-first bootstrap pattern with Jira Work Item Assistant and Release Notes Manager.

This packet does not claim ROVO Studio has version control. Confluence is the versioned source of truth; Studio remains a thin manual bootstrap with explicit knowledge sources.

## Source Verification

Checked through Atlassian read-only API on 2026-06-08.

| Page | Page ID | Live version | Status |
|---|---:|---:|---|
| Deployment Notes Standard for Jira Work Items | 5362778187 | 13 | Current |
| Deployment Notes Agent Pilot | 5363007530 | 9 | Current |
| ROVO Studio Configuration - Jira Work Item Assistant | 5349113857 | 12 | Current |
| Studio Setup - Jira Work Item Assistant | 5362614357 | 5 | Current |
| Rovo Studio Configuration - Release Notes Manager | 5300715546 | 8 | Current |
| Studio Setup - Release Notes Manager | 5363597417 | 1 | Current |
| Knowledge Source Plan - Jira Work Item Assistant | 5348655107 | 10 | Current |
| Knowledge Source Plan - Release Notes Manager | 5300158474 | 9 | Current |

Authoritative Deployment Notes Standard:

```text
https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5362778187
```

## Live Jira Evidence Pull

Read-only Jira query:

```text
key in (MR26-3076,MR26-2831,M26-788,SRNGR-4539,MR26-810,MR26-2708,SMOBL-4073,SRNGR-3815,M26-231,MOBPXD-1399) ORDER BY key ASC
```

Fields reviewed:

```text
key, summary, status, fixVersions, customfield_13450
```

| Issue | FixVersion | Deployment-note signal | Expected agent handling |
|---|---|---|---|
| M26-231 | Mobilitas 2026.02.20 | Load `CASFormPatterns_Ext.xml` from `modules\configuration\etc\surepath\pc\configuration\data\default`; validate added and retired form IDs. | Data import work package; identify shared CASFormPatterns artifact and ask for coordinator story before batch execution. |
| M26-788 | Mobilitas 2026.03.20 | Remove two permissions from Manager and Supervisor roles before importing `M26-788_Supervisor_Manager_Roles.xml`; source text says "Navigate to" a repo path. | Treat permissions as pre-deployment sequencing; treat `modules\...` as artifact location, not target navigation; validation is `Data Incomplete`. |
| MOBPXD-1399 | Mobilitas 2026.01.23 | Deployment Notes value is `NA`. | Do not draft Jira Deployment Notes field text; explain outside the field that no manual action was identified. |
| MR26-810 | Mobilitas 2026.04.17 | Approve/deploy `mobilitas-ccm-pipeline-payments-api`; add secret `mobilitas-ccm-csaa-entra`. | AWS work package with separate secret action; flag AWS account, role, and ordering if not supplied. |
| MR26-2708 | Mobilitas 2026.05.31 | Deploy three AWS document/webhook/process pipelines. | AWS work package separate from MR26-810 because the action and pipelines differ. Do not invent order. |
| MR26-2831 | Mobilitas 2026.05.31 | Import attached producer org XML; validate producer code `001-0129`; spreadsheet is validation reference. | Producer code import work package; preserve attached file and validation reference. |
| MR26-3076 | Mobilitas 2026.06.12 | Import attached `ProducerOrg_2026.06.01_Org_AdminData.xml`; applies to MR26-3076 through MR26-3082; validate listed producer orgs. | Coordinator import work package; fold supplied known answer that import is additive into sequencing notes. |
| SMOBL-4073 | Mobilitas 2026.01.23 | Delete existing rule before importing replacement `.gwrules` file. | Business rule/admin manual step; prerequisite deletion must remain above import. |
| SRNGR-3815 | Mobilitas 2026.01.23 | Deployment note is a Confluence release-instructions link. | External dependency package; mark inline action summary data incomplete if link content is not available. |
| SRNGR-4539 | Mobilitas 2026.01.23 | Import runtime properties, validate attached screenshot, delete/create IG properties. | Runtime properties / IG properties package; do not infer AWS Parameter Store. |

## Current Assessment

| Test | Agent | Result | Evidence |
|---|---|---|---|
| Source routing after explicit knowledge source configuration | Jira Work Item Assistant | Pass, based on handoff evidence | Latest captured live output named and linked `Deployment Notes Standard for Jira Work Items` after the page was configured as a Studio knowledge source. |
| M26-788 draft shape | Jira Work Item Assistant | Pass with minor source-verification issue | Latest v2 / Studio Setup v5 focused retest kept permission removal only in sequencing, preserved story evidence, treated the repo path as artifact location, and used `Data Incomplete` validation. Source verification still omitted the full URL. |
| Fallback trap | Jira Work Item Assistant | Pass | Live test refused to use Studio configuration alone while the Confluence standard was available. |
| MOBPXD-1399 no-notes test | Jira Work Item Assistant | Pass | Live test produced no Jira Deployment Notes field draft and did not suggest `NA` or no-action placeholder text. |
| MR26-3076 coordinator test | Jira Work Item Assistant | Pass with minor polish note | Latest v2 / Studio Setup v5 retest used correct deployment type, coordinator/additive answers, target system, attachment location, related stories, and no prod-sync/rollback/environment questions. Validation should preserve the explicit producer org list when available. |
| Release batch work-package grouping | Release Notes Manager | Not run live; repo-side expected behavior is pass-shaped | Live Jira evidence supports distinct packages for runtime properties, producer org imports, M26-788 permissions/import, AWS pipelines, business rules, external dependency, CASFormPatterns, and no-action item. |

## Pass / Partial / Fail Rules

### Jira Work Item Assistant

Pass when all are true:

- Names and links `Deployment Notes Standard for Jira Work Items`.
- Does not use MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, or any other Jira hygiene page as the deployment-note authority.
- For M26-788, classifies `admin_manual_step`, `user_role_permission`, and `data_import`.
- Keeps permission removal in `Pre-Deployment / Sequencing Notes`.
- Treats `modules\configuration\...` as artifact location.
- Does not invent validation from the title or summary.
- Produces no field draft for MOBPXD-1399.

Partial when the right source is used but one non-critical formatting or question-scoping issue remains.

Fail when the source is wrong, validation is invented, `NA` becomes placeholder field text, or repo paths are treated as target-environment navigation.

### Release Notes Manager

Pass when all are true:

- Produces deployment work packages, not a flat story list.
- Groups by action, target system, artifact, and dependency.
- Keeps MR26-810 and MR26-2708 separate under AWS work.
- Identifies M26-231 as `CASFormPatterns_Ext.xml`.
- Treats SRNGR-4539 as runtime properties / IG properties unless source evidence says otherwise.
- Keeps MOBPXD-1399 out of deployment work packages.
- Does not invent release metadata, source JQL, AWS account/role, Bitbucket branch/tag, rollback, evidence capture, IAM, or validation paths.

Partial when the grouping is useful but one story is misclassified or one data-incomplete flag is missing.

Fail when the output is a flat issue list, substitutes adjacent standards, invents operational details, or collapses different deployment actions into one package.

## Recommended Live Test Order

1. Jira Work Item Assistant source routing test with M26-788.
2. Jira Work Item Assistant fallback trap with M26-788.
3. Jira Work Item Assistant no-notes test with MOBPXD-1399.
4. Jira Work Item Assistant coordinator test with MR26-3076 and known answers.
5. Release Notes Manager batch regression with the ten-story issue list and known answers.

## Captured Live Test Runs

### 2026-06-08 - Jira Work Item Assistant - M26-788

```text
Test Run
- Date: 2026-06-08
- Agent: Jira Work Item Assistant
- Agent version/context: v2 reported by tester
- Studio setup page used: Studio Setup - Jira Work Item Assistant v1
- Runtime/source page version: Deployment Notes Standard for Jira Work Items v11
- Prompt: User asked the agent to review Jira work item M26-788 using the Deployment Notes Standard for Jira Work Items.
- Result: Partial
- Source verification: The response said it was based on the Deployment Notes Standard for Jira Work Items, but did not provide the page title and link in the required source-verification structure.
- Notes: Correctly recognized Deployment Notes are required; used `admin_manual_step`, `user_role_permission`, and `data_import`; put permission removal under Pre-Deployment / Sequencing Notes; treated `modules\configuration\...` as artifact location; used `Data Incomplete - source deployment notes do not provide explicit validation steps`.
- Follow-up doc/config change needed: No standard change yet. Rerun with Studio Setup - Jira Work Item Assistant v3 and the exact source-routing prompt from Deployment Notes Agent Pilot.
```

Partial findings:

- The Jira field draft duplicated manual permission removal in `Deployment Steps` even though it was already captured as a prerequisite in `Pre-Deployment / Sequencing Notes`.
- `Questions To Resolve Before Finalizing` asked a routine target-environment question. The standard says Release Management owns normal environment progression; ask environment questions only for story-specific exceptions or files.
- The validation question included inferred examples such as role post-state validation and `Verify Policy` button visibility. The field correctly kept validation as `Data Incomplete`, but questions should ask for source-backed validation without suggesting unsourced validation paths.
- The response did not include the required source verification title/link block from the smoke-test prompt.

Expected next-run improvements:

- Include explicit source verification with the `Deployment Notes Standard for Jira Work Items` title and link.
- Keep manual permission removal only under `Pre-Deployment / Sequencing Notes` unless the source says it must be repeated as an execution-window step.
- Limit questions to:
  - Confirm whether the XML file is committed to the provided configuration path or attached to the Jira issue.
  - Confirm the import utility if the standard ClaimCenter admin import path is not correct.
  - Provide source-backed validation steps if Release Management needs validation beyond successful import.

### 2026-06-08 - Jira Work Item Assistant - Regression Set After Studio Setup

```text
Test Run
- Date: 2026-06-08
- Agent: Jira Work Item Assistant
- Agent version/context: v2 reported by tester
- Studio setup page used: Studio Setup - Jira Work Item Assistant v1 initial configuration; Studio Setup page later refined to v3
- Runtime/source page version: Deployment Notes Standard for Jira Work Items v11
- Prompt: Source routing, fallback trap, no-notes, and coordinator-story prompts from Deployment Notes Agent Pilot.
- Result: Partial overall
- Source verification: Agent said it used the Deployment Notes Standard, but the M26-788 source-verification block did not include the actual page URL.
- Follow-up doc/config change needed: No standard change yet. Keep testing Jira Work Item Assistant before moving to Release Notes Manager.
```

Results:

| Test | Result | Notes |
|---|---|---|
| M26-788 source routing / draft | Partial | Correct labels, field shape, artifact location, and `Data Incomplete` validation. Still duplicated manual permission removal in `Deployment Steps`; source verification did not include the page URL. |
| Fallback trap | Pass | Correctly refused to use Studio configuration alone while the Confluence standard is available. |
| MOBPXD-1399 no-notes | Pass | Correctly produced no Jira Deployment Notes field draft and no `NA` or no-action placeholder. |
| MR26-3076 coordinator | Partial | Correctly used the coordinator and additive-import known answers and preserved validation evidence. Incorrectly classified as `admin_manual_step`; expected `data_import, batch_multi_story`. Asked an unsourced prod-sync question, which the standard forbids unless source evidence mentions it. |

Next Jira Work Item Assistant retest focus:

- M26-788: do not duplicate a pre-deployment prerequisite in `Deployment Steps`.
- M26-788: provide the Confluence page title and URL in the source-verification block.
- MR26-3076: use `data_import, batch_multi_story`.
- MR26-3076: do not ask about prod-sync scripts unless the Jira issue, linked runbook, or user context mentions prod sync.

### 2026-06-08 - Jira Work Item Assistant - Focused Retest

```text
Test Run
- Date: 2026-06-08
- Agent: Jira Work Item Assistant
- Agent version/context: v2 reported by tester
- Studio setup page used: Studio Setup - Jira Work Item Assistant v3
- Runtime/source page version: Deployment Notes Standard for Jira Work Items v11
- Prompt: Focused M26-788 source-routing retest and MR26-3076 coordinator retest.
- Result: Partial
- Source verification: M26-788 response said it used the Deployment Notes Standard, but still did not include the page URL.
- Follow-up doc/config change needed: Added targeted rollback clarification to Deployment Notes Standard v12 and a temporary Deployment Notes pilot guardrail to Studio Setup - Jira Work Item Assistant v4.
```

Repeated findings:

- M26-788 still duplicated manual permission removal in `Deployment Steps`.
- M26-788 still asked routine environment-progression and inferred validation questions.
- MR26-3076 still used `admin_manual_step`; expected `data_import, batch_multi_story`.
- MR26-3076 asked for target environment and rollback plan even though the story-level Deployment Notes standard does not require routine environment or rollback content.

Published follow-up:

- Deployment Notes Standard v12 now explicitly states the Jira Deployment Notes field does not require a rollback plan.
- Studio Setup - Jira Work Item Assistant v4 now includes a temporary pilot guardrail for source URL, prerequisite duplication, routine environment questions, rollback questions, prod-sync questions, neutral validation questions, and known type labels for M26-788 and MR26-3076.

### 2026-06-08 - Jira Work Item Assistant - Overcorrection Retest

```text
Test Run
- Date: 2026-06-08
- Agent: Jira Work Item Assistant
- Agent version/context: v2 reported by tester
- Studio setup page used: Studio Setup - Jira Work Item Assistant v4
- Runtime/source page version: Deployment Notes Standard for Jira Work Items v12
- Prompt: Focused M26-788 source-routing retest and MR26-3076 coordinator retest.
- Result: Fail for M26-788, Partial for MR26-3076
- Source verification: Agent said it accessed the standard but still did not provide the full Confluence URL.
- Follow-up doc/config change needed: Add explicit reminder that Jira story evidence must be preserved and `Data Incomplete` is only for missing, inaccessible, or conflicting details.
```

Findings:

- M26-788 regressed from partial to fail by replacing known story evidence with `Data Incomplete`, including target system `CC`, file name, repo path, and manual permission sequencing.
- MR26-3076 improved deployment type to `data_import, batch_multi_story`, but still replaced known source evidence with `Data Incomplete`, including PolicyCenter, attached file name, import path, and validation producer org list.
- The response still omitted the full page URL in source verification.

Published follow-up:

- Deployment Notes Standard v13 clarifies that `Data Incomplete` means a detail is missing, inaccessible, or conflicting; explicit Jira evidence must be preserved.
- Studio Setup - Jira Work Item Assistant v5 updates the temporary pilot guardrail to preserve explicit source evidence for M26-788 and MR26-3076.

### 2026-06-08 - Jira Work Item Assistant - Evidence Preservation Retest

```text
Test Run
- Date: 2026-06-08
- Agent: Jira Work Item Assistant
- Agent version/context: v2 reported by tester
- Studio setup page used: Studio Setup - Jira Work Item Assistant v5
- Runtime/source page version: Deployment Notes Standard for Jira Work Items v13
- Prompt: Focused M26-788 source-routing retest and MR26-3076 coordinator retest.
- Result: Partial overall
- Source verification: Agent said it accessed the standard but still did not provide the full Confluence URL.
- Follow-up doc/config change needed: No new doc change yet. Continue one more focused M26-788 retest or proceed to Release Notes Manager setup only after accepting this residual risk.
```

Results:

| Test | Result | Notes |
|---|---|---|
| M26-788 source routing / draft | Partial | Preserved target system `CC`, file name, repo path, permission prerequisite, deployment labels, and `Data Incomplete` validation. Still duplicated the permission prerequisite in `Deployment Steps`; added a specific admin navigation path not present in source evidence; source verification still omitted the full page URL. |
| MR26-3076 coordinator | Pass with minor polish note | Correct deployment labels, coordinator story handling, additive import note, target system, file, Jira attachment location, related story range, and no prod-sync/rollback/environment questions. Minor polish: validation would be more copy-ready if it included the explicit producer org list from the Jira evidence instead of saying "provided list." |

Latest retest focus:

- M26-788: keep permission removal only in `Pre-Deployment / Sequencing Notes`.
- M26-788: keep deployment steps to the import action unless the source provides an exact role/permission admin path.
- M26-788: include the full Confluence page URL in source verification.
- MR26-3076: preserve the explicit producer organization validation list when available.

### 2026-06-08 - Jira Work Item Assistant - M26-788 Prerequisite Retest

```text
Test Run
- Date: 2026-06-08
- Agent: Jira Work Item Assistant
- Agent version/context: v2 reported by tester
- Studio setup page used: Studio Setup - Jira Work Item Assistant v5
- Runtime/source page version: Deployment Notes Standard for Jira Work Items v13
- Prompt: M26-788 source-routing retest with explicit instruction not to repeat the manual permission prerequisite in Deployment Steps.
- Result: Pass with minor source-verification issue
- Source verification: Agent said it accessed the standard and named the title, but still did not provide the full Confluence URL.
- Follow-up doc/config change needed: No new doc change. Continue to Release Notes Manager batch test while watching source URL behavior.
```

Result notes:

- Correctly preserved `admin_manual_step, user_role_permission, data_import`.
- Kept manual permission removal in `Pre-Deployment / Sequencing Notes`.
- Did not repeat the manual permission removal in `Deployment Steps`.
- Preserved target system `CC`, file name, repo path, and import action.
- Used `Data Incomplete - source deployment notes do not provide explicit validation steps`.
- Questions were limited to source-backed validation and related-story confirmation.
- Remaining issue: source verification still did not include the full Confluence URL.

Capture each result with:

```text
Test Run
- Date:
- Agent:
- Studio config version/page:
- Runtime/source page version:
- Prompt:
- Result: Pass / Partial / Fail
- Source verification:
- Notes:
- Follow-up doc/config change needed:
```

## Rollout Plan

Use this pattern one governed agent at a time after both pilot agents pass the regression set.

| Order | Agent | First bootstrap focus | Exit signal |
|---:|---|---|---|
| 1 | Jira Work Item Assistant | Deployment Notes standard retrieval, no-substitute rules, Jira draft boundaries. | Passes source routing, M26-788, MOBPXD-1399, and MR26-3076 tests. |
| 2 | Release Notes Manager | Deployment work package grouping, exact release scope, no invented release metadata. | Passes ten-story batch regression. |
| 3 | Release Drift Monitor | Runtime source pages for drift evidence, accepted exceptions, and handoff rules. | Names current drift source pages and produces a source-backed delta without write actions. |
| 4 | Release Health Analyst | Runtime source pages for scoring, evidence completeness, and human-owned go/no-go boundaries. | Separates health assessment from release approval and cites current scoring source. |
| 5 | Jira Ticket Polisher | Runtime source pages for ticket quality, team overlay authority, and forbidden substitutes. | Applies org/team standards only when explicitly sourced. |
| 6 | Remaining governed agents | Thin Studio bootstrap plus explicit source map and regression prompt pack. | Each agent has a source-verification smoke test and 2-3 behavior regressions. |

For each agent:

1. Identify behavior currently over-copied into Studio.
2. Move detailed runtime behavior into a Confluence source page.
3. Keep Studio to identity, routing, safety, source links, fallback behavior, knowledge sources, and skills/tools.
4. Configure explicit knowledge sources.
5. Run the source-verification smoke test.
6. Run 2-3 behavior regressions.
7. Record pass/partial/fail before publishing or broadening.
