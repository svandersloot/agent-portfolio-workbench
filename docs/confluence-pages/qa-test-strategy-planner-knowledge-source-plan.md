# Knowledge Source Plan - QA Test Strategy Planner

## Source Strategy

QA Test Strategy Planner should work from explicit, current QA process sources and request-specific evidence. It should prefer approved QA strategy, deliverable, quality criteria, automation, and AI governance pages over generic testing advice.

When evidence is missing, inaccessible, stale, or conflicting, the agent must mark `Data Incomplete` rather than inventing a plan, owner, environment, data setup, test result, sign-off, or readiness claim.

## Authority Labels

| Label | Meaning |
|---|---|
| Process Authority | Approved source that defines expected QA planning, deliverables, quality criteria, or automation standards. |
| Strategy Context | High-level direction that informs portfolio fit, AI use, evaluation, and governance. |
| Related Agent Authority | Source of truth for routing to another governed agent. |
| System of Record | Jira issue, requirement, epic, project page, or user-provided source that defines the current work. |
| Reference Example | Project-specific example that can inspire structure but must not become general policy. |
| User-Supplied Evidence | Current-turn pasted or attached evidence. |

## Approved Source Map

| Source | Type | Authority | Allowed use | Freshness | Fallback |
|---|---|---|---|---|---|
| Test Planning And Strategy | Confluence / IQS | Process Authority | Define strategy sections: objectives, scope, approach, environments, roles, data, schedule, exit criteria, risks, and communications. | Review after page updates | Ask user to paste current content. |
| Test Deliverables | Confluence / IQS | Process Authority | Determine expected deliverables by SDLC stage. | Review after page updates | Mark deliverable mapping Data Incomplete. |
| Test Plan Quality Criteria | Confluence / IQS | Process Authority | Review plan quality: usefulness, accuracy, efficiency, adaptability, clarity, usability, compliance, foundation, feasibility, risk focus, coverage diversity, data strategy, collaboration, and review. | Review after page updates | Use provided criteria only. |
| Types of Testing | Confluence / IQS | Process Authority | Define common test type vocabulary. | Review after page updates | Ask user for accepted team definitions. |
| Risk Management | Confluence / IQS | Process Authority / Reference | Structure risk identification, severity, likelihood, mitigation, and monitoring. | Review after page updates | Mark risk rubric Data Incomplete. |
| Enterprise End To End Regression Test Service | Confluence / IQS | Process Authority / Reference | E2E and regression process, business workflow testing, Jira/Xray evidence, prod-like integrations, and defect triage. | Review after page updates | Route uncertain release evidence to Release Drift Monitor or Release Health Analyst. |
| CSAA Test Services: Next Gen Program - Master Test Strategy | Confluence / IQS | Reference Example | Program-level strategy structure and governance pattern. | Per request | Use as example only. |
| Representative test plans: FNOL, Claims NGA, CXOne, SAM NBA | Confluence / IQS | Reference Example | Examples of impact areas, AC coverage, environment/data constraints, risks, and coverage matrices. | Per request | Do not generalize project-specific systems or owners. |
| Virtual Claims Assistant NBA Environment Information | Confluence / IQS | Reference Example | Example of environment mapping and execution checklist. | Per request | Ask for current environment map. |
| QA Consolidated Automation Strategy & Implementation | Confluence / IQS | Process Authority for automation handoff | Automation suite strategy, workstream sections, ownership, CI/CD/nightly/on-demand execution, data dependencies, reusable assets, and Jira tracking notes. | Review after page updates | Mark automation handoff Data Incomplete. |
| Quality Assurance (QA) AI Strategy - 2026 | Confluence / IQS | Strategy Context | Small composable agent strategy, human-in-the-loop, evaluation harness, scorecards, adoption, and governance. | Review after page updates | Treat as direction, not approval. |
| QA and Testing Agents | Confluence / ROVO | Related Agent Authority | Portfolio index and QA agent guardrails. | Review before pilot | Ask user to provide page if inaccessible. |
| QA Test Case Architect v2 Project Brain and related pages | Confluence / ROVO | Related Agent Authority | Routing boundary for test cases, coverage maps, RTMs, XRAY CSV, and artifact packs. | Review before pilot | Ask for current page family if inaccessible. |
| Jira Work Item Assistant Project Brain | Repo / Confluence | Related Agent Authority | Routing boundary for Jira follow-up drafts and ticket/comment preparation. | Review when Work Item Assistant changes | Draft only; no Jira writes. |
| Release Drift Monitor and Release Health Analyst docs | Repo / Confluence | Related Agent Authority | Routing boundary for release drift, evidence checks, final readiness, and go/no-go support. | Review when release agents change | Route, do not duplicate. |
| User-provided epic, requirements, Jira issue, export, test plan, or notes | User evidence | System of Record for current request | Define current work scope. | Current request | Ask for missing specific source. |

## Required Input Check

Before producing a confident strategy draft or plan review, the agent should confirm:

- Workstream/application or program context.
- Request mode: strategy draft, plan review, readiness gap review, automation handoff, or routing.
- Epic, requirement set, Confluence page, Jira issue, or user-provided source that defines the work.
- In-scope and out-of-scope areas, or a note that they are missing.
- Required test types and any team-specific rules.
- Environment map or known environment constraints.
- Test data source, generation, masking, synthetic-data, refresh, or reset needs.
- Known risks, dependencies, assumptions, constraints, and open questions.
- Deliverables and target SDLC or Agile phase.
- Entry criteria, exit criteria, metrics, communication cadence, and sign-off owner.
- Whether detailed test cases, RTM, coverage map, or XRAY CSV should be routed to QA Test Case Architect v2.

## Data Incomplete Flags

| Flag ID | Missing or incomplete data | Impact | How to clear |
|---|---|---|---|
| QATSP-DI-001 | Workstream, application, epic, or product scope is missing. | Strategy may not target the correct business or technical area. | Provide source page, Jira issue, requirement packet, or scope statement. |
| QATSP-DI-002 | In-scope or out-of-scope boundaries are missing. | Coverage and risk may be over- or under-stated. | Provide scope decisions or owner-approved exclusions. |
| QATSP-DI-003 | Required test types are unknown. | The plan may miss required testing. | Provide team standard or QA lead decision. |
| QATSP-DI-004 | Environment map is missing or stale. | Execution feasibility cannot be assessed. | Provide environment names, endpoints, integration dependencies, access, and constraints. |
| QATSP-DI-005 | Test data strategy is missing. | Test execution may block on data availability, masking, or refresh. | Provide data source, generation method, synthetic data plan, masking, and refresh/reset cadence. |
| QATSP-DI-006 | Risk rubric or risk owner is missing. | Risk-based prioritization cannot be trusted. | Provide likelihood/severity approach and mitigation owner. |
| QATSP-DI-007 | Entry or exit criteria are missing. | Readiness and completion cannot be reviewed consistently. | Provide criteria or QA lead decision. |
| QATSP-DI-008 | Deliverable expectations are unclear. | QA outputs and stakeholder review may drift. | Provide expected SDLC/Agile deliverables and review cadence. |
| QATSP-DI-009 | Automation ownership or suite strategy is unclear. | Smoke/regression/integration/E2E planning handoff may not be actionable. | Provide suite ownership, execution location, reusable assets, framework/RapidBotz notes, and Jira tracking approach. |
| QATSP-DI-010 | Traceability source is missing. | AC-to-plan or requirement-to-test coverage cannot be shown. | Provide acceptance criteria, requirement IDs, or route to QA Test Case Architect v2 with source packet. |
| QATSP-DI-011 | Human sign-off owner is missing. | The draft cannot move toward review. | Identify QA lead and required stakeholder approvers. |

## Source Handling Rules

- Use process authority pages for structure and review criteria.
- Use project-specific pages as examples only unless the user says they are the current project source of truth.
- Do not copy domain-specific systems, owners, environments, or data from one project into another.
- Do not infer a test type is unnecessary because it is absent from the provided context.
- Do not claim a plan is approved, ready, complete, or signed off.
- If a user asks for detailed test cases, RTM, XRAY CSV, or full artifact pack, route to QA Test Case Architect v2 and list required inputs.
- If a user asks to create Jira follow-up work, route to Jira Work Item Assistant for draft-only Jira content.
- If a user asks whether release evidence is enough, route to Release Drift Monitor or Release Health Analyst based on stage and decision type.
- If a user asks for performance test report metrics or deltas, route to Performance Test Report Agent (Extension).
- Keep team overlays explicit and current-turn sourced.

## Team Overlay Guidance

Use this overlay table when adapting the core planning template for a team:

| Overlay field | Agent behavior |
|---|---|
| Workstream/application | Include it in title, scope, owner notes, and routing decisions. |
| Required test types | Convert into the plan's test approach and coverage matrix. |
| Environment map | Use it in environment needs, entry criteria, dependencies, and readiness gaps. |
| Data strategy | Use it in data requirements, risk, automation, and execution feasibility. |
| Automation-suite ownership | Use it in automation handoff, CI/CD/nightly/on-demand notes, and Jira follow-up drafts. |
| Risk rubric | Use it to prioritize coverage and mitigation items. |
| Deliverable expectations | Use it to build the deliverables checklist and sign-off path. |

If an overlay field is not supplied, mark it Data Incomplete instead of inventing it.

## Knowledge Source Review

| Review item | Status | Notes |
|---|---|---|
| QA planning and quality criteria sources identified | Draft | Live Confluence sources inspected on 2026-06-17. |
| Automation strategy source identified | Draft | QA Consolidated Automation Strategy provides suite and workstream guidance. |
| QA AI portfolio source identified | Draft | QA AI Strategy supports small composable agents and evaluation harnesses. |
| QA Test Case Architect v2 boundary identified | Draft | Confluence page family exists; local repo-backed copy not present in this slice. |
| Team overlay model identified | Draft | Needs QA lead review before pilot. |
| Owner and backup owner confirmed | Open | Required before pilot. |
| Runtime/setup split applied | Draft | Runtime behavior belongs in `Runtime Contract - QA Test Strategy Planner`; manual wiring belongs in `Studio Setup - QA Test Strategy Planner`. |
| Studio configuration applied or captured | Open | Manual only; no Studio write from this repo. |
