# Knowledge Source Plan - Jira Work Item Assistant

## Source Strategy

Jira Work Item Assistant should use exact release, Kanban, and Jira context supplied by the user or available through approved sources. It should apply the organization-wide Jira ticket standard first, then apply a documented team standard only when the project, board, or supplied source clearly matches.

The agent should produce richer tickets and task guidance from evidence, not from guesswork.

The standards model is global-plus-overlay: one organization-wide Jira ticket standard for all teams, plus team standards pages for team-specific requirements. MOBRM is the first pilot overlay; future teams should add standards pages rather than separate assistant copies unless their workflow is materially different.

## Authority Labels

| Label | Meaning |
|---|---|
| System of Record | Jira issue, Kanban board, release scope, fixVersion, or release work item. |
| Process Authority | Approved release process, Jira standard, team standard, or governance page. |
| Team Overlay | Team-specific ticket drafting rules that supplement the org-wide Jira standard. |
| Proposed Team Standard | Draft team overlay that still needs human/team owner approval. |
| Reference | Prior task page, old ticket, release notes, or meeting notes used for context only. |
| Observed Pattern | Pattern found in sampled tickets; useful but not official policy. |
| Draft Input | Candidate ticket bundle or text that still needs human approval. |

## Approved Source Map

| Source | Type | Authority | Allowed Use | Freshness | Fallback |
|---|---|---|---|---|---|
| User's current Kanban or release context | Jira / prompt | System of Record / Request Context | Draft candidate work from visible current context. | Runtime | Ask user to paste board item, ticket, or context summary. |
| Jira project, board, selected issue, or issue list | Jira / supplied export | System of Record | Identify issue type, parent, status, labels, dependencies, and required fields. | Runtime | Ask for project key, board, filter, or pasted export. |
| MOBRM board/project | Jira | Pilot System of Record | First pilot board and team context. | Runtime | Use pasted context if live access is unavailable. |
| Release plan, release calendar, or release page | Confluence / Jira | Process Authority | Confirm release identity, timing, scope, owners, and coordination needs. | Per release | Mark `Data Incomplete`. |
| Jira Ticket Standards | Confluence | Standards Index | Shared standards parent for Jira hygiene agents. | Quarterly or after governance restructure | Use directly linked standard pages if the parent is unavailable. |
| Organization-Wide Jira Ticket Quality Standard | Confluence | Process Authority | Default drafting baseline for all candidate Jira tickets. | Quarterly or after workflow change | Route draft through Jira Ticket Polisher or ask user to provide standard. |
| Team Jira Standards | Confluence | Team Standards Index | Identify available team overlays. | Per team review | State no approved team overlay was applied. |
| MOBRM Team Jira Standards | Confluence | Team Overlay | Apply to `MOBRM-*` work or MOBRM board `7690` context. | Annual or after workflow change | Use org-wide standard only and state no team overlay applied. |
| Proposed team standards page | Draft Markdown / Confluence draft | Proposed Team Standard | Help teams document required fields, important fields, non-required defaults, issue type expectations, labels, parent rules, and common task patterns. | Per team setup | Keep as proposed and do not apply as official until approved. |
| Jira Work Item Draft Bundle schema | Repo contract | Draft Contract | Package candidate release tickets for review. | Per contract change | Use field blocks instead. |
| Jira Ticket Polisher output | ROVO agent response | Quality Review | Use as optional strict review before creation. | Runtime | Present draft for manual review without Polisher. |
| Legacy MO source folder | Confluence | Legacy Reference | Migrate historical instructions, templates, and behavior after capture. | Migration-time | Treat as source gap until accessible. |

## Required Input Check

Before producing a final-seeming ticket draft, identify:

- Requested outcome.
- Target release or release stage, if relevant.
- Target Jira project, board, or team.
- Whether the user wants one ticket or multiple candidate tickets.
- Issue type, parent, labels, and assignee when known.
- For status comment drafts: target Jira issue, user-supplied status, completed work, blockers, validation evidence, next action, evidence links, and whether the comment should support drift or health assessment evidence.
- For bulk status comment drafts: named comment set, target issue for each comment, exact comment text, evidence source, and approval state.
- Team-specific required fields; for MOBRM pilot, parent and labels are the first required or important fields, while fixVersion, component, priority, and sprint are not required.
- Source evidence used.
- Applicable organization-wide and team standards.
- Missing details that prevent confident ticket creation.
- Whether the user wants copy-ready draft only, Jira Ticket Polisher review, or future approved create path.

## Source Handling Rules

- Apply the Organization-Wide Jira Ticket Quality Standard to every candidate ticket.
- Apply the MOBRM overlay only when the ticket project key is `MOBRM`, MOBRM board `7690` is visible, or the user supplies the MOBRM standard for the current request.
- Apply other team overlays only when a documented standard and project/board mapping are supplied or approved.
- If a team overlay is missing, draft a proposed team standards page only after asking about required fields, important fields, fields not required by default, issue types, board/project mapping, labels, parent expectations, and workflow conventions.
- Do not apply a proposed team standards page as official until a human/team owner approves it.
- Include `How to perform this task` only when the work is repeatable, script-driven, or explicitly meant to teach a common task.
- Support bulk candidate tickets when multiple known tickets are requested up front; require a named approval summary before any future create path.
- Draft Jira status comments from supplied or visible evidence only; do not post comments during this migration slice.
- When drafting comments, separate completed work, current status, blockers, validation evidence, next action, and open questions so Release Drift Monitor and Release Health Analyst can consume the ticket history as evidence.
- For bulk status comment drafts, produce a named set and require approval for each target issue or the whole named set before any future posting path.
- Keep documented standards, observed ticket patterns, and proposed recommendations separate.
- Use `Data Incomplete` when release identity, project, issue type, task steps, acceptance criteria, validation, owner, or source evidence is missing.
- Do not treat old tickets as policy unless a team owner confirms they are examples of current practice.
- Do not broaden to all Jira or all Confluence.
- Do not copy sensitive details into generated tickets unless they are required and approved for the target Jira project.

## Data Incomplete Flags

| Flag ID | Missing or incomplete data | Impact | How to clear |
|---|---|---|---|
| JWA-DI-001 | Target project or board is unknown. | Required fields and team standards may be wrong. | Provide project key, board, or selected issue. |
| JWA-DI-002 | Release identity or stage is unknown. | Ticket may attach to wrong release or omit timing context. | Provide release name, fixVersion, release date, or plan page. |
| JWA-DI-003 | Task steps are not source-backed. | Ticket may not teach the common task reliably. | Provide source page, prior ticket, runbook, or owner explanation. |
| JWA-DI-004 | Acceptance criteria or validation evidence is missing. | AI and humans cannot assess done state confidently. | Provide expected result, validation method, or QA notes. |
| JWA-DI-005 | Team standard is unavailable. | Only org-wide baseline can be applied. | Provide approved team standard or mapping. |
| JWA-DI-006 | User asks for Jira write without approval path. | Mutation is out of scope. | Use copy-ready draft or approve a governed write workflow later. |
| JWA-DI-007 | Parent or labels are missing for MOBRM pilot. | Ticket may not satisfy first pilot field expectations. | Provide parent and discovery labels. |
| JWA-DI-008 | Bulk ticket set lacks explicit approval. | Multiple Jira issues could be created incorrectly. | Present named candidate list and capture human approval. |
| JWA-DI-009 | Proposed team standard lacks owner approval. | Draft overlay could be mistaken for official policy. | Capture team owner approval before applying it as a standard. |
| JWA-DI-010 | Status comment lacks target issue, evidence, or approval. | Comment may update the wrong ticket or imply unsupported progress. | Provide target issue, factual update, validation/blocker details, and approve exact comment text before any future posting path. |
| JWA-DI-011 | Bulk status comment set is unnamed or has ambiguous targets. | Comments could be posted to the wrong issues or approved too broadly. | Name the comment set and list exact target issue plus exact comment text for each item. |

## Knowledge Source Review

| Review item | Status | Notes |
|---|---|---|
| Legacy MO folder captured | Open | Chrome bridge blocked retrieval during this pass. |
| Shared Jira standards parent available | Done | Published under Jira Hygiene Agents in ROVO. |
| Org-wide ticket standard available | Done | Published under the shared Jira Ticket Standards tree in ROVO. |
| MOBRM team standard available | Done | Published under Team Jira Standards as the first active overlay. |
| First pilot board/project confirmed | Done | MOBRM project board supplied: `https://csaaig.atlassian.net/jira/software/c/projects/MOBRM`. |
| MOBRM field expectations captured | Partial | Parent and labels are first required/important fields; issue type and exact create mapping still need confirmation. |
| Jira create field mapping confirmed | Open | Required before any write-capable creation workflow, especially bulk creation. |
| Jira comment template and write mapping confirmed | Open | Required before any comment-posting workflow; draft-only comments are allowed during this migration slice. |
| Permission model reviewed | Open | Needs Studio/admin confirmation before pilot. |
