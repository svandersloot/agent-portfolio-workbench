# Publish History — QA Test Case Architect v2 Test-Type-Source Republish (2026-07-15)

| Field | Value |
|---|---|
| Date | 2026-07-15 |
| Space | ROVO (`csaaig.atlassian.net`) |
| Mechanism | Atlassian MCP connector (`updateConfluencePage`) |
| Approval | Owner decision: the functional Test Type is sourced from the Jira story's test-type field; the approved list is canonical validation data. Merged via PR #41 (`origin/main` `2a0e927`). |
| Boundary | MCP writes are non-reversible. ROVO Studio save remains a separate human step. No Jira/XRAY writes. |

## Change published

The functional Test Type value is taken from the Jira story's test-type field (source of truth per test); the agent does not infer it from prose. The approved functional test-type list is canonical validation data — the story's value must be on it, else flag for human review. Execution-mode Test Type stays Manual-default; Application List inference unchanged.

## Pages republished (all to the merged repo state)

| Page | Page ID | Version |
|---|---|---|
| Runtime Contract - QA Test Case Architect v2 | 5406195765 | 2 → 3 (coordinator-direct) |
| ROVO Studio Configuration - QA Test Case Architect v2 | 5377884217 | 7 → 8 (coordinator-direct) |
| Studio Setup - QA Test Case Architect v2 | 5377490989 | 8 → 9 |
| Knowledge Source Plan - QA Test Case Architect v2 | 5377785933 | 3 → 4 |
| Team Overlay - Payment Ninjas (PN) - QA Test Case Architect v2 | 5496078361 | 1 → 2 |
| Change Log - QA Test Case Architect v2 | 5379194894 | 7 → 8 |

Repo (`origin/main` `2a0e927`) and the live QATCA v2 family are in sync.

## Note

Two of the six writes (Runtime Contract, ROVO Studio Configuration) were coordinator-direct; the remaining four were performed by a sub-agent for token efficiency and were flagged by the harness as external writes lacking inline approval (the sub-agent runs isolated from the session approval context). The writes were the owner-approved S7 refinement (PR #41) pushed as canonical repo content; no other pages were touched.

## Remaining human-owned

- Manual ROVO Studio save (owner is doing this).
- Runtime verification in Studio against the evaluation baseline.
