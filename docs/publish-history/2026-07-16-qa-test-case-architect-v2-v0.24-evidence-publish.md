# Publish History — QA Test Case Architect v2 v0.24 Evidence Republish (2026-07-16)

| Field | Value |
|---|---|
| Date | 2026-07-16 |
| Space | ROVO (`csaaig.atlassian.net`) |
| Mechanism | Governed publisher (`scripts/Publish-ConfluencePages.ps1`), per-page dry-run then `-Apply -UpdateExisting`, run from a worktree at merged `origin/main` with owner-authorized `-EnvPath`/`-ConfigPath` |
| Source | `origin/main` merge `4ea4b5b` (PR #59, commit `f240b27` — v0.24 evaluation evidence and provenance) |
| Approval | Owner sequencing decision after merging PR #59: "Republish only Evaluation and Change Log, with dry-run → approval → apply → MCP read-back," then "proceed" |
| Boundary | Exactly two pages updated. No Jira, XRAY, or ROVO Studio action. Atlassian MCP used for read-back verification only. No other QATCA page republished (Runtime Contract, Configuration, Setup, KSP, Overlay unchanged since the v0.23 publish). |

## Pages republished

| Slug | Page ID | Version | Dry-run | Apply | MCP read-back |
|---|---|---|---|---|---|
| qa-test-case-architect-v2-evaluation | 5378572351 | 8 → 9 | clean (update, expected target/parent) | success | verified: v9, correct title/parent, QATCA-EVAL-027/028/029 Pass rows and the 2026-07-16 results-evidence note present; EVAL-030 remains Not Run |
| qa-test-case-architect-v2-change-log | 5379194894 | 9 → 10 | clean (update, expected target/parent) | success | verified: v10, single candidate, live-content match on the v0.24 entry, last-modified equals the apply timestamp |

## Change published

The v0.24 evaluation-evidence record: QATCA-EVAL-027/028/029 marked Pass with evidence links to the results review; the change-log v0.24 row recording the first v0.23-attributed Studio grader run (grader 80%/89%/100%; independent 14/19 clean; findings R-1–R-8), explicitly not a readiness or promotion claim.

## Notes

- Known converter trait (disclosed since the v0.23 publish): inline bold and markdown links inside table cells render as literal characters on the published pages; content is complete and correct.
- The referenced repo reports (results review, instruction capture #2) are Git-only evidence and are intentionally not published as Confluence pages.

## Remaining human-owned

- F2/R-1 + R-4 hardening slice (next per the owner's sequencing), then F9, F10.
- Downloadable-file verification in Studio; admin-visible Studio configuration capture.
- EVAL-031 authoring and EVAL-030/031 execution; remaining category reruns.
