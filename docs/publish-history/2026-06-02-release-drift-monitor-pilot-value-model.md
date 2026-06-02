# Publish History - Release Drift Monitor Pilot Value Model

## Summary

| Field | Value |
|---|---|
| Date | 2026-06-02 |
| Space | ROVO |
| Parent | Release Drift Monitor Project Brain |
| Source | `docs/confluence-pages/release-drift-monitor-pilot-value-model.md` |
| Studio writes | None |
| Jira writes | None |
| Confluence writes from Codex | Created pilot value page; updated Release Drift Monitor Project Brain link |

## Published Page

The page explains why Release Drift Monitor is being piloted, how to interpret noisy first runs, how teams should respond to evidence gaps, how the code-freeze handoff feeds Release Health Analyst, and which metrics can show improvement over time.

| Page | Page ID | Parent | Version After Publish |
|---|---|---|---|
| Release Drift Monitor Pilot Value Model | `5340692753` | Release Drift Monitor Project Brain (`5317918849`) | `1` |
| Release Drift Monitor Project Brain | `5317918849` | Release and Change Agents (`5281218643`) | `6` |

Key message:

```text
The goal is not to punish teams for incomplete evidence. The goal is to make missing evidence visible early enough that teams can fix it while there is still time.
```

## Companion Updates

| Artifact | Update |
|---|---|
| `config/confluence-pages.example.yml` | Added `release-drift-monitor-pilot-value-model` as a child of `release-drift-monitor-project-brain`. |
| `docs/confluence-pages/release-drift-monitor-project-brain.md` | Added the pilot value model to Required Linked Artifacts. |

## Validation

Initial dry-run attempt on 2026-06-02 stopped before Confluence because local `.env` was not present:

```text
Cannot find path '.\.env' because it does not exist.
```

The prior ignored `.env` was recovered from an earlier local Codex workspace and copied into this workspace. It is intentionally ignored by Git.

Dry-run for the new page:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-drift-monitor-pilot-value-model
```

Result:

- Mode: dry-run.
- Space: `ROVO`.
- Page count: `1`.
- Action: `create`.
- Parent page: Release Drift Monitor Project Brain (`5317918849`).

Apply for the new page:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-drift-monitor-pilot-value-model -Apply
```

Result:

- Created page `5340692753`.
- Labels: `agent-governance`, `user-guide`, `release-drift`, `pilot`.

Project Brain link update dry-run:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-drift-monitor-project-brain -UpdateExisting
```

Result:

- Mode: dry-run.
- Space: `ROVO`.
- Page count: `1`.
- Action: `update`.
- Current version: `5`.
- Planned version: `6`.

Project Brain link update apply:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug release-drift-monitor-project-brain -UpdateExisting -Apply
```

Result:

- Updated Release Drift Monitor Project Brain to version `6`.

Post-apply verification:

- `Release Drift Monitor Pilot Value Model` resolves as existing at version `1`.
- `Release Drift Monitor Project Brain` resolves at current version `6`.
