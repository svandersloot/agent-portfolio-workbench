# Knowledge Source Plan - Jira Ticket Polisher

## Source Strategy

Jira Ticket Polisher uses a default organization-wide standard plus one active team overlay for the current pilot: MOBRM. It should prefer exact ticket context and approved standards. It must label missing or inaccessible standards rather than pretending a team policy was checked.

## Authority Labels

| Label | Meaning |
|---|---|
| System of Record | Jira ticket field, workflow, or project context for the current issue. |
| Process Authority | Approved organization-wide or team-specific standard. |
| Team Overlay | Team-specific standard that supplements the org-wide standard. |
| Observed Pattern | Pattern found in sampled tickets; useful evidence but not official policy. |
| Proposed Standard | Recommendation for review by a team or working group. |
| Fallback Guidance | Best-practice suggestion used only when approved standards are missing. |

## Approved Source Map

| Source | Type | Authority | Allowed Use | Freshness | Fallback |
|---|---|---|---|---|---|
| Current ticket content | Jira / supplied text | System of Record | Review visible fields and draft improvements. | Runtime | Ask user to paste summary, description, acceptance criteria, and key metadata. |
| Organization-Wide Jira Ticket Quality Standard | Confluence | Process Authority | Default standard for every review. | Quarterly or after workflow changes | Use labeled fallback guidance and report the missing standard. |
| Jira Ticket Polisher Standards - Active Set | Confluence | Active Standards Index | Identify the organization-wide standard and active MOBRM overlay. | Per team review | State no approved team overlay was applied. |
| MOBRM Team Jira Standards | Confluence | Team Overlay | Apply to `MOBRM-*` tickets and MOBRM board `7690` context after ROVO publish or when supplied. | Annual or after team workflow changes | Use org-wide standard only and state no team overlay was applied. |
| Jira project, board, filter, or workflow | Jira | System of Record / Process Authority | Check issue type, status, fields, and workflow expectations. | Runtime or workflow change | Ask for project key, board, filter, or pasted export. |
| Sample tickets | Jira / export | Observed Pattern | Identify patterns and gaps; never treat as policy alone. | Per research sample | Use only as proposed standard evidence. |

## Active Team Scope

| Team or board | Intended evidence | Current status |
|---|---|---|
| MOBRM | Team standard page, project key `MOBRM`, board `7690`, owner Shane Vandersloot, backup Harish. | Draft migrated locally; ROVO publish review pending. |

Other team standards are intentionally out of scope for the current active page. Add them only after a team-owned source, mapping metadata, owner, and application boundaries are confirmed.

## Required Input Check

Before producing a final-seeming ticket review, the agent should identify:

- Ticket key, project, issue type, and visible status when available.
- Summary, description, acceptance criteria, and any test or QA notes.
- Team or board name if a team overlay is requested.
- Whether an approved team standard was found or supplied.
- Any missing fields that prevent a confident review.
- Whether the user wants review-only feedback or draft replacement text.

## Source Handling Rules

- Apply the organization-wide standard to every ticket review.
- Apply the MOBRM overlay when the ticket key or project key is `MOBRM`, or when MOBRM board `7690` is visible.
- Apply other team overlay standards only when the user explicitly supplies an approved standard for that request.
- Name the standard sources used in the response.
- Keep documented standards, observed ticket patterns, and proposed standards separate.
- Use `No team overlay applied` when team standards are unavailable.
- Do not let related release or epic keys such as `MR26`, `M26`, or `CLE` trigger the MOBRM overlay by themselves.
- Use `Evidence missing` when ticket fields or source links are inaccessible.
- Do not search broad Jira or broad Confluence unless the user explicitly provides that scope and it is justified.
- Do not use private sample ticket details in published reports.

## Data Incomplete Flags

| Flag ID | Missing or incomplete data | Impact | How to clear |
|---|---|---|---|
| JTP-DI-001 | Ticket content is missing or partial. | Agent cannot review fields confidently. | Provide ticket link, selected context, export row, or pasted fields. |
| JTP-DI-002 | Issue type is unknown. | Issue-type-specific checks may be wrong. | Provide issue type or project workflow context. |
| JTP-DI-003 | Organization-wide standard is inaccessible. | Default standard cannot be cited. | Provide source access or paste the standard. |
| JTP-DI-004 | Requested team standard is unavailable. | Team overlay cannot be applied. | Provide team standard page or approve draft overlay. |
| JTP-DI-005 | Project workflow or required fields are unknown. | Readiness and reporting checks may be incomplete. | Provide project key, board, filter, or workflow source. |
| JTP-DI-006 | User asks for direct Jira update. | Mutation is out of scope. | Return draft-only content for human application. |

## Knowledge Source Review

| Review item | Status | Notes |
|---|---|---|
| Old-space Project Brain evidence reviewed | Done | Export includes Jira Ticket Polisher Project Brain Draft and Jira Hygiene Agents index. |
| Organization-wide standard drafted | Done | New page created for review. |
| Active MOBRM standard identified | Done | Source page `MO` page `5266898945`, version `3`, migrated locally for ROVO review. |
| Jira board and project keys confirmed | Done | MOBRM project key and board `7690` confirmed by owner. |
| Additional team standards | Deferred | Out of scope until a team-owned source and exact mapping are approved. |
| Permission model reviewed | Open | Needs Studio/admin confirmation before pilot. |
