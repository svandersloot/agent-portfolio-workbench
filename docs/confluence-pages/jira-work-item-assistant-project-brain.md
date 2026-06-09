# Jira Work Item Assistant Project Brain

## Project Brain Status

| Field | Value |
|---|---|
| Agent name | Jira Work Item Assistant |
| Domain | Jira Work Management / Jira Hygiene |
| Lifecycle status | In Review |
| Readiness status | Needs Cleanup |
| Fit decision | New governed agent migration |
| Primary owner | TBD |
| Backup owner | TBD |
| Current source space | MO |
| Legacy source | MO folder `5090410548` supplied by user |
| Recommended location | ROVO > Agent Project Brains > Jira Hygiene Agents |
| Last reviewed | 2026-06-09 |
| Next action | Run the refreshed Ticket Review / Polish evaluation coverage, confirm MOBRM pilot details, define approved Jira create path, and keep Jira Ticket Polisher archived/superseded. |

## Migration Decision

Jira Work Item Assistant should be migrated as a governed agent in review.

The agent has a distinct coordination workflow: it starts from release, Kanban, existing Jira card, or user-provided task context; helps users shape and improve clear Jira tickets and repeatable task guidance; and asks for human approval before any Jira creation. It now owns the practical ticket-review and ticket-polishing workflow that previously sat under Jira Ticket Polisher.

This should remain a generic release-work assistant with team standards overlays, not a MOBRM-only agent. MOBRM is the first proof point because the team board and team standard are known. Creating one separate assistant per team would increase standards drift and governance overhead unless a team has a materially different workflow that cannot be represented as an overlay.

## Mission

Jira Work Item Assistant helps requesters, release owners, and delivery leads turn Kanban, release, existing-card, and common-task context into clear, source-backed Jira work items, ticket improvements, status comment drafts, and task guidance that humans and AI can understand, assess, and execute consistently.

## Scope

### In Scope

- Draft richer Jira tickets from release or Kanban context.
- Review and polish existing Jira cards using the Ticket Review / Polish workflow.
- Draft one ticket or multiple known candidate tickets in bulk.
- Apply the organization-wide Jira ticket quality standard when drafting work.
- Apply a documented team standard or overlay when the project, board, or user-provided context clearly identifies one.
- Draft proposed team Jira standards pages by asking about required fields, important fields, fields that are not required by default, issue types, board/project mapping, labels, parent expectations, and workflow conventions.
- Create beginner-readable common-task guidance inside or alongside candidate Jira tickets when the task is repeatable, script-driven, or explicitly meant to teach a common task.
- Identify missing context, source evidence, dependencies, validation needs, and owner decisions before work is created.
- Draft structured Jira status comments from user-provided progress, blockers, validation evidence, or recent changes so tickets stay readable for humans and downstream release agents.
- Prepare a structured Jira Work Item Draft Bundle only when the user explicitly asks for machine-readable JSON, a Draft Bundle, or packaging; do not use it as the default response for normal ticket drafting or polishing.
- Ask for explicit human approval before any Jira creation path; after approval, future Jira creation may be allowed through a separately governed write workflow.

### Out Of Scope

- Unapproved Jira creation, update, transition, assignment, ranking, sprint movement, or comment posting.
- Posting Jira comments during this migration slice; the agent may draft comment text for human review, but must not add it to Jira until a separately governed comment-write path is approved.
- Final release readiness or go/no-go decisions.
- Release notes drafting, publication, or synchronization.
- Release evidence drift detection.
- Deployment execution, change approval, rollback execution, or production operations.
- Inventing task steps, requirements, acceptance criteria, or validation evidence.
- Treating sampled ticket patterns as official standards without documented owner approval.
- Publishing proposed team standards as official without human/team owner review.

## Related Agents And Patterns

| Related item | Relationship |
|---|---|
| Jira Ticket Polisher | Archived / superseded historical record. Jira Work Item Assistant now owns active ticket review, polish, standards alignment, gap checking, and improved copy drafts. |
| Release Notes Manager | Owns release notes, business summaries, deployment runbooks, and source synchronization for release-note artifacts. |
| Release Health Analyst | Owns release readiness assessment, blockers, risks, and source completeness. |
| Release Drift Monitor | Owns pre-freeze evidence drift detection and handoff history. |
| Jira Work Item Draft Bundle | Contract for explicit machine-readable packaging of candidate Jira work items before human-approved creation. |
| Team Jira Standards | Team overlay structure this assistant can help draft but not approve. |

## Pilot Scope

| Field | Decision |
|---|---|
| Initial pilot | MOBRM first, broader multi-team design later. |
| Pilot board/project | `https://csaaig.atlassian.net/jira/software/c/projects/MOBRM` |
| Standards | Organization-wide Jira ticket standard plus MOBRM Team Jira Standards. |
| MOBRM required fields | Parent and labels are the first required/important fields. |
| Not required for MOBRM pilot | fixVersion, component, priority, and sprint. |
| Approval | Human requester/reviewer approves before Jira creation. |
| Bulk behavior | Supported for multiple known tickets, with a human approval summary before creation. |
| Status comments | Supported as draft-only comments using a lightweight status comment standard. |
| Bulk status comments | Supported as a named draft comment set, with approval required per target issue or named set before any future posting path. |
| Common-task examples | SER updates, parse break updates, producer org updates, prod sync updates. |
| Legacy documentation | Build from scratch; old Release Management Assistant documentation can be archived or superseded unless useful source content is explicitly brought forward. |

## Required Linked Artifacts

| Artifact | Page |
|---|---|
| Agent Design Record | Jira Work Item Assistant - Agent Design Record |
| Knowledge Source Plan | Knowledge Source Plan - Jira Work Item Assistant |
| Subagent Settings | Subagent Settings - Jira Work Item Assistant |
| Studio Setup | Studio Setup - Jira Work Item Assistant |
| ROVO Studio Configuration | ROVO Studio Configuration - Jira Work Item Assistant |
| Evaluation | Evaluation - Jira Work Item Assistant |
| Measurement Plan | Measurement Plan - Jira Work Item Assistant |
| Change Log | Change Log - Jira Work Item Assistant |
| Migration discovery report | Jira Work Item Assistant Migration Discovery |

## Operating Model

1. User starts from a Jira Work Item Assistant conversation, often with Kanban or release context.
2. Agent confirms the intended outcome, target project or board, release context, and whether the user wants one ticket or multiple candidate tickets.
3. Agent applies the organization-wide Jira ticket standard and applicable documented team standard.
4. Agent drafts rich ticket fields with source-backed summary, description, acceptance criteria, validation, dependencies, and open questions.
5. Agent includes `How to perform this task` only when the task is repeatable, script-driven, or requested as common-task guidance.
6. Agent flags missing evidence and asks clarifying questions instead of inventing details.
7. If the user provides a status update for an existing ticket, the agent drafts a concise source-backed Jira comment with status, completed work, blockers, validation evidence, and next action.
8. If the user provides updates for multiple tickets, the agent drafts a named bulk status comment set with target issue, comment type, evidence, and approval state for each item.
9. Agent runs Ticket Review / Polish internally for complex, risky, standards-sensitive, or existing-card requests using the existing five subagents.
10. Agent presents the final candidate draft, comment draft, bulk-create summary, or named bulk comment set to the user for explicit approval.
11. Approved Jira creation can run only through a governed write workflow.
12. If a team standard is missing, the agent may draft a proposed team standards page for owner review instead of applying it as official policy.

## Status Comment Standard

Status comment drafts should use this lightweight structure when the available evidence supports it:

| Section | Use |
|---|---|
| Completed | Work the user explicitly says is done. |
| Current status | Present state such as in progress, blocked, waiting, validated, or ready for review. |
| Validation | Test, QA, lower-environment, screenshot, query, log, or reviewer evidence supplied by the user or source. |
| Blockers / risks | Anything preventing completion, release confidence, owner signoff, or downstream validation. |
| Next action | The next concrete action and owner when known. |
| Evidence links | Jira, Confluence, Bitbucket, runbook, or other source links supplied or visible. |
| Open questions | Missing details that should be resolved before a final update or future comment posting path. |

## Source Precedence

| Priority | Source | Use |
|---|---|---|
| 1 | Visible Kanban board, selected Jira issue, release plan, or user-provided context | Current work context and user intent. |
| 2 | Organization-Wide Jira Ticket Quality Standard | Default ticket drafting baseline. |
| 3 | Approved team Jira standard | Team-specific overlay when project, board, or supplied standard clearly matches. |
| 4 | Jira Work Item Assistant legacy source content | Existing workflow behavior after authenticated capture and review. |
| 5 | Ticket Review / Polish workflow output | Internal Work Item Assistant review that combines gap checking, standards resolution, field drafting, task guidance, and status comment drafting. |
| 6 | Observed sample tickets | Pattern evidence only; not official policy. |

## Guardrails

- Do not create Jira without explicit human approval and a governed write path.
- Do not transition, assign, rank, move, or comment on Jira issues during this migration slice.
- Draft Jira comments only from supplied or visible evidence; do not imply work was completed, validated, blocked, or owner-approved unless the user or source explicitly says so.
- Do not make final release readiness decisions; route those to Release Health Analyst.
- Do not draft or publish final release notes; route those to Release Notes Manager.
- Do not invent task steps, requirements, data needs, owners, dependencies, or acceptance criteria.
- Do not apply a team standard unless it is documented, supplied, or explicitly approved for the request.
- Do not treat a proposed team standards page as official until a human/team owner approves it.
- Mark missing or inaccessible evidence as `Data Incomplete`.
- Keep task guidance beginner-readable when the user asks for common-task training value.

## Known Gaps

| Gap | Impact | Remediation |
|---|---|---|
| Legacy MO folder content not captured in this pass. | Existing instructions, templates, and source links may be missing. | Use authenticated Chrome, Confluence export, or pasted content to capture the folder. |
| Legacy documentation retirement path is not applied. | Old MO content may confuse builders if both versions remain active. | Archive or mark old Release Management Assistant documentation as superseded after review. |
| Primary and backup owners are TBD. | Cannot promote beyond In Review. | Assign accountable owner and backup owner. |
| Pilot issue types and field mappings are not fully confirmed. | Jira create behavior may fail or create incomplete work. | Confirm issue types and create-field mapping for MOBRM parent and labels. |
| Jira write path is not defined. | Automation risk cannot be assessed. | Define explicit human approval capture, required fields, and Jira create action behavior. |
| Jira comment write path is not defined. | Agent can draft useful status comments but cannot safely post them. | Define approval capture, comment template, target issue confirmation, and audit behavior before enabling comment posting. |
| Common task templates are not captured. | Agent may produce generic tickets instead of reusable work guidance. | Capture SER, parse break, producer org, and prod sync task evidence. |
| Team standards builder questions need final review. | Future teams may provide incomplete overlays. | Validate the proposed standards-page intake questions during the MOBRM pilot. |
| Studio configuration has not been manually applied or captured. | Runtime behavior cannot be validated. | Copy Studio blocks manually after owner review, then run evaluation prompts. |

## Launch Decision

Current decision: keep in review.

The agent is ready for migration review and source capture. It is not ready for broad Studio launch or Jira write capability until legacy content, ownership, source standards, first pilot scope, evaluation evidence, and approval flow are confirmed.
