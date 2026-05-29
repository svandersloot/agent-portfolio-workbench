# Publish History - Release Drift Monitor Repo And Branch Sources

## Summary

| Field | Value |
|---|---|
| Date | 2026-05-28 |
| Space | ROVO |
| Operation | Updated Release Drift Monitor source repository and release branch guidance |
| Mode | Dry-run first, then apply |
| Studio writes | None |

## Pages Updated

| Page | Page ID | Source File | Old Version | New Version |
|---|---|---|---|---|
| Release Evidence Ledger Contract | `5318443179` | `docs/confluence-pages/release-evidence-ledger-contract.md` | `1` | `2` |
| Release Drift Monitor Project Brain | `5317918849` | `docs/confluence-pages/release-drift-monitor-project-brain.md` | `1` | `2` |
| Release Drift Monitor - Agent Design Record | `5317853355` | `docs/confluence-pages/release-drift-monitor-agent-design-record.md` | `1` | `2` |
| Knowledge Source Plan - Release Drift Monitor | `5318148300` | `docs/confluence-pages/release-drift-monitor-knowledge-source-plan.md` | `1` | `2` |
| ROVO Studio Configuration - Release Drift Monitor | `5318770794` | `docs/confluence-pages/release-drift-monitor-rovo-studio-configuration.md` | `3` | `4` |

## Change

Updated Release Drift Monitor documentation to:

- Treat the Knowledge Source Plan as the canonical source for approved Bitbucket repository URLs.
- Add ClaimCenter, PolicyCenter, BillingCenter, and ContactManager as approved application repositories for read-only code evidence checks.
- Keep ROVO Studio instructions lighter by naming the approved application repos without hard-coding full URLs.
- Add the release branch naming convention `release/r-xx.x`, such as `release/r-64.0`.
- Preserve the boundary that repository access is for release evidence drift, not broad code review or implementation quality scoring.

## Commands

Pre-apply dry-run:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-evidence-ledger-contract,release-drift-monitor-project-brain,release-drift-monitor-agent-design-record,release-drift-monitor-knowledge-source-plan,release-drift-monitor-rovo-studio-configuration -UpdateExisting
```

Apply:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-evidence-ledger-contract,release-drift-monitor-project-brain,release-drift-monitor-agent-design-record,release-drift-monitor-knowledge-source-plan,release-drift-monitor-rovo-studio-configuration -UpdateExisting -Apply
```

Post-apply verification dry-run:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-evidence-ledger-contract,release-drift-monitor-project-brain,release-drift-monitor-agent-design-record,release-drift-monitor-knowledge-source-plan,release-drift-monitor-rovo-studio-configuration -UpdateExisting
```

## Verification

Post-apply dry-run confirmed:

- `pageCount`: `5`
- Release Evidence Ledger Contract `currentVersion`: `2`
- Release Drift Monitor Project Brain `currentVersion`: `2`
- Release Drift Monitor - Agent Design Record `currentVersion`: `2`
- Knowledge Source Plan - Release Drift Monitor `currentVersion`: `2`
- ROVO Studio Configuration - Release Drift Monitor `currentVersion`: `4`

No ROVO Studio configuration was changed directly.

