# Regression Prompt Pack Evaluation Page Updates

## Summary

Published the Regression Prompt Pack sections for the two pilot agent evaluation pages. The sections add repo-backed prompt packs and expected-behavior criteria for repeatable regression checks; they do not claim live Studio test results, change agent readiness, or authorize Jira, Studio, or Confluence writes beyond this approved page update.

## Publish Details

| Page | Page ID | Action | Version Change | Source |
|---|---:|---|---|---|
| Evaluation - Jira Work Item Assistant | 5348524037 | Update | 4 -> 5 | `docs/confluence-pages/jira-work-item-assistant-evaluation.md` |
| Evaluation - Release Notes Manager | 5301403671 | Update | 3 -> 4 | `docs/confluence-pages/release-notes-manager-evaluation.md` |

## Commands

Dry-runs:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug jira-work-item-assistant-evaluation -UpdateExisting
.\scripts\Publish-ConfluencePages.ps1 -Slug release-notes-manager-evaluation -UpdateExisting
```

Apply:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug jira-work-item-assistant-evaluation -UpdateExisting -Apply
.\scripts\Publish-ConfluencePages.ps1 -Slug release-notes-manager-evaluation -UpdateExisting -Apply
```

## Verification Result

- `Evaluation - Jira Work Item Assistant` reported `mode: apply` and is current at version 5.
- `Evaluation - Release Notes Manager` reported `mode: apply` and is current at version 4.
- Apply was explicitly approved after dry-run review.
- No Jira writes or ROVO Studio writes were performed.
- `config/confluence-pages.yml` remains ignored and out of Git.

## Notes

- The publish results were reported by Claude Code after the approved live applies.
- A private Confluence reference in the Release Notes Manager evaluation source remains redacted in the repo-backed page source.
