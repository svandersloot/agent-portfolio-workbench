# Subagent Settings - QA Test Adequacy Critic

## Current Orchestration Model

QA Test Adequacy Critic uses a single-parent-agent model with no subagents of its own. This page instead documents the **hand-off contract with QA Test Case Architect v2 (QATCA v2)**, since this agent is itself designed to be a downstream reviewer of QATCA v2's output.

## Hand-off Contract With QATCA v2

### Trigger condition (confirmed 2026-08-25)

QATCA v2 surfaces a hand-off recommendation to this agent **only when it generates a complete production TestSuite/ArtifactPack.** It does not trigger for:

- Evaluation-mode or AgentLab runs.
- Single-artifact requests (e.g., "just give me the TestSuite CSV").
- Prototype runs.
- Partial output (a response that stopped early due to missing data, a conflict, or a validation failure).

This keeps the trigger deterministic and testable rather than incidental — see `Evaluation - QA Test Case Architect v2` and `Evaluation - QA Test Adequacy Critic` for the eval cases proving the recommendation appears when the condition is met and does not appear when it isn't.

### Invocation model

Do not claim hidden agent-to-agent invocation unless Studio exposes and governs that capability (this repeats QATCA v2's own Runtime Contract routing rule). Until Studio's agent-to-agent invocation capability is confirmed available and governed:

- **QATCA v2's behavior**: after generating a complete production ArtifactPack/TestSuite, it ends its response with a clear, human-readable recommendation to run the generated output through QA Test Adequacy Critic before treating it as review-ready — a message, not an automated call.
- **The human's action**: the reviewer copies or attaches QATCA v2's generated artifacts (and the source requirements/ACs used to generate them) into a separate conversation with QA Test Adequacy Critic.
- **If Studio subagent chaining is later confirmed available and governed**, this hand-off can be revisited as its own decision — not assumed into either agent's contract by this page.

### What QATCA v2 passes (once hand-off happens, by whatever mechanism)

- The generated TestSuite (and any other generated artifacts in the pack).
- The source requirements/acceptance criteria the artifacts were generated from.
- Any ConflictLog/TBDLog entries from the generation run, so the Critic doesn't re-flag already-logged gaps as new findings without noting they were already known.

### What comes back

- The full Required Output Format from `Runtime Contract - QA Test Adequacy Critic` (Executive Summary, Coverage Assessment, Technique/Non-Functional matrices, Top Missing Test Areas, Critical Assumptions, Human Review Checklist, Human Signoff Decision).
- This is a recommendation for the human reviewer, not a decision, and not a signal that loops back into QATCA v2 to auto-generate more tests. If the human wants QATCA v2 to add tests based on the Critic's findings, that is a separate, explicit request to QATCA v2.

## Why No Deeper Subagent Split Yet

| Consideration | Current decision |
|---|---|
| Workflow shape | All 12 reviews share the same input (a generated suite plus requirements) and the same output contract. |
| Risk profile | Read-only analysis plus a generated Markdown report; no write actions. |
| Evaluation maturity | No pilot evaluation has run yet, so splitting the 12 reviews into separate subagents would add configuration complexity before evidence supports it. |

## Guardrails For Any Future Subagent Split

- Keep write actions disabled unless a separate governed write workflow is approved.
- Do not let any future subagent approve test plans, risk sign-offs, go/no-go decisions, or Definition of Done.
- Keep the Human Signoff Decision on the parent agent only, synthesized from all reviews, not fragmented across subagents.
