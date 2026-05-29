# Release Drift Monitor Studio Instruction Split Publish

Date: 2026-05-28

## Published Pages

- ROVO Studio Configuration - Release Drift Monitor
  - Page ID: 5318770794
  - Published version: v14
- Subagent Settings - Release Drift Monitor
  - Page ID: 5318606986
  - Published version: v3
- Change Log - Release Drift Monitor
  - Page ID: 5318574194
  - Published version: v8

## Change Summary

- Slimmed the Release Drift Monitor parent instructions into an operating contract.
- Moved detailed external repository evidence matching into Jira-Code Reconciler instructions.
- Added explicit fallback coverage for Guidewire Bitbucket, GitHub/AWS repositories, future Bitbucket migration, Jira Web Links, structured Jira comments, and human-reviewed mappings.
- Updated Health Pulse Summarizer wording, trend, source freshness, and pre-freeze severity discipline.
- Updated subagent routing and tool/source stance so code evidence is not limited to the Jira Development Panel.

## Publish Commands

Dry run:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-drift-monitor-rovo-studio-configuration,release-drift-monitor-subagent-settings,release-drift-monitor-change-log -UpdateExisting
```

Apply:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-drift-monitor-rovo-studio-configuration,release-drift-monitor-subagent-settings,release-drift-monitor-change-log -UpdateExisting -Apply
```
