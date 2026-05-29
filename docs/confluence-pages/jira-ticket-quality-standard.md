# Organization-Wide Jira Ticket Quality Standard

Use this standard as the default review baseline for any Jira ticket when no team-specific standard is available. Team standards may add stricter or more specific expectations, but they should not remove the need for a clear, testable, source-backed ticket.

## Standard Status

| Field | Value |
|---|---|
| Status | Draft |
| Owner | TBD |
| Last reviewed | 2026-05-29 |
| Intended use | Default standard for Jira Ticket Polisher and human ticket review. |
| Review cadence | Quarterly or after major workflow changes. |

## Universal Ticket Checks

| Check | Good Ticket Signal | Common Gap |
|---|---|---|
| Clear outcome | A reader can explain what should change and why. | Summary names an activity but not the outcome. |
| User or business value | The ticket explains who benefits or what risk is reduced. | Value is implied or absent. |
| Issue type fit | Story, bug, task, spike, defect, or epic matches the work. | Issue type hides workflow, testing, or reporting needs. |
| Scope boundary | In scope and out of scope are clear enough to avoid surprise work. | Ticket expands during refinement because boundaries are missing. |
| Acceptance criteria | Conditions are specific, testable, and tied to the outcome. | Criteria are vague, implementation-only, or missing. |
| Dependencies | External systems, teams, tickets, data, access, and sequencing are named. | Blockers appear late. |
| Priority or severity rationale | Urgency is explained by customer, business, operational, compliance, or delivery impact. | Priority is present as a field but unsupported in text. |
| Technical context | Required architecture, API, config, data, repo, environment, or integration context is linked or summarized. | Developer must ask where to work or what system is affected. |
| QA and validation | Expected validation path, test data, affected flows, and regression needs are clear. | QA has to infer what to test. |
| Data, config, or environment needs | Special data setup, flags, properties, environments, roles, or permissions are visible. | Work is blocked by missing setup details. |
| Release or rollout notes | Release timing, migration, feature flag, communication, or rollback considerations are included when relevant. | Release impact is discovered after build. |
| Labels, components, and fields | Metadata supports ownership, reporting, routing, and workflow rules. | Reporting and board filters miss the ticket. |
| Ownership | Product, engineering, QA, and dependency owners are named when needed. | Questions have no clear owner. |
| Risk and assumptions | Important uncertainty is named with a resolution path. | Hidden assumptions become rework. |
| Readiness signal | The ticket states what evidence is needed before refinement, sprint pull, development, QA, or release. | Status suggests readiness that the content does not support. |

## Issue-Type-Specific Checks

| Issue type | Additional checks |
|---|---|
| Story | User outcome, acceptance criteria, UX/API behavior, data needs, dependencies, and test expectations. |
| Bug | Steps to reproduce, expected behavior, actual behavior, environment, frequency, severity, workaround, and validation path. |
| Task | Concrete deliverable, owner, dependencies, done criteria, and expected output or artifact. |
| Spike | Decision to answer, timebox, research method, output format, and follow-up decision path. |
| Production defect | Customer or operational impact, severity rationale, mitigation, reproduction evidence, impacted system, and release/hotfix path. |
| Epic | Outcome, scope boundaries, child-ticket readiness criteria, success measure, dependencies, and sequencing. |

## Readiness Levels

| Level | Meaning | Use |
|---|---|---|
| Needs discovery | The problem or source context is too incomplete for confident refinement. | Ask clarifying questions and identify missing owners or evidence. |
| Ready for refinement | The ticket is understandable enough for team discussion but may still need estimation or split decisions. | Use before backlog refinement. |
| Ready for delivery planning | Scope, acceptance criteria, dependencies, and validation path are clear enough to plan. | Use before sprint pull or delivery commitment. |
| Ready for QA handoff | Build evidence, acceptance criteria, test data, and validation path are clear. | Use before QA execution. |
| Ready for release review | Release, rollout, validation, and support notes are clear when needed. | Use before release/change review. |

## Review Severity

| Severity | Meaning |
|---|---|
| P0 | Missing or unsafe information blocks responsible action, creates material risk, or could cause the wrong work. |
| P1 | Important gap likely to create rework, delay, or missed validation. |
| P2 | Useful improvement that would make the ticket clearer but does not block review. |

## Recommended Review Output

Jira Ticket Polisher should return:

- Standards used.
- Ticket context reviewed.
- P0 and P1 gaps first.
- P2 improvements second.
- Draft replacement text by Jira field.
- Missing evidence or questions for the ticket owner.
- A reminder that the human owner must apply Jira changes manually.

## Fallback Rule

If a team standard is unavailable, use this standard and say:

```text
No team overlay was available, so this review used the organization-wide Jira ticket quality standard only.
```
