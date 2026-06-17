# QA Test Case Architect v2 Project Brain

## Project Brain Status

| Field | Value |
|---|---|
| Agent name | QA Test Case Architect v2 |
| Working name from self-description | Senior QA Test Engineer and Documentation Author (Stateless, Deterministic, Auditable) |
| Domain | QA documentation, test case generation, traceability, and XRAY CSV preparation |
| Lifecycle status | Draft |
| Readiness status | Needs Cleanup |
| Fit decision | New governed agent candidate |
| Primary owner | Needs human confirmation; Shayne Vandersloot identified as likely candidate, not formally assigned |
| Backup owner | TBD |
| Current source space | ROVO / QA AI Ops sources to confirm |
| Recommended location | Agent Project Brains > QA and Testing Agents |
| Last reviewed | 2026-06-11 |
| Next action | Confirm owner, backup owner, Ticket Pack Builder path, QA standard source, golden-copy examples, and pilot validation path before Studio launch or broad use. |

## Source Evidence

This scaffold is based on the agent's self-description provided on 2026-06-11. The self-description is discovery evidence only and does not prove Studio configuration, approval, visibility, or readiness.

## Mission

QA Test Case Architect v2 helps QA Engineers, SDETs, Test Leads, and Project Managers generate review-ready QA artifacts from explicit Jira and Confluence inputs while preserving traceability, deterministic formatting, and human ownership of final test-plan approval.

## Pipeline Model

Use a three-stage pipeline:

1. Retrieval: gather specific user-provided or configured source inputs.
2. Generation: create draft QA artifacts from the retrieved evidence.
3. Validation: check coverage, format, traceability, and missing-data logs before returning output.

This pipeline is an operating model, not approval for autonomous writes or unattended execution.

## Scope

### In Scope

- Generate the required QA artifact package from `TICKET_PACK_COMBINED.xml` in production workflows.
- Use prompt-provided source packets only for Studio evaluation or controlled AgentLab testing.
- Generate XRAY-compatible CSV test suites from ticket-pack story evidence.
- Generate feature briefs from ticket-pack Jira, Confluence, attachment, diagram, or schema evidence.
- Map acceptance criteria to test cases with 1:1 traceability.
- Create coverage maps that show source requirements, acceptance criteria, test cases, and gaps.
- Draft requirement traceability matrices from provided Jira or Confluence evidence.
- Normalize requirements into deterministic test-case structures.
- Produce `ConflictLog` and `TBDLog` sections when inputs conflict, are ambiguous, or are incomplete.
- Apply the confirmed `QA Standard - Test Case Template For Rovo Agents` when available.
- Validate output for coverage completeness, XRAY format expectations, and CSV structure before returning it.

## Required Artifact Catalog

| Artifact | Format | Required? | Notes |
|---|---|---|---|
| FeatureBrief | XML | Yes | Source-backed feature overview and testing scope. |
| TestSuite | XRAY CSV | Yes | Required output for manual downstream CSV generation/import flow. |
| CoverageMap | CSV | Yes | Maps requirements and acceptance criteria to tests and gaps. |
| RTM | CSV | Yes | Requirement Traceability Matrix. |
| E2E_Scenarios | TXT | Yes | End-to-end scenario outline from source evidence. |
| MiniTestPlan | XML | Yes | Compact test plan for human review. |
| TestSummary | XML | Yes | Summary of generated coverage, gaps, and review state. |
| ConflictLog | TXT | Yes | Conflicting source evidence requiring human decision. |
| TBDLog | TXT | Yes | Missing details, assumptions to clear, and owner questions. |

### Out Of Scope

- Execute tests in any environment.
- Make go/no-go release decisions.
- Approve test plans, test summaries, risk sign-offs, or feature Definition of Done.
- Fabricate acceptance criteria, requirements, test data, APIs, or architecture details that are not in the provided sources.
- Modify Jira, XRAY, or Confluence directly in the current design.
- Resolve conflicting requirements without human review.

## Required Linked Artifacts

| Artifact | Page |
|---|---|
| Agent Design Record | QA Test Case Architect v2 - Agent Design Record |
| Knowledge Source Plan | Knowledge Source Plan - QA Test Case Architect v2 |
| Subagent Settings | Subagent Settings - QA Test Case Architect v2 |
| Studio Setup | Studio Setup - QA Test Case Architect v2 |
| ROVO Studio Configuration | ROVO Studio Configuration - QA Test Case Architect v2 |
| Evaluation | Evaluation - QA Test Case Architect v2 |
| Measurement Plan | Measurement Plan - QA Test Case Architect v2 |
| Change Log | Change Log - QA Test Case Architect v2 |

## Operating Model

1. Production user supplies `TICKET_PACK_COMBINED.xml` from the upstream Ticket Pack Builder workflow.
2. Agent confirms the ticket pack includes requirements, acceptance criteria, source manifest, and relevant standards or template references.
3. For Studio evaluation or AgentLab testing only, the agent may treat a complete prompt-provided source packet as a temporary input package.
4. Agent retrieves or reviews only specific supplied/configured sources, not broad `all Jira` or `all Confluence` scopes.
5. Agent applies the QA standard test case template and golden-copy examples where available.
6. Agent produces the required artifact package with requirement-to-test traceability.
7. Agent validates output for coverage completeness, XRAY/CSV formatting, source traceability, and missing data.
8. Agent marks missing or conflicting inputs in `TBDLog` or `ConflictLog`.
9. Human QA owner reviews, edits, approves, and uses Copilot or another approved manual step to generate/import final CSV into XRAY.

## Guardrails

- Work only from provided or retrievable source evidence.
- Use `TBD` when required test detail is missing.
- Do not invent acceptance criteria, test data, expected results, API fields, architecture relationships, or validation steps.
- Keep generated CSV output review-ready, not automatically uploaded.
- Keep write actions disabled until a future governed write workflow is approved.
- Preserve data privacy; users must not provide PII/PHI beyond what is permitted for internal QA tooling.
- Treat deterministic ID logic as draft until a human confirms alignment with existing legacy test case numbering.
- If source evidence conflicts, log the conflict and ask for human resolution.

## Known Gaps

| Gap | Impact | Remediation |
|---|---|---|
| Primary owner is not formally assigned. | Cannot promote beyond Draft. | Confirm primary owner and decision authority. |
| Backup owner is missing. | Operational continuity gap. | Assign backup owner or delegate. |
| Production Ticket Pack Builder path needs confirmation. | Agent may block or produce incomplete artifacts without context. | Confirm how `TICKET_PACK_COMBINED.xml` is generated and handed to the agent. |
| Direct Jira/XRAY integration is not available. | Current workflow must remain manual copy/paste into Copilot and manual XRAY import. | Revisit only if Copilot gains a Jira or XRAY connector and governance approves the write path. |
| Knowledge source access is not confirmed. | Agent may miss required QA standards or source exports. | Confirm named source pages and allowed attachments. |
| Evaluation has not been run. | Quality and safety are unproven. | Run evaluation prompts against representative Jira stories and ambiguous AC examples. |
| Golden-copy examples are partial. | Format validation may be incomplete for non-TestSuite artifacts. | Use the sanitized XRAY CSV golden copy now; collect approved examples for XML, CSV, and TXT artifacts. |
| Validation thresholds are not defined. | Coverage gate pass/fail results may be inconsistent. | Define coverage, XRAY, CSV, and traceability validation criteria. |

## Launch Decision

Current decision: keep in Draft / Needs Cleanup.

The agent is promising as a governed QA documentation assistant, but it should not be promoted or broadened until ownership, source access, deterministic ID behavior, evaluation evidence, and measurement are confirmed.
