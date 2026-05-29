# Publish History - Release Drift Monitor Guidewire Bitbucket Fallback

## Summary

| Field | Value |
|---|---|
| Date | 2026-05-28 |
| Space | ROVO |
| Area | Guidewire Bitbucket fallback evidence |
| Studio writes | None |

## Pages Published

| Page | Page ID | Result |
|---|---|---|
| Release Evidence Ledger Contract | `5318443179` | Updated to v5 |
| Release Drift Monitor Project Brain | `5317918849` | Updated to v5 |
| Knowledge Source Plan - Release Drift Monitor | `5318148300` | Updated to v4 |
| ROVO Studio Configuration - Release Drift Monitor | `5318770794` | Updated to v13 |
| Evaluation - Release Drift Monitor | `5318312094` | Updated to v8 |
| Measurement Plan - Release Drift Monitor | `5318443195` | Updated to v4 |
| Template - Release Drift Monitor Handoff Page | `5322244174` | Updated to v3 |
| User Guide - Release Drift Monitor Handoff Pages | `5322473565` | Updated to v2 |
| Change Log - Release Drift Monitor | `5318574194` | Updated to v7 |

## Change Summary

- Documented that Jira Development Panel links may point to CSAA Bitbucket while application PRs live in Guidewire Bitbucket.
- Added Jira Web Link and structured Jira comment fallback evidence rules.
- Added the structured release-evidence comment format.
- Clarified that an empty Development Panel is not proof of missing code for Guidewire-hosted app repos.
- Added two E2E evaluation cases for Web Link and structured-comment fallback behavior.
- Added measurement for fallback adoption and evidence quality.

## Commands

Dry-run:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-evidence-ledger-contract,release-drift-monitor-project-brain,release-drift-monitor-knowledge-source-plan,release-drift-monitor-rovo-studio-configuration,release-drift-monitor-evaluation,release-drift-monitor-measurement-plan,release-drift-monitor-handoff-template,release-drift-monitor-handoff-user-guide,release-drift-monitor-change-log -UpdateExisting
```

Apply:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-evidence-ledger-contract,release-drift-monitor-project-brain,release-drift-monitor-knowledge-source-plan,release-drift-monitor-rovo-studio-configuration,release-drift-monitor-evaluation,release-drift-monitor-measurement-plan,release-drift-monitor-handoff-template,release-drift-monitor-handoff-user-guide,release-drift-monitor-change-log -UpdateExisting -Apply
```
