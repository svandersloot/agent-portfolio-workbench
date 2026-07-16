# QA Test Case Architect v2 — Studio Evaluation Results Review (v0.23 era, 2026-07-16)

| Field | Value |
|---|---|
| Date | 2026-07-16 |
| Author | Governance workbench (Claude Code), read-only-first |
| Evidence | Three Studio/AgentLab grader exports supplied by the owner as read-only evaluation evidence (19 prompt rows total). Raw files kept **outside Git** (session scratchpad); not committed. |
| Contract graded against | The merged v0.23 contract on `origin/main` (PR #58, commits `7145d1e` + `5b0cd3c`, publish record `bdd2f2e`) — not the graders' verdicts. |
| Baselines | 2026-07-16 pre-v0.23 grader run: Category 1 = 40%, Category 4 = 50%, Category 6 = 80% (documented in the eval-failure review, currently uncommitted in a frozen worktree). |
| Boundary | Analysis only. No runtime instruction changed, nothing published, no live-system write, no Jira/XRAY/Studio action. Canonical Evaluation-page result fields left unchanged (see §2 provenance). |

## 1. Executive result

The v0.23 behaviors that this slice set out to fix are now observably working: evaluation-mode `Mode:`/`Mode trigger:` metadata appears on every non-raw evaluation response and never in TBDLog (QATCA-EVAL-027 behavior: pass), raw-only requests stay pure CSV with no mode lines (EVAL-028: pass, 3/3), the evaluation insufficiency stop holds (EVAL-029: pass), the first `Test Type` is `Manual` in every row, `Priority` defaults to `Low` everywhere, the 15-column header is exact everywhere it appears, `Sprint` stays correctly omitted, no real-looking TC-ID example reappears, and no live Jira/Confluence content was mixed into any synthetic packet.

Grader scores: Category 1 **80%** (4/5), Category 4 **89%** (8/9), Category 6 **100%** (5/5) — 17/19 overall, up from 40/50/80.

Independent regrading against the merged contract is less generous: **14/19 clean, 2 Fail, 3 Partial (~74% strict)**. One severe behavioral failure recurs — a **production** request with a pasted Jira export was misclassified as Evaluation and produced a full ArtifactPack (the pre-v0.23 F2 failure, unfixed by design: v0.23 never included the F2 hardening). The graders also missed a new class of defect: **CSV field-integrity errors inside otherwise-passing responses** (unquoted commas and short continuation rows that would break import). Score improvement is real but is **not** a readiness signal.

## 2. Run provenance — established with caveats (upgraded 2026-07-16, same day)

- The exports carry **no run timestamp, Studio configuration version, or environment field**. Grader fields present: `prompt`, `expected_response`, `actual_response`, `evaluation_status`, `reasoning`.
- **Evidence the run used v0.23 inputs:** every `expected_response` matches the v0.23 category datasets verbatim (including "decision recorded 2026-07-16" wording and the revised F4 row), and the responses exhibit v0.23-only instructed behavior (`Mode:`/`Mode trigger:` lines, raw-only exception, `SYNTH-1001-1`-era ID patterns).
- **Dataset-lineage correction (found during the F2/R-4 slice):** the Category 1 expectations match `origin/main`'s v0.23 dataset, but the Category 4 run used a 9-row dataset variant — `origin/main` carried only 6 rows at run time. The three extra rows (priority-default C4-006 and downloadable C4-007/C4-008) and the strengthened raw-only wording match the frozen pre-v0.23 worktree's uncommitted rewrite, evidently the file imported into Studio. The graded expectations are contract-consistent with merged v0.23, so verdicts stand; the F2/R-4 slice ports the exercised rows into the tracked Category 4 dataset so the run is reproducible from `main`.
- **Provenance upgrade:** later the same day, the owner pulled the live Studio parent instructions (non-admin view) and they are **content-identical to the approved v0.23 copy block** — see the [instruction capture record](qa-test-case-architect-v2-studio-instruction-capture-2026-07-16b.md) (normalized diff, 63/63 lines, zero differences). Combined with the verbatim v0.23 dataset expectations and v0.23-only response behavior, the run is attributed to the v0.23 Studio configuration.
- **Remaining caveats:** the pull post-dates the run within the same day (attribution assumes no interim Studio edit; no audit trail available to the non-admin owner), and only the parent-instructions field was capturable — knowledge sources/tools remain unverified.
- Consequence: the Evaluation page's `Result` fields are updated **only** for the three cases unambiguously exercised with clear outcomes (QATCA-EVAL-027/028/029), and a Change Log entry records the run. All other result fields stay `Not Run`. The Measurement Plan is deliberately untouched: this run measured behavioral contract compliance, not the plan's draft-time/coverage metrics, and no readiness or ROI signal is claimed.

## 3. Files reviewed

| File | Category | Rows | Grader verdicts |
|---|---|---|---|
| `Evaluation-034_Category-1---Input-Validation-Redux_3.csv` | 1 — Input Validation | 5 | 4 RESOLVED / 1 UNRESOLVED |
| `Evaluation-035_Category-4---XRAY-CSV-Compliance-Redux_3.csv` | 4 — XRAY CSV Compliance | 9 | 8 RESOLVED / 1 UNRESOLVED |
| `Evaluation-032_Category-6---Logging-Behavior-New_3.csv` | 6 — Logging Behavior | 5 | 5 RESOLVED |

No Category 2/3/5/7 reruns were supplied. All rows parsed cleanly (2-column-plus-grader schema); every embedded XRAY CSV block was extracted and field-counted programmatically.

## 4. Per-category scores

| Category | Baseline (pre-v0.23) | Grader (this run) | Independent strict verdicts |
|---|---|---|---|
| 1 — Input Validation | 40% | 80% (4/5) | 4 Pass, 1 **Fail** (R-1) |
| 4 — XRAY CSV Compliance | 50% | 89% (8/9) | 6 Pass, 2 Partial (R-4, R-6), 1 **Fail** (R-3) |
| 6 — Logging Behavior | 80% | 100% (5/5) | 4 Pass (two with R-4 findings), 1 Partial (R-2) |

## 5. QATCA-EVAL-027–031 results

| Case | Expected | Result |
|---|---|---|
| 027 — non-raw evaluation mode metadata | `Mode: Evaluation` + `Mode trigger:` open every non-raw eval response; no mode metadata in TBDLog | **Pass** — 11/11 non-raw evaluation responses open with both lines; 0/19 TBDLogs contain mode metadata; production responses correctly omit the lines (except the R-1 misclassified row) |
| 028 — raw-only evaluation exception | Raw-only requests return CSV only, no mode lines | **Pass** — 3/3 raw-only rows (C4-001, C4-006, T-1) are pure CSV |
| 029 — evaluation insufficiency stop | Missing ACs/rules → Data Incomplete, smallest-missing-input ask | **Pass** — Category 1 insufficient-input row stops with Data Incomplete, TBDLog, and a scoped ask; no invented tests |
| 030 — Manual-only with automation signal | Manual retained; automation signal to validation notes, not TBDLog | **Not exercised** — no attached prompt contains an automation signal. First `Test Type` = `Manual` in all 12 emitted suites (consistent), but the specific case remains Not Run |
| 031 — evaluation source isolation | Only the supplied packet/fixtures; no unrequested live retrieval; retrieved sources listed | **Informally consistent, not formally exercised** — zero live Jira keys, live page citations, or retrieval artifacts in any of 19 responses (a marked improvement over the pre-v0.23 run, which cited live-looking story keys in a synthetic packet). However, **QATCA-EVAL-031 does not exist as a defined case or dataset row on `origin/main`** — it needs to be authored before it can be Run |

Also assessed: **EVAL-024 (downloadable CSV)** — the validated-input row emitted a `sandbox:`-style file link (see R-6, unverifiable); the blocked-validation row correctly stayed draft-only with an explicit not-import-ready statement.

## 6. Row-level findings register

Severity: H/M/L. Classifications per the run brief.

| ID | Row(s) | Finding | Verdict vs grader | Classification | Sev |
|---|---|---|---|---|---|
| **R-1** | Cat1 r4 (production, pasted export) | Agent opened a **production** request with `Mode: Evaluation`, declared "Using the provided source packet as the evaluation input package," and generated the full ArtifactPack. The production input rule (pasted exports do not replace `TICKET_PACK_COMBINED.xml`) exists verbatim in the runtime contract. Recurrence of pre-v0.23 finding F2, which was explicitly left out of the v0.23 slice. | Grader also failed it (agree) | Agent behavioral non-compliance (+ known runtime instruction gap: no production mode-declaration/self-check) | **H** |
| **R-2** | Cat6 r2 (production conflict) | Generated test cases for **both** conflicting discount values (5% and 7%) plus one safe negative test, instead of safe-only tests + ConflictLog. Conflict was logged and output marked draft-only, but the dataset expectation ("generate only safe non-conflicting tests") was not met. The runtime contract still lacks a production conflict-generation rule (pre-v0.23 finding F9, deliberately deferred). | Grader passed it (**grader-spec leniency**) | Runtime instruction gap + automated-grader defect | M |
| **R-3** | Cat4 r1; also Cat1 r2 | **CoverageMap (and RTM) emitted as markdown tables** instead of CSV text in non-raw responses, contrary to the artifact contract and the Category 4 dataset expectation. Behavior is inconsistent: Cat6 r1 and Cat1 r2's TestSuite used correct CSV text, and the grader's claim that Cat4 r1's TestSuite was "markdown" is wrong — it was raw CSV text; only the CoverageMap was a markdown table. | Grader failed Cat4 r1 (agree, reasoning partly wrong); grader passed Cat1 r2's markdown CoverageMap (leniency) | Agent behavioral non-compliance (+ grader reasoning defect) | M |
| **R-4** | Cat1 r2, r4; Cat4 r1, r8; Cat6 r4, r5; (Cat6 r2 variant) | **CSV field-integrity defects inside otherwise-passing suites**, all missed by the grader and by the agent's own pre-return self-check: (a) metadata rows with **unquoted commas in Description/Data**, parsing to 16–18 fields instead of 15 (4 rows) — import-breaking; (b) continuation rows with only 12 leading blanks (**14 fields**), shifting Action into the Data column (3 rows); (c) one continuation row with Action blank and text landing in Expected Result only; (d) subsequent test-case metadata rows with a blank Story ID (Cat6 r2). The Cat4 masking row's own expectation ("keep CSV fields consistently quoted or escaped") was violated and still graded RESOLVED. | Grader missed all (**grader defect**) | Agent behavioral non-compliance (self-check does not count fields or enforce quoting) | **H** (recorded M at review; elevated to High by owner 2026-07-16 — import-breaking and grader-invisible) |
| **R-5** | 9 of 19 rows; ARI in Cat4 r1 | `Assignee` auto-populated with a **real user's display name** (redacted here), and one TBDLog embedded that user's **Atlassian account ARI** (redacted) as a people-link; other rows correctly used `TBD`. Recurrence of pre-v0.23 finding F10 (assignee sourcing rule was deferred, not part of v0.23). Also a privacy-hygiene reason these raw exports must not be committed. | Grader silent | Runtime instruction gap + privacy/evidence hygiene | M |
| **R-6** | Cat4 r9 (EVAL-024 positive) | Downloadable file delivered as a `sandbox:/mnt/data/...` link — a path shape that typically does not resolve in the ROVO runtime. Cannot verify from the export whether a real file was emitted; if the runtime cannot emit files, the contract requires falling back to CSV text **and saying so**, which did not happen. Possible false capability claim. | Grader passed it (took the link at face value) | Data incomplete / possible runtime capability limitation + grader defect | M |
| **R-7** | Cat1 r2/r4, Cat4 r1/r3/r6, Cat6 r3/r4/r5 vs Cat6 r1, Cat4 r5/r8 | Inconsistent second-`Test Type` handling when the Jira story field is absent: some rows correctly use `TBD` + human-review flag; others **default to `Functional`** (flagged in TBDLog but still an invented value in the column). Contract: missing/inaccessible story value → flag + draft-only, do not guess. | Grader silent | Agent behavioral non-compliance (partial — always flagged, usually draft-only) | L-M |
| **R-8** | Dataset/coverage | EVAL-030 not exercised by any attached prompt; **EVAL-031 (source isolation) is not yet defined** as an evaluation case or dataset row on `origin/main`; Categories 2/3/5/7 not rerun. Additionally, the Category 4 dataset on `origin/main` lacked three rows the run exercised (C4-006/007/008 — ported into the tracked dataset by the F2/R-4 slice; see §2 dataset-lineage correction). | n/a | Evaluation-dataset defect / missing coverage | L |

## 7. Grader/spec disagreements (summary)

- Cat6 r2 RESOLVED contra its own expected_response (safe-tests-only) — leniency.
- Cat1 r2 RESOLVED with a markdown CoverageMap/RTM — leniency vs artifact contract.
- Cat4 r1 reasoning claims the TestSuite was a markdown table; it was raw CSV text (verdict still correct for the CoverageMap).
- Field-count/quoting defects (R-4) invisible to the grader in five rows; Cat4 r8 passed despite violating its own quoting expectation.
- Cat4 r9 passed on an unverifiable `sandbox:` link (R-6).
- Positively: the graders correctly applied the revised F4 expectation (no `EvaluationMode=True` demanded, mode-in-TBDLog not present anywhere).

## 8. Comparison with the previous baseline

| Behavior | Pre-v0.23 run (2026-07-16 AM) | This run |
|---|---|---|
| Eval-mode metadata / F4 | Failed (old expectation; no mode lines) | **Fixed** (027 pass, TBDLog clean) |
| Eval insufficiency stop (F1) | Failed — generated from empty ACs | **Fixed** (029 pass) |
| Raw-only purity | Pass | Pass, now including no-mode-lines (028) |
| Production pasted-export gate (F2) | Failed | **Still failing** (R-1) — F2 was never remediated |
| Production conflict policy (F9) | Failed | **Still failing/lenient-passed** (R-2) — F9 still open |
| Assignee sourcing (F10) | Real name + ARI emitted | **Still occurring** (R-5) — F10 still open |
| Live-source mixing (F11) | Observed once | **Not observed** in 19/19 rows (031 informal) |
| Real-prefix TC-ID examples | Present in instructions | **Absent** from all outputs |
| CSV field integrity | Not measured | **New finding** (R-4) |

The improvements map exactly to what v0.23 changed; the residual failures map exactly to what v0.23 deliberately deferred (F2, F9, F10) plus one newly measured defect class (R-4).

## 9. Privacy and sanitization applied

- Raw exports contain a real user display name (9 rows) and one Atlassian account ARI; both are **redacted in this report** and the raw files are kept in the session scratchpad, outside Git (not `data/raw/`, not staged, not committed).
- All story keys, account numbers, and addresses in the outputs are synthetic (`SYNTH-*`, masked `****9012`, placeholder addresses); no PII/PHI, tokens, private URLs, or live Jira keys were found by the programmatic sweep.
- Structural evidence (field counts, line shapes) is preserved above without reproducing sensitive values.

## 10. Remaining human decisions

- ~~Confirm and capture the manual v0.23 Studio save~~ **Parent instructions captured and verified identical 2026-07-16** ([capture record](qa-test-case-architect-v2-studio-instruction-capture-2026-07-16b.md)); still open: the full Manual Setup Record (knowledge sources, tools, permissions) requires Studio admin visibility.
- F2 remediation approval (production gate hardening + production mode self-check) — highest-severity open behavior.
- F9 policy wording (production conflict → safe-tests-only) and F10 assignee rule — both still owner-gated.
- Whether the runtime can actually emit downloadable files (R-6) — verify in Studio; if not, the downloadable-CSV instruction needs the text-fallback path exercised.
- Authoring EVAL-031 (source isolation) and an EVAL-030 prompt into the category datasets.
- Readiness, visibility, and promotion remain human-owned; nothing in this run changes lifecycle status.

## 11. Recommended smallest remediation slices (in order)

1. **F2/R-1 slice**: production mode-declaration + positive ticket-pack preflight instruction; two Category 1 regression rows (already-failing row + a variant); this is the only High-severity item.
2. **R-4 slice**: extend the pre-return CSV self-check to (a) count 15 fields per emitted row, (b) quote any field containing a comma, (c) require exactly 13 leading blanks on continuation rows, (d) repeat Story ID on each test case's first row; add one Category 4 regression row with comma-bearing descriptions.
3. **F9/R-2 slice**: production conflict-generation rule + corrected Category 6 grader expectation.
4. **R-3/R-7 slice**: artifact-format rule (CoverageMap/RTM as CSV text in non-raw responses) and second-`Test Type` missing-value rule tightened to `TBD` only; regression rows for both.
5. **F10/R-5 slice**: assignee sourcing rule (TBD unless in source/overlay; never real-person defaults) — also closes the recurring privacy leak in exports.
6. **Dataset slice**: add EVAL-030 prompt and author EVAL-031; schedule Category 2/3/5/7 reruns.

## 12. What this run does not establish

- It does **not** prove there was no Studio edit between the run and the same-day instruction pull (§2 caveat), and it does **not** verify the Studio knowledge-source/tool configuration (non-admin capture covers parent instructions only).
- It does **not** establish readiness, approval, pilot fitness, or ROI; score improvement is necessary but not sufficient, and two contract behaviors still fail.
- It does **not** verify XRAY import round-trip, downloadable-file emission (R-6), EVAL-030, EVAL-031, or Categories 2/3/5/7.
- It does **not** validate the graders as a quality gate — §7 shows they miss import-breaking CSV defects and pass contra-spec behavior; independent structural checks remain necessary.
