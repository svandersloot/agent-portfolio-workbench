# Subagent Settings - QA Test Case Architect v2

## Current Subagent And Orchestration Model

QA Test Case Architect v2 currently uses a single-parent-agent model. No subagents belong to this agent.

This page exists to record that decision and prevent future Studio configuration drift. If subagents are added later, update this page before changing Studio.

## Hand-off To QA Test Adequacy Critic (added 2026-08-25)

QA Test Case Architect v2 is not itself a parent of QA Test Adequacy Critic, but the two agents are linked by a one-way hand-off: after this agent generates a **complete production TestSuite/ArtifactPack** (not evaluation mode, not a single-artifact request, not partial output), it ends its response with a recommendation to run the output through QA Test Adequacy Critic before treating it as review-ready. See `Runtime Contract - QA Test Case Architect v2` (Routing Rules) and `Subagent Settings - QA Test Adequacy Critic` for the exact trigger condition and hand-off contract.

Do not claim hidden agent-to-agent invocation unless Studio exposes and governs that capability. Until confirmed, the hand-off is human-mediated: this agent's recommendation message is the extent of the behavior change, and the human reviewer copies/attaches the output into a separate conversation with QA Test Adequacy Critic.

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
