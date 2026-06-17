# Subagent Settings - QA Test Case Architect v2

## Current Subagent And Orchestration Model

QA Test Case Architect v2 currently uses a single-parent-agent model. No subagents are required for the draft documentation slice.

This page exists to record that decision and prevent future Studio configuration drift. If subagents are added later, update this page before changing Studio.

The agent should still follow a three-stage operating pipeline:

1. Retrieval: collect specific source inputs.
2. Generation: create draft artifacts.
3. Validation: check coverage, XRAY/CSV format, traceability, and missing-data logs.

## Why No Subagents Yet

| Consideration | Current decision |
|---|---|
| Workflow shape | Test-suite generation, coverage mapping, and RTM drafting share the same source discipline and safety rules. |
| Risk profile | All current actions are read-only plus generated text/CSV output. |
| Source model | Same source package is used across artifact types. |
| Evaluation maturity | No pilot evaluation has run yet, so splitting behavior would add configuration complexity before evidence supports it. |

## Parent Agent Responsibilities

The parent agent owns:

- Intake validation.
- Retrieval, generation, and validation orchestration.
- Feature brief drafting from supplied evidence.
- QA template retrieval or missing-template flagging.
- Requirement and acceptance-criteria normalization.
- XRAY-compatible CSV drafting.
- Coverage map drafting.
- RTM drafting.
- `ConflictLog` and `TBDLog` creation.
- Human review checklist output.

## Future Split Criteria

Consider subagents only if evaluation or pilot use shows a durable need for separate routing, such as:

| Possible subagent | Trigger | Split rationale |
|---|---|---|
| XRAY CSV Drafter | User asks specifically for XRAY-compatible CSV output. | Useful if CSV formatting diverges from other artifact workflows. |
| Coverage Mapper | User asks for AC coverage or gap analysis. | Useful if coverage analysis needs a separate rubric. |
| RTM Builder | User asks for requirement traceability matrix output. | Useful if RTM formatting or source aggregation becomes more complex. |
| Source Conflict Reviewer | User asks to reconcile conflicting sources. | Useful only if it remains read-only and never resolves conflicts without human decision. |
| Validation Gate Runner | User asks whether output satisfies coverage, XRAY, CSV, or traceability checks. | Useful if validation rules become complex or artifact-specific. |

## Guardrails For Any Future Subagent

- Keep write actions disabled unless a separate governed write workflow is approved.
- Preserve the same source authority model from the Knowledge Source Plan.
- Do not let a subagent approve test plans, risk sign-offs, go/no-go, Definition of Done, or source conflicts.
- Keep conversation starters on the parent agent only.
- Keep triggers on subagents only.
