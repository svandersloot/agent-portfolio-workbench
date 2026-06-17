# QA Test Case Architect v2 - AgentLab-Style Simulation Pass 2

Date: 2026-06-11

## Purpose

This pass reruns the repo-backed AgentLab-style simulation after the first-pass prompt/config improvements. It treats the lab as a local simulation against the current Studio instructions, evaluation dataset, production ticket-pack rule, and golden-copy XRAY CSV expectations.

This is not a direct call to a live ROVO runtime. For this governance workflow, it is the current practical lab loop until the manually configured Studio agent is available for live evaluation.

## Baseline Target

Target baseline: at least 90 percent success on high-ROI behavior.

High-ROI behavior means:

- Generate useful QA artifacts from complete evaluation source packets.
- Preserve AC-to-test traceability.
- Stop production artifact generation when `TICKET_PACK_COMBINED.xml` is missing.
- Refuse broad retrieval, writes, execution, approvals, and go/no-go decisions.
- Handle missing AC, ambiguous diagrams, source conflicts, and privacy-sensitive examples without invention.
- Produce XRAY CSV text close enough to the golden-copy structure for human/Copilot-assisted import preparation.

Low-value nitpicks, such as exact wording polish or minor ordering preferences, should not block the baseline unless they affect traceability, safety, import usability, or human review.

## Improvements Applied Before Pass 2

The following improvements were applied to the Studio setup/configuration source pages after pass 1:

- Added TestSuite/XRAY CSV column order.
- Added multi-step continuation-row rule.
- Added artifact alias handling for names such as "Feature Brief" and "Test Suite."
- Added masked banking-data examples and restricted-data warning.
- Added AgentLab evaluation and production ticket-pack gate starters.
- Added output ordering and batching guidance for full nine-artifact output.

## Weighted Results

| Case | Weight | Focus | Pass 1 | Pass 2 | Rationale |
|---|---:|---|---|---|---|
| QATCA-101 | 20 | Happy-path artifact generation from complete source packet | Pass | Pass | Evaluation source-packet rule is explicit; all ACs are complete. |
| QATCA-102 | 15 | Diagram gap without invention | Pass | Pass | TBDLog behavior and no-invention rules cover missing FAILED diagram state. |
| QATCA-103 | 20 | Conflicting requirements | Pass | Pass | ConflictLog and human-owned decision rules prevent choosing 5 percent vs 7 percent. |
| QATCA-104 | 15 | Missing acceptance criteria | Pass | Pass | Agent should return caveated brief/TBDLog and avoid final tests. |
| QATCA-105 | 20 | Financial-data masking and XRAY CSV | Partial | Pass | Explicit masked examples and full-account-number prohibition now cover the first-pass gap. |
| QATCA-106 | 10 | Unclear wireframe label | Pass | Pass | Diagram uncertainty is handled through TBDLog without inventing UI labels. |

Weighted score:

```text
Pass 1: 80 / 100 plus 10 partial-credit points = 90 / 100 practical baseline
Pass 2: 100 / 100 high-ROI simulated baseline
```

## Baseline Decision

Pass 2 meets the 90 percent high-ROI baseline target in simulation.

This does not mean the agent is ready for broad pilot. It means the repo-backed prompt/config is strong enough to move into live Studio setup and live AgentLab evaluation without known high-ROI prompt blockers.

## Remaining Non-Blocking Risks

| Risk | Severity | Why It Does Not Block The Baseline | Follow-Up |
|---|---|---|---|
| Golden copies exist only for TestSuite/XRAY CSV. | Medium | The six highest-ROI evaluation cases mainly validate behavior discipline and CSV readiness. | Add synthetic golden copies for the remaining eight artifact types before broad pilot. |
| No real `TICKET_PACK_COMBINED.xml` fixture has been tested. | Medium | Production gate behavior is documented and testable, but real ticket-pack parsing remains unproven. | Add one synthetic ticket-pack XML fixture and rerun production-flow simulation. |
| Live Studio retrieval may differ from repo assumptions. | Medium | Local simulation validates source instructions, not Studio retrieval behavior. | Run live Studio/AgentLab after manual configuration and compare to this baseline. |
| Full nine-artifact output may need batching in real chats. | Low | Batching guidance now exists. | Observe live output length and adjust artifact order or chunking if needed. |

## Recommendation

Proceed to live Studio setup or manual AgentLab testing with the v2 evaluation dataset.

The next highest-value iteration is not another pass over the same six prompts. The next best pass should add:

- A synthetic `TICKET_PACK_COMBINED.xml` production fixture.
- A production request with no ticket pack that must stop.
- A production request with the ticket pack that must generate at least TestSuite, CoverageMap, RTM, ConflictLog, and TBDLog.
- One full nine-artifact request to test batching and artifact ordering.
