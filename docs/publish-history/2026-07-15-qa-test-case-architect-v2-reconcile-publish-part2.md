# Publish History — QA Test Case Architect v2 Reconcile Publish, Part 2 (2026-07-15)

| Field | Value |
|---|---|
| Date | 2026-07-15 |
| Space | ROVO (`csaaig.atlassian.net`) |
| Mechanism | Atlassian MCP connector (`updateConfluencePage` / `createConfluencePage`), coordinator-driven |
| Approval | Owner approved the follow-up reconcile + publish of the remaining pages ("proceed"). |
| Source | `agent-portfolio-workbench` `origin/main` after PR #39 (reconcile) — decisions across PRs #18–#39. |
| Boundary | MCP writes are non-reversible (no delete/trash tool). ROVO Studio save remains a separate human step. No Jira/XRAY writes. |

## Context

Part 1 (`2026-07-15-qa-test-case-architect-v2-contract-reconcile-publish.md`) published the 3 core pages (Runtime Contract, ROVO Studio Configuration, Studio Setup). PR #39 reconciled the remaining pages against their live baselines (capturing the live-only 2026-06-17 "Runtime contract split" change-log row and the live Runtime-Contract evaluation goal/cases). This part published them.

## Pages published (updates)

| Page | Page ID | Version | Change |
|---|---|---|---|
| Change Log - QA Test Case Architect v2 | 5379194894 | 6 → 7 | Preserved live-only `v0.12a` (2026-06-17 Runtime contract split) + repo rows `v0.13`–`v0.21`. |
| Measurement Plan - QA Test Case Architect v2 | 5378703415 | 2 → 3 | Added the Time-Savings Hypothesis (Session 1 follow-up; explicitly not ROI; owner-owned baseline). |
| Knowledge Source Plan - QA Test Case Architect v2 | 5377785933 | 2 → 3 | Added Controlled Vocabularies (execution-mode + 26 functional Test Type values; Application List reference-only) and the confirmed answers (shared org-wide, single-value, Jira/XRAY-admin owner). |
| Evaluation - QA Test Case Architect v2 | 5378572351 | 6 → 7 | Added eval cases `QATCA-EVAL-018`–`024` + the 15-column hardened-behavior note; preserved live's Runtime-Contract goal, parity case, and routing case (renumbered to `025`/`026` to avoid ID collision). |

## Page created

| Page | Page ID | Parent | Note |
|---|---|---|---|
| Team Overlay - Payment Ninjas (PN) - QA Test Case Architect v2 | 5496078361 | 5377720354 (QATCA v2 Project Brain) | S4 TC-ID pattern, S5 step-style/preconditions, shared 15-col contract reference. |

## Correction to Part 1

Part 1 recorded that a Payment Ninjas overlay "already exists live (`5477793868`) — reconcile, don't create." **That was a misidentification.** Direct inspection confirmed `5477793868` ("Team Overlay - Payment Ninjas (PN)") is the **QA Test *Strategy Planner*** overlay (parent `5404885001` "Team Overlays - QA Test Strategy Planner"; related record is the strategy-planner review; it routes test-case/RTM/CSV work *to* QATCA v2). The QATCA v2 overlay did **not** exist live and was created fresh here (`5496078361`). The QATSP page `5477793868` was **not** modified.

## Status: full QATCA v2 family reconciled + published

Runtime Contract (v2), ROVO Studio Configuration (v7), Studio Setup (v8), Change Log (v7), Measurement Plan (v3), Knowledge Source Plan (v3), Evaluation (v7), and the new Payment Ninjas overlay (`5496078361` v1) all reflect the reconciled repo source (`origin/main`).

## Remaining human-owned steps

- **Manual ROVO Studio save** — apply the reconciled Runtime Contract / Studio Configuration to the running agent (owner is doing this).
- **Runtime verification** — run the Runtime Verification prompts in Studio against the evaluation baseline; live behavior is not proven until then.
- **Still-open inputs**: exact `Priority` column index vs a real Priority-bearing import; full Application List stays reference-only (enforced via the Jira/XRAY knowledge source, not committed); the Jira/XRAY Application List field-hygiene cleanup (near-duplicate entries) is owner-owned.

## Note on prior sub-agent write flag

Part 1's Studio Setup update was executed by a sub-agent and flagged by the harness (isolated approval context). All writes in this part were performed **directly by the coordinator**, carrying the owner's approval context.
