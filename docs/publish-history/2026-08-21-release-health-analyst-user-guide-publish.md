# Publish History - Release Health Analyst User Guide & Operations Manual

## Summary

| Field | Value |
|---|---|
| Date | 2026-08-21 |
| Space | ROVO |
| Confirmed canonical parent | `5299994681` (see Drift Note below) |
| Studio writes | None |
| Jira writes | None |
| Rename/archive/move/permission actions | None |

## Drift Note (Reported, Not Resolved)

The user explicitly confirmed `5299994681` as the intended canonical parent for this family. At the time of publish, that page's live title and full body were **"Release Notes Manager Project Brain"** — a different agent's governance record (its own Scope, Required Linked Artifacts, Guardrails, and Launch Decision, none referencing Release Health Analyst). This is a content mismatch, not only a cosmetic title mismatch. Per explicit instruction, the parent page was not renamed, updated, archived, banner-noted, or otherwise modified. This note is the only record of the discrepancy; resolving it (e.g., confirming the transposed-ID hypothesis, or retitling the parent) remains a human decision.

An earlier candidate parent, `5288362010` ("Release Health Analyst Project Brain"), was superseded by this confirmed ID and was **not** used.

## Published Pages

| Page | Page ID | Parent | Source | URL |
|---|---|---|---|---|
| Release Health Analyst - User Guide & Operations Manual | `5636259946` | `5299994681` | `docs/confluence-pages/release-health-analyst-user-guide-home.md` | `/spaces/ROVO/pages/5636259946/Release+Health+Analyst+-+User+Guide+Operations+Manual` |
| Release Health Analyst Overview | `5636259967` | `5636259946` | `docs/confluence-pages/release-health-analyst-user-guide-overview.md` | `/spaces/ROVO/pages/5636259967/Release+Health+Analyst+Overview` |
| Running a Manual Release Assessment | `5635375363` | `5636259946` | `docs/confluence-pages/release-health-analyst-user-guide-manual-assessment.md` | `/spaces/ROVO/pages/5635375363/Running+a+Manual+Release+Assessment` |
| Understanding the Assessment Output | `5636096103` | `5636259946` | `docs/confluence-pages/release-health-analyst-user-guide-assessment-output.md` | `/spaces/ROVO/pages/5636096103/Understanding+the+Assessment+Output` |
| Release Health Automation Setup | `5636292752` | `5636259946` | `docs/confluence-pages/release-health-analyst-user-guide-automation-setup.md` | `/spaces/ROVO/pages/5636292752/Release+Health+Automation+Setup` |
| Automation Field Reference | `5636620290` | `5636259946` | `docs/confluence-pages/release-health-analyst-user-guide-automation-field-reference.md` | `/spaces/ROVO/pages/5636620290/Automation+Field+Reference` |
| Release Health Assessment Workflow | `5636292773` | `5636259946` | `docs/confluence-pages/release-health-analyst-user-guide-workflow.md` | `/spaces/ROVO/pages/5636292773/Release+Health+Assessment+Workflow` |
| Best Practices | `5636161622` | `5636259946` | `docs/confluence-pages/release-health-analyst-user-guide-best-practices.md` | `/spaces/ROVO/pages/5636161622/Best+Practices` |
| Known Limitations and Caveats | `5635637329` | `5636259946` | `docs/confluence-pages/release-health-analyst-user-guide-known-limitations.md` | `/spaces/ROVO/pages/5635637329/Known+Limitations+and+Caveats` |
| Troubleshooting Guide | `5635244323` | `5636259946` | `docs/confluence-pages/release-health-analyst-user-guide-troubleshooting.md` | `/spaces/ROVO/pages/5635244323/Troubleshooting+Guide` |
| Governance and Ownership | `5636325555` | `5636259946` | `docs/confluence-pages/release-health-analyst-user-guide-governance.md` | `/spaces/ROVO/pages/5636325555/Governance+and+Ownership` |
| Continuous Improvement Backlog | `5635735673` | `5636259946` | `docs/confluence-pages/release-health-analyst-user-guide-improvement-backlog.md` | `/spaces/ROVO/pages/5635735673/Continuous+Improvement+Backlog` |

All 12 pages created at version `1`, status `current`.

## Rendering Findings (Follow-Up, Not Yet Actioned)

Two content-fidelity issues surfaced only once pages were live, not visible in local Markdown review:

1. **Cross-page links did not resolve.** Internal links written as relative Markdown filenames (e.g. `release-health-analyst-user-guide-overview.md`) rendered as literal `<a href="...md">` links to a non-existent relative path, not as working Confluence page links. Every "See [X](...)" cross-reference across all 12 pages is affected.
2. **Mermaid diagrams rendered as plain code blocks.** The `createConfluencePage` markdown-to-storage conversion mapped ` ```mermaid ` fences to a Confluence `code` macro with `language=mermaid` (syntax-highlighted text), not a rendered diagram. This affects the two flowcharts on "Release Health Assessment Workflow" and the Gantt chart on "Release Health Automation Setup." Whether a diagram renders depends on whether the ROVO space has a Mermaid-rendering app/macro installed, which was not confirmed.

Fixing either issue requires an `updateConfluencePage` call per page, which is a separate live write requiring its own explicit approval and was out of scope for this publish action.

## Validation

- Dry-run manifest (12 planned pages, order, titles, slugs, source paths, parent IDs) was reviewed and explicitly approved by the user before any write.
- Pre-publish integrity check: all 12 source files re-read and confirmed to match the previously validated manifest; no drift found.
- `git diff --check`, `.\scripts\Test-ConfluencePageFamilyConsistency.ps1` (0 issues), and `.\scripts\Test-PrivateDataScan.ps1` (0 findings) ran clean before publish.
- Apply created exactly 12 new pages in the `ROVO` space, all at version `1`.
- No Studio changes were made. No Jira issues were read or written. No rename, archive, move, or permission actions were taken on any existing page, including the confirmed parent.

## Follow-Ups (Require Separate Approval)

- Confirm whether `5299994681` is genuinely intended long-term, or whether the ID was transposed — see Drift Note above.
- Decide whether to fix the 12 pages' internal cross-links (would require 12 `updateConfluencePage` calls).
- Confirm whether ROVO has Mermaid rendering available; if not, decide whether to keep the diagrams as labeled code blocks or convert them to a different format.
- Populate the untracked `config/confluence-pages.yml` local manifest with the real page IDs above (e.g. via `.\scripts\Sync-ConfluenceLocalManifest.ps1`) if this family will be managed by the publisher scripts going forward. Not done in this slice.
