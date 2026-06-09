# Jira Ticket Polisher Project Brain

> **Archived / Superseded - 2026-06-09**
>
> Jira Ticket Polisher is retained for governance history only. Use Jira Work Item Assistant for active Jira ticket drafting, review, polishing, standards alignment, gap checking, and comment drafting. Do not configure or promote Jira Ticket Polisher as a separate user-facing agent unless a new governed decision reopens it.

## Project Brain Status

| Field | Value |
|---|---|
| Agent name | Jira Ticket Polisher |
| Domain | Jira Hygiene |
| Lifecycle status | Archived / Superseded |
| Readiness status | Historical Reference |
| Fit decision | Superseded by Jira Work Item Assistant |
| Primary owner | TBD |
| Backup owner | TBD |
| Current source space | ROVO |
| Legacy source | MO > Rovo Agents > Experimental / Sandbox Agents > Agent - Jira Ticket Polisher |
| Recommended location | ROVO > Agent Project Brains > Jira Hygiene Agents |
| Last reviewed | 2026-06-09 |
| Next action | Preserve this page as historical reference and route active ticket review/polish work to Jira Work Item Assistant. |

## Migration Decision

Jira Ticket Polisher should not continue as a standalone governed user-facing agent.

The old-space export identified it as the best early pilot for the organization-wide standard plus team-overlay pattern. Jira Work Item Assistant now covers the same practical service area: existing-card review, ticket polishing, standards alignment, gap checking, improved copy drafts, common-task guidance, and draft-only Jira comments. The useful Polisher review criteria should live inside Jira Work Item Assistant's five-subagent model rather than as a separate active agent.

## Mission

Jira Ticket Polisher historically helped Jira users improve ticket clarity, completeness, and handoff readiness. Active use now belongs to Jira Work Item Assistant, which reviews tickets against the organization-wide Jira ticket quality standard first, then applies a team-specific overlay only when a relevant team standard is available or supplied by the user.

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
| Jira Work Item Assistant | Replacement active agent for Jira ticket drafting, existing-card review, polishing, standards alignment, gap checking, common-task guidance, and draft-only status comments. |
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
| Team standards index | Team Jira Standards |
| Research report | Jira Ticket Polisher Migration Research Report |

## Operating Model

1. User provides or selects a Jira ticket, paste, export row, or ticket summary.
2. Agent identifies issue type, project/team context, visible fields, and user intent.
3. Agent applies the organization-wide ticket quality standard.
4. Agent applies a team overlay only when the relevant team standard is available or explicitly supplied.
5. Agent returns gaps, evidence used, missing evidence, and draft improvement text.
6. Human ticket owner reviews and applies any changes in Jira.

## Historical Jira Work Item Assistant Handoff Pattern

Jira Ticket Polisher previously could receive a structured `Jira Work Item Draft Bundle` from Jira Work Item Assistant before a Jira work item was created. This is now a historical pattern. Jira Work Item Assistant should handle Ticket Review / Polish internally without adding a sixth subagent.

Handoff contract:

```text
schemas/jira-work-item-draft-bundle.schema.json
```

Default flow:

1. User asks Jira Work Item Assistant to create or prepare a Jira ticket from Kanban or work context.
2. Jira Work Item Assistant drafts copy-ready fields first.
3. If the user explicitly asks for machine-readable packaging or a Draft Bundle, Jira Work Item Assistant creates a `Jira Work Item Draft Bundle` with approval set to false.
4. Jira Work Item Assistant applies standards, identifies missing evidence, and returns polished Jira field drafts through its existing subagents.
5. Jira creation or update remains blocked until a human approves through a separately governed write path.

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
| MOBRM standard is published in ROVO. | The first team overlay is available for pilot use. | Run Studio evaluations against a `MOBRM-*` ticket and a non-MOBRM fallback ticket. |
| Additional team standards are intentionally out of scope. | The agent should use the org-wide fallback for other teams. | Add future team standards only after a team-owned source, exact mapping, and owner review are confirmed. |
| Approved organization-wide standard is newly drafted. | Needs working-group review before broad use. | Review and approve the standard with representative ticket owners. |
| Studio configuration has not been manually applied or captured. | Runtime behavior cannot be validated. | Copy the Studio blocks manually, run evaluations, and capture safe evidence. |
| Pilot audience is not confirmed. | Visibility and feedback route are unclear. | Define a small pilot audience before launch. |

## Launch Decision

Current decision: archived / superseded.

Jira Ticket Polisher should not be promoted, configured in Studio, or presented as a separate active service area. Keep the page family visible for governance history, source provenance, rollback context, and comparison only.
