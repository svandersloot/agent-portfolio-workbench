# Knowledge Source Plan - Jira Ticket Polisher

## Source Strategy

Jira Ticket Polisher uses a default organization-wide standard plus optional team overlays. It should prefer exact ticket context and approved standards. It must label missing or inaccessible standards rather than pretending a team policy was checked.

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
| Jira Ticket Polisher Team Standards - Draft Overlays | Confluence | Draft Team Overlay | Apply only sections marked approved or supplied by the user. | Per team review | State no approved team overlay was applied. |
| Team standards folder under supplied MO link | Confluence | Candidate Team Overlay | Research and harvest documented team rules before migrating durable outputs to ROVO. | Per research run | Record as unverified if not accessible. |
| Jira project, board, filter, or workflow | Jira | System of Record / Process Authority | Check issue type, status, fields, and workflow expectations. | Runtime or workflow change | Ask for project key, board, filter, or pasted export. |
| Sample tickets | Jira / export | Observed Pattern | Identify patterns and gaps; never treat as policy alone. | Per research sample | Use only as proposed standard evidence. |
| MR26 June release sample | Jira / export | Observed Pattern | Research Mobilitas/Mobi Rangers ticket quality using MR26-key tickets from fixVersion `Mobilitas 2026.06.12`. | One research pass | Use JQL `project = MR26 AND fixVersion = "Mobilitas 2026.06.12"` or a safe export; do not treat patterns as official standards. |

## Target Team Research Scope

| Team or board | Intended evidence | Current status |
|---|---|---|
| Breaking Backlogs | Team standard page, board/project identity, 10-15 ticket sample. | Not verified; live access unavailable in this session. |
| 404 Errors | Team standard page, board/project identity, 10-15 ticket sample. | Not verified; live access unavailable in this session. |
| MR26 / Mobi Rangers | Team standard page, board/project identity, and 10-15 MR26-key tickets from `fixVersion = "Mobilitas 2026.06.12"`. | Research seed identified; local Release Drift Monitor evidence says this release had 43 Jira issues, but ticket-quality sample details are not verified. |
| Mobilizers | Team standard page, board/project identity, 10-15 ticket sample. | Not verified; live access unavailable in this session. |
| Related team standards folder pages | Any discovered team overlay pages under the supplied Confluence folder. | Not verified; browser/auth access required. |

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
- Apply team overlay standards only when the relevant source is available or supplied.
- Name the standard sources used in the response.
- Keep documented standards, observed ticket patterns, and proposed standards separate.
- Use `No team overlay applied` when team standards are unavailable.
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
| Team standards folder reviewed live | Open | Public fetch and Chrome automation were unavailable; authenticated research is required. |
| Jira board and project keys confirmed | Open | Needs live Jira or exported samples. |
| Sample tickets reviewed | Open | Start with MR26 June release filter: `project = MR26 AND fixVersion = "Mobilitas 2026.06.12"`. |
| Permission model reviewed | Open | Needs Studio/admin confirmation before pilot. |
