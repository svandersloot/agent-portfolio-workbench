# Jira Ticket Polisher Migration Research Report

Date: 2026-05-29

## Summary

This report captures the research evidence used to scaffold Jira Ticket Polisher as a governed, draft-only ROVO agent.

Live Atlassian research was limited in the initial scaffold. The current active standards decision is now narrower: keep the ROVO-facing Jira Ticket Polisher standards set to the organization-wide Jira ticket quality standard plus the MOBRM team standard only.

## Sources Reviewed

| Source | Result |
|---|---|
| `rovo-export/entities.xml` | Found `Jira Ticket Polisher Project Brain Draft`, `Jira Hygiene Agents`, and migration notes identifying the org-wide plus team-overlay pattern. |
| `docs/confluence-pages/agent-inventory.md` | Jira Ticket Polisher was listed as Candidate / Idea-Draft / Not Ready before this scaffold. |
| `docs/reports/governance-completeness-dry-run.md` | Jira Ticket Polisher draft was missing owner, backup owner, sources, tools, measurement, readiness, and review fields. |
| `docs/confluence-pages/agent-fit-intake.md` | Confirmed governed agent completeness and fit decision requirements. |
| `docs/confluence-pages/release-drift-monitor-*` | Provided reusable evidence discipline patterns for exact Jira context, team standards, and no false claims from missing sources. |
| User-provided MOBRM Team Jira Standards URL | Live page `MO` page `5266898945`, version `3`, identified as the team-owned source for MOBRM. |
| Supplied Atlassian folder URL | Initial broad folder access was not used for the active standards set. |
| Authenticated Chrome automation | Not available in this session; Confluence page retrieval used the repo's API publishing/auth path. |

## Legacy Evidence Summary

The old-space Project Brain draft described Jira Ticket Polisher as:

- A Jira Hygiene agent.
- Experimental / promote candidate.
- Organization-wide scope with team overlays.
- Draft-only unless write-capable Jira skills are explicitly approved in the future.
- Designed to apply organization-wide standards first, then team-specific Confluence standards when available.
- Required to state when no team overlay was applied.

The old `Jira Hygiene Agents` index described Jira hygiene work as improving ticket quality, metadata consistency, acceptance criteria, reporting readiness, and workflow clarity.

## Derived Organization-Wide Standard

The organization-wide standard was derived from the legacy draft, existing governance rules, and common ticket quality dimensions:

- Clear outcome.
- User or business value.
- Issue type fit.
- Scope boundary.
- Acceptance criteria.
- Dependencies.
- Priority or severity rationale.
- Technical and source context.
- QA and validation expectations.
- Data, config, environment, release, and rollout needs.
- Labels, components, ownership, risks, and readiness signals.

This is now documented in `Organization-Wide Jira Ticket Quality Standard`.

## Active Standards Status

| Standard | Status | Result |
|---|---|---|
| Organization-Wide Jira Ticket Quality Standard | Drafted locally and published to ROVO in the Jira Ticket Polisher page set. | Default fallback for every ticket review. |
| MOBRM Team Jira Standards | Source found in `MO` page `5266898945`, version `3`; migrated locally for ROVO review. | Only active team overlay for the current pilot. |

## Key Design Decisions

| Decision | Rationale |
|---|---|
| Keep one org-wide agent. | Prevents duplicate team-specific agents and keeps shared behavior consistent. |
| Make the org-wide standard the fallback. | Allows useful review when team standards are missing. |
| Keep overlays explicit. | Prevents false claims that a team standard was applied. |
| Separate documented standards from observed patterns. | Avoids turning ticket samples into policy without team owner approval. |
| Keep Jira behavior draft-only. | Direct Jira writes need a separate governed workflow, owner, and evaluation. |
| Keep ROVO as the migrated source of truth. | The agent documentation, standards pages, Studio copy blocks, and inventory entry belong in the ROVO governance space. |
| Keep the active standards page small. | Current ROVO-facing standards should include only the organization-wide standard and MOBRM team standard. |
| Do not use related keys as MOBRM triggers. | `MR26`, `M26`, and `CLE` references do not trigger the MOBRM overlay by themselves. |

## Recommended Next Research Pass

1. Publish the MOBRM Team Jira Standards page in the chosen ROVO location after approval.
2. Update the active standards index page in ROVO so it names only the organization-wide standard and MOBRM overlay.
3. Run evaluation cases for an org-wide fallback ticket, a `MOBRM-*` ticket, and a wrong-overlay boundary case.
4. Add future team standards only after a team-owned source, exact project/board/filter mapping, owner, and application boundaries are confirmed.

## Current Recommendation

Move Jira Ticket Polisher from Candidate / Idea-Draft / Not Ready to Governed agent / In Review / Needs Cleanup in the local inventory. Do not promote to Experimental or Active until live research, owner assignment, Studio copy/capture, and evaluation evidence are complete.
