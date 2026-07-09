# Measurement Plan - QA Test Strategy Planner

## Measurement Status

| Field | Value |
|---|---|
| Agent | QA Test Strategy Planner |
| Lifecycle status | Draft |
| Readiness status | Needs Cleanup; limited pilot candidate evidence captured |
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
| ROVO Studio CSV #002 | 19 cases run, 19 resolved, 0 unresolved, 0 P1/P2 issues | Current Studio evaluation baseline for limited pilot candidate behavior. |
| Manual Studio Test #001 | 10 prompts run, 10 pass, 0 P1/P2 issues, 1 P3 formatting note | Initial realistic Jira-packet evidence using Mobi Rangers source packets. |
| Manual Studio Test #002 | 9 prompts run, 9 pass, 0 P1/P2 issues | Current manual retest evidence for release route-away, vague-user guidance, routing, guardrails, and matrix formatting. |

This baseline supports a limited pilot candidate posture for the tested workflows. It does not assign owner, backup owner, final pilot scope, Studio visibility, or broad production readiness.

## Quality And Risk Signals

| Signal | Good | Warning | Action |
|---|---|---|---|
| Source specificity | Exact epic, requirement, page, or plan is provided. | User asks for generic strategy with no source. | Ask for source or draft only a generic shell with Data Incomplete flags. |
| Team overlay completeness | Workstream/application, test types, environment, data, automation ownership, risk rubric, and deliverables are supplied. | Overlay fields are missing. | Mark Data Incomplete and ask for the smallest missing fields. |
| Plan quality review | Findings map to quality criteria and required sections. | Review is generic or approves the plan. | Update instructions and rerun evaluation. |
| Routing discipline | Detailed artifact, Jira, release, and performance requests route correctly. | Agent tries to do downstream work itself. | Update routing rules and rerun routing cases. |
| Test skip boundary | Agent requires human approval and accepted risk. | Agent recommends skipping tests to save time. | Stop pilot and remediate instructions. |
| Approval boundary | Output is review-ready draft only. | Output says approved, final, ready, signed off, or go/no-go. | Stop pilot and remediate instructions. |

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
- Promotion review: require at least two accepted or lightly edited outputs, clean unsafe-action evaluation, and named owner/backup owner.

## Promotion Evidence Needed

- Named primary and backup owner.
- Confirmed pilot audience and visibility boundary.
- Confirmed knowledge sources and access model.
- Evaluation run showing routing, Data Incomplete, approval boundary, and test-skip guardrails.
- At least one QA lead-reviewed strategy draft.
- At least one QA lead-reviewed plan-quality review or automation handoff.
- Measurement notes for time saved, correction rate, and accepted/edited/rejected outcome.
