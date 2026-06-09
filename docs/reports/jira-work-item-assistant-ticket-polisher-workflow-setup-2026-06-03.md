# Jira Work Item Assistant To Jira Ticket Polisher Workflow Setup - 2026-06-03

> **Superseded note - 2026-06-09**
>
> This setup report is historical. Jira Ticket Polisher is now archived/superseded, and Jira Work Item Assistant owns active Ticket Review / Polish behavior internally. Do not implement this cross-agent handoff unless a new governed decision reopens Jira Ticket Polisher.

## Purpose

This report originally proposed a governed handoff workflow where a user begins in a Jira Work Item Assistant conversation with Kanban board context, asks for a Jira ticket, and receives a Jira Ticket Polisher-reviewed draft before any Jira work item is created. That cross-agent path is superseded by Jira Work Item Assistant's internal Ticket Review / Polish workflow.

The draft-only and human-approved Jira write stance remains valid. Jira Work Item Assistant is now the quality gate and draft improver for active work.

## Platform Findings

Atlassian documentation supports invoking Rovo agents from automation flows and passing the response to later steps with `{{agentResponse}}`.

Relevant constraints:

- `Use Rovo agent` invokes a selected agent in an automation flow and exposes the response through `{{agentResponse}}`.
- Rovo agent automation responses can be referenced as markdown, ADF, plain string, object, or list variants such as `{{agentResponse.asObject}}`.
- Atlassian's Rovo agent skills documentation says an agent triggered in an automation flow cannot use its own skills and only provides a text response for the automation to use.
- Historical finding: `Use Rovo` is different from `Use Rovo agent`. Do not use this finding to configure a Jira Ticket Polisher handoff unless a new governed decision reopens that agent.

Sources reviewed:

- https://support.atlassian.com/rovo/docs/agents-in-automations/
- https://support.atlassian.com/cloud-automation/docs/automation-smart-values-rovo-agents/
- https://support.atlassian.com/rovo/docs/agent-actions/
- https://support.atlassian.com/studio/docs/what-is-the-use-rovo-action/

## Historical Operating Decision

Use a staged handoff, not a hidden cross-agent write:

```text
User conversation with Jira Work Item Assistant in Kanban context
-> Jira Work Item Assistant produces a Jira Work Item Draft Bundle
-> Jira Ticket Polisher reviews and rewrites the draft bundle [superseded]
-> Jira Work Item Assistant presents the polished draft and asks for approval
-> Human approves or asks for changes
-> A separate governed Jira create step may run only after approval
```

Contract:

```text
schemas/jira-work-item-draft-bundle.schema.json
```

## Historical MVP: Conversation-First Handoff

Use this first because it matches the current user behavior: the work starts as a live conversation with Jira Work Item Assistant while viewing or discussing the Kanban board.

### Jira Work Item Assistant Behavior Patch

Add this behavior to Jira Work Item Assistant's instructions or a release-ticket subagent:

```text
When the user asks you to create, draft, split, or prepare Jira tickets from release or Kanban context, do not create Jira immediately.

First produce a Jira Work Item Draft Bundle that follows the Jira Work Item Draft Bundle contract. Include the visible Kanban context, work context, requested outcome, candidate ticket drafts, source evidence, open questions, and approval state.

Set approval.humanApprovalRequired to true and approval.approvedForJiraWrite to false.

Then run Ticket Review / Polish internally before Jira creation. Create or show a Draft Bundle only when the user explicitly asks for machine-readable JSON, packaging, or a Draft Bundle.

Do not provide a copy-ready handoff prompt for Jira Ticket Polisher in the active workflow. Use Jira Work Item Assistant Ticket Review / Polish instead.
```

### Historical Jira Ticket Polisher Handoff Prompt

This prompt is retained only as historical reference:

```text
Review this Jira Work Item Draft Bundle from Jira Work Item Assistant before Jira ticket creation.

Apply the Organization-Wide Jira Ticket Quality Standard and any approved team overlay that is clearly applicable from the project key, board, ticket key, or supplied standard.

Do not create, update, transition, assign, rank, comment on, or edit Jira.

Return:
- Standards used
- Bundle completeness check
- P0/P1 gaps that block confident Jira creation
- P2 improvements
- Polished Jira field drafts for each candidate ticket
- Open questions for the release owner or ticket owner
- A short approval summary Jira Work Item Assistant can show the user

Jira Work Item Draft Bundle:
[PASTE BUNDLE HERE]
```

### Historical Jira Work Item Assistant Approval Prompt

After Jira Ticket Polisher returns the reviewed draft, Jira Work Item Assistant should ask:

```text
Jira Ticket Polisher reviewed the draft. I have not created Jira yet.

Please review:
- Ticket summary
- Description
- Acceptance criteria
- Open questions
- Any P0/P1 gaps

Do you approve creating the Jira ticket from this polished draft, or should I revise it first?
```

If the user approves, Jira Work Item Assistant may proceed only if a separate governed Jira write path exists and the required Jira fields are known. If not, it should provide copy-ready fields for manual Jira creation.

## Historical Semi-Automated Handoff

Use this after the manual MVP produces one or two good examples.

Recommended shape:

```text
Manual trigger from handoff page
-> Use Rovo agent: Jira Ticket Polisher
-> Publish new draft review page from {{agentResponse}}
```

Trigger artifact:

- A Confluence draft page containing the Jira Work Item Draft Bundle.
- Label suggestion: `jira-ticket-polish-request`.
- Parent suggestion: a release planning or release coordination page, not the canonical Jira Ticket Polisher governance page.

Jira Ticket Polisher automation settings:

| Field | Value |
|---|---|
| Agent | Jira Ticket Polisher |
| Allow agent to execute actions | Disabled / false |
| Purpose | Return polished ticket draft and approval summary only |
| Input | Handoff page or triggering work item content |
| Output | `{{agentResponse}}` into a child page or review artifact |

Automation prompt:

```text
Review the Jira Work Item Draft Bundle in this automation context before Jira ticket creation.

Use Jira Ticket Polisher standards and behavior.

Do not create, update, transition, assign, rank, comment on, or edit Jira.
Do not approve release readiness or delivery commitment.
Return only review-ready polished ticket draft content for human approval.

Include:
- Standards used
- Bundle completeness check
- P0/P1 creation blockers
- P2 improvements
- Polished Jira field drafts
- Open questions
- Approval summary for Jira Work Item Assistant
```

Output destination:

- Prefer a draft child page or review artifact during pilot.
- Do not overwrite the original handoff bundle.
- Keep the automation audit log and output page for pilot evidence.

## Future Governed Jira Write Step

Only add Jira creation after the handoff is stable.

Required before enabling:

- Jira project, issue type, required fields, and board placement are confirmed.
- The automation can map polished fields deterministically.
- Human approval is captured in the conversation, page, form, or Jira manual trigger.
- The approval artifact names exactly which ticket drafts are approved.
- Jira Ticket Polisher remains draft-only unless its own governance is updated.

Suggested write shape after approval:

```text
Human-approved polished draft
-> Manual trigger: Create Jira ticket from approved draft
-> Create issue using deterministic field mappings
-> Record the created issue link in the approval artifact through the approved pilot process
```

## First Pilot Checklist

- [ ] Jira Work Item Assistant can produce a valid Jira Work Item Draft Bundle.
- [ ] The bundle includes work context, Kanban context, candidate ticket fields, source evidence, open questions, and approval set to false.
- [ ] Jira Ticket Polisher can review the bundle without direct Jira writes.
- [ ] The polished output is good enough for a human to approve or revise.
- [ ] Jira Work Item Assistant presents the polished draft and asks for explicit approval.
- [ ] No Jira issue is created until approval is captured.
- [ ] The pilot output and any automation audit result are saved without raw private exports.

## Known Open Questions

| Question | Why it matters |
|---|---|
| Can Jira Work Item Assistant create a Confluence handoff page with approval in the current Studio configuration? | Determines whether the semi-automated handoff can avoid manual copy/paste. |
| Which Kanban board/project is the first pilot target? | Required for project key, issue type, fields, labels, and board placement. |
| Should the first run create one ticket or split a release task into multiple tickets? | Affects bundle examples and validation. |
| Who approves the final Jira create action? | Needed before any write-capable automation. |
| Where should polished drafts live during pilot? | Keeps review artifacts findable without cluttering governance pages. |

## Recommended Next Step

Do not run the historical cross-agent MVP. For active validation, run one manual Ticket Review / Polish test from an existing Jira Work Item Assistant conversation:

1. Ask Jira Work Item Assistant to review or polish an existing Jira card or candidate ticket.
2. Confirm it returns human-readable standards findings, gaps, and copy-ready field improvements without raw JSON by default.
3. Ask explicitly for a Jira Work Item Draft Bundle and confirm the approval fields remain false.
4. Confirm no Jira issue is created, updated, transitioned, assigned, ranked, moved, or commented on.
