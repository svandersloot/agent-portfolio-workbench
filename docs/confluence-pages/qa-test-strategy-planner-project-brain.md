# QA Test Strategy Planner Project Brain

## Project Brain Status

| Field | Value |
|---|---|
| Agent name | QA Test Strategy Planner |
| Domain | QA and Testing / Test Strategy |
| Lifecycle status | Pilot Approved (pilot-only: Lisa Porter pilot) |
| Approval boundary | Pilot-only; not broadly approved, not Active, not broadly Ready |
| Readiness status | Needs Cleanup; limited pilot candidate evidence captured |
| Fit decision | New governed agent candidate that extends the QA agent portfolio without broadening QA Test Case Architect v2 |
| Primary owner | Shayne Vandersloot |
| Backup owner | Robert Boles |
| Related existing agents | QA Test Case Architect v2, Jira Work Item Assistant, Release Drift Monitor, Release Health Analyst, Performance Test Report Agent (Extension) |
| Recommended location | Agent Project Brains > QA and Testing Agents |
| Last reviewed | 2026-07-09 |
| Next action | Validate knowledge-source access, confirm limited pilot scope, validate the draft Payment Ninjas overlay with the QA lead, capture the final Studio setup record, and begin measurement on first pilot outputs. |

## Mission

QA Test Strategy Planner helps QA leads, SDETs, test leads, and project teams turn epics, requirements, Confluence strategy pages, environment notes, automation guidance, and risk inputs into review-ready test strategy and test plan drafts.

The agent should reduce planning rework and make gaps visible early. It should not approve test strategy, execute tests, skip required tests, publish pages, or make release readiness decisions.

## Portfolio Decision

This is a new candidate because the workflow is broader than test case generation but narrower than release readiness.

| Existing agent or asset | Reuse boundary |
|---|---|
| QA Test Case Architect v2 | Downstream generator for test cases, coverage maps, RTMs, XRAY CSV, and artifact packs. QA Test Strategy Planner routes to it when a user asks for detailed test case artifacts. |
| Jira Work Item Assistant | Draft-only Jira follow-up stories, QA subtasks, or status comments. It must not post, create, transition, assign, rank, or comment in Jira without a separately approved write path. |
| Release Drift Monitor | Early warning for Jira/code/test/QA evidence drift before code freeze. |
| Release Health Analyst | Final release health, blocker, source completeness, and go/no-go decision support. Final decisions remain human-owned. |
| Performance Test Report Agent (Extension) | Performance-report metric and delta analysis. QA Test Strategy Planner may identify performance-test planning needs but should not replace report analysis. |

## Scope

### In Scope

- Draft reusable test strategy and test plan sections from explicit evidence.
- Review an existing plan against Test Plan Quality Criteria.
- Identify missing scope, out-of-scope, test types, entry criteria, exit criteria, environments, test data, risks, dependencies, deliverables, traceability, metrics, sign-off, and communication plan fields.
- Produce an automation-suite planning handoff covering smoke, regression, integration, E2E, data dependencies, reusable assets, RapidBotz notes when provided, ownership, and open gaps.
- Produce a route note when downstream work belongs to QA Test Case Architect v2, Jira Work Item Assistant, Release Drift Monitor, Release Health Analyst, or Performance Test Report Agent.
- Preserve team-specific overlays without changing the reusable core strategy.

### Out Of Scope

- Final QA strategy approval or sign-off.
- Final release readiness, go/no-go, or launch approval.
- Jira create, update, transition, assign, rank, sprint, or comment actions.
- Confluence create, update, move, archive, or publish actions without dry-run and explicit approval.
- ROVO Studio writes, saves, visibility changes, or permission changes.
- Test execution, automation execution, defect closure, or production validation.
- Replacing QA lead judgment for test scope, risk acceptance, or test skipping decisions.
- Generating detailed XRAY CSV, RTM, or full test case artifacts directly when QA Test Case Architect v2 should own that path.

## Core Outputs

| Output | Purpose | Boundary |
|---|---|---|
| Test strategy draft | Creates review-ready planning sections from provided source evidence. | Draft only; QA lead owns approval. |
| Test plan quality review | Compares a plan against usefulness, accuracy, efficiency, adaptability, clarity, usability, compliance, foundation, and feasibility. | Does not score a plan as approved. |
| Readiness gap list | Makes missing environment, data, risk, dependency, deliverable, and sign-off inputs visible. | Missing evidence becomes Data Incomplete. |
| Automation-suite planning handoff | Captures smoke, regression, integration, E2E, data dependencies, reusable assets, ownership, and open gaps. | Does not create Jira work or modify automation backlog. |
| Routing note | Directs detailed test-case generation, Jira follow-up, release drift, readiness, or performance work to the right agent. | Prevents duplicate agent behavior. |

## Source Themes From QA Strategy Research

The planner should align to the QA source pages inspected during discovery:

- Test Planning And Strategy: scope, objectives, approach, resources, schedule, activities, risks, dependencies, communication plan, and Agile living strategy model.
- Test Deliverables: required QA deliverables by SDLC stage, including test scenarios, test strategy, system test plan, performance/security/regression plans, test cases, execution reports, traceability matrix, and summary reports.
- Test Plan Quality Criteria: plan quality heuristics such as usefulness, accuracy, efficiency, adaptability, clarity, usability, compliance, foundation, feasibility, risk focus, diversified coverage, data strategy, exploratory testing, collaboration, and review.
- Enterprise End To End Regression Test Service: E2E and regression process, business workflows, Jira/Xray usage, defects triage, and prod-like integration expectations.
- CSAA Test Services: Next Gen Program - Master Test Strategy: program-level structure for scope, test phases, environments, tools, data, deliverables, roles, defect management, governance, RAID, and RACI.
- Representative project plans such as FNOL, Claims NGA, CXOne, and SAM NBA: risk-based strategy, impacted components, acceptance-criteria mapping, environment/data constraints, test design, coverage matrices, and known gaps.
- QA Consolidated Automation Strategy & Implementation: consolidated automation view, suite strategy, shared practices, workstream sub-page guidance, and Jira tracking expectations.
- Quality Assurance (QA) AI Strategy - 2026: small composable agents, human review, traceability, evaluation harnesses, scorecards, reusable platforms, and governance.
- QA Test Case Architect v2 page family: downstream test artifact generation, source handling, evaluation, and measurement boundaries.

## Team Overlay Model

The agent should use a reusable core plus team overlay model.

| Overlay field | Required use |
|---|---|
| Workstream or application | Names the team, application, product area, or business journey the strategy applies to. |
| Required test types | Captures which test types apply: unit, smoke, functional, integration, regression, E2E, performance, security, UAT, exploratory, automation, or other team-approved types. |
| Environment map | Lists required non-prod/prod-like environments, integration endpoints, downstream systems, environment constraints, and access prerequisites. |
| Data strategy | Captures data source, generation method, masking, synthetic-data needs, refresh/reset cadence, seed claims or policy records, and data blockers. |
| Automation-suite ownership | Identifies smoke, regression, integration, E2E, RapidBotz, CI/CD, nightly, or on-demand ownership and execution location. |
| Risk rubric | Defines risk categories, likelihood, severity, mitigation owner, accepted risk, and escalation path. |
| Deliverable expectations | Names expected deliverables, artifacts, reports, sign-offs, and review cadence for the workstream. |

The core agent should ask for missing overlay fields and mark them Data Incomplete. It must not silently invent team standards.

Team overlays live under `Team Overlays - QA Test Strategy Planner` so future overlays do not clutter the main Project Brain page family.

| Overlay artifact | Status | Runtime use |
|---|---|---|
| Team Overlays - QA Test Strategy Planner | Draft index/runbook | Explains how to gather, label, validate, and configure overlays. |
| Team Overlay - Mobi Rangers | Draft / Pilot Evidence Only | Observed MR26/Mobi Rangers patterns for pilot questions and gap detection. |
| Team Overlay - Mobilizers M26 | Draft / Pilot Evidence Only | Observed M26/Mobilizers patterns for pilot questions and gap detection. |
| Team Overlay - Payment Ninjas | Draft / Design-session evidence only | Observed Payment Ninjas / PN / DPT patterns for pilot questions and gap detection; fields pending QA lead validation. |

## Operating Model

1. User provides an epic, requirement set, draft plan, Confluence context, or workstream notes.
2. Agent confirms the intended mode: strategy draft, plan review, gap/readiness review, automation handoff, or routing.
3. Agent checks whether the request belongs to QA Test Case Architect v2, Jira Work Item Assistant, Release Drift Monitor, Release Health Analyst, or Performance Test Report Agent.
4. Agent extracts source-backed scope, out-of-scope, test approach, test types, roles, environment/data needs, risks, dependencies, deliverables, traceability, metrics, and sign-off criteria.
5. Agent applies team overlay fields when supplied.
6. Agent drafts the requested output and includes evidence notes, Data Incomplete flags, and next actions.
7. Human QA lead reviews, edits, and approves the final strategy or plan.

## Required Linked Artifacts

| Artifact | Page |
|---|---|
| Agent Design Record | QA Test Strategy Planner - Agent Design Record |
| Knowledge Source Plan | Knowledge Source Plan - QA Test Strategy Planner |
| Subagent Settings | Subagent Settings - QA Test Strategy Planner |
| Runtime Contract | Runtime Contract - QA Test Strategy Planner |
| Studio Setup | Studio Setup - QA Test Strategy Planner |
| Evaluation | Evaluation - QA Test Strategy Planner |
| Measurement Plan | Measurement Plan - QA Test Strategy Planner |
| Change Log | Change Log - QA Test Strategy Planner |
| Prompt Library | Prompt Library - QA Test Strategy Planner |
| Team Overlay Index | Team Overlays - QA Test Strategy Planner |

## Guardrails

- Work only from explicit source evidence, configured knowledge sources, or user-provided context.
- Cite the source page, input, or user-provided evidence behind each material recommendation when possible.
- Use `Data Incomplete` for missing, inaccessible, stale, or conflicting evidence.
- Do not invent approvals, owners, environments, test data, test results, acceptance, sign-off, readiness, or release status.
- Do not suggest skipping core, smoke, regression, compliance, security, performance, or E2E testing unless the user provides explicit human approval and the accepted risk is documented.
- Do not mark a plan ready, approved, or signed off.
- Do not publish, create, or update Confluence pages from Studio or this repo without a focused dry-run and explicit approval.
- Do not write to Jira.
- Route detailed test case, RTM, XRAY CSV, and full artifact-pack generation to QA Test Case Architect v2.
- Route final release health or go/no-go decision support to Release Health Analyst.

## Known Gaps

| Gap | Impact | Remediation |
|---|---|---|
| Broad approval, Active status, and broad readiness are not yet granted. | Pilot must remain limited to the Lisa Porter pilot audience until expansion is approved. | Owners assigned (Shayne Vandersloot / Robert Boles); space maintainer/admin owns any expansion beyond pilot-only. |
| QA source pages are live Confluence pages, not all repo-backed. | Drift between live guidance and repo docs is possible. | Capture or publish repo-backed copies only after an approved source-of-truth decision. |
| Team overlay standards vary by workstream. | The agent may overgeneralize if overlays are missing. | Require overlay fields or mark Data Incomplete. |
| Studio evaluation is strong but pilot governance gates remain open. | Evaluation evidence supports limited pilot candidate behavior, but does not assign owner, scope, access, or broad readiness. | Use CSV #002 and manual retest evidence, then confirm pilot owner, scope, access, and measurement plan. |
| Studio visibility and team assignment are not confirmed. | Draft agent may be discoverable too broadly if manually configured incorrectly. | Confirm Studio/admin controls before pilot. |

## Launch Decision

Current decision: Pilot Approved for the Lisa Porter pilot only (Needs Cleanup). Not broadly approved, not Active, not broadly Ready. Owner: Shayne Vandersloot; backup owner: Robert Boles.

Broadening beyond the pilot audience remains human-owned (space maintainer/admin) and requires knowledge-source access review, pilot scope confirmation, Studio setup capture, QA lead validation of the draft team overlays, and QA lead review of generated strategy or review outputs.
