# ROVO Governance Implementation Backlog

This backlog translates the ROVO space audit into trackable work. It can be copied into Jira or used as a local planning artifact until Jira tracking exists.

## Milestone 1: Space Cleanup

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 1.1 | Merge Agent Inventory pages | P0 | None | Space admin + Michael Holian | One canonical inventory page exists. `Rovo Agent Inventory Home` is archived with a legacy banner. Meta-agents point to the merged page. |
| 1.2 | Move CoP 5/15/26 under Working Group Notes | P1 | None | Space admin | CoP page is a child of Working Group Notes. |
| 1.3 | Move Confluence Formatting Standards under Governance and Safety | P1 | None | Space admin | Governance and Safety parent exists. Formatting Standards is a child page. |
| 1.4 | Promote Pattern Library patterns to child pages | P2 | None | Working group lead | Each core pattern is individually linkable. Parent page is an index. |
| 1.5 | Update Space Structure and Navigation | P1 | 1.1-1.4 | Space admin | Page tree documentation matches actual structure. |
| 1.6 | Update Agent Governance Home | P1 | 1.1-1.5 | Space admin | New top-level sections are linked. Recommended structure is current. |

## Milestone 2: Template Creation

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 2.1 | Create Agent Design Record Template | P0 | None | Working group lead | Template exists under Templates and includes sections from `templates/confluence/agent-design-record-template.md`. |
| 2.2 | Create Context Readiness Checklist | P0 | None | Working group lead | Top-level page exists with criteria table, scoring rubric, and remediation table. |
| 2.3 | Create Agent Governance Review Template | P1 | None | Working group lead | Template exists under Templates with human-facing checklist. |
| 2.4 | Create Agent ADR Template | P1 | None | Working group lead | Template exists under Templates. |
| 2.5 | Create Decision Log index page | P1 | 2.4 | Working group lead | Page exists with ADR naming convention. |

## Milestone 3: Governance Model

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 3.1 | Create Governance and Safety section | P0 | 1.3 | Working group lead | Parent page exists with Governance Review Checklist, Known Risks and Limitations, and Formatting Standards as children. |
| 3.2 | Create Known Risks and Limitations page | P1 | None | Working group lead | Page includes platform limitations, organizational risks, mitigations, and workarounds. |
| 3.3 | Add Context Readiness Assessment to Doc Health Gate | P1 | 2.2 | Meta-agent owner | Doc Health Gate includes context readiness as a P1 audit check. |
| 3.4 | Add measurement plan check to Doc Health Gate | P1 | 5.1 | Meta-agent owner | Doc Health Gate includes measurement plan as a P1 check. |
| 3.5 | Create first three ADRs | P2 | 2.4, 2.5 | Working group lead | ADRs exist for Project Brain pattern, fit triage framework, and meta-agent collaboration model. |

## Milestone 4: Meta-Agent Enhancement

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 4.1 | Add measurement questions to Design Agent intake | P1 | None | Meta-agent owner | Design Agent asks about success and measurement. Output includes metrics recommendation. |
| 4.2 | Add context readiness pre-check to Design Agent | P1 | 2.2 | Meta-agent owner | Output includes readiness summary. Critical gaps can route to `NOT READY`. |
| 4.3 | Add inventory dedup check to Design Agent | P1 | 1.1 | Meta-agent owner | Output states inventory was checked before recommending `CREATE NEW`. |
| 4.4 | Add risk tier classification to Design Agent output | P2 | None | Meta-agent owner | Risk tier appears in every design packet. |
| 4.5 | Update Doc Steward to check measurement plans | P1 | None | Meta-agent owner | Missing measurement plan is flagged as P1. |
| 4.6 | Update Doc Steward to generate completeness score | P2 | None | Meta-agent owner | Doc Health Gate output includes completeness percentage. |
| 4.7 | Update Evaluation Library with new scenarios | P2 | 4.1-4.5 | Meta-agent owner | At least three new test cases per meta-agent cover new capabilities. |

## Milestone 5: Measurement And Reporting

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 5.1 | Create Measurement and Value Tracking page | P0 | None | Working group lead | Page exists with adoption, time saved, quality, rework, and satisfaction framework. |
| 5.2 | Add success metrics to Release Health Analyst Project Brain | P1 | 5.1 | Agent owner | Release Health Analyst includes baseline and target metrics. |
| 5.3 | Create quarterly review template | P2 | 5.1 | Working group lead | Template exists for portfolio review. |

## Milestone 6: Pilot And Feedback Loop

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 6.1 | Create User Guide - Designing Agents | P1 | 1.5, 2.1 | Working group lead | A new builder can follow the guide without working group hand-holding. |
| 6.2 | Create Admin and Owner Guide | P2 | None | Space admin | Page exists with admin responsibilities, label management, review cadence, and retirement process. |
| 6.3 | Create Backlog and Improvement Roadmap | P1 | None | Working group lead | All open CoP action items are migrated. |
| 6.4 | Run pilot with one new builder | P1 | 6.1 | Working group lead | Builder completes process and at least three improvements are identified. |
| 6.5 | Conduct post-pilot retrospective | P2 | 6.4 | Working group lead | Retrospective notes and template updates are documented. |
