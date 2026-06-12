# Knowledge Source Plan - Release Notes Manager

## Source Strategy

Release Notes Manager uses approved release-specific sources only. It should prefer exact release metadata and clearly label any missing or incomplete evidence.

## Authority Labels

| Label | Meaning |
|---|---|
| System of Record | Authoritative structured data for release scope or status. |
| Process Authority | Approved page or workflow source that defines how release notes should be produced. |
| Working Draft | Current draft content that may change before approval. |
| Reference | Helpful background that cannot override system-of-record or process-authority sources. |
| Archive Reference | Legacy example that can inform patterns but must not become the default standard. |

## Approved Source Map

| Source | Type | Authority | Allowed Use | Freshness | Fallback |
|---|---|---|---|---|---|
| Jira fixVersion, release filter, or supplied issue list | Jira | System of Record | Identify release scope and candidate note items. | Per release | Ask for exact release identifier or mark `Data Incomplete`. |
| Release plan, change summary, or release calendar | Confluence / Jira | Process Authority | Confirm release dates, milestones, impacted groups, and release-owner notes. | Per release | Ask for authoritative link or owner confirmation. |
| Existing release notes page | Confluence | Working Draft / Published Record | Compare, refine, and identify gaps. | Per release | Ask the user to paste content if inaccessible. |
| Deployment Notes Standard for Jira Work Items | Confluence | Process Authority / Versioned Source of Truth | Interpret story-level Deployment Notes and group them into release-level deployment work packages. This Confluence page is authoritative over copied Studio examples. | Pilot review, then quarterly or after release process change | Mark deployment-note standard unavailable and ask for release-owner guidance. |
| Deployment Notes Agent Pilot | Confluence | Evaluation / Pilot Evidence | Test release-level grouping, duplicate-action detection, shared artifacts, and data-incomplete flags. | During pilot | Use the standard page only and ask the user for the historical card set. |
| Product or business summary | Confluence / supplied text | Process Authority | Translate technical changes into audience-specific summaries. | Per release | Keep business summary out of scope until provided. |
| ClaimCenter repo | Bitbucket | Source Reference | Locate deployment files referenced by Jira deployment notes. | Per release branch or develop branch | Ask release owner which branch/tag to use before referencing a file. |
| PolicyCenter repo | Bitbucket | Source Reference | Locate deployment files referenced by Jira deployment notes. | Per release branch or develop branch | Ask release owner which branch/tag to use before referencing a file. |
| BillingCenter repo | Bitbucket | Source Reference | Locate deployment files referenced by Jira deployment notes. | Per release branch or develop branch | Ask release owner which branch/tag to use before referencing a file. |
| ContactManager repo | Bitbucket | Source Reference | Locate deployment files referenced by Jira deployment notes. | Per release branch or develop branch | Ask release owner which branch/tag to use before referencing a file. |
| Release Health Analyst output | Confluence / supplied text | Reference | Reuse health findings, blockers, and data-completeness flags. | Per run | Route health scoring back to Release Health Analyst. |
| Mobilitas Release Notes Agent materials | Legacy export / archive | Archive Reference | Learn from examples only when relevant. | Static | Do not generalize as default behavior. |

## Runtime Context Map

Use this map to keep runtime retrieval narrow. The live agent should use the smallest trusted source that matches the user's task and should not substitute adjacent governance pages when the mapped source is missing.

This section is a repo-backed prototype until a human manually configures and verifies the matching Studio knowledge sources.

| User or task intent | Use this source first | Do not substitute | Fallback if missing | Smoke test prompt |
|---|---|---|---|---|
| Build a release-level deployment runbook or deployment work-package rollup from Jira Deployment Notes. | `Deployment Notes Standard for Jira Work Items`, `Deployment Notes Agent Pilot`, exact Jira fixVersion or supplied issue list, and story-level Deployment Notes evidence. | MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, generic Jira hygiene pages, or Studio memory from earlier drafts. | Say the Deployment Notes standard or Jira scope could not be verified, ask for the page content or issue list, and mark the missing source as `Data Incomplete`. | Build deployment work packages for `MR26-3076, MR26-2831, M26-788, SRNGR-4539, MR26-810, MR26-2708, SMOBL-4073, SRNGR-3815, M26-231, MOBPXD-1399`. |
| Draft technical release notes for a release. | Exact Jira fixVersion, release filter, supplied issue list, release plan, existing release notes page, and approved technical source context. | Mobilitas archive materials as default behavior, Release Health Analyst output as the release scope, or fuzzy fixVersion matching. | Ask for the exact release identifier, release scope source, or existing draft/template; mark release scope or template gaps with `RNM-DI-001`, `RNM-DI-002`, or `RNM-DI-003`. | Draft technical release notes for this fixVersion and list source coverage gaps before the draft. |
| Compare or synchronize an existing release-note draft against release scope. | Existing release notes page or pasted draft, exact Jira scope source, release plan, and release owner notes. | Unsupported Jira search guesses, old release notes as current scope, or Release Health Analyst findings as automatic corrections. | Return unsupported claims, missing items, and conflicts for release-owner decision; do not silently resolve the draft. | Compare this release-note draft against the supplied issue list and identify unsupported claims. |
| Produce a business or executive release summary. | Product or business summary, release plan, stakeholder notes, approved technical notes, and user-provided audience context. | Technical implementation detail alone, archive examples, or inferred customer impact. | Keep business summary out of scope until audience and product context are supplied; mark `RNM-DI-004` when missing. | Turn this release context into a business summary and identify what audience context is missing. |
| Answer release health, blocker, source-completeness, or go/no-go readiness questions. | Release Health Analyst configuration, assessment template, prompt library, and supplied Release Health Analyst output as reference only. | Release Notes Manager runbook rules, release notes draft status, or deployment work-package grouping as readiness approval. | Route the request to Release Health Analyst and offer to prepare release-note or deployment-work-package evidence for that workflow. | Score release readiness and identify blockers for this release. |

## Mobilitas Application Source Repositories

Use these repositories when a deployment note references files in a Guidewire application repo:

| Application | Repository |
|---|---|
| ClaimCenter | `https://bitbucket.insu.dev-1.us-east-1.guidewire.net/projects/STARSYSONE/repos/claimcenter/browse` |
| PolicyCenter | `https://bitbucket.insu.dev-1.us-east-1.guidewire.net/projects/STARSYSONE/repos/policycenter/browse` |
| BillingCenter | `https://bitbucket.insu.dev-1.us-east-1.guidewire.net/projects/STARSYSONE/repos/billingcenter/browse` |
| ContactManager | `https://bitbucket.insu.dev-1.us-east-1.guidewire.net/projects/STARSYSONE/repos/contactmanager/browse` |

Branch selection is release-context dependent. A release branch may look like `release/r-64.0`; other work may still come from `develop`. If the branch or tag is not explicitly provided, do not assume it. Mark the runbook with a data-incomplete flag and ask the release owner or deployment lead which branch/tag should be used.

## Required Input Check

Before drafting final-seeming content, the agent must confirm:

- Target release identifier or exact issue list.
- Intended audience: technical, business, executive, operations, or mixed.
- At least one source for release scope.
- Whether an existing release notes page or template should be followed.
- Whether blocked, deferred, or partial items should be included.
- For deployment runbooks, which Bitbucket repo and branch/tag should be used for referenced files.
- For deployment runbooks, which admin application URL should be used when it is not already standard for the Release Management environment sequence.
- For deployment work packages, whether Deployment Notes should be interpreted under the current Deployment Notes Standard and whether shared artifacts or duplicate deployment actions should be collapsed.
- Whether any story-specific environment exception exists outside the normal Release Management sequence of SIT, TRN1, UAT, dry run/pre-prod, and production.

## Data Incomplete Flags

| Flag ID | Missing or incomplete data | Impact | How to clear |
|---|---|---|---|
| RNM-DI-001 | Exact release identifier is missing. | Release scope cannot be validated. | Provide fixVersion, release link, or issue list. |
| RNM-DI-002 | Jira scope source is inaccessible. | Draft may omit or include wrong issues. | Grant access, provide export, or paste issue list. |
| RNM-DI-003 | Release notes draft or template is inaccessible. | Format and prior content cannot be synchronized. | Grant access or paste the draft/template. |
| RNM-DI-004 | Business audience context is missing. | Business summary may be misleading or incomplete. | Provide audience, product summary, or stakeholder context. |
| RNM-DI-005 | Source conflict found. | Final notes cannot be trusted. | Release owner resolves authoritative source. |
| RNM-DI-006 | Bitbucket repo, branch, or tag is unclear for a referenced deployment file. | Deployer may import the wrong file version. | Confirm app repo and branch/tag with the release owner. |
| RNM-DI-007 | Admin application URL, non-standard environment target, or role is missing. | A new deployer cannot safely perform non-standard import steps. | Provide URL, required admin role, or the story-specific environment exception. |
| RNM-DI-008 | AWS account or role is missing for a pipeline deployment. | Pipeline could be promoted in the wrong account or role. | Confirm AWS account, role, and pipeline owner. |
| RNM-DI-009 | Story-level Deployment Notes do not include validation expectations. | Release Management may not know how to confirm success. | Use the Deployment Notes Standard or ask the developer/release owner for validation details. |
| RNM-DI-010 | Shared artifact or duplicate deployment action lacks a coordinator story. | Duplicate execution or missed final artifact ownership is possible. | Identify a master/coordinator story or ask Release Management to assign one. |

## Source Handling Rules

- Use exact release metadata when available.
- For Deployment Notes, retrieve or reference the current Deployment Notes Standard for Jira Work Items when available; treat that Confluence page as authoritative over stale Studio instructions.
- Do not substitute MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, or other Jira hygiene pages for the Deployment Notes Standard.
- Keep unsupported assumptions out of the release notes draft.
- Preserve source traceability in an internal review checklist.
- Avoid naming private source URLs in broad user-facing output unless the user supplied them for that purpose.
- Use `None identified` when no source exists, rather than inventing one.
- For deployment runbooks, treat Jira stories as evidence, not as the final runbook structure.
- Group deployment work into work packages by system, action type, and dependency.
- Collapse exact duplicate deployment notes into one work package and list all source stories.
- Group related actions that use the same system or admin path, but do not collapse them when files, properties, or pipelines differ.
- Label branch, role, admin-path, AWS account, and story-specific environment exceptions as data incomplete unless the source evidence confirms them.
- Do not add rollback/recovery sections to Jira Deployment Notes. Release Management owns rollback execution outside the story-level Deployment Notes field.
- Flag missing validation expectations when story-level Deployment Notes do not provide them.
- Use bullets instead of Markdown tables when producing Jira Deployment Notes field drafts.
- Keep unresolved questions outside the Jira Deployment Notes field under `Questions To Resolve Before Finalizing`.
- Do not infer implementation platforms such as AWS Parameter Store unless the source explicitly says so.
- Exclude `NA` or no-manual-action stories from deployment work packages; list them separately as no-action items when useful.
- Do not invent release metadata, release names, source JQL, IAM systems, screenshot-capture requirements, rollback/recovery gaps, or adjacent process questions unless the source or user asks for them.

## Default Deployment Ordering Rules

| Work package type | Default order | Notes |
|---|---|---|
| Runtime properties | Pre-deployment | Usually required before application deployment unless the release owner says otherwise. |
| Guidewire application file imports | Pre-deployment or deployment window | Use admin application import steps and confirm target app, environment, and branch. |
| AWS CodePipeline promotions | Flexible | Can often run before, during, or after Guidewire deployment unless a dependency is stated. Confirm AWS account and role. |
| Special timed changes | Explicit source timing wins | Follow story-specific timing such as evening deployment or live-date requirements. |
| Validation | After each work package | Do not wait until the end if a package has its own validation. |

## Knowledge Source Review

| Review item | Status | Notes |
|---|---|---|
| Jira projects or filters confirmed | Partial | Exact fixVersion JQL is known; broader project/filter ownership still needs confirmation. |
| Mobilitas Bitbucket app repos confirmed | Done | ClaimCenter, PolicyCenter, BillingCenter, and ContactManager repos are documented. |
| Branch/tag selection rule confirmed | Partial | Use release branch such as `release/r-64.0` or `develop` depending on release context; ask when unclear. |
| Confluence source spaces confirmed | Open | Needs source access review. |
| Release-note templates confirmed | Open | Needs process-owner input. |
| Deployment Notes Standard available | Draft | Published for pilot use with Jira Work Item Assistant and Release Notes Manager. |
| Deployment Notes Agent Pilot available | Draft | Use historical cards to validate release-level grouping before active promotion. |
| Archive sources separated from active instructions | Done | Mobilitas is archive/reference only. |
| Permission model reviewed | Open | Needs Studio/admin confirmation. |
