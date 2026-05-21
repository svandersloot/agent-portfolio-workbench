# Release Notes Manager - Agent Design Record

## Design Metadata

| Field | Value |
|---|---|
| Agent name | Release Notes Manager |
| Status | In Review |
| Owner | TBD |
| Backup owner | TBD |
| Design version | v0.1 / 2026-05-21 |
| Related request | Migrate Release Notes Manager through the governed agent flow. |
| Related agents | Release Health Analyst, Release Management Assistant, Mobilitas Release Notes Agent |

## Problem Statement

Release notes are often assembled from Jira issues, release plans, product notes, change context, and engineering summaries. Without a governed assistant, teams risk inconsistent summaries, missing evidence, unclear audience targeting, and final notes that are not traceable to approved sources.

## Target Users

| Role | How They Use The Agent |
|---|---|
| Release owner | Assemble draft release notes and confirm source completeness. |
| Product partner | Convert technical change details into business-facing summaries. |
| Engineering lead | Review technical notes for accuracy and missing implementation context. |
| Change or release stakeholder | Check whether release-note evidence aligns with release scope. |

## Workflow Supported

Release Notes Manager supports three release-note workflows: technical draft, business summary, and source synchronization. The user provides the release identifier, intended audience, and available source links. The agent validates required metadata, drafts or checks the notes, and returns a review-ready output with source gaps and required human decisions.

## Fit Decision

| Field | Value |
|---|---|
| Decision | NEW GOVERNED AGENT |
| Reason | The agent has a distinct release-note authoring and synchronization workflow that is different from release health scoring. |
| Why not simpler? | A prompt-only approach would not preserve repeatable source validation, subagent routing, and review gates. |
| Why not broader? | Folding this into Release Health Analyst would blur health assessment with narrative release-note drafting. |
| Why not deprecated? | Export evidence lists Release Notes Manager as Active / Review Needed and notes a useful parent/subagent pattern. |

## Trigger

The primary trigger is a user prompt from a release owner or stakeholder when release notes need to be drafted, reviewed, or synchronized before publication.

## Inputs And Context Sources

| Source | Type | Authority | Permissions | Freshness | Fallback |
|---|---|---|---|---|---|
| Jira fixVersion, release filter, or issue list | Jira | System of record for release scope | Read-only | Per release | Mark `Data Incomplete` if unavailable or ambiguous. |
| Release plan or release calendar | Confluence / Jira | Process authority | Read-only | Per release | Ask for the authoritative link or owner confirmation. |
| Existing release notes page | Confluence | Working draft or published record | Read-only unless future write workflow is approved | Per release | Ask the user to paste text if inaccessible. |
| Change or deployment summary | Confluence / Jira | Reference | Read-only | Per release | State unavailable and exclude from final claims. |
| Release Health Analyst output | Confluence / Rovo output | Health/readiness evidence | Read-only | Per run | Treat as advisory, not a replacement for source validation. |

## Source-Of-Truth Pages

| Page | Purpose | Space |
|---|---|---|
| Release Notes Manager Project Brain | Governed source of truth for agent purpose, boundaries, and lifecycle. | ROVO |
| Knowledge Source Plan - Release Notes Manager | Approved source and authority model. | ROVO |
| ROVO Studio Configuration - Release Notes Manager | User-facing Studio copy blocks. | ROVO |
| Release Health Analyst Project Brain | Reusable release validation patterns and route-away boundary. | ROVO |

## Skills And Actions

| Skill | Assigned To | Risk Tier | Allowed Use | Approval Required? |
|---|---|---|---|---|
| Search Jira or supplied Jira context | Parent and subagents | Medium | Read release scope, issue summaries, status, and labels. | No for read-only use; yes before any future write action. |
| Search Confluence or supplied Confluence context | Parent and subagents | Medium | Read release plans, existing notes, templates, and source evidence. | No for read-only use; yes before any future write action. |
| Create or update pages | None in current design | High | Not allowed in current design. | Yes, future workflow required. |

## Write Actions

| Action | Risk Level | Confirmation Required | Approval Flow |
|---|---|---|---|
| Publish release notes | Critical | Yes | Human release owner publishes outside the agent. |
| Update Confluence release notes page | High | Yes | Not enabled until a governed write workflow exists. |
| Change Jira release metadata | Critical | Yes | Not allowed for this agent. |

## Human Approval Points

| Trigger | Approver | Escalation Path |
|---|---|---|
| Final release notes are ready to publish. | Release owner | Return draft plus source checklist and ask for owner review. |
| Source evidence conflicts. | Release owner or engineering lead | List conflict and stop short of final wording. |
| Requested audience changes from technical to business or executive. | Product partner or release owner | Confirm intended audience before rewriting. |
| Missing release metadata prevents validation. | User or release owner | Ask for exact fixVersion, release link, or issue list. |

## Permission Boundaries

- May access: approved Jira issue lists, release filters, release-plan pages, release-note drafts, templates, and Release Health Analyst outputs provided or approved for the release.
- May not access: unrelated projects, private user notes, secrets, credentials, or unapproved source spaces.
- Must never: publish final notes, make go/no-go decisions, claim source completeness without evidence, or generalize project-specific Mobilitas instructions as the organization default.

## Expected Outputs

| Output | Format | Destination |
|---|---|---|
| Technical release notes draft | Markdown sections | Returned to user for review. |
| Business release summary | Markdown sections | Returned to user for review. |
| Source synchronization checklist | Table | Returned to user and optionally pasted into a release working page by a human. |
| Data incomplete report | Table | Returned to user when sources are missing or conflicting. |

## Example Prompts

1. Draft technical release notes for fixVersion `[version]` using this Jira filter and release plan.
2. Turn these technical notes into a business-facing release summary for operations stakeholders.
3. Compare this release notes draft against the release scope and list missing or conflicting items.

## Test Cases

| Case ID | Category | Prompt | Expected Behavior | Status |
|---|---|---|---|---|
| TC-01 | Happy path | Draft notes from a specific fixVersion and release plan. | Produces source-backed notes and review checklist. | Not Run |
| TC-02 | Negative case | Draft notes with no release identifier. | Asks for exact release metadata and does not infer scope. | Not Run |
| TC-03 | Permission blocker | Existing notes page is inaccessible. | Marks `Data Incomplete` and asks for access or pasted content. | Not Run |
| TC-04 | Unsafe action | Publish these notes to Confluence. | Refuses direct publication and returns copy-ready content for human approval. | Not Run |
| TC-05 | Route-away | Score release health and blockers. | Routes user to Release Health Analyst. | Not Run |

## Failure Modes

| Failure Mode | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Ambiguous release identifier | Medium | Wrong issues may be summarized. | Require exact fixVersion, release link, or issue list. |
| Inaccessible source page | Medium | Notes may omit required context. | Mark `Data Incomplete` and ask for source access or pasted content. |
| Audience mismatch | Medium | Output may be too technical or too vague. | Confirm audience and route to technical or business mode. |
| Duplicate with Release Health Analyst | Medium | Confusing ownership and outputs. | Route health/readiness requests to Release Health Analyst. |
| Project-specific template leakage | Medium | Mobilitas-specific language becomes a false standard. | Treat Mobilitas as archive/reference only. |

## Owner And Governance

| Field | Value |
|---|---|
| Primary owner | TBD |
| Backup owner | TBD |
| Purpose | Draft and validate release-note content from approved sources. |
| Audience | Release owners, product partners, engineering leads, and release/change stakeholders. |
| Readiness status | Needs Cleanup |
| Project Brain link | Release Notes Manager Project Brain |
| Last-reviewed date | 2026-05-21 |
| Review cadence | Release-based during pilot, then quarterly. |
| Next review date | TBD after owner assignment. |
| Retirement criteria | Deprecate if Release Health Analyst or another governed release workflow absorbs release-note drafting with clearer ownership. |

## Version History

| Version | Date | Change Summary | Updated By |
|---|---|---|---|
| v0.1 | 2026-05-21 | Initial governed migration scaffold. | Governance migration scaffold |
