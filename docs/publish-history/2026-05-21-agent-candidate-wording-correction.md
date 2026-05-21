# Publish History - Agent Candidate Wording Correction

## Summary

Corrected the intake outcome wording from `App candidate` / Forge-oriented language to `Agent candidate`. No Studio changes were made.

## Confluence Targets

| Page | Page ID | Source | Previous Version | Published Version |
|---|---|---|---|---|
| Agent Fit Intake | `5301174273` | `docs/confluence-pages/agent-fit-intake.md` | `2` | `3` |
| User Guide - Designing Agents | `5298716754` | `docs/confluence-pages/user-guide-designing-agents.md` | `2` | `3` |

## Commands

Dry-runs:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug agent-fit-intake -UpdateExisting
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-designing-agents -UpdateExisting
```

Apply:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug agent-fit-intake -UpdateExisting -Apply
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-designing-agents -UpdateExisting -Apply
```

Post-apply verification:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug agent-fit-intake -UpdateExisting
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-designing-agents -UpdateExisting
```

## Verification

- Each dry-run returned `pageCount: 1`.
- Each apply returned `mode: apply`, `action: update`, and `currentVersion: 3`.
- Post-apply dry-runs returned `currentVersion: 3` and `plannedVersion: 4`.
- Repo search found no remaining tracked `app candidate`, `App candidate`, `APP CANDIDATE`, `App/Forge`, or `Forge candidate` wording.

## Published At

`2026-05-21T14:04:45-07:00`
