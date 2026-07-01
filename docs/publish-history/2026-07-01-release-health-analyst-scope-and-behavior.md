# Publish History - Release Health Analyst Scope And Behavior

## Summary

| Field | Value |
|---|---|
| Date | 2026-07-01 |
| Space | ROVO |
| Studio writes | None |
| Jira writes | None |
| Approval | Explicit human go-ahead after focused dry-run |

Published the per-team scope knowledge source and the vNext behavior-rules knowledge source, and updated the thinned Studio configuration and its prompt library, so the live knowledge sources match the repo and no references dangle.

## Published Pages

| Page | Page ID | Parent | Action | Version After |
|---|---|---|---|---|
| Template - Release Scope Definition | `5451743262` | `5281218643` (Release and Change Agents) | create | `1` |
| Release Health Analyst Assessment Behavior Rules | `5450924071` | `5288362010` (Release Health Analyst Project Brain) | create | `1` |
| Rovo Studio Configuration - Release Health Analyst | `5289476102` | `5288362010` (Release Health Analyst Project Brain) | update | `10` |
| Prompt Library - Release Health Analyst Assessment Pages | `5334073374` | `5288362010` (Release Health Analyst Project Brain) | update | `7` |

## Validation

- Focused dry-run (no `-Apply`) targeted exactly the four pages before publishing.
- Set `parentPageId` for the two new pages in the local manifest so they would not land at the space root: `5281218643` for the scope template, `5288362010` for the behavior rules.
- Second dry-run confirmed both new pages resolved to their intended parents and both existing pages resolved by title to update in place.
- Apply created the two new pages and updated the two existing pages.
- Post-apply readback by page ID confirmed: scope template parent `5281218643`; behavior rules parent `5288362010`; both existing pages remain under `5288362010`; all four `status=current`.
- New-page CQL title search lagged the create (search index delay); direct page-ID readback was used to verify placement.
- No Studio changes were made; Studio still requires a manual update from the thinned configuration page.
- No Jira tickets were read or written during publishing.

## Publish Command

```powershell
.\scripts\Publish-ConfluencePages.ps1 `
  -Slug release-scope-definition-template,release-health-analyst-assessment-behavior-rules,release-health-analyst-rovo-studio-configuration,release-health-analyst-assessment-prompts `
  -UpdateExisting -Apply
```

## Manual Studio Follow-Up

- Update the vNext Release Health Analyst parent instructions from `Rovo Studio Configuration - Release Health Analyst`.
- Add `Release Scope Definition` (this team) and `Release Health Analyst Assessment Behavior Rules` as named knowledge sources.
- Confirm the scope instruction uses the team's declared `fixVersion`-only query with no added project filter.
- Run the comment-over-status, calibration, and scope smoke prompts from `agent-portfolio-lab/test-runs/004-vnext-behavior-calibration/findings.md`.
