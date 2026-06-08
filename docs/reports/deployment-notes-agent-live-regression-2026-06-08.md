# Deployment Notes Agent Live Regression Packet - 2026-06-08

## Purpose

Record the live Jira evidence and pass/partial/fail expectations for proving the Confluence-first bootstrap pattern with Jira Work Item Assistant and Release Notes Manager.

This packet does not claim ROVO Studio has version control. Confluence is the versioned source of truth; Studio remains a thin manual bootstrap with explicit knowledge sources.

## Source Verification

Checked through Atlassian read-only API on 2026-06-08.

| Page | Page ID | Live version | Status |
|---|---:|---:|---|
| Deployment Notes Standard for Jira Work Items | 5362778187 | 10 | Current |
| Deployment Notes Agent Pilot | 5363007530 | 8 | Current |
| ROVO Studio Configuration - Jira Work Item Assistant | 5349113857 | 12 | Current |
| Rovo Studio Configuration - Release Notes Manager | 5300715546 | 8 | Current |
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
| M26-788 draft shape | Jira Work Item Assistant | Partial until rerun live | Handoff says the latest live output improved. Repo-side expected output now requires path-as-artifact handling and `Data Incomplete` validation. |
| Fallback trap | Jira Work Item Assistant | Not run | Must verify the agent refuses to bypass Confluence when the standard is available. |
| MOBPXD-1399 no-notes test | Jira Work Item Assistant | Not run | Live Jira evidence confirms `NA`; expected behavior is no Jira field draft and no placeholder replacement. |
| MR26-3076 coordinator test | Jira Work Item Assistant | Not run | Live Jira evidence confirms shared story range; user-provided known answer confirms additive import. |
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
