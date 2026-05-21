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
| Product or business summary | Confluence / supplied text | Process Authority | Translate technical changes into audience-specific summaries. | Per release | Keep business summary out of scope until provided. |
| Release Health Analyst output | Confluence / supplied text | Reference | Reuse health findings, blockers, and data-completeness flags. | Per run | Route health scoring back to Release Health Analyst. |
| Mobilitas Release Notes Agent materials | Legacy export / archive | Archive Reference | Learn from examples only when relevant. | Static | Do not generalize as default behavior. |

## Required Input Check

Before drafting final-seeming content, the agent must confirm:

- Target release identifier or exact issue list.
- Intended audience: technical, business, executive, operations, or mixed.
- At least one source for release scope.
- Whether an existing release notes page or template should be followed.
- Whether blocked, deferred, or partial items should be included.

## Data Incomplete Flags

| Flag ID | Missing or incomplete data | Impact | How to clear |
|---|---|---|---|
| RNM-DI-001 | Exact release identifier is missing. | Release scope cannot be validated. | Provide fixVersion, release link, or issue list. |
| RNM-DI-002 | Jira scope source is inaccessible. | Draft may omit or include wrong issues. | Grant access, provide export, or paste issue list. |
| RNM-DI-003 | Release notes draft or template is inaccessible. | Format and prior content cannot be synchronized. | Grant access or paste the draft/template. |
| RNM-DI-004 | Business audience context is missing. | Business summary may be misleading or incomplete. | Provide audience, product summary, or stakeholder context. |
| RNM-DI-005 | Source conflict found. | Final notes cannot be trusted. | Release owner resolves authoritative source. |

## Source Handling Rules

- Use exact release metadata when available.
- Keep unsupported assumptions out of the release notes draft.
- Preserve source traceability in an internal review checklist.
- Avoid naming private source URLs in broad user-facing output unless the user supplied them for that purpose.
- Use `None identified` when no source exists, rather than inventing one.

## Knowledge Source Review

| Review item | Status | Notes |
|---|---|---|
| Jira projects or filters confirmed | Open | Needs owner confirmation. |
| Confluence source spaces confirmed | Open | Needs source access review. |
| Release-note templates confirmed | Open | Needs process-owner input. |
| Archive sources separated from active instructions | Done | Mobilitas is archive/reference only. |
| Permission model reviewed | Open | Needs Studio/admin confirmation. |
