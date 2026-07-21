# Publish History — QA Test Case Architect v2 v0.26/v0.27 Checkpoint Republish (2026-07-21)

| Field | Value |
|---|---|
| Date | 2026-07-21 |
| Space | ROVO (`csaaig.atlassian.net`) |
| Mechanism | Governed publisher (`scripts/Publish-ConfluencePages.ps1`), per-page dry-run (target identity asserted programmatically) then `-Apply -UpdateExisting`, run from a worktree at merged `origin/main` with owner-authorized `-EnvPath`/`-ConfigPath` |
| Source | `origin/main` merges `1f3a84a` (PR #64, v0.25 evaluation results) and `32c4d9b` (PR #65, controlled-QA checkpoint + instruction capture #3) |
| Approval | Owner instruction "proceed to publish" following the merged checkpoint decision |
| Boundary | Exactly two pages updated. No Jira, XRAY, or ROVO Studio action. MCP used for read-back verification only. No other QATCA page republished. |

## Pages republished

| Slug | Page ID | Version | Dry-run | Apply | MCP read-back |
|---|---|---|---|---|---|
| qa-test-case-architect-v2-evaluation | 5378572351 | 10 → 11 | asserted clean | success | verified — live text-match on the v0.25 results-review reference (QATCA-EVAL-032 Pass / 033 Partial rows), just-modified timestamp |
| qa-test-case-architect-v2-change-log | 5379194894 | 11 → 12 | asserted clean | success | verified — live text-match on the v0.27 "Controlled QA checkpoint" row (plus v0.26 results row), just-modified timestamp |

## Change published

The v0.26 evaluation-results record (R-1/F2 closed; R-4 open with refined root causes; F10 escalated) and the owner's v0.27 **Controlled QA checkpoint** decision: synthetic data only, **no live XRAY imports**, no broad rollout or readiness claim; remediation reordered to R-4 iteration 2 → F10 (ahead of F9) → capture #3 + reruns → F9/EVAL-031. Instruction capture #3 (same-day, 64/64-line identity with the v0.25 copy block) verified the manual Studio save and resolved the run's provenance caveat; the capture record itself is Git-only evidence.

## Notes

- Known converter trait (disclosed since the v0.23 publish) still applies: inline bold/italic and markdown links inside bullets and table cells render as literal characters; content is complete and correct.

## Remaining human-owned

- Controlled-QA restrictions in force until R-4 iteration 2 and the F10 assignee slice land and re-verify.
- Admin-visible Studio configuration capture (knowledge sources/tools) for the full Manual Setup Record.
- F9, EVAL-031 authoring, and remaining category coverage afterward.
