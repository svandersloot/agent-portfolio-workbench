# Jira Ticket Standards

Use this page as the shared parent for Jira ticket standards used by Jira hygiene agents.

These standards are not owned by a single agent. Jira Work Item Assistant uses them when drafting tickets and status comment drafts. Jira Ticket Polisher uses them when reviewing and improving ticket quality. Future Jira hygiene agents should reference this standards tree instead of creating agent-specific copies.

## Current Standards

| Standard | Status | Applies To | Notes |
|---|---|---|---|
| Organization-Wide Jira Ticket Quality Standard | Draft shared baseline | All Jira ticket drafts and reviews when no team-specific overlay applies. | Default quality standard. |
| Team Jira Standards | Active index | Team-specific overlays that supplement the organization-wide standard. | Use as an index; cite the exact team page applied. |
| MOBRM Team Jira Standards | Published active overlay | Jira project key `MOBRM` or MOBRM board `7690`. | First pilot team overlay. |
| Prompt Library - Team Jira Standards Discovery | Draft prompt library | Teams that need to discover, draft, or review a proposed team standard. | Use for intake questions, board sampling, and proposed-standard reviews. |

## Use By Agents

| Agent | Use |
|---|---|
| Jira Work Item Assistant | Drafts source-backed Jira tickets, proposed team standards, status comment drafts, and bulk candidate sets using the org-wide standard plus applicable team overlay. |
| Jira Ticket Polisher | Reviews and improves ticket fields using the org-wide standard plus applicable team overlay. |
| Release Drift Monitor | May consume structured ticket comments and ticket evidence, but does not own ticket standards. |
| Release Health Analyst | May consume ticket readiness, blocker, validation, and status evidence, but does not own ticket standards. |

## Governance Rules

- Apply the organization-wide standard first.
- Apply a team overlay only when the project, board, filter, or supplied source clearly matches.
- Do not treat sampled tickets as standards unless a team owner approves them.
- Keep proposed team standards marked proposed until a human/team owner approves them.
- Move or update standards in this shared tree instead of copying standards under individual agent Project Brains.
