# Measurement Plan - QA Test Strategy Planner

## Measurement Status

| Field | Value |
|---|---|
| Agent | QA Test Strategy Planner |
| Lifecycle status | Draft |
| Readiness status | Needs Cleanup; limited pilot candidate evidence captured; Studio #003 F1 and DI1 re-runs required |
| Measurement maturity | Draft |
| Review cadence | After each pilot strategy or plan review, then quarterly if promoted |

## Value Hypothesis

QA Test Strategy Planner should reduce the time required to draft and review QA test strategies while improving consistency, traceability, risk visibility, environment/data readiness, automation-suite planning, and routing to the right downstream QA or release agent.

## Metrics

| Metric | Baseline | Target | Measurement method | Cadence |
|---|---|---|---|---|
| Strategy draft time | TBD during first pilot | 25 percent reduction after two pilot plans | QA lead estimates manual vs agent-assisted time | Per plan |
| Plan review completeness | TBD | 100 percent of reviewed plans checked against quality criteria and required planning sections | Review output checklist | Per review |
| Data Incomplete visibility | TBD | All known missing scope, environment, data, risk, dependency, deliverable, traceability, and sign-off items are listed | QA lead review | Per plan |
| Routing accuracy | TBD | 100 percent of test case, Jira, release drift, readiness, and performance requests route to correct agent | Evaluation prompts and pilot review | Monthly during pilot |
| Human correction rate | TBD | Repeated formatting and missing-section corrections decrease after first two pilot outputs | Count owner edits or review comments | Per plan |
| Automation handoff usefulness | TBD | QA lead accepts or lightly edits the suite ownership/data/open-gap handoff | Accepted/edited/rejected review | Per handoff |
| Unsafe action refusal | Not measured | 100 percent refusal for approval, go/no-go, Jira write, Confluence publish, Studio write, and unsupported test-skipping prompts | Evaluation prompts | Monthly during pilot |

## Pre-Pilot Evaluation Baseline

| Evidence | Result | Use |
|---|---|---|
| Offline Agent Lab baseline | 15 cases run, 15 pass, 0 fail, 0 P1/P2 safety failures | Pre-Studio comparison baseline for core behavior. |
| ROVO Studio CSV #001 | 15 cases run, 14 resolved, 1 unresolved, 1 P2 route-away issue | Historical remediation evidence for release drift routing. |
| ROVO Studio CSV #002 | 19 cases run, 19 resolved, 0 unresolved, 0 P1/P2 issues | Historical clean Studio baseline before overlay expansion and #003 realistic Jira-populated input. |
| Manual Studio Test #001 | 10 prompts run, 10 pass, 0 P1/P2 issues, 1 P3 formatting note | Initial realistic Jira-packet evidence using Mobi Rangers source packets. |
| Manual Studio Test #002 | 9 prompts run, 9 pass, 0 P1/P2 issues | Manual retest evidence for release route-away, vague-user guidance, routing, guardrails, and matrix formatting. |
| ROVO Studio Evaluation #003 | #007 e2e-v4: 18 Pass, 3 Partial, 1 Fail, 1 Data Incomplete; #006 PN overlay: 12 Pass | Current assessment evidence. Creates remediation gates for automation-status over-claim (F1) and go/no-go coverage gap (DI1); PN fields remain pending QA-lead validation. |

This evidence supports controlled pilot review only. Studio Evaluation #003 prevents treating the current baseline as clean until F1 is remediated in Studio and re-run, DI1 is re-run, and any remaining P2/P3 findings are accepted or addressed. It does not assign owner, backup owner, final pilot scope, Studio visibility, or broad production readiness.

## Quality And Risk Signals

| Signal | Good | Warning | Action |
|---|---|---|---|
| Source specificity | Exact epic, requirement, page, or plan is provided. | User asks for generic strategy with no source. | Ask for source or draft only a generic shell with Data Incomplete flags. |
| Team overlay completeness | Workstream/application, test types, environment, data, automation ownership, risk rubric, and deliverables are supplied. | Overlay fields are missing. | Mark Data Incomplete and ask for the smallest missing fields. |
| Plan quality review | Findings map to quality criteria and required sections. | Review is generic or approves the plan. | Update instructions and rerun evaluation. |
| Routing discipline | Detailed artifact, Jira, release, and performance requests route correctly. | Agent tries to do downstream work itself or omits the named route target. | Update routing rules and rerun routing cases. |
| Test skip boundary | Agent requires human approval and accepted risk. | Agent recommends skipping tests to save time. | Stop pilot and remediate instructions. |
| Approval boundary | Output is review-ready draft only. | Output says approved, final, ready, signed off, or go/no-go. | Stop pilot and remediate instructions. |
| Automation status evidence | Automation states are separated as planned, implemented, executed, passing, or Data Incomplete. | Jira Done/Completed status is treated as proof of implemented or passing automation. | Stop pilot and remediate instructions; re-run the automation-status case. |
| Role identity handling | Draft role fields use roles only unless current source evidence names people. | Output injects named individuals, account IDs, user ARIs, or current-user identities. | Review Studio tool behavior and rerun the roles-only case. |

## Reporting Table

| Pilot item | Date | Mode | Source completeness | Draft time saved | Accepted / edited / rejected | Main gaps found | Notes |
|---|---|---|---|---|---|---|---|
| TBD | TBD | TBD | TBD | TBD | TBD | TBD | First pilot not yet run. |

Recommended first pilot reporting rows:

- Mobi Rangers strategy/readiness gap review using a filled source packet.
- M26 strategy/readiness gap review using a filled source packet.
- One automation handoff where ownership and suite data are intentionally reviewed by the QA lead.

## Review Cadence

- Draft candidate: review after each evaluation run and each QA lead pilot output.
- Experimental pilot: review after every two strategy drafts or plan reviews.
- Promotion review: require at least two accepted or lightly edited outputs, a clean unsafe-action and routing evaluation after #003 remediation/re-runs, and named owner/backup owner.

## Promotion Evidence Needed

- Named primary and backup owner.
- Confirmed pilot audience and visibility boundary.
- Confirmed knowledge sources and access model.
- Evaluation run showing routing, Data Incomplete, approval boundary, test-skip guardrails, automation-status evidence discipline, roles-only draft fields, and clean #003 F1/DI1 re-runs.
- At least one QA lead-reviewed strategy draft.
- At least one QA lead-reviewed plan-quality review or automation handoff.
- Measurement notes for time saved, correction rate, and accepted/edited/rejected outcome.
