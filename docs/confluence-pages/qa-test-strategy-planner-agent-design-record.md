# QA Test Strategy Planner - Agent Design Record

## Design Metadata

| Field | Value |
|---|---|
| Agent name | QA Test Strategy Planner |
| Status | Pilot Approved (pilot-only: Lisa Porter pilot); Needs Cleanup |
| Owner | Shayne Vandersloot |
| Backup owner | Robert Boles |
| Design version | v0.1 / 2026-06-17 |
| Related request | Help a QA lead achieve her testing strategy with reusable governed agents. |
| Related agents | QA Test Case Architect v2, Jira Work Item Assistant, Release Drift Monitor, Release Health Analyst, Performance Test Report Agent (Extension), ROVO Design Agent |

## Problem Statement

QA leads need a reusable way to turn strategy guidance, project-specific requirements, environment constraints, automation goals, and risk inputs into consistent test strategy and test plan drafts. Current plans repeat many sections but can vary in completeness, traceability, risk handling, environment/data detail, and automation handoff quality.

The existing QA Test Case Architect v2 is valuable for downstream test artifacts. It should not absorb full strategy planning, plan-quality review, automation-suite planning, and readiness-gap routing.

## Target Users

| Role | How They Use The Agent |
|---|---|
| QA lead | Draft strategy, review plan completeness, identify risks and missing readiness inputs. |
| Test lead | Convert epic or workstream context into a structured plan and automation handoff. |
| SDET | Identify automation candidates, suite ownership, data dependencies, and reusable assets. |
| Project manager | See missing deliverables, dependencies, schedule, sign-off, and risk items. |
| Product owner / business analyst | Review scope, acceptance coverage, UAT opportunities, and open questions. |

## Workflow Supported

The agent supports five modes:

| Mode | Trigger | Output |
|---|---|---|
| Strategy Draft | User asks for a test strategy or test plan from epic, requirements, or Confluence context. | Draft plan with source notes and Data Incomplete flags. |
| Plan Quality Review | User provides an existing test plan or asks whether a plan is complete. | Findings against Test Plan Quality Criteria and planning sections. |
| Readiness Gap Review | User asks what is missing before testing can proceed. | Environment/data/risk/dependency/deliverable/sign-off gap list. |
| Automation Handoff | User asks for automation planning or workstream automation scope. | Smoke/regression/integration/E2E planning handoff with ownership and gaps. |
| Routing | Request belongs to another agent or deeper artifact generator. | Route note with rationale and next action. |

## Fit Decision

| Field | Value |
|---|---|
| Decision | New governed agent candidate |
| Reason | The workflow is repeatable, shared across QA roles, source-backed, and distinct from downstream test case generation or release readiness. |
| Why not prompt-only? | The workflow needs source discipline, reusable team overlays, routing, evaluation, and governance guardrails across many teams. |
| Why not QA Test Case Architect v2? | That agent owns artifact generation from source packets: test cases, coverage maps, RTMs, XRAY CSV, and artifact packs. Strategy planning would make it too broad. |
| Why not Release Health Analyst? | Release Health Analyst owns final readiness, blocker, and go/no-go decision support, not strategy drafting. |

## Trigger

Use this agent when the user asks for any of:

- Test strategy or test plan draft.
- Review of an existing test strategy or plan.
- Test planning gaps, readiness gaps, or missing evidence.
- Test deliverables, entry/exit criteria, environment, data, risk, or sign-off planning.
- Automation-suite planning for smoke, regression, integration, E2E, RapidBotz, CI/CD, nightly, or on-demand execution.
- Routing between QA strategy, test case generation, Jira follow-up, release drift, release health, or performance analysis.

## Inputs And Context Sources

| Source | Type | Authority | Allowed Use | Freshness | Fallback |
|---|---|---|---|---|---|
| Test Planning And Strategy | Confluence / IQS | Process Authority | Defines required strategy elements and Agile planning model. | Review after page change | Ask user to paste current page content if inaccessible. |
| Test Deliverables | Confluence / IQS | Process Authority | Defines SDLC deliverables and expected QA outputs. | Review after page change | Mark Data Incomplete for deliverable questions. |
| Test Plan Quality Criteria | Confluence / IQS | Process Authority | Plan review heuristics and quality review dimensions. | Review after page change | Use only provided criteria if page inaccessible. |
| Enterprise End To End Regression Test Service | Confluence / IQS | Reference / Process Context | E2E/regression approach, Xray, defect triage, and integration expectations. | Review after page change | Mark E2E/regression context incomplete. |
| Master test strategy pages | Confluence / IQS | Reference / Example | Example structure for program-level strategy. | Per request | Use as example only, not universal policy. |
| Representative project plans | Confluence / IQS | Reference / Example | Example sections, risk patterns, environment/data constraints, and coverage matrices. | Per request | Do not generalize domain-specific details unless supplied. |
| QA Consolidated Automation Strategy & Implementation | Confluence / IQS | Process Authority for automation planning | Automation suite strategy, workstream page guidance, ownership, and Jira tracking expectations. | Review after page change | Mark automation handoff Data Incomplete. |
| Quality Assurance (QA) AI Strategy - 2026 | Confluence / IQS | Strategy Context | Agent portfolio, evaluation, governance, and human review expectations. | Review after page change | Do not use as approval for launch. |
| QA Test Case Architect v2 page family | Confluence / ROVO | Related Agent Authority | Routing and downstream artifact-generation boundaries. | Review before pilot | Ask user to provide current page if inaccessible. |
| User-provided epic, requirements, Jira export, or source text | User-supplied evidence | System of Record for current request when explicit | Current work scope and acceptance context. | Current request | Ask for missing exact source. |

## Skills And Actions

| Skill or action | Risk tier | Allowed use | Approval required |
|---|---|---|---|
| Read/search Confluence | Tier 1 | Retrieve approved QA process, strategy, and agent docs. | No, if already permissioned. |
| Read Jira or user-provided Jira exports | Tier 1 | Understand epic/story scope and draft follow-up needs. | No, if already permissioned. |
| Draft text, tables, and copy-ready sections | Tier 1 | Produce human-reviewed strategy, plan, gaps, and handoff drafts. | No. |
| Jira writes | Tier 3 | Not allowed. Route draft-only follow-ups to Jira Work Item Assistant. | N/A. |
| Confluence writes | Tier 3 | Not enabled from this agent. | Future dry-run and explicit approval only. |
| ROVO Studio writes | Tier 3 | Not allowed. | N/A. |

## Human Approval Points

| Decision | Human owner |
|---|---|
| Promote the candidate beyond Draft | Working group / QA agent owner |
| Approve a test strategy or test plan | QA lead and required project stakeholders |
| Accept risk, skip a test type, or reduce coverage | QA lead plus accountable business/technical owner |
| Approve automation backlog or Jira follow-up creation | Human requester / Jira owner |
| Final release readiness or go/no-go | Release owner with Release Health Analyst support |

## Expected Outputs

| Output | Required sections |
|---|---|
| Test strategy draft | Purpose, scope, out-of-scope, approach, test types, roles, environments, data, schedule, deliverables, entry criteria, exit criteria, risks, dependencies, traceability, metrics, communication, sign-off, Data Incomplete. |
| Plan quality review | Summary, findings by quality criterion, missing source evidence, risk impact, recommended edits, route notes. |
| Readiness gap review | Missing inputs grouped by scope, environment, data, automation, risk, dependency, deliverable, traceability, and approval. |
| Automation handoff | Workstream/application, suite map, execution location, ownership, data/common conditions, reusable assets, RapidBotz or framework notes when provided, Jira tracking notes, open gaps. |
| Routing note | Recommended agent, reason, what context to provide next, and boundary warning. |

## Failure Modes

| Failure mode | Impact | Mitigation |
|---|---|---|
| Agent invents strategy content from generic QA knowledge. | Plans appear complete but are not source-backed. | Require evidence notes and Data Incomplete flags. |
| Agent competes with QA Test Case Architect v2. | Duplicated test case generation behavior and governance drift. | Route test case, RTM, XRAY CSV, and artifact-pack requests downstream. |
| Agent recommends skipping tests. | Quality and governance risk. | Require explicit human approval and documented accepted risk. |
| Agent treats a draft as approved. | Human-owned approval boundary is crossed. | Always label outputs draft/review-ready only. |
| Agent overgeneralizes project examples as enterprise policy. | Team-specific detail becomes false standard. | Mark examples as reference unless source is process authority. |

## Example Prompts

1. Draft a test strategy for this epic using the attached requirements and known environment constraints.
2. Review this test plan against Test Plan Quality Criteria and list gaps the QA lead should resolve.
3. Identify missing data, environment, risk, and exit-criteria inputs before this plan is ready for review.
4. Turn these workstream automation notes into a smoke/regression/integration/E2E planning handoff.
5. This request asks for XRAY CSV test cases. Route me to the right agent and list what source packet it needs.
6. Can we skip regression for this change? Explain what approval and risk evidence would be needed.

## Version History

| Version | Date | Change Summary | Updated By |
|---|---|---|---|
| v0.1 | 2026-06-17 | Initial governed candidate design for QA test strategy planning. | Codex governance scaffold |
