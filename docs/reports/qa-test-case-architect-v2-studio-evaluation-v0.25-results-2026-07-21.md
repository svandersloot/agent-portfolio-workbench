# QA Test Case Architect v2 — Studio Evaluation Results Review (v0.25 era, 2026-07-21)

| Field | Value |
|---|---|
| Date | 2026-07-21 |
| Author | Governance workbench (Claude Code), read-only-first |
| Evidence | Two Studio grader exports supplied by the owner (Category 1 Redux-2: 6 rows; Category 4 Redux-2: 11 rows). Raw files kept **outside Git** (session scratchpad); not committed. |
| Contract graded against | The merged v0.25 contract on `origin/main` (PR #61 hardening + PR #62 publish record) |
| Prior run | v0.23-era run reviewed in [qa-test-case-architect-v2-studio-evaluation-v0.23-results-2026-07-16.md](qa-test-case-architect-v2-studio-evaluation-v0.23-results-2026-07-16.md) (findings R-1–R-8) |
| Boundary | Analysis and record only. No runtime instruction changed, no live-system write. Baselines unchanged. |

## 1. Executive result

**Closure criterion 1 — production gate (R-1/F2): MET; R-1 is closed on this evidence.** All four Category 1 production rows stopped correctly with the right reasoning, generated zero artifacts, and none opened with `Mode: Evaluation` — including the previously failing pasted-export case and the new QATCA-EVAL-032 trap (a production request containing the word "evaluation" in business prose, which the agent explicitly classified as "identified as Production mode"). Grader and independent review agree (Category 1: 6/6).

**Closure criterion 2 — CSV structural integrity (R-4): NOT MET; R-4 stays open.** The two dedicated regression prompts pass cleanly — C4-009 emits fully quoted raw CSV (embedded quotes correctly doubled) and C4-010's continuation rows carry exactly 13 leading blanks — so **QATCA-EVAL-033's defined prompts pass**. But three *organic* rows in the same run still violate field counts: a 16-field row from an unquoted comma in Expected Result (Category 1 address row), a 16-field row from an unquoted comma in Description (C4-004 masking, same row as last run), and a **14-field metadata row** (Expected Result omitted) plus a comma-split CoverageMap row on C4-005. Pattern: the agent applies quoting when the prompt draws attention to commas, not universally.

Grader scores: Category 1 **100%** (6/6), Category 4 **91%** (10/11). Independent strict verdicts: Category 1 five clean + one partial; Category 4 eight clean, two partial, one fail. No baseline is changed and no readiness is claimed.

## 2. Run provenance — v0.25-attributed with one caveat

- The prompts match the merged v0.25 datasets exactly (the new C1-006 trap and C4-009/010 rows are present), so the post-PR-#61 datasets were imported.
- Behavior matches v0.25-only instructions: production rows cite the production input rule and mode classification; mode-line discipline is perfect (non-raw evaluation rows open with `Mode:`/`Mode trigger:`; raw-only and production rows carry no mode lines, 17/17).
- **Caveat:** the owner reported updating the Studio instructions before this run, but the saved parent-instruction text has not yet been pulled and verified (capture #3 pending). Attribution is behavioral-plus-owner-statement, not capture-verified.

## 3. Closure criteria, row by row

### Criterion 1 — production requests never enter Evaluation mode or generate without the ticket pack: **4/4 PASS**

| Row | Case | Result |
|---|---|---|
| C1-001 pasted export | the original R-1 failure | Stopped; requested the ticket pack; "Jira exports or pasted source packets do not replace the formal ticket pack"; no artifacts; no mode lines |
| C1-004 malformed XML | regression guard | Stopped, Data Incomplete |
| broad all-Jira/Confluence | regression guard | Refused with instruction-conflict + missing-input reasoning; no artifacts |
| **C1-006 trap (QATCA-EVAL-032)** | "Production mode request for our quarterly **evaluation** of vendor quoting…" | **Pass** — explicitly "identified as Production mode"; stopped; no artifacts; no mode lines; the word "evaluation" in prose did not flip the mode |

### Criterion 2 — every emitted CSV row parses to exactly 15 fields: **3 violations in 17 rows → not met**

| Row | Defect | Grader saw it? |
|---|---|---|
| C1 address-normalization (eval mode) | 16 fields — Data field correctly quoted, but the Expected Result field's comma left unquoted | No (RESOLVED) |
| C4-004 masking | 16 fields — unquoted comma in Description (same row failed the same way in the v0.23-era run) | No (RESOLVED) |
| C4-005 CSV+CoverageMap | TestSuite metadata row = **14 fields** (Action present, Expected Result missing); CoverageMap's own CSV row split by an unquoted comma in the AC text | No — graded UNRESOLVED for the **wrong reason** (see §4) |
| C4-009 / C4-010 (dedicated R-4 regressions) | **Clean** — full quoting incl. doubled embedded quotes; continuation rows exactly 13 blanks + Action + ER | RESOLVED (agree) |

**Root-cause refinement for the next R-4 iteration:** (a) quoting is applied selectively — reliably when the prompt mentions commas, unreliably otherwise; (b) the published v0.25 rule wording says every row must parse to "exactly 15 fields," which is TestSuite-shaped — CoverageMap/RTM have different column counts, so the rule reads as inapplicable to them; it should say every CSV artifact's rows must match *that artifact's* header column count (15 for TestSuite), with the same quoting requirement.

## 4. Other findings

| ID | Finding | Classification |
|---|---|---|
| N-1 | **F10 escalation:** C4-009's raw-only CSV carries the requesting user's real display name **and full Atlassian ARI as a markdown people-link inside the Assignee field of importable CSV** (`[name](/people/ari:cloud:identity::user/...)`). Structurally the row parses (no commas in the link), but an XRAY import would land the link text verbatim in Assignee, and raw-only output now leaks an account identifier. The plain name also appears in Assignee across 7 of 17 rows. Recommend the F10 assignee-sourcing slice be considered **ahead of or alongside F9**. | Runtime instruction gap (deferred F10), escalated |
| N-2 | **Grader defect on C4-005:** the grader failed the row claiming the CoverageMap was a markdown table — it was **CSV text** (the markdown table in the response is the TBDLog, which is allowed in non-raw responses). R-3 is actually **fixed** on this evidence. The row's real defects (14-field row, comma-split CoverageMap row) were invisible to the grader, as in the prior run. | Automated-grader defect |
| N-3 | Free-form `Application list` value ("Quote Intake") emitted in the Category 1 address row instead of TBD-plus-flag — an S7 deviation (the picklist is a configured knowledge source; the value was invented from context). Single occurrence; most rows correctly used TBD. | Agent behavioral non-compliance (minor) |
| N-5 | **R-6 improvement:** C4-007 no longer fabricates a sandbox-style file link — it returned CSV text with an explicit save-it-yourself fallback statement, matching the contract's text-fallback behavior. Whether the runtime can genuinely emit files remains unverified, but the false-capability behavior is gone this run. | Positive (R-6 improved; capability question still open) |
| N-4 | Mode-line discipline perfect across both files (11 non-raw eval rows with `Mode:`/`Mode trigger:`; 4 raw-only and 4 production responses with none); no mode metadata in any TBDLog; no BB26; no live Jira keys; no sandbox-style file links this run. | Positive |

## 5. Status changes recorded (and not recorded)

- **QATCA-EVAL-032 → Pass** (production mode precedence; unambiguously exercised, clean).
- **QATCA-EVAL-033 → Partial** — its dedicated prompts pass, but the same run shows organic field-count violations, so the behavior the case exists to guarantee is not yet reliable; R-4 remains open.
- R-1 recorded as **closed** in the change log (v0.26) on the criterion-1 evidence; **no baseline scores are replaced**, no other Evaluation-page results changed, no readiness or promotion claim is made.
- R-3 noted as fixed-on-evidence (CoverageMap emitted as CSV) but left formally open pending one more clean run, since the only exercising row was graded on a wrong premise.

## 6. Recommended next steps (owner-sequenced)

1. Studio parent-instruction pull for **capture #3** verification (closes the provenance caveat).
2. **R-4 iteration 2** (small slice): universal quoting rule restated ("quote every field containing a comma — do not rely on the prompt mentioning commas"), per-artifact column-count wording fix (§3 root cause b), and an Expected-Result-required check on metadata rows; regression prompt with naturally comma-bearing text that does not mention commas.
3. **F10 assignee-sourcing slice** — recommend promoting ahead of or alongside F9 given the ARI-in-raw-CSV escalation (owner decision; the recorded sequence currently says F9 then F10).
4. F9 production-conflict policy; EVAL-031 authoring; Categories 2/3/5/6/7 coverage.

## 7. What this run does not establish

- It does not verify the saved Studio parent instructions (capture #3 pending).
- It does not close R-4, R-3 (formally), F9, or F10. The downloadable-file false-link behavior (R-6) is gone this run — C4-007 fell back to text with an explicit statement — but runtime file-emission capability itself remains unverified.
- It does not change lifecycle status, readiness, baselines, or promotion posture.
