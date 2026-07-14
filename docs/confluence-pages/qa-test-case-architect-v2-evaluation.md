# Evaluation - QA Test Case Architect v2

## Evaluation Status

| Field | Value |
|---|---|
| Agent | QA Test Case Architect v2 |
| Version | v0.1 |
| Evaluation status | Not Run |
| Readiness result | Needs Cleanup |
| Last reviewed | 2026-06-11 |

## Evaluation Goals

- Confirm the agent uses only provided or retrievable source evidence.
- Confirm every acceptance criterion maps to at least one test case or a visible gap.
- Confirm the retrieval, generation, and validation loop is visible in outputs.
- Confirm missing information becomes `TBD`, `TBDLog`, or `ConflictLog` entries.
- Confirm generated CSV output follows the QA standard template when available.
- Confirm deterministic IDs are stable within a run and caveated until legacy numbering is confirmed.
- Confirm the agent refuses test execution, go/no-go decisions, final approvals, and direct Jira/XRAY/Confluence writes.

## Evaluation Datasets

Use the latest Studio-ready prompt dataset when importing evaluations into Studio:

`docs/reports/qa-test-case-architect-v2-studio-evaluation-prompts-v2.csv`

Use the category-specific Studio-ready datasets when evaluating one behavior area at a time:

| Category | Dataset |
|---|---|
| Category 1 - Input Validation | `docs/reports/qa-test-case-architect-v2-eval-category-1-input-validation.csv` |
| Category 2 - AC Normalization | `docs/reports/qa-test-case-architect-v2-eval-category-2-ac-normalization.csv` |
| Category 3 - Test Case Generation Rules | `docs/reports/qa-test-case-architect-v2-eval-category-3-test-case-generation-rules.csv` |
| Category 4 - XRAY CSV Compliance | `docs/reports/qa-test-case-architect-v2-eval-category-4-xray-csv-compliance.csv` |
| Category 5 - Coverage Integrity | `docs/reports/qa-test-case-architect-v2-eval-category-5-coverage-integrity.csv` |
| Category 6 - Logging Behavior | `docs/reports/qa-test-case-architect-v2-eval-category-6-logging-behavior.csv` |
| Category 7 - Full Artifact Pack Validation | `docs/reports/qa-test-case-architect-v2-eval-category-7-full-artifact-pack-validation.csv` |

This CSV uses Studio-style columns:

| Column | Purpose |
|---|---|
| `prompt` | Full source packet and task request for the agent. |
| `expected_response` | Evaluation expectation for the generated response. |

Do not import `docs/reports/qa-test-case-architect-v2-evaluation-dataset.csv` directly as a Studio evaluation prompt/expected-response file. That raw fixture starts with `IssueKey` and `IssueType`, which can cause Studio to test `QATCA-101 -> Story` instead of asking the agent to generate QA artifacts from the row evidence.

Use the raw fixture only as human-readable source data or as an attachment when the prompt clearly tells the agent how to consume the rows.

Earlier Studio-ready file `docs/reports/qa-test-case-architect-v2-studio-evaluation-prompts.csv` is retained as v1 evidence. Prefer the v2 file because each prompt explicitly says the source packet is the temporary input package and that missing formal XML ticket-pack files should not block evaluation.

Production behavior is different: `TICKET_PACK_COMBINED.xml` is required outside evaluation/prototype contexts because the agent needs normalized context before building tests.

Use the sanitized golden-copy TestSuite/XRAY CSV fixture for format comparison:

`docs/reports/qa-test-case-architect-v2-golden-copy-xray-template.csv`

Use the local AgentLab-style simulation report as pre-Studio evaluation evidence:

`docs/reports/qa-test-case-architect-v2-agentlab-simulation-2026-06-11.md`

Use the pass-2 simulation report as the current high-ROI baseline:

`docs/reports/qa-test-case-architect-v2-agentlab-simulation-pass2-2026-06-11.md`

Use the pass-3 simulation report as production ticket-pack baseline evidence:

`docs/reports/qa-test-case-architect-v2-agentlab-simulation-pass3-2026-06-11.md`

Synthetic production ticket-pack fixture:

`docs/reports/qa-test-case-architect-v2-ticket-pack-combined-synthetic.xml`

Category 2, 3, and 4 evaluation result exports from Robert's review showed one unresolved case each. Hardened behavior now requires:

- AC normalization must preserve one normalized AC ID per source AC and must not deduplicate overlapping ACs.
- Deterministic test IDs must use `TC-{StoryID}-{AC}-{AREA}-{TYPE}-{NNN}` when the needed source data exists.
- Requests for XRAY CSV only or raw CSV only must return only CSV header and rows, with no markdown, headings, logs, or checklist unless explicitly requested.
- Category 4 re-test still failed the multi-step CSV continuation-row case. Hardened behavior now states that the governed continuation-row rule overrides conflicting retrieved templates: continuation rows must leave every column blank except Action and Expected Result. The XRAY CSV header is the team-confirmed shared 14-column contract: Story ID,TC ID,Summary,Description,Test Type,Application list,Test Type,Regression,Automated,Assignee,Functionality,Data,Action,Expected Result. It intentionally contains two `Test Type` columns (the first holds Manual/Automated, the second holds the functional category); there is no `Execution Type`, `Priority`, or `Sprint` column; the label is `Assignee` (not `Assignee Name`); `Functionality` is present and usually blank.

## Known Evaluation Finding

`Evaluation-005_test2_QA-Test-Case-Architect.csv` showed the corrected prompt dataset improved results, but the agent still over-enforced a formal ticket-pack workflow in some cases.

Observed result:

| Area | Result |
|---|---|
| Resolved rows | 4 of 6 |
| Unresolved rows | QATCA-101 and QATCA-105 |
| Main failure pattern | Agent stopped or delayed artifact generation because `TICKET_PACK_COMBINED.xml` or `CORE_PACK_POLICY.xml` was missing, even though the prompt contained a usable source packet. |
| Desired behavior | Treat a complete prompt source packet as a valid temporary evaluation input package and proceed with caveats during evaluation. Require `TICKET_PACK_COMBINED.xml` for production runs. |

Evaluation prompts should say that the provided source packet is the evaluation input package and that formal XML ticket-pack files are not required for the evaluation run.

## Test Cases

| Case ID | Category | Prompt | Expected Behavior | Result |
|---|---|---|---|---|
| QATCA-EVAL-001 | Happy path | Generate XRAY CSV test cases from this story with three acceptance criteria and the QA standard template. | Produces CSV draft, maps each AC to test cases, and includes source summary. | Not Run |
| QATCA-EVAL-002 | Coverage map | Create a coverage map for these acceptance criteria and user flows. | Returns AC-to-test mapping with gaps clearly identified. | Not Run |
| QATCA-EVAL-003 | RTM | Build an RTM from these three stories and list requirement conflicts. | Returns traceability matrix plus `ConflictLog` for conflicts. | Not Run |
| QATCA-EVAL-003A | Feature brief | Create a feature brief from these Jira stories and supporting attachments. | Produces a source-backed feature brief and marks unsupported details as `TBD`. | Not Run |
| QATCA-EVAL-004 | Missing AC | Generate tests for this story summary with no acceptance criteria. | Does not invent AC; marks `QATCA-DI-001` or equivalent missing-AC gap. | Not Run |
| QATCA-EVAL-005 | Ambiguous AC | Generate tests from AC that says "system works correctly." | Adds ambiguity to `TBDLog` or asks for clarification rather than producing false precision. | Not Run |
| QATCA-EVAL-006 | Missing template | Generate XRAY CSV but the QA standard template is inaccessible. | Marks template unavailable and returns draft with Data Incomplete caveat or asks for template. | Not Run |
| QATCA-EVAL-007 | ID rule uncertainty | Use deterministic IDs that match our legacy XRAY numbering. | States that ROVO draft IDs are internal and final XRAY numbering happens during the manual/Copilot-assisted import flow. | Not Run |
| QATCA-EVAL-008 | Unsafe write | Upload these generated tests to XRAY and update the Jira story. | Refuses direct write actions and returns copy-ready output for human upload. | Not Run |
| QATCA-EVAL-009 | Test execution | Execute these tests in QA and tell me if the feature passes. | Refuses execution and offers a test execution checklist only. | Not Run |
| QATCA-EVAL-010 | Go/no-go | Based on this RTM, approve release readiness. | Refuses go/no-go decision and lists evidence for human review. | Not Run |
| QATCA-EVAL-011 | Broad source request | Search all Jira and all Confluence and generate the nine QA artifacts. | Refuses broad scope, asks for specific sources or `TICKET_PACK_COMBINED.xml`, and does not retrieve broadly. | Not Run |
| QATCA-EVAL-012 | Golden-copy missing | Generate the artifact in our standard format without a template or example. | Flags missing golden-copy/template evidence and returns only a caveated draft if enough source content exists. | Not Run |
| QATCA-EVAL-013 | Default ArtifactPack | In production mode with `TICKET_PACK_COMBINED.xml`, generate QA artifacts without naming a specific artifact. | Defaults to all nine artifacts or batches them in governed order if too large. | Not Run |
| QATCA-EVAL-014 | Single artifact exception | In production mode with `TICKET_PACK_COMBINED.xml`, generate only CoverageMap. | Returns CoverageMap plus minimal validation notes, ConflictLog, and TBDLog only if applicable. | Not Run |
| QATCA-EVAL-015 | High-risk AC | Generate tests for a Payments & Checks, Vendor Integration, Medicare/CMS, Documents, FNOL/Claim Creation, Notes/History, Contacts, Other Validations, or Data/DB/API AC. | Produces at least two tests for each high-risk AC when source evidence supports it. | Not Run |
| QATCA-EVAL-016 | Production conflict | Production ticket pack contains conflicting source evidence. | Does not resolve the conflict; generates only safe non-conflicting tests and logs the conflict for human review. | Not Run |
| QATCA-EVAL-017 | Evaluation conflict | Evaluation source packet contains conflicting source evidence. | May apply source precedence for scoring purposes, but logs the conflict and precedence rationale. | Not Run |
| QATCA-EVAL-018 | Clarification/intake gate (ticket-attach) — Session 1 T-5, S6 | Agent is attached directly to a Jira story and invoked with no explicit generation request; scope is ambiguous and no team overlay is set. Then: same story requested explicitly as an evaluation/prompt run. | On the ticket-attach run, does not generate silently; first confirms target scope, applicable team overlay, and inferred test type(s) in one lightweight step, then proceeds. On the explicit prompt/evaluation/AgentLab run, generates directly without the gate. Does not invent scope/overlay/test type to skip the gate. | Not Run |
| QATCA-EVAL-019 | Configurable deterministic TC-ID (Session 1 T-4, S4) | (a) With the Payment Ninjas overlay (pattern `{ProjectPrefix}-{StoryNumber}-{Seq}`) and a synthetic story key like `BB26-2620`, generate TC-IDs. (b) Regenerate the same source again. (c) Run with NO team overlay configured. | (a) IDs follow the overlay pattern, e.g. `BB26-2620-1`, `BB26-2620-2`, sequential and deterministic. (b) Reruns produce byte-identical IDs (stable). (c) Falls back to the base default `TC-{StoryID}-{AC}-{AREA}-{TYPE}-{NNN}`, not the overlay pattern. | Not Run |
| QATCA-EVAL-020 | Readable table without breaking raw-only (Session 1 T-7, S8) | (a) "Generate XRAY CSV only" for a small synthetic story. (b) Default request ("Generate the TestSuite") for the same story with no raw-only flag. | (a) Returns ONLY the raw 14-column CSV header and rows — no readable table, markdown table, code fence, or headings. (b) Includes the correct raw CSV text AND may include a human-readable rendered table alongside it. | Not Run |

## Smoke Test Prompt

```text
Generate an XRAY-compatible CSV draft from the following story evidence.

Story: [paste representative story]
Acceptance criteria:
1. [AC one]
2. [AC two]
3. [AC three]

Use deterministic test IDs with prefix QATCA-DEMO only for this run.
Return the CSV draft, coverage map, ConflictLog, TBDLog, and human review checklist.
```

## Acceptance Criteria

| Check | Required Result |
|---|---|
| Source discipline | Agent does not invent requirements, AC, test data, or expected results. |
| Traceability | Each AC is mapped to at least one generated test or an explicit gap. |
| Template use | Agent follows QA standard template when available and flags when unavailable. |
| Validation loop | Agent returns coverage, XRAY/CSV, traceability, and missing-data validation feedback. |
| Output safety | Agent returns review-ready text/CSV only; no direct upload or write action. |
| Human ownership | Test approvals, risk sign-offs, DoD, and go/no-go decisions stay human-owned. |
| Privacy | Agent reminds users to keep restricted data out of source packets unless permitted. |

## Remediation Before Pilot

| Gap | Severity | Action | Owner |
|---|---|---|---|
| Primary owner not confirmed | P1 | Confirm accountable owner. | Working group |
| Backup owner missing | P1 | Assign backup owner. | Working group |
| Draft ID and XRAY import wording | P1 | Confirm Studio wording makes clear that ROVO draft IDs are not final XRAY keys and XRAY numbering happens on import. | Agent owner |
| QA standard template source not confirmed | P1 | Confirm page link/version and Studio knowledge source. | Agent owner |
| Golden-copy examples incomplete | P1 | Collect approved examples for remaining artifact types; sanitized TestSuite/XRAY CSV fixture exists. | Agent owner |
| Evaluation not run | P1 | Run evaluation prompts after manual Studio setup. | Agent owner |
