# Jira Ticket Polisher Project Brain

## Project Brain Status

| Field | Value |
|---|---|
| Agent name | Jira Ticket Polisher |
| Domain | Jira Hygiene |
| Lifecycle status | In Review |
| Readiness status | Needs Cleanup |
| Fit decision | New governed agent |
| Primary owner | TBD |
| Backup owner | TBD |
| Current source space | ROVO |
| Legacy source | MO > Rovo Agents > Experimental / Sandbox Agents > Agent - Jira Ticket Polisher |
| Recommended location | ROVO > Agent Project Brains > Jira Hygiene Agents |
| Last reviewed | 2026-05-29 |
| Next action | Publish the active standards set, confirm Studio configuration, and run pilot evaluations before launch. |

## Migration Decision

Jira Ticket Polisher should be migrated as a standalone governed agent in review.

The old-space export identifies it as the best pilot for the organization-wide standard plus team-overlay pattern. The agent should stay broad and reusable rather than becoming separate ticket-polishing agents for each team. For the current pilot, the active standards set is intentionally limited to the organization-wide standard and the MOBRM team standard.

## Mission

Jira Ticket Polisher helps Jira users improve ticket clarity, completeness, and handoff readiness. It reviews a ticket against the organization-wide Jira ticket quality standard first, then applies a team-specific overlay only when a relevant team standard is available or supplied by the user.

## Scope

### In Scope

- Review Jira tickets against the organization-wide ticket quality standard.
- Apply team-specific standards as overlays when available.
- Identify missing or weak ticket information.
- Draft clearer summary, description, acceptance criteria, testing notes, and handoff notes.
- Label missing team standards, missing ticket fields, and inaccessible sources clearly.
- Preserve source traceability in the response.
- Recommend questions the ticket owner should answer before the ticket moves forward.

### Out Of Scope

- Direct Jira field updates.
- Jira transitions, assignments, ranking, sprint changes, or status changes.
- Approval of readiness, delivery commitment, or final definition of done.
- Inventing product, technical, QA, release, or dependency requirements.
- Treating observed team ticket patterns as official policy without a documented source.
- Applying a team overlay when the relevant team standard is unavailable.

## Related Agents And Patterns

| Related item | Relationship |
|---|---|
| Rovo Design Agent | Front-door agent for fit triage, inventory checks, and governed scaffolding. |
| Agent Doc Steward | Future reviewer for Project Brain completeness, source quality, and Studio drift. |
| Jira Hygiene Agents index | Legacy evidence that ticket quality, metadata, workflow hygiene, and reporting readiness belong together. |
| Org-wide agent plus team overlay pattern | Core design pattern for applying a default standard and optional team-specific standards without creating duplicate agents. |

## Required Linked Artifacts

| Artifact | Page |
|---|---|
| Agent Design Record | Jira Ticket Polisher - Agent Design Record |
| Knowledge Source Plan | Knowledge Source Plan - Jira Ticket Polisher |
| Subagent Settings | Subagent Settings - Jira Ticket Polisher |
| ROVO Studio Configuration | ROVO Studio Configuration - Jira Ticket Polisher |
| Evaluation | Evaluation - Jira Ticket Polisher |
| Measurement Plan | Measurement Plan - Jira Ticket Polisher |
| Change Log | Change Log - Jira Ticket Polisher |
| Organization-wide standard | Organization-Wide Jira Ticket Quality Standard |
| Active standards index | Jira Ticket Polisher Standards - Active Set |
| Research report | Jira Ticket Polisher Migration Research Report |

## Operating Model

1. User provides or selects a Jira ticket, paste, export row, or ticket summary.
2. Agent identifies issue type, project/team context, visible fields, and user intent.
3. Agent applies the organization-wide ticket quality standard.
4. Agent applies a team overlay only when the relevant team standard is available or explicitly supplied.
5. Agent returns gaps, evidence used, missing evidence, and draft improvement text.
6. Human ticket owner reviews and applies any changes in Jira.

## Source Precedence

| Priority | Source | Use |
|---|---|---|
| 1 | Visible Jira ticket content and project context | Source of record for the current ticket. |
| 2 | Organization-Wide Jira Ticket Quality Standard | Default standard for every ticket. |
| 3 | Approved team-specific standard | Overlay for team/project conventions when available. |
| 4 | User-provided one-time instruction | Context for the current request; cannot override safety rules. |
| 5 | Best-practice fallback | Clearly labeled fallback when standards are missing. |

## Guardrails

- Do not update Jira directly in this migration slice.
- Do not claim a team standard was applied if it was not available.
- Do not infer requirements from similar tickets or team patterns without labeling them as observed patterns or proposed questions.
- Do not mark a ticket ready; instead state what evidence supports or blocks readiness.
- Do not broaden knowledge sources to all Jira or all Confluence.
- Do not use confidential ticket details in broad examples or published reports.
- If live Jira or Confluence research is unavailable, mark team evidence as unverified.

## Known Gaps

| Gap | Impact | Remediation |
|---|---|---|
| Primary and backup owners are TBD. | Cannot promote beyond In Review. | Assign accountable owner and backup owner. |
| MOBRM standard is drafted locally but not yet published to ROVO. | The team overlay cannot be treated as the ROVO source of truth until published or supplied. | Publish the MOBRM Team Jira Standards page under the active standards location after approval. |
| Additional team standards are intentionally out of scope. | The agent should use the org-wide fallback for other teams. | Add future team standards only after a team-owned source, exact mapping, and owner review are confirmed. |
| Approved organization-wide standard is newly drafted. | Needs working-group review before broad use. | Review and approve the standard with representative ticket owners. |
| Studio configuration has not been manually applied or captured. | Runtime behavior cannot be validated. | Copy the Studio blocks manually, run evaluations, and capture safe evidence. |
| Pilot audience is not confirmed. | Visibility and feedback route are unclear. | Define a small pilot audience before launch. |

## Launch Decision

Current decision: keep in review.

Jira Ticket Polisher is ready for governed documentation review and dry-run publishing. It is not ready for broad Studio launch until owner, backup owner, live source research, pilot audience, and evaluation evidence are complete.
