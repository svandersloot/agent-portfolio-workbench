# Publish History - Team Jira Standards Discovery Prompt Library

Published a shared prompt library for discovering, drafting, and reviewing proposed team Jira standards.

## Published Pages

| Page | Page ID | Parent | Version After Operation |
|---|---|---|---|
| Prompt Library - Team Jira Standards Discovery | `5348458502` | `5348720642` | `1` |
| Jira Ticket Standards | `5348720642` | `5279908067` | `2` |

## Scope

- Added global prompts usable by Jira Work Item Assistant, Jira Ticket Polisher, and future Jira hygiene agents.
- Added a Team Standards Intake prompt.
- Added a Kanban Board Standards Discovery prompt for reviewing board/ticket samples without turning observed patterns into policy.
- Added a Proposed Standard Review prompt.
- Added a Global-Only Fallback Prompt.
- Added a Proposed Team Standard Page Template.

## Validation

- Pre-apply dry-run targeted exactly two pages: one create and one update.
- Apply created the prompt library under `Jira Ticket Standards`.
- Post-apply dry-run confirmed the prompt library exists at version `1`.
- Post-apply dry-run confirmed `Jira Ticket Standards` exists at version `2`.
- No ROVO Studio changes were made.
- No Jira tickets were created, updated, transitioned, assigned, ranked, moved, or commented on.

## Publish Command

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug team-jira-standards-discovery-prompt-library,jira-ticket-standards -UpdateExisting -Apply
```
