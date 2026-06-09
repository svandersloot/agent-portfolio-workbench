# Jira Ticket Polisher Retirement Handoff

Published retirement updates for Jira Ticket Polisher after Jira Work Item Assistant absorbed the active ticket review and polishing workflow.

## Decision

Jira Ticket Polisher is `Archived / Superseded by Jira Work Item Assistant`.

Use Jira Work Item Assistant for active Jira ticket drafting, existing-card review, polishing, standards alignment, gap checking, improved summary/description/acceptance criteria/validation notes, common-task guidance, and draft-only status comments.

Keep Jira Ticket Polisher pages visible as historical reference with a superseded notice. Do not hard-delete the pages and do not configure a separate active Jira Ticket Polisher in Studio unless a new governed decision reopens it.

## Local Page Updates

| Page | Source |
|---|---|
| Agent Inventory | `docs/confluence-pages/agent-inventory.md` |
| Jira Work Item Assistant Project Brain | `docs/confluence-pages/jira-work-item-assistant-project-brain.md` |
| Knowledge Source Plan - Jira Work Item Assistant | `docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md` |
| Subagent Settings - Jira Work Item Assistant | `docs/confluence-pages/jira-work-item-assistant-subagent-settings.md` |
| Studio Setup - Jira Work Item Assistant | `docs/confluence-pages/jira-work-item-assistant-studio-setup.md` |
| ROVO Studio Configuration - Jira Work Item Assistant | `docs/confluence-pages/jira-work-item-assistant-rovo-studio-configuration.md` |
| Evaluation - Jira Work Item Assistant | `docs/confluence-pages/jira-work-item-assistant-evaluation.md` |
| Measurement Plan - Jira Work Item Assistant | `docs/confluence-pages/jira-work-item-assistant-measurement-plan.md` |
| Change Log - Jira Work Item Assistant | `docs/confluence-pages/jira-work-item-assistant-change-log.md` |
| Jira Ticket Polisher Project Brain | `docs/confluence-pages/jira-ticket-polisher-project-brain.md` |
| Jira Ticket Polisher - Agent Design Record | `docs/confluence-pages/jira-ticket-polisher-agent-design-record.md` |
| Knowledge Source Plan - Jira Ticket Polisher | `docs/confluence-pages/jira-ticket-polisher-knowledge-source-plan.md` |
| Subagent Settings - Jira Ticket Polisher | `docs/confluence-pages/jira-ticket-polisher-subagent-settings.md` |
| ROVO Studio Configuration - Jira Ticket Polisher | `docs/confluence-pages/jira-ticket-polisher-rovo-studio-configuration.md` |
| Evaluation - Jira Ticket Polisher | `docs/confluence-pages/jira-ticket-polisher-evaluation.md` |
| Measurement Plan - Jira Ticket Polisher | `docs/confluence-pages/jira-ticket-polisher-measurement-plan.md` |
| Change Log - Jira Ticket Polisher | `docs/confluence-pages/jira-ticket-polisher-change-log.md` |
| Jira Ticket Polisher Standards - Active Set | `docs/confluence-pages/jira-ticket-polisher-team-standards-draft-overlays.md` |
| Team Jira Standards | `docs/confluence-pages/team-jira-standards.md` |
| Prompt Library - Team Jira Standards Discovery | `docs/confluence-pages/team-jira-standards-discovery-prompt-library.md` |

Local-only historical reports marked superseded:

- `docs/reports/jira-work-item-assistant-migration-discovery-2026-06-03.md`
- `docs/reports/jira-work-item-assistant-ticket-polisher-workflow-setup-2026-06-03.md`

## Evaluation Updates

Updated `docs/reports/jira-work-item-assistant-agent-studio-evaluation.csv` to cover:

- Existing-card review and gap checking.
- Organization-wide ticket polish with no team overlay.
- MOBRM/team-standard polish when MOBRM evidence is present.
- Improved summary, description, acceptance criteria, and validation notes.
- No raw JSON unless machine-readable JSON, packaging, or a Draft Bundle is explicitly requested.
- Explicit Draft Bundle packaging with approval set to false.
- No Jira create, update, transition, assignment, ranking, movement, or comments.

## Suggested Dry Run

Completed before publishing. The active local config covered 11 pages and planned only updates. A temporary config copied to `C:\tmp\confluence-pages-retirement-publish.yml` covered the 9 missing inventory/Polisher-family pages and also planned only updates.

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug agent-inventory,jira-work-item-assistant-project-brain,jira-work-item-assistant-knowledge-source-plan,jira-work-item-assistant-subagent-settings,jira-work-item-assistant-studio-setup,jira-work-item-assistant-rovo-studio-configuration,jira-work-item-assistant-evaluation,jira-work-item-assistant-measurement-plan,jira-work-item-assistant-change-log,jira-ticket-polisher-project-brain,jira-ticket-polisher-agent-design-record,jira-ticket-polisher-knowledge-source-plan,jira-ticket-polisher-subagent-settings,jira-ticket-polisher-rovo-studio-configuration,jira-ticket-polisher-evaluation,jira-ticket-polisher-measurement-plan,jira-ticket-polisher-change-log,jira-ticket-polisher-team-standards-draft-overlays,team-jira-standards,team-jira-standards-discovery-prompt-library -UpdateExisting
```

## Suggested Publish After Review

Applied on 2026-06-09.

Published from active local config:

| Page | Page ID | Published version |
|---|---:|---:|
| Jira Work Item Assistant Project Brain | 5348982785 | 3 |
| Knowledge Source Plan - Jira Work Item Assistant | 5348655107 | 11 |
| Subagent Settings - Jira Work Item Assistant | 5349081089 | 6 |
| Studio Setup - Jira Work Item Assistant | 5362614357 | 7 |
| ROVO Studio Configuration - Jira Work Item Assistant | 5349113857 | 14 |
| Evaluation - Jira Work Item Assistant | 5348524037 | 4 |
| Measurement Plan - Jira Work Item Assistant | 5348753410 | 2 |
| Change Log - Jira Work Item Assistant | 5349244929 | 9 |
| Team Jira Standards | 5327749169 | 4 |
| Prompt Library - Team Jira Standards Discovery | 5348458502 | 3 |
| Jira Ticket Polisher Standards - Active Set | 5329059879 | 6 |

Published from temp config:

| Page | Page ID | Published version |
|---|---:|---:|
| Agent Inventory | 5280334048 | 3 |
| Jira Ticket Polisher Project Brain | 5328240651 | 4 |
| Jira Ticket Polisher - Agent Design Record | 5327814698 | 3 |
| Knowledge Source Plan - Jira Ticket Polisher | 5327945775 | 4 |
| Subagent Settings - Jira Ticket Polisher | 5327913018 | 2 |
| ROVO Studio Configuration - Jira Ticket Polisher | 5329223705 | 3 |
| Evaluation - Jira Ticket Polisher | 5329551365 | 4 |
| Measurement Plan - Jira Ticket Polisher | 5329616919 | 2 |
| Change Log - Jira Ticket Polisher | 5328142371 | 5 |

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug agent-inventory,jira-work-item-assistant-project-brain,jira-work-item-assistant-knowledge-source-plan,jira-work-item-assistant-subagent-settings,jira-work-item-assistant-studio-setup,jira-work-item-assistant-rovo-studio-configuration,jira-work-item-assistant-evaluation,jira-work-item-assistant-measurement-plan,jira-work-item-assistant-change-log,jira-ticket-polisher-project-brain,jira-ticket-polisher-agent-design-record,jira-ticket-polisher-knowledge-source-plan,jira-ticket-polisher-subagent-settings,jira-ticket-polisher-rovo-studio-configuration,jira-ticket-polisher-evaluation,jira-ticket-polisher-measurement-plan,jira-ticket-polisher-change-log,jira-ticket-polisher-team-standards-draft-overlays,team-jira-standards,team-jira-standards-discovery-prompt-library -UpdateExisting -Apply
```

## Manual Studio Follow-Up

After Confluence review/publish, manually update Jira Work Item Assistant in ROVO Studio from the refreshed setup/configuration pages. Do not create or enable a separate active Jira Ticket Polisher. Keep Jira and Confluence write-capable actions disabled unless a separate governed write workflow is approved.
