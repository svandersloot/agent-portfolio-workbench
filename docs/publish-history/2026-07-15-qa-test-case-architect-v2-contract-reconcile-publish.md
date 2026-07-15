# Publish History — QA Test Case Architect v2 Contract Reconcile (2026-07-15)

| Field | Value |
|---|---|
| Date | 2026-07-15 |
| Space | ROVO (`csaaig.atlassian.net`) |
| Mechanism | Atlassian MCP connector (`updateConfluencePage`), coordinator-driven |
| Approval | Owner approved publish via MCP for the 3 core pages + overlay (this session) |
| Source | `agent-portfolio-workbench` `origin/main` after PRs #33, #34, #35, #36, #37 |
| Boundary | MCP writes are non-reversible (no delete/trash tool); any correction is a new version or manual UI cleanup. ROVO Studio save remains a separate human step. No Jira/XRAY writes. |

## Context

Live Confluence had drifted from the repo: the live pages carried the OLD XRAY contract plus a `Runtime Contract - QA Test Case Architect v2` page (behavior authority, created 2026-06-17) that had never been committed to this repo. PR #37 reconciled the repo (captured the live Runtime Contract baseline verbatim and re-layered the merged behavior changes). This publish pushed the reconciled repo content back to the 3 core live pages.

## Pages published

| Page | Page ID | Version | Change |
|---|---|---|---|
| Runtime Contract - QA Test Case Architect v2 | 5406195765 | 1 → 2 | XRAY CSV Rules → 15-column shared contract (dual `Test Type`, `Functionality`, `Priority`=Low, no `Execution Type`/`Sprint`, `Assignee`); Deterministic ID → configurable pattern; +S5 step-quality; ticket-attach intake gate; Test Type/Application List validation; readable table; downloadable CSV; 2 Runtime-Verification lines. |
| ROVO Studio Configuration - QA Test Case Architect v2 | 5377884217 | 6 → 7 | Parent-Instructions contract/behavior updated to match the above; Runtime Contract named as behavior authority (already aligned in repo). |
| Studio Setup - QA Test Case Architect v2 | 5377490989 | 7 → 8 | Thin-instruction contract/behavior updated to match; Runtime Contract added to the source-of-truth list. |

Each page was re-fetched immediately before its write to confirm no concurrent edit since the reconcile baseline (Runtime Contract was still v1; Studio Config still v6; Studio Setup v7).

## Not published (needs follow-up reconcile)

| Page | Page ID | Reason |
|---|---|---|
| Team Overlay - Payment Ninjas (PN) | 5477793868 | Already exists live (created 2026-07-09), predates the repo's S4/S5 overlay work. Do NOT create a duplicate; reconcile the live page against the repo overlay (`docs/confluence-pages/qa-test-case-architect-v2-team-overlay-payment-ninjas.md`) — likely missing the S5 step-quality/preconditions and the confirmed App List answers. |
| Evaluation - QA Test Case Architect v2 | 5378572351 | Repo has new eval cases (QATCA-EVAL-018–024) + updated hardened-behavior note, but the page was not reconciled against its live 2026-06-17 baseline; publish only after a reconcile pass. |
| Knowledge Source Plan - QA Test Case Architect v2 | 5377785933 | Repo has controlled-vocabulary + App List answers not yet reconciled against live. |
| Measurement Plan - QA Test Case Architect v2 | 5378703415 | Repo has the S11 time-savings hypothesis not yet reconciled against live. |
| Change Log - QA Test Case Architect v2 | 5379194894 | Repo change log advanced to v0.21; reconcile against live before publishing. |

## Remaining human-owned steps

- **Manual ROVO Studio save**: apply the reconciled Runtime Contract / Studio Configuration to the running agent (human action; not automated).
- **Reconcile + publish** the five pages above in a follow-up pass (capture live → repo → re-layer → surgical publish).
- **Runtime verification**: live ROVO output is not proven until the Runtime Verification prompts are run in Studio and compared with the evaluation baseline.

## Note on the sub-agent write flag

The Studio Setup update was executed by a sub-agent, which the harness flagged as an external write lacking inline approval (the sub-agent could not see the session's approval context). The write was within the owner-approved scope and used canonical repo content. Future live writes are performed directly by the coordinator so the approval context travels with the action.
