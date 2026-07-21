# Decision Record — Retirement of the `testcasegen-qatca-v2-proof` Branch (2026-07-21)

| Field | Value |
|---|---|
| Date | 2026-07-21 |
| Decision owner | Shayne Vandersloot (repo/agent owner) — stated directly in-session on 2026-07-21 |
| Recorded by | Governance workbench (Claude Code) |
| Decision type | Retirement of an unapproved proof-of-concept work branch; explicitly **not** an agent retirement (no live agent was configured from this branch) |
| Boundary | Repo-only. No ROVO Studio, Jira, XRAY, or Confluence action. No change to QA Test Case Architect v2 runtime instructions, datasets, or governance status. |

## Decision

The branch `shaynevandersloot/testcasegen-qatca-v2-proof` is **not approved** and is retired. None of its content will be folded into QA Test Case Architect v2: the v2 lineage (S1–S8 slices, v0.13–v0.25 change-log trail, the 15-column shared XRAY contract, evaluation-mode metadata, and the F2/R-4 hardening) is substantially more mature after the 2026-07 governance work and supersedes the proof. The branch is removed from tracking (remote and local branch refs deleted) per the owner's instruction to stop tracking it entirely.

## What the branch contained (for the record)

One commit not on `main`: `e18f7c6` (2026-07-09, "Add QA Test Case Architect v2 evaluation docs, handoffs, and testing-services AI reports"), 8 files, ~2,400 added lines:

- an early `qa-test-case-architect-v2-evaluation.md` addition (30 lines);
- `qatsp-studio-eval-remediation-handoff-2026-07-09.md`;
- `qa-test-case-architect-v2-handoff-2026-07-08.md`;
- `...-architect-v2-integration-design-2026-07-08.md`;
- a testing-services AI adoption executive brief (HTML);
- an agent-inventory readiness report (2026-07-08);
- a test-generation agent comparison (Markdown + HTML, 2026-07-08).

These were 2026-07-08/09 spike-era documents predating the merged v2 governance lineage; the durable decisions they explored were subsequently made and recorded through the governed slice trail (change log v0.13–v0.25 and the `docs/publish-history/` records).

## Disposition

- Remote branch `shaynevandersloot/testcasegen-qatca-v2-proof` deleted.
- Local branch deleted after detaching the primary checkout in place (no working-tree files were changed; untracked local files were untouched).
- **No archive tag was created**, per the owner's explicit instruction not to track this work at all. The retired commit remains recoverable by SHA `e18f7c6` from reflogs and remote storage until routine garbage collection; after that, this record is the durable trace.
- If any individual document from the spike later proves worth keeping, it must re-enter through a normal reviewed slice, evaluated against the current v2 lineage — not by resurrecting the branch.

## What this decision does not do

- It does not change QA Test Case Architect v2's lifecycle status, readiness, ownership, or evaluation baselines.
- It does not retire, deprecate, or alter any live agent, Studio configuration, or Confluence page.
- It does not affect the frozen `work-main-latest` worktree, whose retire/re-derive decision remains separately open.
