# ROVO Studio Configuration Field Guide

## Status And Ownership

| Field | Value |
|---|---|
| Status | Draft from Studio read-only inspection |
| Primary owner | Shayne Vandersloot |
| Applies to | Governed ROVO Studio agents and subagents |
| First inspected agent | Release Notes Manager v2 |
| Last reviewed | 2026-06-09 |

## Purpose

Use this page as a practical field guide for human Studio setup pages and audits.

Studio configuration is not just one parent prompt. A governed agent can have parent fields, parent skills, parent knowledge, conversation controls, subagent routing, subagent-specific instructions, subagent-specific skills, and subagent-specific knowledge. Audit all of those surfaces before deciding an agent is read-only or correctly sourced.

## Studio Configuration Model

| Area | What Studio exposes | Setup guidance |
|---|---|---|
| Name and scenario titles | Parent name and subagent scenario names are editable title fields with visible length limits. | Use concise Studio-safe names. Confluence setup pages may use fuller canonical names, but audits should match by role and trigger, not exact title only. |
| Description | Short parent-agent description under the name. | Keep this user-facing and short; do not put runtime behavior here. |
| Parent instructions | Rich-text editor for parent identity, source stance, routing, and safety rules. | Keep thin. Link or name authoritative runtime/source pages instead of copying full behavior. |
| Test panel | `Test` button in the parent header. | Use for smoke tests after setup changes. Do not treat a successful chat as proof that knowledge and skills are correctly scoped. |
| Parent skills | Expandable Skills section with selected skills and an Add skills picker. | Parent can have zero skills even when subagents have many. Audit parent and each subagent separately. |
| Parent knowledge | Knowledge scope radio group: all organizational knowledge, custom knowledge, or no organizational knowledge. | Use custom knowledge for governed agents unless a broader scope is deliberately approved. |
| Conversation controls | Conversation starters plus web search and deep research controls. | Record whether web search/deep research are enabled at parent and subagent level; do not assume they inherit consistently without checking. |
| Subagent mode settings | Parent-level control for subagent behavior. | Record the setting when changed. Confirm with Studio docs or an admin before relying on undocumented routing behavior. |
| Subagent enablement | Each subagent has an enable/disable toggle. | Enabled subagents show active/green state in the UI. If a toggle appears off after a change, confirm whether the change was saved or whether the browser view is stale. |
| Subagent trigger | Text field describing when the subagent should handle a request. | Keep short and scenario-based. This is routing, not detailed behavior. |
| Subagent instructions | Rich-text editor for the subagent role and constraints. | Keep thin; reference runtime/source pages for detailed behavior. |
| Subagent skills | Each subagent can have its own selected skills. | Audit these even when parent skills are zero. A subagent skill can make the overall workflow write-capable. |
| Subagent knowledge | Each subagent can have its own knowledge scope and sources. | Audit each subagent; do not assume parent knowledge is the full source set. |

## Text Field Save Behavior

Studio text fields do not expose an explicit save button. After changing parent instructions, a subagent trigger, or subagent instructions, click static blank space near the field label, such as beside `Instructions` or `Trigger`.

Do not use a dropdown, section expander, menu, toggle, or other functional control as the blur target. Wait for the small saving spinner in the card header to finish and briefly show a green checkmark before reloading or testing.

## Knowledge Source Model

Studio knowledge has two layers:

1. Overall scope: `All organizational knowledge`, `Custom knowledge`, or `No organizational knowledge`.
2. Source picker selections inside custom knowledge.

For Confluence custom knowledge, the picker exposes:

- `All content`
- `Select spaces`
- `Select content under`

When Confluence uses `Select content under`, selecting a parent page covers that parent page and child pages underneath it. Future audits should distinguish:

- `Covered`: the required page is selected directly or is a child of a selected parent page.
- `Missing`: the required page is neither selected directly nor covered by a selected parent page.
- `Ambiguous`: the audit cannot confirm the page tree or selected-parent relationship from Studio alone.

For Jira custom knowledge, the picker currently presents Jira as a separate source family and can show project/space-level coverage such as `All spaces`. Do not audit Jira knowledge as page-level coverage unless Studio or Atlassian docs explicitly expose that granularity.

## Release Notes Manager v2 Snapshot

Read-only Studio inspection on 2026-06-09 found:

| Area | Observed configuration |
|---|---|
| Parent name | `Release Notes Manager v2` |
| Parent description | `Automates the creation and synchronization of Release Documentation (Business Summaries and Technical Runbooks) using Jira data and Mobilitas standard skeletons.` |
| Parent instructions | Thin governed Release Notes Manager bootstrap matching the current setup-page intent. |
| Parent skills | `0` selected. |
| Parent knowledge | Custom knowledge with `Deployment Notes Standard for Jira Work Items` selected. |
| Parent knowledge picker mode | Confluence `Select content under` with `Deployment Notes Standard for Jira Work Items` selected. |
| Parent web/deep research | Web search control visible; deep research visible but disabled at parent level. |
| Subagents | `Release Notes Drafter`, `Business Communicator`, `Deployment Runbook Drafter`, and `Sync Manager`. Titles are shortened Studio labels. |

Subagent observations:

| Subagent | Trigger summary | Skill/knowledge observation |
|---|---|---|
| Release Notes Drafter | Technical, engineering-facing, implementation, or issue-by-issue release notes. | 13 skills; includes read-oriented Jira/Confluence skills and write-capable Confluence skills such as create page, create label, and append content. Shows 2 custom Confluence sources plus Jira coverage. |
| Business Communicator | Business, executive, customer, operations, or non-technical release summaries. | 11 skills; includes read-oriented Jira/Confluence skills and write-capable Confluence skills such as create page, create label, and append content. Shows 2 custom Confluence sources; confirm whether Jira coverage is also present when auditing saved state. |
| Deployment Runbook Drafter | Technical deployment runbook, deployment checklist, deployment-note cleanup, or release deployment coordination. | 4 skills: create page, search fields, search with JQL, and search Jira projects. Shows 2 custom Confluence sources plus Jira `All spaces`. Browser view showed the toggle off, while Shayne reported enabling it; confirm saved Studio state before auditing final enablement. |
| Sync Manager | Compare, validate, reconcile, synchronize, or find gaps between release notes and release scope. | 4 skills: search with JQL, edit page append content, get page, and create label. Shows 2 custom Confluence sources; confirm whether Jira coverage is also present when auditing saved state. |

## Jira And Confluence Skill Classification

Classify skills by visible Studio descriptions. Confirm exact permission and approval behavior against Atlassian docs or admin policy before broad enablement.

| Skill | Visible description summary | Classification |
|---|---|---|
| Get work item | Fetch Jira work item. | Read-only |
| Get changelog | Fetch a Jira work item's changelog. | Read-only |
| Get editable fields | Fetch a Jira work item's editable fields and field information. | Read-only |
| Get versions | Fetch a Jira space's versions. | Read-only |
| Get version | Fetch a Jira space version. | Read-only |
| Search fields | Search for Jira fields, values, and functions. | Read-only |
| Search Jira projects | Search Jira projects and return project key, id, title, and type. | Read-only |
| Search project components | Search Jira or Compass project components in a project. | Read-only |
| Search with JQL | Search Jira with a JQL expression. | Read-only |
| Find similar work items | Find work items with a similar summary in a Jira space. | Read-only |
| Get creatable fields | Fetch creatable fields and field information. | Read-only |
| Get work item types | Fetch all available Jira work item types. | Read-only |
| Create work item | Create a work item in Jira. | Write-capable |
| Create Jira issues with advanced configuration | Create issues, optionally with child issues and additional fields. | Write-capable |
| Comment on work item | Add a comment to a Jira work item. | Write-capable |
| Update field | Update a Jira work item's field. | Write-capable |
| Update work item | Update a Jira work item's fields. | Write-capable |
| Update status | Update a Jira work item's status. | Write-capable |
| Update assignee, labels, priority, severity, major incident tag | Update Jira work item metadata. | Write-capable |
| Create release/version | Create a new release/version in Jira. | Write-capable |
| Create sprint, start sprint, move work items to sprint | Change sprint state or membership. | Write-capable |
| Log work | Log work on a Jira work item for time tracking. | Write-capable |
| Trigger Autodev workflow | Trigger Autodev to draft a code change. | Approval-sensitive |
| Generate workflow operations | Generate operations on a Jira workflow. | Unclear; confirm before enabling |
| Get page | Get a Confluence page. | Read-only |
| Find source of truth | Find whether a more recently updated page may be source of truth. | Read-only |
| Find owner of topic | Find likely owners of a topic. | Read-only |
| Add comment to page | Add a comment to a Confluence page. | Write-capable |
| Create page | Create a formatted Confluence page. | Write-capable |
| Edit content | Make changes to a page or live doc. | Write-capable |
| Edit page (append content) | Add content to the bottom of a Confluence page. | Write-capable |
| Create label, remove label | Change Confluence labels. | Write-capable |
| Create live doc, database, folder, smart link, whiteboard | Create Confluence content or containers. | Write-capable |
| Copy page, move page, rename page, archive page | Change Confluence content or location/state. | Write-capable |
| Restrict page | Update Confluence page access restrictions. | Approval-sensitive |
| Update state | Update Confluence page state properties. | Write-capable |
| Convert page format | Convert page content to match a template. | Write-capable |

## Human Setup Guidance

- Match Studio names by intent when title limits require shortened labels.
- Keep parent and subagent instructions thin; move durable behavior to Confluence runtime/source pages.
- For each parent and subagent, record skills, knowledge, web search, deep research, and enablement state separately.
- Treat any Confluence create/edit/comment/label/restrict/move/archive skill as write-capable even if the workflow instruction says not to publish.
- Treat any Jira create/update/comment/status/sprint/log-work skill as write-capable.
- Prefer read-only Jira skills for release evidence: get work item, changelog, versions, search fields, search projects, and search with JQL.
- Prefer read-only Confluence skills for evidence: get page, find source of truth, and find owner of topic.
- Audit Confluence selected parents before flagging required child pages as missing.
- Record Jira knowledge as project/space coverage when Studio shows that granularity.

## Open Questions

- Confirm with Atlassian docs or an admin whether Studio skills always ask for runtime confirmation before mutating Jira or Confluence.
- Confirm whether subagent knowledge inherits from parent knowledge, is isolated, or is merged when both parent and subagent custom knowledge are configured.
- Confirm final saved enablement state for `Deployment Runbook Drafter`.
- Confirm whether web search and deep research settings inherit or are independently evaluated at parent and subagent level.
