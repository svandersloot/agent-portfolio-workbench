# Publish History - Release Drift Monitor Handoff User Guide

## Summary

| Field | Value |
|---|---|
| Date | 2026-05-28 |
| Space | ROVO |
| Area | Release Drift Monitor stakeholder rollout |
| Studio writes | None |

## Pages Published

| Page | Page ID | Parent Page ID | Source File | Result |
|---|---|---|---|---|
| Template - Release Drift Monitor Handoff Page | `5322244174` | `5317918849` | `docs/confluence-pages/release-drift-monitor-handoff-template.md` | Updated to v2 |
| User Guide - Release Drift Monitor Handoff Pages | `5322473565` | `5317918849` | `docs/confluence-pages/release-drift-monitor-handoff-user-guide.md` | Created |
| Change Log - Release Drift Monitor | `5318574194` | `5317918849` | `docs/confluence-pages/release-drift-monitor-change-log.md` | Updated to v6 |

## Change Summary

- Added stakeholder guidance for reading Release Drift Monitor handoff pages.
- Documented how to resolve `WARN`, `BLOCK`, and `UNKNOWN` states.
- Added prompt templates for initial pulse, existing handoff update, and stakeholder review.
- Embedded the prompt templates in the handoff template so generated pages can stay consistent.

## Commands

Dry-run:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-drift-monitor-handoff-user-guide,release-drift-monitor-handoff-template,release-drift-monitor-change-log -UpdateExisting
```

Apply:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-drift-monitor-handoff-user-guide,release-drift-monitor-handoff-template,release-drift-monitor-change-log -UpdateExisting -Apply
```
