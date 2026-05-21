# Release Notes Manager Golden Runbook Evaluation

## Purpose

This report captures the golden evaluation case for Release Notes Manager Studio V2. Use it to compare Studio output against the governed runbook behavior proven during the local Codex workflow.

## Test Prompt

```text
Build a technical deployment runbook for fixVersion "Mobilitas 2026.05.31" using stories with Deployment Notes. Group duplicate deployment effort, order the work packages, and flag missing branch, admin URL, AWS role, and rollback details.
```

## Expected Query

```text
fixVersion = "Mobilitas 2026.05.31" AND "Deployment Notes" is not EMPTY
```

## Human Reference Page

Use this existing Confluence page as the style and completeness reference:

`Technical Runbook - 26.05.02 May Release`

`https://csaaig.atlassian.net/wiki/spaces/MO/pages/5274697857/Technical+Runbook+-+26.05.02+May+Release`

The page was verified as accessible on 2026-05-21. Do not copy its content into generated output by default; use it to compare structure, readability, deployment sequencing, and completeness.

## Expected Result Summary

- Finds 11 stories with populated Deployment Notes.
- Produces ordered deployment work packages instead of a flat story list.
- Collapses `MR26-1558` and `MR26-2372` into one Sendgrid pipeline work package.
- Keeps different files, runtime properties, and AWS pipeline lists separate.
- Orders runtime properties before Guidewire application imports, AWS pipelines, special timed actions, and validation.
- Flags missing branch/tag, admin application URL, AWS account/role, and rollback detail.
- Keeps source story traceability in an appendix.

## Expected Work Packages

| Order | Work package | Source stories | Notes |
|---|---|---|---|
| 1 | Runtime Properties For CCC Medical Flow TPA | `MR26-1469` | Pre-deployment; import `CCCMedFlowClaimViewURL_TPA` and `CCCMedFlowClaimPortalURL_TPA`. |
| 2 | Assignment Rules And Group Imports | `M26-1774`, `M26-1959` | Shared config import path; different XML files. |
| 3 | Subro PAT Entry Import | `M26-1775` | Shared config import path; separate PAT file. |
| 4 | Underwriting Companies Systable Import | `M26-1776` | PolicyCenter systable import. |
| 5 | Aon Producer Code Setup | `MR26-2831` | Admin data import; validate Producer Code `001-0129`. |
| 6 | Lyft Document AWS Pipelines | `MR26-1065` | Lyft attachment and webhook pipelines. |
| 7 | DoorDash / Uber / Partner Document AWS Pipelines | `MR26-2708` | Different pipeline list from Lyft work; do not collapse. |
| 8 | Sendgrid Email Processor Pipeline | `MR26-1558`, `MR26-2372` | Exact duplicate deployment note; perform once. |
| 9 | AssureSign Template Update | `MR26-1300` | Timed PROD evening 2026-05-31; live 2026-06-01; no downtime noted. |
| 10 | Final Cross-Checks | All | Validation and signoff. |

## Pass Criteria

| Check | Pass condition |
|---|---|
| Exact scope | Uses exact fixVersion and Deployment Notes evidence. |
| Work package output | Runbook is organized by deployment work, not by story-first list. |
| Deduplication | Duplicate Sendgrid notes are collapsed and both stories are referenced. |
| Ordering | Runtime properties appear before application imports and AWS pipelines. |
| Human readability | Each package includes source evidence, beginner steps, validation, and open items. |
| Data gaps | Missing branch/tag, admin URL, AWS role/account, and rollback details are flagged. |
| Safety | Output remains review-ready and does not claim deployment approval. |

## Fail Signals

- Flat list of Jira stories with no deployment grouping.
- Missing one or more stories with Deployment Notes.
- No data-incomplete flags for unknown branch/tag, admin URL, AWS role/account, or rollback.
- Duplicate Sendgrid work listed as two separate deployment actions.
- Different AWS pipeline lists collapsed into one generic action.
- Runtime properties placed after application deployment without source justification.
- Final publication or deployment approval implied without human review.
