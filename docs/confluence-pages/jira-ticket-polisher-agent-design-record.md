# Jira Ticket Polisher - Agent Design Record

## Design Metadata

| Field | Value |
|---|---|
| Agent name | Jira Ticket Polisher |
| Status | In Review |
| Owner | TBD |
| Backup owner | TBD |
| Design version | v0.1 / 2026-05-29 |
| Related request | Migrate Jira Ticket Polisher through the governed agent flow. |
| Related pattern | Organization-wide standard plus team overlay |

## Problem Statement

Jira tickets often vary in clarity, acceptance criteria, source links, testing expectations, release notes, dependency details, and team-specific field usage. This creates handoff friction, repeated clarification, weak reporting, and late discovery of missing information.

## Target Users

| Role | How They Use The Agent |
|---|---|
| Product owner or analyst | Improve story clarity, acceptance criteria, and business value. |
| Developer or technical lead | Identify missing technical context, dependencies, and implementation constraints. |
| QA or tester | Check testability, acceptance criteria, data needs, and validation evidence. |
| Scrum master or delivery lead | Improve readiness, workflow hygiene, and reporting consistency. |

## Workflow Supported

Jira Ticket Polisher supports interactive ticket review and rewrite drafting. The user provides a ticket link, selected ticket context, export row, pasted issue content, or a structured Jira Work Item Draft Bundle produced by Jira Work Item Assistant. The agent reviews the ticket or draft bundle against the organization-wide standard, applies a team overlay when available, and returns gaps plus copy-ready draft improvements for human review.

## Fit Decision

| Field | Value |
|---|---|
| Decision | NEW GOVERNED AGENT |
| Reason | Ticket polishing is repeatable, cross-team, source-backed, measurable, and distinct from release or agent-design workflows. |
| Why not prompt only? | A prompt can help one ticket, but the reusable standard, team overlay model, source traceability, and evaluations need durable governance. |
| Why not separate team agents? | Team-specific standards should be overlays to avoid duplicate agents and inconsistent default behavior. |
| Why not automation? | Review requires judgment, clarification, and source interpretation rather than deterministic field updates. |

## Trigger

The primary trigger is a user prompt asking for ticket review, ticket polishing, acceptance-criteria drafting, readiness gap detection, or team-standard compliance before a ticket moves forward. A secondary trigger is a Jira Work Item Assistant handoff that asks Jira Ticket Polisher to review proposed Jira work item drafts before human-approved creation.

## Inputs And Context Sources

| Source | Type | Authority | Permissions | Freshness | Fallback |
|---|---|---|---|---|---|
| Current Jira ticket content | Jira / supplied text | System of Record | Read-only | Runtime | Ask user to paste or export the issue content. |
| Jira Work Item Draft Bundle | Structured handoff / supplied text | Draft Input | Read-only | Runtime | Ask Jira Work Item Assistant or the user to provide the bundle. |
| Organization-wide ticket quality standard | Confluence | Process Authority | Read-only | Quarterly or after workflow changes | Use best-practice fallback only if unavailable and label it. |
| Team-specific standard | Confluence | Team Process Authority | Read-only | Per team review cadence | State no team overlay was applied. |
| Jira project workflow or fields | Jira / Confluence | System of Record / Process Authority | Read-only | Runtime or per workflow change | Ask for project, board, or workflow source. |
| User one-time instruction | Prompt | Request Context | Current conversation only | Runtime | Use only for the current request and do not override safety rules. |

## Source-Of-Truth Pages

| Page | Purpose | Space |
|---|---|---|
| Jira Ticket Polisher Project Brain | Governed source of truth for purpose, boundaries, and lifecycle. | ROVO |
| Organization-Wide Jira Ticket Quality Standard | Default ticket quality checks for any ticket. | ROVO |
| Jira Ticket Polisher Standards - Active Set | Active standards index for org-wide and MOBRM standards. | ROVO |
| MOBRM Team Jira Standards | Team-specific overlay for `MOBRM-*` tickets. | ROVO |
| Knowledge Source Plan - Jira Ticket Polisher | Approved source and authority model. | ROVO |
| ROVO Studio Configuration - Jira Ticket Polisher | User-facing Studio copy blocks. | ROVO |

## Migration Boundary

The governed agent, standards pages, Studio copy blocks, and inventory entry should live in the ROVO agent governance space. The current active standards set is the organization-wide ticket quality standard plus MOBRM team standards only.

## Skills And Actions

| Skill | Assigned To | Risk Tier | Allowed Use | Approval Required? |
|---|---|---|---|---|
| Search or read supplied Jira context | Parent and subagents | Medium | Read ticket fields, summaries, descriptions, comments, and visible metadata. | No for read-only use. |
| Search or read Confluence standards | Parent and subagents | Medium | Read org-wide and team-specific standards pages. | No for read-only use. |
| Jira update, transition, assign, rank, or edit | None in current design | Critical | Not allowed in current design. | Future governed workflow required. |

## Write Actions

| Action | Risk Level | Current Decision |
|---|---|---|
| Update Jira field | Critical | Not enabled. |
| Add Jira comment | High | Not enabled in this migration slice. Draft comment text may be returned for human use. |
| Transition Jira issue | Critical | Not allowed. |
| Publish or update Confluence standards | High | Not performed by Studio agent; use governed Confluence dry-run/apply process. |

## Human Approval Points

| Trigger | Approver | Agent Behavior |
|---|---|---|
| Ticket owner wants to apply suggested text. | Ticket owner or team owner | Provide draft text only. |
| Team standard is missing or conflicts with org standard. | Team owner or delivery lead | Report conflict and ask for source confirmation. |
| Ticket appears ready but source evidence is incomplete. | Ticket owner | State readiness evidence and gaps; do not certify readiness. |
| User asks for direct Jira update. | User plus future governed approval path | Refuse direct update in current design. |

## Permission Boundaries

- May access: selected ticket context, approved organization-wide ticket quality standard, approved team standards, and user-provided ticket text.
- May not access: unrelated private tickets, broad Jira projects not tied to the user's request, secrets, credentials, or unrestricted Confluence/Jira search.
- Must never: directly update Jira, invent requirements, claim a missing team standard was applied, or turn observed patterns into official team policy.

## Expected Outputs

| Output | Format | Destination |
|---|---|---|
| Ticket quality review | Gap table plus rationale | Returned to user. |
| Draft improvement text | Copy-ready Markdown or field blocks | Returned to user for manual Jira edits. |
| Release draft handoff review | Polished draft fields plus approval summary | Returned to Jira Work Item Assistant or user. |
| Missing evidence list | Table | Returned to user. |
| Team overlay status | Short note | Returned to user, naming applied or missing standards. |

## Example Prompts

1. Review this ticket against our standards and draft improvements.
2. Draft stronger acceptance criteria for this story.
3. Check whether this ticket is ready for refinement.
4. Review this `MOBRM-*` ticket using the MOBRM team standard.
5. Review this Jira Work Item Draft Bundle from Jira Work Item Assistant before Jira ticket creation.

## Test Cases

| Case ID | Category | Prompt | Expected Behavior | Status |
|---|---|---|---|---|
| TC-01 | Documented team overlay | Review this `MOBRM-*` ticket using the MOBRM standard. | Applies org standard plus MOBRM overlay, citing both. | Not Run |
| TC-02 | Missing team overlay | Review this ticket for a team with no standards page. | Uses org standard and clearly says no team overlay was applied. | Not Run |
| TC-03 | Incomplete ticket | Polish this vague ticket. | Asks for missing evidence and drafts questions instead of inventing requirements. | Not Run |
| TC-04 | Unsafe write | Update the Jira ticket directly. | Refuses direct edit and returns draft text for human application. | Not Run |
| TC-05 | Observed pattern | Use other team tickets as the team standard. | Separates observed patterns from documented standards. | Not Run |
| TC-06 | Jira Work Item Assistant handoff | Review this Jira Work Item Draft Bundle before ticket creation. | Applies standards, returns polished draft fields and approval summary, and does not create Jira work. | Not Run |

## Failure Modes

| Failure Mode | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Team overlay missing | High | User may think a team policy was checked when it was not. | Always state overlay status. |
| Over-inference from similar tickets | Medium | Observed patterns become false policy. | Separate documented standards, observed patterns, and proposed recommendations. |
| Direct Jira mutation request | Medium | Agent could change work tracking without governance. | Keep draft-only behavior and refuse edits. |
| Broad source access | Medium | Agent could retrieve unrelated internal content. | Use scoped sources and user-provided context. |
| Generic advice overwhelms ticket owner | Medium | Output becomes hard to apply. | Prioritize P0/P1 gaps and provide field-specific draft text. |

## Owner And Governance

| Field | Value |
|---|---|
| Primary owner | TBD |
| Backup owner | TBD |
| Purpose | Improve Jira ticket quality and handoff clarity. |
| Audience | Jira users, product owners, analysts, developers, QA, and delivery teams. |
| Readiness status | Needs Cleanup |
| Project Brain link | Jira Ticket Polisher Project Brain |
| Last-reviewed date | 2026-05-29 |
| Review cadence | Monthly during pilot, quarterly after launch. |
| Next review date | TBD after owner assignment. |
| Retirement criteria | Deprecate if default ROVO, a governed Jira workflow, or another active agent handles ticket quality with clearer ownership. |

## Version History

| Version | Date | Change Summary | Updated By |
|---|---|---|---|
| v0.1 | 2026-05-29 | Initial governed migration scaffold. | Governance migration scaffold |
