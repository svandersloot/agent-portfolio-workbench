# Publish History - Jira Ticket Standards Shared Tree

Moved Jira ticket standards into a shared Jira hygiene standards tree after user approval.

## Structure Created

| Page | Page ID | Parent | Version After Operation |
|---|---|---|---|
| Jira Ticket Standards | `5348720642` | `5279908067` | `1` |
| Organization-Wide Jira Ticket Quality Standard | `5328764970` | `5348720642` | `2` |
| Team Jira Standards | `5327749169` | `5348720642` | `3` |
| MOBRM Team Jira Standards | `5327847473` | `5327749169` | `5` |

## Related Page Updated

| Page | Page ID | Parent | Version After Operation |
|---|---|---|---|
| Jira Ticket Polisher Standards - Active Set | `5329059879` | `5328240651` | `5` |
| Knowledge Source Plan - Jira Work Item Assistant | `5348655107` | `5348982785` | `2` |

## Actions

- Created the new shared parent page `Jira Ticket Standards` under Jira Hygiene Agents (`5279908067`).
- Moved `Organization-Wide Jira Ticket Quality Standard` under `Jira Ticket Standards`.
- Moved `Team Jira Standards` under `Jira Ticket Standards`.
- Preserved `MOBRM Team Jira Standards` as a child of `Team Jira Standards`.
- Updated standards wording so the standards are shared by Jira Work Item Assistant, Jira Ticket Polisher, and future Jira hygiene agents rather than owned by Jira Ticket Polisher.
- Updated Jira Work Item Assistant knowledge source plan to reference the shared standards parent.

## Validation

- Post-operation dry-run confirmed all six affected configured pages as `exists`.
- Direct ancestor verification confirmed:
  - `Jira Ticket Standards` is under Jira Hygiene Agents.
  - Organization-wide and team standards are under `Jira Ticket Standards`.
  - MOBRM remains under `Team Jira Standards`.
- The move used the Confluence Cloud move endpoint with `append`, preserving existing page history.
- No ROVO Studio changes were made.
- No Jira tickets were created, updated, transitioned, assigned, ranked, moved, or commented on.

## Commands

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug jira-ticket-standards -Apply
```

```powershell
PUT /wiki/rest/api/content/5328764970/move/append/5348720642
PUT /wiki/rest/api/content/5327749169/move/append/5348720642
```

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug jira-ticket-quality-standard,team-jira-standards,mobrm-team-jira-standards,jira-ticket-polisher-team-standards-draft-overlays,jira-work-item-assistant-knowledge-source-plan -UpdateExisting -Apply
```
