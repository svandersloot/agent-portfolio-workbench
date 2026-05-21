# Release Notes Manager Project Brain

## Project Brain Status

| Field | Value |
|---|---|
| Agent name | Release Notes Manager |
| Domain | Release and Change Management |
| Lifecycle status | In Review |
| Readiness status | Needs Cleanup |
| Fit decision | New governed agent |
| Primary owner | TBD |
| Backup owner | TBD |
| Current source space | MO |
| Legacy source | MO > Release and Change Agents > Release Notes Manager |
| Recommended location | Agent Project Brains > Release and Change Agents |
| Last reviewed | 2026-05-21 |
| Next action | Confirm owner, source access, Studio configuration, and pilot audience before launch. |

## Migration Decision

Release Notes Manager should be migrated as a standalone governed agent in review.

The old-space export and inventory evidence show four related release/change assets:

| Asset | Migration handling |
|---|---|
| Release Health Analyst | Keep as the release health, readiness, blocker, and data-completeness agent. |
| Release Management Assistant | Review later for overlap with release coordination workflows. |
| Release Notes Manager | Migrate as a governed agent focused on release notes planning, drafting, review support, and source synchronization. |
| Mobilitas Release Notes Agent | Keep as archive/reference evidence only; do not make Mobilitas-specific language the central standard. |

## Mission

Release Notes Manager helps release owners, product partners, and delivery teams assemble accurate, audience-appropriate release notes from approved sources while preserving human ownership of final publication.

## Scope

### In Scope

- Draft technical release notes from approved Jira, Confluence, and release-planning sources.
- Draft business-facing release summaries from approved release context.
- Compare requested release scope against known fixVersion, change, or release-plan evidence.
- Flag missing evidence, source conflicts, and items requiring release-owner review.
- Produce copy-ready release note sections for human review.
- Maintain a source synchronization checklist for release notes updates.

### Out Of Scope

- Final publication without human approval.
- Release go/no-go decisions.
- Deployment execution.
- Incident, rollback, or change approval workflows.
- Broad release health scoring already owned by Release Health Analyst.
- Project-specific Mobilitas procedures unless explicitly provided as source context for that release.

## Related Agents And Patterns

| Related item | Relationship |
|---|---|
| Release Health Analyst | Reuse fail-closed metadata validation, strict fixVersion matching, source completeness flags, and human review patterns. Do not duplicate health scoring. |
| Release Management Assistant | Potential coordination overlap; keep separate until an owner review confirms whether coordination belongs here or there. |
| Mobilitas Release Notes Agent | Archive/reference example for domain-specific templates. Do not generalize Mobilitas language as the default. |
| Release and Change Agents index | Legacy evidence that Release Notes Manager has a parent/subagent pattern for technical, business, and sync modes. |

## Required Linked Artifacts

| Artifact | Page |
|---|---|
| Agent Design Record | Release Notes Manager - Agent Design Record |
| Knowledge Source Plan | Knowledge Source Plan - Release Notes Manager |
| Subagent Settings | Subagent Settings - Release Notes Manager |
| ROVO Studio Configuration | ROVO Studio Configuration - Release Notes Manager |
| Evaluation | Evaluation - Release Notes Manager |
| Measurement Plan | Measurement Plan - Release Notes Manager |
| Change Log | Change Log - Release Notes Manager |

## Operating Model

1. User provides the target release, intended audience, and available source links.
2. Agent validates that release metadata is specific enough to evaluate.
3. Agent routes to technical notes, business summary, or synchronization review.
4. Agent drafts or checks release notes from approved sources only.
5. Agent flags incomplete, conflicting, or inaccessible evidence.
6. Human release owner reviews, edits, and approves final release notes.

## Guardrails

- Do not infer release scope from unsupported context.
- Do not use fuzzy fixVersion matching when a Jira fixVersion is required.
- Do not present final release notes as approved until a human release owner approves them.
- Do not publish or update Confluence pages directly from the agent unless a future approved write workflow is documented.
- If source evidence is incomplete, mark the output as `Data Incomplete`.
- If a request is actually release readiness, blocker analysis, or health scoring, route to Release Health Analyst.

## Known Gaps

| Gap | Impact | Remediation |
|---|---|---|
| Primary and backup owners are TBD. | Cannot promote beyond In Review. | Assign accountable owner and backup owner. |
| Live Studio configuration has not been captured in this repo. | Drift cannot be measured. | Manually configure or capture Studio, then normalize safe evidence. |
| Approved knowledge sources need confirmation. | Agent could rely on stale or incomplete source context. | Confirm Jira projects, Confluence spaces, release templates, and permission model. |
| Pilot audience is not confirmed. | Visibility cannot be safely broadened. | Define initial release-owner and stakeholder group. |
| Measurement baseline is estimated only. | Value tracking starts directional. | Capture baseline after first two pilot releases. |

## Launch Decision

Current decision: keep in review.

Release Notes Manager can be prepared for a controlled pilot after owner, source, audience, and evaluation gaps are closed. It should not replace Release Health Analyst and should not inherit Mobilitas-specific instructions as default behavior.
