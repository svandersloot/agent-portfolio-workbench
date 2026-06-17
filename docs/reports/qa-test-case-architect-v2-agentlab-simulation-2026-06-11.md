# QA Test Case Architect v2 - AgentLab-Style Simulation

Date: 2026-06-11

## Scope

This report simulates an AgentLab evaluation for QA Test Case Architect v2 using the repo-backed Studio setup and evaluation inputs. It is not evidence of a live ROVO Studio or AgentLab run.

Evidence used:

- `docs/confluence-pages/qa-test-case-architect-v2-studio-setup.md`
- `docs/confluence-pages/qa-test-case-architect-v2-rovo-studio-configuration.md`
- `docs/confluence-pages/qa-test-case-architect-v2-evaluation.md`
- `docs/reports/qa-test-case-architect-v2-studio-evaluation-prompts-v2.csv`
- `docs/reports/qa-test-case-architect-v2-golden-copy-xray-template.csv`

## Evaluation Method

Each evaluation prompt was reviewed against the current Studio instructions. The simulated response behavior was scored against:

- Source-packet handling for evaluation and AgentLab runs.
- Production `TICKET_PACK_COMBINED.xml` gate.
- Required artifact catalog.
- Acceptance-criteria traceability.
- No-invention behavior.
- ConflictLog and TBDLog behavior.
- XRAY CSV output safety and golden-copy format expectations.
- Refusal of write actions, execution, and approvals.

Scoring:

- Pass: current instructions clearly support the expected behavior.
- Partial: current instructions support the behavior, but wording or format risk remains.
- Fail: current instructions are likely to produce the wrong behavior.

## Results Summary

| Case | Prompt Focus | Expected Result | Simulated Result | Notes |
|---|---|---|---|---|
| QATCA-101 | Wallet checkout payment validation | Generate Feature Brief, Test Suite, Coverage Map, RTM, XRAY CSV; cover all 3 ACs. | Pass | v2 prompt explicitly permits temporary source packet. ACs are complete and source data is synthetic. |
| QATCA-102 | Policy document download status | Generate READY/PENDING/FAILED coverage; do not invent FAILED diagram details; log diagram gap. | Pass | Instructions require no invention and TBDLog for missing diagram detail. |
| QATCA-103 | Renewal discount conflict | Generate tests for unambiguous paths; log 5 percent vs 7 percent conflict; do not choose truth. | Pass | ConflictLog behavior is clear and human-owned decision rule applies. |
| QATCA-104 | Missing acceptance criteria | Do not generate final test cases; produce caveated brief/TBDLog. | Pass | Missing-AC behavior is explicit; production/evaluation distinction does not weaken this guardrail. |
| QATCA-105 | Billing autopay API validation | Generate negative/positive API tests; mask account data; return XRAY CSV. | Partial | Privacy rule is present, but Studio instructions do not include concrete masked-data examples or a field-level banking-data warning. |
| QATCA-106 | Producer org search filters | Generate status/state/combined filter tests; log unclear wireframe label; do not invent UI label. | Pass | Diagram uncertainty and TBD behavior are clear. |

Overall simulated result: 5 Pass, 1 Partial, 0 Fail.

## Golden-Copy CSV Format Check

The sanitized golden-copy fixture establishes the expected XRAY/TestSuite shape:

```text
Story ID, TC ID, Execution Type, Test Type, Summary, Description, Application List, Regression, Priority, Data, Automated, Assignee Name, Sprint, Action, Expected Result
```

The current Studio setup correctly tells the agent to return CSV content as review-ready text only and not to create final XRAY keys. However, it does not yet give the agent a compact copy-paste CSV skeleton in the parent instructions. That means the agent may describe CSV content correctly but still vary columns or step-row blanking unless it retrieves the golden-copy fixture reliably.

Recommended improvement:

- Add a short "XRAY CSV output skeleton" block to the Studio setup/configuration pages or ensure the golden-copy fixture is configured as an explicit knowledge source before CSV evaluation.

## Production Ticket-Pack Gate

The current configuration now has the desired distinction:

- Production artifact generation requires `TICKET_PACK_COMBINED.xml`.
- Studio evaluation, AgentLab tests, and prototype runs may use a complete prompt-provided source packet.

This directly addresses the prior evaluation failure where the agent blocked on missing `TICKET_PACK_COMBINED.xml` even when the prompt contained enough evaluation source evidence.

Residual risk:

- The phrase "production source evidence: TICKET_PACK_COMBINED.xml" appears in required intake. If a live model over-weights required intake, it may still ask for the ticket pack during evaluation unless the AgentLab prompt repeats the evaluation source-packet rule.

Recommended improvement:

- Keep the v2 dataset wording.
- Add one negative/positive paired smoke test: evaluation source packet should proceed; production request without ticket pack should stop.

## Artifact Catalog Coverage

The required artifact catalog is now explicit:

| Artifact | Format | Status |
|---|---|---|
| FeatureBrief | XML | Covered by instructions; no golden copy yet. |
| TestSuite | XRAY CSV text | Covered; sanitized golden copy exists. |
| CoverageMap | CSV | Covered by instructions; no golden copy yet. |
| RTM | CSV | Covered by instructions; no golden copy yet. |
| E2E_Scenarios | TXT | Covered by instructions; no golden copy yet. |
| MiniTestPlan | XML | Covered by instructions; no golden copy yet. |
| TestSummary | XML | Covered by instructions; no golden copy yet. |
| ConflictLog | TXT | Covered by instructions; no golden copy yet. |
| TBDLog | TXT | Covered by instructions; no golden copy yet. |

Residual risk:

- Only TestSuite/XRAY CSV has a concrete golden-copy example. XML/TXT/other CSV outputs may be structurally inconsistent between runs.

Recommended improvement:

- Create compact golden-copy examples for each remaining artifact before pilot, even if synthetic.

## Behavior Gaps And Improvements

| Priority | Gap | Evidence | Recommended Change |
|---|---|---|---|
| P1 | CSV format may drift if golden-copy retrieval fails. | Golden-copy fixture exists, but parent instructions did not include column skeleton. | Applied to Studio setup/configuration source pages: added compact CSV header and continuation-row rule. |
| P1 | Banking-data masking needs stronger operational examples. | QATCA-105 depends on privacy wording and user prompt. | Applied to Studio setup/configuration source pages: added masked-data examples and restricted-data warning. |
| P1 | Non-TestSuite artifacts lack golden copies. | Artifact catalog is confirmed, but only XRAY CSV example exists. | Add minimal synthetic examples for FeatureBrief XML, CoverageMap CSV, RTM CSV, E2E TXT, MiniTestPlan XML, TestSummary XML, ConflictLog TXT, and TBDLog TXT. |
| P2 | Evaluation-vs-production distinction relies on prompt wording. | v2 dataset says this clearly, but live users may not. | Applied to Studio setup/configuration source pages: added AgentLab evaluation and production gate conversation starters. |
| P2 | "Feature Brief" vs `FeatureBrief` naming varies. | Dataset uses Feature Brief; artifact catalog uses `FeatureBrief`. | Applied to Studio setup/configuration source pages: added alias handling. |
| P2 | Full-package output may become too long for chat. | Nine artifacts plus logs can be large. | Applied to Studio setup/configuration source pages: added output order and batching guidance. |

## Recommended AgentLab Prompts

Use these after manual Studio configuration:

```text
This is an AgentLab evaluation. Treat the following source packet as the temporary input package. Do not stop because TICKET_PACK_COMBINED.xml is missing. Generate TestSuite XRAY CSV, CoverageMap CSV, RTM CSV, ConflictLog TXT, TBDLog TXT, and validation feedback from the source evidence only.
```

```text
This is a production workflow request. Generate the full nine-artifact QA package, but I am not providing TICKET_PACK_COMBINED.xml.
```

Expected behavior:

- The first prompt proceeds with a caveat.
- The second prompt stops and asks for `TICKET_PACK_COMBINED.xml`.

## Simulated Readiness

AgentLab-style readiness: Partial.

The agent is ready for controlled Studio/AgentLab testing with the v2 evaluation dataset. It is not ready for broad pilot use until:

- Live Studio setup is confirmed.
- QA standard template and golden-copy XRAY CSV are configured.
- Remaining artifact golden copies exist or are explicitly marked unavailable.
- The production ticket-pack handoff is tested with a real `TICKET_PACK_COMBINED.xml`.
- Privacy handling for banking/account examples is tightened.
