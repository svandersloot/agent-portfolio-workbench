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
| Jira project, board, selected issue, or issue list | Jira / supplied export | System of Record | Identify issue type, parent, status, labels, dependencies, and required fields. Studio must configure Jira as a knowledge source for the parent or relevant subagent; user browser visibility is not enough. | Runtime | Ask for project key, board, filter, pasted export, or configured Jira knowledge access. |
| MOBRM board/project | Jira | Pilot System of Record | First pilot board and team context. | Runtime | Use pasted context if live access is unavailable. |
| Release plan, release calendar, or release page | Confluence / Jira | Process Authority | Confirm release identity, timing, scope, owners, and coordination needs. | Per release | Mark `Data Incomplete`. |
| Jira Ticket Standards | Confluence | Standards Index | Shared standards parent for Jira hygiene agents. | Quarterly or after governance restructure | Use directly linked standard pages if the parent is unavailable. |
| Organization-Wide Jira Ticket Quality Standard | Confluence | Process Authority | Default drafting and review baseline for all candidate or existing Jira tickets. | Quarterly or after workflow change | Mark standard coverage `Data Incomplete` and ask the user to provide the standard. |
| Team Jira Standards | Confluence | Team Standards Index | Identify available team overlays. | Per team review | State no approved team overlay was applied. |
| MOBRM Team Jira Standards | Confluence | Team Overlay | Apply to `MOBRM-*` work or MOBRM board `7690` context. | Annual or after workflow change | Use org-wide standard only and state no team overlay applied. |
| Deployment Notes Standard for Jira Work Items | Confluence | Process Authority / Versioned Source of Truth | Decide when Deployment Notes are needed and draft the Jira Deployment Notes field for human review. This Confluence page is authoritative over copied Studio examples. | Pilot review, then quarterly or after release process change | Mark Deployment Notes guidance `Data Incomplete` and ask for the standard or release-owner guidance. |
| Deployment Notes Agent Pilot | Confluence | Evaluation / Pilot Evidence | Backtest historical deployment-note behavior and score Jira Work Item Assistant output. | During pilot | Use the standard page only and ask the user for historical card context. |
| Proposed team standards page | Draft Markdown / Confluence draft | Proposed Team Standard | Help teams document required fields, important fields, non-required defaults, issue type expectations, labels, parent rules, and common task patterns. | Per team setup | Keep as proposed and do not apply as official until approved. |
| Jira Work Item Draft Bundle schema | Repo contract | Draft Contract | Package candidate release tickets only when the user explicitly asks for machine-readable JSON, packaging, or a Draft Bundle. | Per contract change | Use human-readable field blocks instead. |
| Jira Ticket Polisher historical pages | Archived reference | Historical Reference | Preserve prior review criteria and standards provenance only. Do not route active work to Jira Ticket Polisher. | Migration-time | Use Jira Work Item Assistant Ticket Review / Polish. |
| Legacy MO source folder | Confluence | Legacy Reference | Migrate historical instructions, templates, and behavior after capture. | Migration-time | Treat as source gap until accessible. |

## Runtime Context Map

Use this map to keep runtime retrieval narrow. The live agent should use the smallest trusted source that matches the user's task and should not substitute adjacent governance pages when the mapped source is missing.

This section is a repo-backed prototype until a human manually configures and verifies the matching Studio knowledge sources.

| User or task intent | Use this source first | Do not substitute | Fallback if missing | Smoke test prompt |
|---|---|---|---|---|
| Draft or review Jira Deployment Notes for a work item with manual deployment, imports, runtime properties, AWS pipelines, user/role changes, timing constraints, preconditions, or shared deployment artifacts. | `Deployment Notes Standard for Jira Work Items`, plus the selected Jira issue or supplied story evidence. | MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, other Jira hygiene pages, or Studio memory from earlier drafts. | Say the Deployment Notes standard could not be verified, ask for the page content or release-owner guidance, and mark Deployment Notes guidance `Data Incomplete` until supplied. | Using the Deployment Notes Standard for Jira Work Items, review Jira story `M26-788` and draft the Jira Deployment Notes field. |
| Draft, review, or polish a normal Jira work item that is not a Deployment Notes request. | `Organization-Wide Jira Ticket Quality Standard`, selected Jira issue or supplied ticket context, and the applicable team overlay only when the project, board, or supplied source clearly matches. | Deployment Notes Standard as a general ticket-quality standard, old tickets as policy, or proposed team standards as approved overlays. | Apply the org-wide baseline only, state `No team overlay applied` when no approved overlay matches, and ask for the missing project, board, parent, labels, or owner approval. | Review this non-MOBRM ticket draft against the org-wide standard and state whether any team overlay applies. |
| Resolve whether MOBRM team requirements apply. | `Team Jira Standards` index, `MOBRM Team Jira Standards`, and the selected Jira project/board evidence. | Related release keys such as `MR26`, `M26`, or `CLE` by themselves, sampled historical tickets, or Deployment Notes examples. | Use org-wide guidance only and state `No team overlay applied`; offer a proposed team standard draft only after asking for owner approval evidence. | For a `MOBRM-*` ticket on board `7690`, identify the applied team overlay and required or important fields. |
| Draft a Jira status comment or status-comment set. | Selected Jira issue/comment context, user-provided progress, blocker, validation, handoff details, and this Knowledge Source Plan's status-comment input requirements. | Release health evidence as approval, vague updates such as "still working on it", or inferred progress from old comments. | Return `Not ready to post`, ask for what changed, current focus, blocker or risk, validation, next action, ETA, or evidence, and do not post Jira comments. | Draft a status comment from the update "still working on it" and explain what details are missing. |
| Check work-item gaps or route a readiness request. | Selected Jira issue or draft, Organization-Wide Jira Ticket Quality Standard, applicable approved team standard, and this Knowledge Source Plan's Data Incomplete flags. | Release Health Analyst scoring, go/no-go approval language, or hidden agent-to-agent invocation. | Return missing fields and Data Incomplete flags; route readiness scoring, blocker analysis, and go/no-go requests to Release Health Analyst. | Check whether this ticket is ready for release approval and identify what Jira Work Item Assistant can and cannot decide. |

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
- Whether the user wants copy-ready draft only, Ticket Review / Polish, explicit Draft Bundle packaging, or a future approved create path.
- Whether Deployment Notes are needed when the work item includes manual deployment steps, imports, runtime properties, AWS pipelines, user/role/permission changes, external coordination, timing constraints, preconditions, or shared deployment artifacts.

## Source Handling Rules

- Apply the Organization-Wide Jira Ticket Quality Standard to every candidate ticket.
- Do not assume the agent can read a Jira issue because the user can open it in their browser. Jira issue visibility requires configured Studio Jira knowledge access, such as Jira `All spaces` for the generic pilot or an explicitly tested narrower project scope.
- For Deployment Notes, retrieve or reference the current Deployment Notes Standard for Jira Work Items when available; treat that Confluence page as authoritative over stale Studio instructions.
- Do not substitute MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, or other Jira hygiene pages for the Deployment Notes Standard.
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
- When drafting Deployment Notes, do not include routine environment progression, evidence capture, or rollback/recovery sections in the Jira field.
- Put pre-deployment notes, ordering, and timing before deployment steps so Release Management sees them before taking action.
- Use bullets instead of Markdown tables in Jira Deployment Notes field drafts.
- Keep unresolved questions outside the Jira Deployment Notes field under `Questions To Resolve Before Finalizing`.
- Use controlled deployment type labels from the standard.
- Do not ask routine environment-sequence questions unless the story has an environment-specific exception or file.
- Put repo paths, attachments, pipeline names, and linked pages under source/artifact location, not as application navigation steps.
- Treat `modules\...`, `modules/...`, `cc/modules/...`, `pc/modules/...`, and similar Guidewire configuration paths as artifact locations, not target-environment navigation steps.
- Do not add adjacent process questions such as prod-sync scripts, IAM, evidence screenshots, or specific validation navigation unless the source mentions them.
- Keep validation source-backed; do not add payment processing, policy update, screen-editing, or other functional validation unless the source mentions it.
- Do not invent Deployment Notes fields such as file names, paths, xCenters, branch/tag, AWS account, validation criteria, sequencing, or owner details. Mark missing details as `Data Incomplete`.

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
| JWA-DI-012 | Deployment Notes need file, path, xCenter, branch/tag, pipeline, AWS account, validation, sequencing, or artifact-location details that are not supplied. | The deployment note could be unsafe or impossible to execute confidently. | Provide the missing deployment source details or link the relevant runbook/source artifact. |
| JWA-DI-013 | Critical preconditions, timing, or ordering are unclear. | Release Management may run steps too early or in the wrong sequence. | Provide required preconditions, timing, ordering, or escalation team. |

## Knowledge Source Review

| Review item | Status | Notes |
|---|---|---|
| Legacy MO folder captured | Open | Chrome bridge blocked retrieval during this pass. |
| Shared Jira standards parent available | Done | Published under Jira Hygiene Agents in ROVO. |
| Org-wide ticket standard available | Done | Published under the shared Jira Ticket Standards tree in ROVO. |
| MOBRM team standard available | Done | Published under Team Jira Standards as the first active overlay. |
| Deployment Notes Standard available | Draft | Published for pilot use with Jira Work Item Assistant and Release Notes Manager. |
| Deployment Notes Agent Pilot available | Draft | Use historical cards to validate the template before active promotion. |
| First pilot board/project confirmed | Done | MOBRM project board supplied: `[internal Atlassian URL]`. |
| MOBRM field expectations captured | Partial | Parent and labels are first required/important fields; issue type and exact create mapping still need confirmation. |
| Jira create field mapping confirmed | Open | Required before any write-capable creation workflow, especially bulk creation. |
| Jira comment template and write mapping confirmed | Open | Required before any comment-posting workflow; draft-only comments are allowed during this migration slice. |
| Permission model reviewed | Open | Needs Studio/admin confirmation before pilot. |
