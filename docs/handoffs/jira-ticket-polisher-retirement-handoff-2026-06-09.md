# Handoff - Jira Ticket Polisher Retirement

## Context

Jira Work Item Assistant now covers the practical Jira Ticket Polisher service area: drafting Jira work items, reviewing existing cards, applying organization-wide and team standards, identifying gaps, improving summaries/descriptions/acceptance criteria/validation notes, and keeping Jira writes draft-only and approval-first.

Keeping Jira Ticket Polisher as a separate user-facing agent creates duplicate service area confusion. Jira Work Item Assistant already has five subagents, and Atlassian guidance says not to exceed five subagents, so the retirement path should fold polishing behavior into the existing five-subagent model rather than adding another subagent.

## Recommended Decisions

| Question | Recommendation | Rationale |
|---|---|---|
| Fully retire Jira Ticket Polisher, or mark it archived/superseded? | Mark it `Archived / Superseded by Jira Work Item Assistant`, not hard-delete it. | Preserves governance history, source provenance, evaluation notes, and rollback context while removing it from active user-facing guidance. |
| Keep old Jira Ticket Polisher pages visible or move them? | Keep pages visible with a clear superseded banner, and move/link them under archive or historical reference if the space structure supports it. | Prevents broken links and makes the retirement discoverable. Users immediately see the replacement path. |
| Add a formal "review mode" phrase inside Jira Work Item Assistant? | Yes, define "Ticket Review / Polish" as a named workflow, not a new subagent. | Gives users and evaluators a stable term for reviewing existing cards while preserving the five-subagent limit. |

## Target Operating Model

Jira Work Item Assistant becomes the single user-facing agent for Jira ticket drafting, critique, polishing, standards alignment, gap checking, and copy-ready comment drafting.

Map the retired Jira Ticket Polisher behavior into existing Jira Work Item Assistant subagents:

| Retired Polisher Capability | Jira Work Item Assistant Home |
|---|---|
| Review an existing ticket for gaps | Work Item Gap Checker |
| Apply organization-wide or team standards | Team Standards Resolver/Drafter |
| Rewrite summary, description, acceptance criteria, and validation notes | Work Item Drafter |
| Improve repeatable task instructions | Common Task Guide Builder |
| Draft better status/update comments | Status Comment Drafter |

Do not add a sixth subagent.

## Proposed Jira Story

### Summary

Retire Jira Ticket Polisher and fold ticket-polishing workflows into Jira Work Item Assistant

### Description

Jira Ticket Polisher overlaps with Jira Work Item Assistant's current scope. Jira Work Item Assistant can already draft, review, critique, improve, and standards-check Jira work items using organization-wide and team standards. Retire Jira Ticket Polisher as a standalone user-facing agent and absorb its useful review behavior into Jira Work Item Assistant workflows without adding any subagents.

Users should use Jira Work Item Assistant for Jira ticket drafting, review, polishing, standards alignment, gap checking, and comment drafting. Jira Ticket Polisher should be marked archived/superseded and should no longer be presented as a separate active service area.

### Scope

- Mark Jira Ticket Polisher as archived/superseded in agent inventory and governance docs.
- Add a clear superseded banner to Jira Ticket Polisher pages, pointing users to Jira Work Item Assistant.
- Update Jira Work Item Assistant setup/configuration docs to explicitly include reviewing and improving existing Jira cards.
- Replace "package this for Jira Ticket Polisher review" language with internal Jira Work Item Assistant review/polish workflow language.
- Fold useful Jira Ticket Polisher review criteria into Jira Work Item Assistant guidance.
- Keep Jira Work Item Assistant at five subagents.
- Update evaluation coverage for existing-ticket review and polishing workflows.
- Publish the relevant Confluence pages after review.
- Leave live Studio updates manual unless separately approved.

### Out Of Scope

- Adding a sixth Jira Work Item Assistant subagent.
- Enabling Jira create, update, transition, assignment, ranking, or comment actions.
- Deleting historical Jira Ticket Polisher source pages.
- Broad redesign of unrelated agents.
- GitHub issue or PR tracking.

### Acceptance Criteria

- Jira Ticket Polisher is clearly marked `Archived / Superseded by Jira Work Item Assistant` in inventory/governance docs.
- Jira Ticket Polisher pages include a visible superseded notice and replacement path.
- Jira Work Item Assistant docs state that it handles ticket critique, polishing, standards review, and improved copy drafts.
- No active Jira Work Item Assistant instruction routes ordinary polish/review requests to Jira Ticket Polisher.
- Existing five-subagent structure remains unchanged.
- Evaluation prompts cover existing-ticket review, org-wide polish, MOBRM/team-standard polish, improved summary/description/acceptance criteria/validation notes, no raw JSON unless explicitly requested, and no Jira updates.
- Confluence pages are published or queued for publishing with the exact page list documented.
- Manual Studio update instructions are clear after docs are published.

## Suggested Implementation Steps

1. Audit Jira Ticket Polisher docs for reusable standards, review criteria, and evaluation language.
2. Update agent inventory and Jira Ticket Polisher governance status.
3. Add superseded banners to Jira Ticket Polisher pages.
4. Update Jira Work Item Assistant setup/configuration pages with the Ticket Review / Polish workflow.
5. Remove or replace Jira Ticket Polisher handoff language from Jira Work Item Assistant.
6. Update evaluation dataset and expected behaviors.
7. Run local Markdown/CSV validation where practical.
8. Publish targeted Confluence pages after dry-run review.
9. Manually update live ROVO Studio instructions from the refreshed setup page.
10. Run focused regression tests.

## Slash Goal

```text
/goal Retire Jira Ticket Polisher as a duplicate user-facing service area and fold its useful ticket review/polishing behavior into Jira Work Item Assistant without adding a sixth subagent. Use docs/handoffs/jira-ticket-polisher-retirement-handoff-2026-06-09.md as the source handoff. Mark Jira Ticket Polisher as Archived / Superseded by Jira Work Item Assistant, preserve historical pages with clear superseded banners, update Jira Work Item Assistant setup/configuration so "Ticket Review / Polish" is an in-scope workflow handled by the existing five subagents, remove ordinary routing/handoff language to Jira Ticket Polisher, update evaluation coverage for existing-card review and polishing, validate changed Markdown/CSV where practical, and prepare targeted Confluence publish steps. Do not enable Jira writes, do not add subagents, do not delete historical docs, do not create GitHub tracking, and do not update live ROVO Studio directly unless explicitly approved.
```
