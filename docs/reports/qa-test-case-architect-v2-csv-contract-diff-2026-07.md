# QA Test Case Architect v2 - XRAY CSV Column-Contract Diff (2026-07)

| Field | Value |
|---|---|
| Date | 2026-07-13 |
| Author | Governance workbench (Claude Code), read-only-first |
| Related | GitHub issue #4 (Slice S1); `qa-test-case-architect-v2-session-review-2026-07-10.md`; `qa-test-case-architect-v2-session-review-followups-2026-07-10.md` |
| Purpose | Document the drift between the currently-enforced XRAY CSV contract and the team-confirmed golden import, so the reconciliation (S3) is measurable and reviewable. |
| Boundary | Repo evidence only. As originally written (S1) this report only captured the drift and changed no enforced surface. S3 (PR #20) has since applied the reconciliation in repo source: the Studio config header, the golden-copy template, and the canonical agent instructions now match the confirmed golden. Still no ROVO Studio / Jira / XRAY / Confluence writes; Studio save remains a separate manual step. |

> Status (2026-07-13): S3 has applied this reconciliation in repo source — the confirmed golden (B) is now the enforced 14-column contract. Sections 2–5 document the pre-S3 drift. Studio save remains a separate manual step.

> Status (2026-07-14): **Reversing the 2026-07-13 "drop Priority" decision.** Per `qa-test-case-architect-v2-session-2-csv-import-decisions-2026-07.md` (§2), `Priority` is required for downstream workflow completion even though import may succeed without it, so `Priority` (default `Low`) has been re-added to the enforced contract, positioned immediately after `Functionality` and before `Data`. The enforced contract is now **15 columns**. This re-adds the same `Priority` column S3 had dropped from the confirmed-golden (B) side; it does not change the committed team-golden import fixture (`qa-test-case-architect-v2-team-golden-import-payment-ninjas.csv`), which is intentionally left 14-column because it predates the Priority requirement and its import already succeeded without Priority. Sections 2–5 below are historical (pre-S3 and S3-era) snapshots and are left unchanged; see the updated §3 row and §6 gate row for the current state.

---

## 1. Sources compared

- **Currently enforced (A):** header in [qa-test-case-architect-v2-golden-copy-xray-template.csv](qa-test-case-architect-v2-golden-copy-xray-template.csv) (matches the Studio-config XRAY contract). **15 columns.**
- **Team-confirmed golden (B):** sanitized capture in [qa-test-case-architect-v2-team-golden-import-payment-ninjas.csv](qa-test-case-architect-v2-team-golden-import-payment-ninjas.csv), derived from 4 clean, mutually consistent QA-provided files. **14 columns.**

### Golden set provenance

The QA team lead approved using only the **4 clean, consistent** exports as the golden set (represented in the fixture by synthetic keys `SYNTH-1001`-`SYNTH-1004`). Three defect files were dropped and are **not** part of this golden. Real Jira keys are intentionally not reproduced here; defect files are described structurally:

| Golden set (clean) | Defect files (dropped) | Reason dropped |
|---|---|---|
| 4 clean single-story exports -> synthetic `SYNTH-1001`-`SYNTH-1004` | Defect file A | duplicate TC ID (`-2` used twice on two different cases) |
| | Defect file B | double-space in every TC ID |
| | Defect file C | double-space IDs + two stories mixed in one file (the second story's rows started at `-3`, no `-1`/`-2`) |

All 4 included files shared a byte-for-byte identical 14-column header, clean sequential TC IDs, single story each, and no ragged rows.

---

## 2. Header comparison

**A - currently enforced (15 cols):**

```
Story ID, TC ID, Execution Type, Test Type, Summary, Description, Application List,
Regression, Priority, Data, Automated, Assignee Name, Sprint, Action, Expected Result
```

**B - confirmed golden (14 cols):**

```
Story ID, TC ID, Summary, Description, Test Type, Application list, Test Type,
Regression, Automated, Assignee, Functionality, Data, Action, Expected Result
```

---

## 3. Column-level diff

| Change | Enforced (A) | Golden (B) | Evidence / decision |
|---|---|---|---|
| **Rename** | `Execution Type` | `Test Type` (1st col; values `Manual`/`Automated`) | Session review E11; golden shows `Manual` |
| **Recase** | `Application List` | `Application list` | Golden header (lowercase "list") |
| **Rename** | `Assignee Name` | `Assignee` | Session review E15; golden header |
| **Add** | - | `Functionality` (blank in every golden row) | Session review E12; golden header |
| **Drop** | `Priority` | *(absent)* | **Decided 2026-07-13, reversed 2026-07-14:** QA team lead initially confirmed `Priority` was excluded from the import contract, superseding the earlier "default `Priority=Low`" idea (session review E13 / P-1). **Reversed 2026-07-14** per Session-2 decision (`qa-test-case-architect-v2-session-2-csv-import-decisions-2026-07.md` §2): import may succeed without `Priority`, but downstream workflow completion requires it. `Priority` is re-added to the enforced contract, positioned after `Functionality` and before `Data`, default value `Low`. |
| **Drop** | `Sprint` | *(absent)* | Session review E14; golden has no `Sprint` |
| **Reorder** | `Summary`/`Description` follow the type columns | `Summary`/`Description` moved ahead of the type columns; `Data` moved to just before `Action`; `Automated` precedes `Assignee` | Golden column order |
| **Unchanged** | `Story ID`, `TC ID`, `Regression`, `Automated`, `Data`, `Action`, `Expected Result` | same labels present | - |

Net column count: **15 -> 14** (drop `Priority`, drop `Sprint`, add `Functionality`).

Note the golden intentionally carries **two columns literally labeled `Test Type`**: the first holds `Manual`/`Automated`, the second holds the functional category (`Functional`). This is the confirmed dual-test-type contract, not a duplication error.

---

## 4. TC-ID convention observed (input for S4, not changed here)

The golden's TC IDs follow **`{ProjectKey}-{StoryNumber}-{Seq}`** - i.e. the Jira story key followed by a numeric sequence (e.g. story key + `-1`, `-2`, ...). This differs from the agent's current enforced format `TC-{StoryID}-{AC}-{AREA}-{TYPE}-{NNN}` (session review E16 / P-3).

The committed fixture uses **synthetic keys that preserve this exact shape** (`SYNTH-1001-1`, `SYNTH-1002-1`, ...). Real Jira keys were redacted per the doc-family redaction discipline; the convention above is what S4 should reconcile against.

---

## 5. Sanitization applied to the fixture

- Assignee name -> `QA Owner` (real name removed).
- Real Jira story/TC keys -> synthetic `SYNTH-100x` keys preserving `{ProjectKey}-{StoryNumber}-{Seq}`.
- Encoding normalized to ASCII: non-breaking hyphen to `-`, curly quotes to straight quotes, right-arrow character to `->`, non-breaking space to space; trailing whitespace trimmed.
- No claim numbers are present (the only claim number in the raw set appeared in one of the dropped defect files, which is not part of this golden).
- `Test-PrivateDataScan.ps1` run before staging.

---

## 6. Decisions / gates

| Gate | Status | Needed from |
|---|---|---|
| Is the column contract shared across teams or team-specific? (S2) | **Resolved** — shared across teams, per QA leadership ruling (see change log v0.13) | QA leadership; evidence from 2+ teams' imports |
| Apply the reconciled contract to the golden-copy template + Studio config (S3) | **Applied on this branch (2026-07-13), superseded 2026-07-14** — enforced header, golden-copy template, and Category 4 evaluation (including T-1) reconciled to the 14-column shared contract at the time; Studio save remains a separate manual step | Agent owner; manual Studio step |
| Re-add `Priority` (default `Low`) to the enforced contract, reversing the S3 drop (2026-07-14) | **Applied on this branch** — enforced header (ROVO Studio Configuration + Studio Setup thin instructions), golden-copy template, evaluation hardened-behavior note, and Category 4 evaluation (including T-1) reconciled to the new 15-column contract; `Priority` positioned after `Functionality`, before `Data`, default `Low`. Committed team-golden import fixture intentionally left 14-column (predates the Priority requirement). Studio save remains a separate manual step. Exact column index pending confirmation against a real Priority-bearing import. | Owner (approved per Session-2 decisions); manual Studio step |
| Reconcile TC-ID format as a configurable pattern (S4) | **Open** | QA/XRAY owner confirms canonical ID pattern |

---

## 7. What the reconciliation changed

S1 added the sanitized golden fixture (Section 1 B) and this diff note. S3 (PR #20) has since applied the reconciliation:

- Promoted the T-1 eval row in [qa-test-case-architect-v2-eval-category-4-xray-csv-compliance.csv](qa-test-case-architect-v2-eval-category-4-xray-csv-compliance.csv) from draft to the enforced shared contract.
- Reconciled the enforced header, the golden-copy template, and the existing Category 4 rows to the confirmed 14-column contract (golden B); `Priority` was later re-added 2026-07-14, so the enforced contract is now 15 columns (see the 2026-07-14 status note above and §6).
