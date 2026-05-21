# ROVO Governance Implementation Backlog

This backlog translates the ROVO space audit into trackable work. It can be copied into Jira or used as a local planning artifact until Jira tracking exists.

## Milestone 1: Space Cleanup

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 1.1 | Merge Agent Inventory pages | P0 | None | Space admin + Michael Holian | Dry-run evidence suggests `Agent Inventory` is the canonical inventory page and `Rovo Agent Inventory Home` is the space overview/root. Preserve page history by updating links and applying any legacy/banner treatment without copy/recreate. |
| 1.2 | Move CoP 5/15/26 under Working Group Notes | P1 | None | Space admin | CoP page is a child of Working Group Notes. |
| 1.3 | Move Confluence Formatting Standards under Governance and Safety | P1 | None | Space admin | Governance and Safety parent exists. Formatting Standards is a child page. |
| 1.4 | Promote Pattern Library patterns to child pages | P2 | None | Working group lead | Each core pattern is individually linkable. Parent page is an index. |
| 1.5 | Update Space Structure and Navigation | P1 | 1.1-1.4 | Space admin | Done: page `5281218620` updated from version 1 to version 2 using `docs/confluence-pages/space-structure-and-navigation.md`. |
| 1.6 | Update Agent Governance Home | P1 | 1.1-1.5 | Space admin | Done: `Governance and Safety` is linked from the recommended structure list. Continue refreshing this page as later structure changes land. |

## Milestone 2: Template Creation

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 2.1 | Create Agent Design Record Template | P0 | None | Working group lead | Template exists under Templates and includes sections from `templates/confluence/agent-design-record-template.md`; status and fit decision options now match Agent Fit Intake. |
| 2.2 | Create Context Readiness Checklist | P0 | None | Working group lead | Done: page-ready draft exists at `docs/confluence-pages/context-readiness-checklist.md`; Confluence page created under `Governance and Safety`. |
| 2.3 | Create Agent Governance Review Template | P1 | None | Working group lead | Template exists under Templates with human-facing checklist and required completeness fields. |
| 2.4 | Create Agent ADR Template | P1 | None | Working group lead | Template exists under Templates. |
| 2.5 | Create Decision Log index page | P1 | 2.4 | Working group lead | Page exists with ADR naming convention. |

## Milestone 3: Governance Model

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 3.1 | Create Governance and Safety section | P0 | 1.3 | Working group lead | Done: parent page exists under Agent Governance Home. Remaining children to move or create include Governance Review Checklist, Known Risks and Limitations, and Formatting Standards. |
| 3.2 | Create Known Risks and Limitations page | P1 | None | Working group lead | Page includes platform limitations, organizational risks, mitigations, and workarounds. |
| 3.3 | Add Context Readiness Assessment to Doc Health Gate | P1 | 2.2 | Meta-agent owner | Doc Health Gate includes context readiness as a P1 audit check. |
| 3.4 | Add measurement plan check to Doc Health Gate | P1 | 5.1 | Meta-agent owner | Doc Health Gate includes measurement plan as a P1 check. |
| 3.5 | Create first three ADRs | P2 | 2.4, 2.5 | Working group lead | ADRs exist for Project Brain pattern, fit triage framework, and meta-agent collaboration model. |
| 3.6 | Define governance completeness contract | P0 | 4.1 | Working group lead | Done locally: `docs/agent-governance-completeness-contract.md` and `schemas/agent-governance-record.schema.json` define required owner, backup owner, status, purpose, audience, knowledge sources, tools or skills, measurement plan, readiness status, Project Brain link, and last-reviewed date. |

## Milestone 4: Meta-Agent Enhancement

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 4.1 | Add Agent Fit Intake to Design Agent flow | P0 | None | Meta-agent owner | Done locally: `docs/confluence-pages/agent-fit-intake.md` defines the Design Agent intake sequence and routing rules for prompt, automation, existing-agent extension, Confluence template, app candidate, new governed agent, or not ready. Confluence update still requires focused dry-run and approval before apply. |
| 4.2 | Add context readiness pre-check to Design Agent | P1 | 2.2 | Meta-agent owner | Done locally: intake flow requires readiness status before a new governed agent recommendation; critical gaps route to `Not ready`. |
| 4.3 | Add inventory dedup check to Design Agent | P1 | 1.1 | Meta-agent owner | Done locally: intake flow requires `Agent Inventory` and related Project Brain checks before recommending `New governed agent`. |
| 4.4 | Add risk tier classification to Design Agent output | P2 | None | Meta-agent owner | Risk tier appears in every design packet. |
| 4.5 | Update Doc Steward to check measurement plans | P1 | None | Meta-agent owner | Missing measurement plan is flagged as P1. |
| 4.6 | Update Doc Steward to generate completeness score | P2 | None | Meta-agent owner | Doc Health Gate output includes completeness percentage. |
| 4.7 | Update Evaluation Library with new scenarios | P2 | 4.1-4.5 | Meta-agent owner | At least three new test cases per meta-agent cover new capabilities. |
| 4.8 | Investigate Studio visibility and team assignment | P1 | None | Atlassian admin + space admin | Read-only checklist exists at `docs/studio-visibility-team-assignment-investigation-checklist.md`. Next: run investigation without Studio writes and document what controls are available. |

## Milestone 5: Measurement And Reporting

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 5.1 | Create Measurement and Value Tracking page | P0 | None | Working group lead | Done: page-ready draft exists at `docs/confluence-pages/measurement-and-value-tracking.md`; Confluence page created under `Governance and Safety`. |
| 5.2 | Add success metrics to Release Health Analyst Project Brain | P1 | 5.1 | Agent owner | Release Health Analyst includes baseline and target metrics. |
| 5.3 | Create quarterly review template | P2 | 5.1 | Working group lead | Template exists for portfolio review. |
| 5.4 | Add publish-history records | P1 | 5.1 | Space admin | Started: `docs/publish-history/2026-05-21-agent-fit-intake.md` records page ID, old version, new version, source file, command, timestamp, and verification result. Next: automate or standardize this for every API-assisted apply. |
| 5.5 | Create governance completeness report | P1 | 1.1, 5.4 | Space admin | Contract and dry-run report shape are defined locally. Next: implement read-only report that identifies missing owner, backup owner, status, purpose, audience, knowledge sources, tools or skills, measurement plan, readiness status, Project Brain link, or last-reviewed date. |
| 5.6 | Create duplicate-agent discovery report | P1 | 1.1 | Working group lead | Report helps builders find existing agents or patterns before creating new work. |
| 5.7 | Create monthly governance snapshot | P1 | 5.5, 5.6 | Space admin | Done locally: template exists at `templates/confluence/monthly-governance-snapshot-template.md` for leadership and builders. Next: generate it from inventory, completeness, publish history, and intake data. |

## Milestone 6: Pilot And Feedback Loop

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 6.1 | Create User Guide - Designing Agents | P1 | 1.5, 2.1 | Working group lead | Done: page-ready draft exists at `docs/confluence-pages/user-guide-designing-agents.md`; Confluence page created under `Governance and Safety`. |
| 6.2 | Create Admin and Owner Guide | P2 | None | Space admin | Page exists with admin responsibilities, label management, review cadence, and retirement process. |
| 6.3 | Create Backlog and Improvement Roadmap | P1 | None | Working group lead | All open CoP action items are migrated. |
| 6.4 | Run pilot with one new builder | P1 | 6.1 | Working group lead | Builder completes process and at least three improvements are identified. |
| 6.5 | Conduct post-pilot retrospective | P2 | 6.4 | Working group lead | Retrospective notes and template updates are documented. |
