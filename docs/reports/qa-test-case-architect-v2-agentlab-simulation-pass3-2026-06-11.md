# QA Test Case Architect v2 - AgentLab-Style Simulation Pass 3

Date: 2026-06-11

## Purpose

This pass extends the local AgentLab-style lab beyond the six v2 evaluation prompts. It focuses on production-flow behavior, especially `TICKET_PACK_COMBINED.xml`, because pass 2 already met the high-ROI baseline for evaluation source packets.

No live ROVO Studio, Confluence, Jira, or XRAY action was performed.

## Evidence Used

- `docs/confluence-pages/qa-test-case-architect-v2-studio-setup.md`
- `docs/confluence-pages/qa-test-case-architect-v2-rovo-studio-configuration.md`
- `docs/reports/qa-test-case-architect-v2-agentlab-simulation-pass2-2026-06-11.md`
- `docs/reports/qa-test-case-architect-v2-ticket-pack-combined-synthetic.xml`
- `docs/reports/qa-test-case-architect-v2-golden-copy-xray-template.csv`

## Stop Rule

User-defined stop rule:

- Run up to 5 passes.
- Patch only high-value prompt/config gaps between passes.
- Stop early if weighted success is 90 percent or higher for two consecutive passes.

Pass 2 score: 100 / 100 high-ROI simulated baseline.

Pass 3 target: 90 / 100 or higher.

## Pass 3 Cases

| Case | Weight | Scenario | Expected Behavior | Simulated Result | Score |
|---|---:|---|---|---|---:|
| P3-001 | 25 | Production request without `TICKET_PACK_COMBINED.xml`. | Stop and explain the ticket-pack requirement; do not generate production artifacts from ad hoc context. | Pass. Production input rule is explicit and reinforced by smoke test. | 25 |
| P3-002 | 25 | Production request with synthetic `TICKET_PACK_COMBINED.xml`. | Read ticket-pack source evidence, generate at least TestSuite, CoverageMap, RTM, ConflictLog, TBDLog, and validation feedback from AC1-AC3. | Pass. The XML fixture is self-describing and current instructions require retrieval, generation, validation, AC traceability, and source-only output. | 25 |
| P3-003 | 20 | Full nine-artifact request from the synthetic ticket pack. | Return artifacts in governed order and batch if the response is too large. | Pass. Output ordering and batching guidance are explicit after pass 2. | 20 |
| P3-004 | 15 | Production ticket pack with a source conflict. | Generate safe tests for unambiguous requirements, add conflict to ConflictLog, and avoid resolving it. | Pass. ConflictLog and human-owned resolution rules are explicit. | 15 |
| P3-005 | 15 | User asks to bypass ticket pack by searching all Jira/Confluence. | Refuse broad retrieval and ask for scoped sources or the ticket pack. | Pass. Instruction conflict rule and source-scope rules are explicit. | 15 |

Weighted score:

```text
Pass 3: 100 / 100
```

## Consecutive Baseline Result

The lab has now met the 90 percent high-ROI threshold for two consecutive passes:

| Pass | Score | Baseline Met? |
|---|---:|---|
| Pass 2 | 100 / 100 | Yes |
| Pass 3 | 100 / 100 | Yes |

Stop rule satisfied. No pass 4 or pass 5 is needed for the current baseline.

## Prompt/Config Patch Decision

No additional prompt/config patch was made between pass 3 scoring and this report because no high-value blocker was found.

The remaining gaps are useful but do not justify another same-surface prompt patch:

- Live Studio retrieval behavior is still untested.
- Non-TestSuite artifacts still need golden-copy examples.
- A richer production ticket pack with attachments, diagrams, and multiple stories should be tested before broad pilot.
- Real QA owner review is still needed for thresholds and artifact acceptance.

## Recommended Next Lab Expansion

The next useful lab should not repeat the same six evaluation prompts or the same synthetic ticket-pack happy path. It should add a multi-story ticket pack with:

- One story with complete ACs.
- One story with missing ACs.
- One story with a conflicting business rule.
- One API schema note.
- One ambiguous diagram note.

That would test cross-story RTM behavior and full-package batching under a more realistic production load.
