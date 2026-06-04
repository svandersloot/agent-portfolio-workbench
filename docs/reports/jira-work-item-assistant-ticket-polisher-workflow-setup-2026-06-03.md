# Jira Work Item Assistant To Jira Ticket Polisher Workflow Setup - 2026-06-03

## Purpose

Start a governed handoff workflow where a user begins in a Jira Work Item Assistant conversation with Kanban board context, asks for a Jira ticket, and receives a Jira Ticket Polisher-reviewed draft before any Jira work item is created.

This setup intentionally keeps Jira writes human-approved. Jira Ticket Polisher remains the quality gate and draft improver, not the autonomous creator.

## Platform Findings

Atlassian documentation supports invoking Rovo agents from automation flows and passing the response to later steps with `{{agentResponse}}`.

Relevant constraints:

- `Use Rovo agent` invokes a selected agent in an automation flow and exposes the response through `{{agentResponse}}`.
- Rovo agent automation responses can be referenced as markdown, ADF, plain string, object, or list variants such as `{{agentResponse.asObject}}`.
- Atlassian's Rovo agent skills documentation says an agent triggered in an automation flow cannot use its own skills and only provides a text response for the automation to use.
- `Use Rovo` is different from `Use Rovo agent`; use the agent action for Jira Ticket Polisher because the workflow needs the governed agent's standards and behavior.

Sources reviewed:

- https://support.atlassian.com/rovo/docs/agents-in-automations/
- https://support.atlassian.com/cloud-automation/docs/automation-smart-values-rovo-agents/
- https://support.atlassian.com/rovo/docs/agent-actions/
- https://support.atlassian.com/studio/docs/what-is-the-use-rovo-action/

## Operating Decision

Use a staged handoff, not a hidden cross-agent write:

```text
User conversation with Jira Work Item Assistant in Kanban context
-> Jira Work Item Assistant produces a Jira Work Item Draft Bundle
-> Jira Ticket Polisher reviews and rewrites the draft bundle
-> Jira Work Item Assistant presents the polished draft and asks for approval
-> Human approves or asks for changes
-> A separate governed Jira create step may run only after approval
```

Contract:

```text
schemas/jira-work-item-draft-bundle.schema.json
```

## MVP: Conversation-First Handoff

Use this first because it matches the current user behavior: the work starts as a live conversation with Jira Work Item Assistant while viewing or discussing the Kanban board.

### Jira Work Item Assistant Behavior Patch

Add this behavior to Jira Work Item Assistant's instructions or a release-ticket subagent:

```text
When the user asks you to create, draft, split, or prepare Jira tickets from release or Kanban context, do not create Jira immediately.

First produce a Jira Work Item Draft Bundle that follows the Jira Work Item Draft Bundle contract. Include the visible Kanban context, work context, requested outcome, candidate ticket drafts, source evidence, open questions, and approval state.

Set approval.humanApprovalRequired to true and approval.approvedForJiraWrite to false.

Then ask the user whether to send the bundle to Jira Ticket Polisher for quality review before Jira creation.

If the user agrees, provide a copy-ready handoff prompt for Jira Ticket Polisher and include the full draft bundle.
```

### Jira Ticket Polisher Handoff Prompt

Use this prompt in Jira Ticket Polisher for the manual MVP:

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

### Jira Work Item Assistant Approval Prompt

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

## Semi-Automated Handoff

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

Run one manual MVP test from an existing Jira Work Item Assistant conversation:

1. Ask Jira Work Item Assistant for a ticket draft from Kanban context.
2. Tell it to output the Jira Work Item Draft Bundle.
3. Paste the bundle into Jira Ticket Polisher with the handoff prompt above.
4. Bring the polished result back to Jira Work Item Assistant.
5. Confirm whether the approval prompt and final draft feel natural.
