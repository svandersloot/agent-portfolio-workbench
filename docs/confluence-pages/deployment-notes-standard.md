# Deployment Notes Standard for Jira Work Items

## Status And Ownership

| Field | Value |
|---|---|
| Status | Draft for pilot |
| Primary owner | Shayne Vandersloot |
| Co-owner | Hareesh |
| Required stakeholder group | Release Management |
| Primary test agents | Jira Work Item Assistant, Release Notes Manager |
| Applies to | Jira work items where manual deployment context is needed |
| Last reviewed | 2026-06-08 |

## Purpose

This standard gives humans and ROVO agents a shared way to decide when Jira Deployment Notes are needed and how to draft them consistently.

Jira owns the story-specific Deployment Notes field. Confluence owns the reusable standard, agent behavior, testing prompts, and future runbook library. Release Management owns deployment execution and rollback execution. Developers and delivery teams provide the story-specific context needed to execute and validate safely.

## Ownership Model

| Area | Owner |
|---|---|
| Deployment execution | Release Management |
| Rollback execution | Release Management |
| Story-specific deployment context | Developer or delivery team |
| Required files, paths, artifacts, and source stories | Developer or delivery team |
| Validation expectations | Developer or delivery team |
| Special preconditions, ordering, or timing | Developer or delivery team when the standard path may not be obvious |
| Agent behavior and test prompts | Agent owners, with Release Management stakeholder review |

## When Deployment Notes Are Required

Deployment Notes are required when a story needs manual deployment context that is not fully covered by the standard release pipeline.

Use Deployment Notes when the story includes:

- Importing a file into any Guidewire xCenter.
- Runtime property, feature toggle, or environment-specific configuration changes.
- AWS pipeline approval or deployment.
- User, role, permission, or API access changes.
- Manual admin UI steps in Guidewire, AWS, DynamoDB, TeamCity, or another console.
- External vendor, partner, or team coordination.
- Preconditions, sequencing, or timing constraints such as pre-startup, evening deployment, or "do this before import."
- Shared deployment artifacts across multiple stories.
- Validation that cannot be inferred from automated deployment alone.

Do not use `NA` or `N/A` to bypass a required field. If Deployment Notes are not required, do not add a Deployment Notes field draft. Do not replace `NA` with "No manual deployment steps required" or similar placeholder text in the Jira Deployment Notes field. If a separate workflow gate requires a reason outside the Deployment Notes field, state that no manual deployment action was identified.

## Historical Pattern Evidence

The first Mobilitas pattern-mining pass reviewed 87 issues across seven fixVersions from January through June 2026. Four issues had `NA` or `N/A`, leaving 83 substantive Deployment Notes.

| Pattern | Observed signal |
|---|---|
| GW XML data import | Approximately 48 issues, the most common deployment action |
| Runtime properties and feature toggles | Approximately 15 issues |
| AWS pipeline approval and deployment | Approximately 14 issues |
| Manual admin UI actions | Approximately 10 issues |
| User, role, and permission changes | Approximately 7 issues |
| Shared deployment across multiple stories | Approximately 18 issues across four batch groups |
| External coordination | Approximately 6 issues |
| Validation-first examples | 2 issues, both combined with data import |

Common gaps found:

- Validation steps were missing in most notes.
- Preconditions were usually missing.
- xCenter, environment, file path, branch, or AWS account details were often unclear.
- Shared artifacts sometimes appeared on many stories with no master or coordinator story.

Environment note:

Release Management owns the normal environment progression, such as SIT, TRN1, UAT, dry run/pre-prod, and production. Do not require a generic Environment section in the Jira Deployment Notes field. Include environment only when the story has a specific exception, timing constraint, environment-specific file, or non-standard deployment target.

Runbook reference note:

Runbook references are primarily for Confluence and agent behavior. They are not required in every Jira Deployment Notes field while the reusable runbook library is still being built. In Jira, prioritize the action, source file or artifact location, required preconditions, and validation.

## Studio Bootstrap Policy

Confluence is the versioned source of truth for this standard. Rovo Studio configurations should stay thin and reference this page instead of copying every detailed rule into Studio.

Studio instructions should include:

- Agent identity, scope, safety boundaries, and routing.
- A link to this standard as the authoritative deployment-note source.
- This page added as an explicit Studio knowledge source where Studio supports configured knowledge sources.
- A requirement to retrieve or reference the latest standard before drafting deployment notes when available.
- Fallback behavior for when this page is inaccessible.

Studio instructions should not duplicate every example, anti-pattern, or formatting detail from this page. When this standard changes, update this Confluence page first, then update Studio only if the bootstrap link, routing, or fallback behavior changes.

If this page is inaccessible, agents must not substitute MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, or other Jira hygiene pages as deployment-note standards. Those pages can inform general ticket quality, but they are not authoritative for Deployment Notes behavior.

Navigation note:

Repo paths, attached files, pipeline names, and linked Confluence pages belong under `Source File(s) / Artifact Location`. Deployment steps should describe the operational action in the application or tool, such as going to Administration > Utilities > Import Data. Do not write "navigate to" a repo path unless the source explicitly says the deployer must browse a file system or repository.

If a path starts with `modules\...`, `modules/...`, `cc/modules/...`, `pc/modules/...`, or a similar repository/configuration path, treat it as an artifact location. Do not put that path in `Deployment Steps` as a place to navigate in the target environment.

Pre-deployment note:

If a source note says an action must happen before an import, startup, pipeline promotion, or validation, put that action under `Pre-Deployment / Sequencing Notes`. Do not duplicate the same prerequisite as a normal `Deployment Steps` item unless the deployer must perform it during the deployment window and the source makes that timing explicit.

Inference limits:

Agents must not add adjacent operational questions or inferred validation paths unless the source evidence mentions them. For example, do not ask about prod-sync scripts, IAM, AWS Parameter Store, screenshots as evidence, or specific admin-page validation paths unless the Jira story, linked runbook, or user-provided context mentions those details.

Data Incomplete means the needed detail is missing, inaccessible, or conflicting in the source evidence. Do not replace explicit Jira story evidence with `Data Incomplete`. If the Jira Deployment Notes field, linked runbook, acceptance criteria, attachments, or user-provided context gives a file name, target system, path, admin page, related story range, or validation record list, preserve that detail in the draft.

Validation steps must stay source-backed. Do not add payment processing, policy update, screen-editing, or other functional validation unless that validation is present in the story, linked source, or user-provided context.

If explicit validation is not present in the Deployment Notes field, linked runbook, Jira acceptance criteria, or user-provided context, do not derive validation from the story title or summary. Use:

```text
Validation Steps
Data Incomplete - source deployment notes do not provide explicit validation steps.
```

Rollback note:

The Jira Deployment Notes field does not require a rollback plan. Do not add rollback/recovery sections or ask for rollback steps in story-level Deployment Notes unless the Jira issue, linked runbook, Release Management, or user-provided context explicitly asks for rollback content.

## Standard Jira Deployment Notes Template

Use this template when Deployment Notes are needed. Keep story-specific details in Jira and link to reusable Confluence runbooks as they become available.

```text
Deployment Type
[data_import | configuration_change | aws_pipeline | admin_manual_step | user_role_permission | business_rule | rate_book | external_dependency | batch_multi_story]

Pre-Deployment / Sequencing Notes
- [Any step that must happen before deployment, import, startup, or validation]
- [Any required sequencing, timing, or non-standard environment constraint]

Target System(s)
[CC | PC | BC | CM | AWS | TeamCity | External | All xCenters | Other]

Source File(s) / Artifact Location
- File or artifact:
- Location: [Jira attachment, repo path, Confluence page, AWS pipeline name, or other source]
- Action: [import/deploy/run/reference]

Deployment Steps
1. [Step with exact target system, path, file, pipeline, or admin page]
2. [Step]
3. [If multiple files or actions exist, specify order only when the source says order matters]

Validation Steps
1. [Expected validation result]
2. [Specific record, property, permission, pipeline, or UI result to verify]

Related Stories
- [Stories sharing this artifact, deployment action, file, or pipeline]

Questions To Resolve Before Finalizing
[Do not paste unresolved questions into the Jira Deployment Notes field. Keep them outside the field draft until answered.]
- [Missing detail that should not be invented]
```

## Resolving Open Questions

Open questions are temporary. They should be answered by the developer, delivery owner, or Release Management stakeholder before the Deployment Notes field is considered ready.

When an open question is answered, update the relevant Deployment Notes section instead of leaving the question in place. Unresolved questions should be shown outside the Jira Deployment Notes field as `Questions To Resolve Before Finalizing`.

Use these closure patterns:

| If the question asks... | Close it by updating... |
|---|---|
| Whether one story owns a shared deployment action | `Related Stories` and `Pre-Deployment / Sequencing Notes` |
| Whether an import is additive or overwriting | `Pre-Deployment / Sequencing Notes` |
| Where a file lives | `Source File(s) / Artifact Location` |
| Whether ordering matters | `Pre-Deployment / Sequencing Notes` and `Deployment Steps` |
| How to validate | `Validation Steps` |
| Who to contact | The relevant deployment section, only if Release Management needs the contact for execution |

Example resolution:

```text
Questions To Resolve Before Finalizing
- Should MR26-3076 be treated as the master/coordinator story for this shared import?
- Is the import additive, or can it overwrite existing producer org data?
```

If the answers are "yes, MR26-3076 is the master/coordinator story" and "yes, the import is additive," remove those open questions and update the notes:

```text
Pre-Deployment / Sequencing Notes
- MR26-3076 is the master/coordinator story for the shared producer org import covering MR26-3076 through MR26-3082.
- Import is additive.

Related Stories
- MR26-3076 through MR26-3082; MR26-3076 owns the shared import file.
```

## Agent Behavior For Jira Work Item Assistant

Jira Work Item Assistant should use this standard when drafting or improving Jira work items that may need Deployment Notes.

Expected behavior:

- Decide whether Deployment Notes are needed from the story context.
- Classify the deployment type.
- Draft the Jira Deployment Notes field when enough source context exists.
- Ask for missing files, paths, xCenters, branch/tag, validation, access details, preconditions, or sequencing instead of inventing them.
- Do not include routine environment progression in the Jira Deployment Notes field. Include environment only when the source notes a story-specific exception or environment-specific file.
- Do not include evidence capture or rollback/recovery sections in the Jira Deployment Notes field.
- Do not use Markdown tables in Jira Deployment Notes field drafts. Use bullets for source files, artifact locations, pipelines, and actions.
- Keep unresolved questions outside the Jira Deployment Notes field as `Questions To Resolve Before Finalizing`; fold answers into the field draft once resolved.
- Do not ask routine environment-sequence questions. Release Management owns normal SIT, TRN1, UAT, dry run/pre-prod, and production progression. Ask only about story-specific environment exceptions or environment-specific files.
- Use the controlled deployment type labels from the template. Do not replace them with broad labels such as `Configuration / Data Import` when a more specific type applies.
- Pick all applicable controlled deployment type labels. For example, `M26-788` should be `admin_manual_step`, `user_role_permission`, and `data_import`; `MR26-3076` should be `data_import` and `batch_multi_story`.
- Do not invent validation navigation. If the source says only to verify records are present, say that. Do not add a specific admin path unless the source provides it.
- If explicit validation is not present in source evidence, mark validation as `Data Incomplete` instead of deriving it from the story title or summary.
- Produce copy-ready Jira field text for human review.
- Do not update Jira unless a separately approved write workflow exists.

## Agent Behavior For Release Notes Manager

Release Notes Manager should use this standard when rolling story-level Deployment Notes into release-level deployment coordination.

Expected behavior:

- Query exact fixVersions or supplied issue lists for populated Deployment Notes.
- Group Deployment Notes into work packages by system, action type, source artifact, and dependency.
- Collapse exact duplicate deployment actions and list all source stories.
- Identify shared artifacts, duplicate pipelines, preconditions, ordering gaps, timing constraints, and missing role details.
- Preserve story evidence without turning the release runbook into a flat story list.
- Flag missing validation, branch/tag, admin URL, AWS account, source artifact location, or required sequencing as `Data Incomplete`.
- Keep final release publication and deployment execution human-owned.
- Do not infer implementation platforms such as AWS Parameter Store unless the source explicitly says so.
- Do not put stories with no required Deployment Notes into a generic deployment work package.
- Do not invent release metadata, release names, or source JQL. Use the exact user-supplied issue list or fixVersion; if no release identifier is supplied, mark it missing.

## Priority Runbook Library

Create the detailed reusable runbooks in this order after the pilot validates the standard:

| Priority | Runbook | Reason |
|---|---|---|
| 1 | GW XML Data Import | Covers the most common pattern and highest consistency gap. |
| 2 | Runtime Properties Import | High copy-paste risk due to environment-specific files. |
| 3 | AWS Pipeline Approve And Deploy | Common pattern with missing verification and account/role details. |
| 4 | CASFormPatterns_Ext.xml Load | Repeated shared artifact pattern with duplicate-execution risk. |
| 5 | External API Partner Integration | Multi-system and coordination-heavy pattern. |

## Pilot Exit Criteria

The standard can move from draft to active when:

- Jira Work Item Assistant can draft Deployment Notes from historical cards without inventing missing details.
- Release Notes Manager can group story-level notes into release-level work packages.
- Release Management confirms the notes are executable and validation expectations are useful.
- Developers confirm the template is practical and not excessive for routine stories.
- Preconditions, timing, and ordering are prominent enough to prevent incorrect early imports or deploys.
- Jira field drafts render cleanly in Jira without Markdown tables.
