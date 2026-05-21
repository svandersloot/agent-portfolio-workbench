# Publish History - Agent Inventory And User Guide Correction

## Summary

Published the first repo-backed `Agent Inventory` update. The Codex-to-Rovo technical builder pattern was initially published to the User Guide, then corrected because that pattern is repo-only guidance and should not appear in Confluence. No Studio changes were made.

## Confluence Targets

| Page | Page ID | Source | Previous Version | Published Version |
|---|---|---|---|---|
| User Guide - Designing Agents | `5298716754` | `docs/confluence-pages/user-guide-designing-agents.md` | `3` | `4` |
| User Guide - Designing Agents correction | `5298716754` | `docs/confluence-pages/user-guide-designing-agents.md` | `4` | `5` |
| Agent Inventory | `5280334048` | `docs/confluence-pages/agent-inventory.md` | `1` | `2` |

## Commands

Dry-runs:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-designing-agents -UpdateExisting
.\scripts\Publish-ConfluencePages.ps1 -Slug agent-inventory -UpdateExisting
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-designing-agents -UpdateExisting
```

Apply:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-designing-agents -UpdateExisting -Apply
.\scripts\Publish-ConfluencePages.ps1 -Slug agent-inventory -UpdateExisting -Apply
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-designing-agents -UpdateExisting -Apply
```

Post-apply verification:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-designing-agents -UpdateExisting
.\scripts\Publish-ConfluencePages.ps1 -Slug agent-inventory -UpdateExisting
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-designing-agents -UpdateExisting
```

## Verification

- Each dry-run returned `pageCount: 1`.
- Each apply returned `mode: apply` and `action: update`.
- `User Guide - Designing Agents` post-apply dry-run returned `currentVersion: 4` and `plannedVersion: 5`.
- `User Guide - Designing Agents` correction dry-run returned `pageCount: 1`, `action: update`, `currentVersion: 4`, and `plannedVersion: 5`.
- `User Guide - Designing Agents` correction removed the repo-only Codex pipeline from Confluence.
- `User Guide - Designing Agents` correction post-apply dry-run returned `currentVersion: 5` and `plannedVersion: 6`.
- `Agent Inventory` post-apply dry-run returned `currentVersion: 2` and `plannedVersion: 3`.
- No duplicate/stale inventory pages were updated.
- No Studio write path was used.

## Published At

`2026-05-21T15:13:14-07:00`

## Corrected At

`2026-05-21T15:15:22-07:00`
