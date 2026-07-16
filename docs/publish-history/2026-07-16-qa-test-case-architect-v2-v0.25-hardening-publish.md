# Publish History — QA Test Case Architect v2 v0.25 Hardening Republish (2026-07-16)

| Field | Value |
|---|---|
| Date | 2026-07-16 |
| Space | ROVO (`csaaig.atlassian.net`) |
| Mechanism | Governed publisher, per-page dry-run (target identity asserted programmatically: action=update, expected page ID, expected current version) then `-Apply -UpdateExisting`, run from a worktree at merged `origin/main` with owner-authorized `-EnvPath`/`-ConfigPath` |
| Source | `origin/main` merges `efd035a` (PR #60, v0.24 republish record) and `b14c25f` (PR #61, commit `d77eb2f` — F2/R-1 + R-4 hardening) |
| Approval | Owner sequencing instruction: merge #60 and #61, refresh IDs/versions via MCP, publish the five pages in order with MCP read-back per page |
| Boundary | Exactly five pages updated. No Jira, XRAY, or ROVO Studio action. MCP used for pre-publish refresh and per-page read-back only. Team overlay, Knowledge Source Plan, and Measurement Plan unchanged and not republished. |

## Pre-publish MCP refresh

All five pages: single candidate per ID, correct titles, last-modified timestamps exactly matching the prior governed applies — no interim drift.

## Pages republished (in order), with results

| # | Slug | Page ID | Version | Dry-run | Apply | MCP read-back |
|---|---|---|---|---|---|---|
| 1 | qa-test-case-architect-v2-runtime-contract | 5406195765 | 5 → 6 | asserted clean | success | verified (text-match: mode-precedence self-check live; just-modified) |
| 2 | qa-test-case-architect-v2-rovo-studio-configuration | 5377884217 | 9 → 10 | asserted clean | success | verified (text-match: CSV structural validation live) |
| 3 | qa-test-case-architect-v2-studio-setup | 5377490989 | 10 → 11 | asserted clean | success | verified (text-match: mode-precedence self-check live) |
| 4 | qa-test-case-architect-v2-evaluation | 5378572351 | 9 → 10 | asserted clean | success | verified (text-match: QATCA-EVAL-033 live) |
| 5 | qa-test-case-architect-v2-change-log | 5379194894 | 10 → 11 | asserted clean | success | verified by authoritative direct page read (v11 body contains the v0.25 row; the initial CQL text-index match lagged and was not accepted as verification) |

## Change published (v0.25)

F2/R-1 mode-precedence self-check (Evaluation only when explicitly marked; production-labeled or unmarked requests stop without the ticket pack and generate nothing; never `Mode: Evaluation` on production) and R-4 CSV structural validation (exactly 15 fields per row; comma/quote/newline fields double-quoted; 13 leading blanks on continuation rows; Action populated whenever Expected Result is; Story ID on each test case's first row) — plus evals QATCA-EVAL-032/033 and the Category 4 dataset lineage reconciliation (prominently disclosed in PR #61).

## Remaining human-owned

- Manual Studio paste/save of the updated Thin Parent Instructions (Studio Setup v11) and capture of the saved configuration back to the repo.
- Rerun Categories 1 and 4 (explicitly covering EVAL-032/033); confirm production requests never enter Evaluation mode or generate without the production packet, and every emitted CSV row parses to exactly 15 fields. Record results without changing baselines or marking closure until evidence supports it.
- F9, then F10; downloadable-file verification; EVAL-031 authoring; remaining category coverage.
