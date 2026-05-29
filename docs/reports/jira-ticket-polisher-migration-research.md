# Jira Ticket Polisher Migration Research Report

Date: 2026-05-29

## Summary

This report captures the research evidence used to scaffold Jira Ticket Polisher as a governed, draft-only ROVO agent.

Live Atlassian research was attempted but not completed in this session. The supplied Confluence folder requires authenticated access, public web fetch did not return page content, and Chrome automation was unavailable with `browser-client is not trusted`. The scaffold therefore uses local repo evidence, old-space export evidence, and the user-provided MR26 June release research seed. Team overlays remain draft/unverified until authenticated research or safe exports can be reviewed.

## Sources Reviewed

| Source | Result |
|---|---|
| `rovo-export/entities.xml` | Found `Jira Ticket Polisher Project Brain Draft`, `Jira Hygiene Agents`, and migration notes identifying the org-wide plus team-overlay pattern. |
| `docs/confluence-pages/agent-inventory.md` | Jira Ticket Polisher was listed as Candidate / Idea-Draft / Not Ready before this scaffold. |
| `docs/reports/governance-completeness-dry-run.md` | Jira Ticket Polisher draft was missing owner, backup owner, sources, tools, measurement, readiness, and review fields. |
| `docs/confluence-pages/agent-fit-intake.md` | Confirmed governed agent completeness and fit decision requirements. |
| `docs/confluence-pages/release-drift-monitor-*` | Provided reusable evidence discipline patterns for exact Jira context, team standards, and no false claims from missing sources. |
| User-provided MR26 June release filter | Added as the first concrete fallback research path: `project = MR26 AND fixVersion = "Mobilitas 2026.06.12"` or equivalent MR26-key export. |
| Supplied Atlassian folder URL | Not accessible through public fetch in this session. |
| Authenticated Chrome automation | Not available in this session; connection failed before any live page read. |

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

## Team Research Status

| Team or board | Live standards found? | Tickets sampled? | Result |
|---|---|---|---|
| Breaking Backlogs | No | No | Draft placeholder only. |
| 404 Errors | No | No | Draft placeholder only. |
| MR26 / Mobi Rangers | No | No live board sample; MR26 June release filter identified for next pass. | Draft placeholder only; release evidence patterns are not official ticket standards. |
| Mobilizers | No | No | Draft placeholder only. |

## Key Design Decisions

| Decision | Rationale |
|---|---|
| Keep one org-wide agent. | Prevents duplicate team-specific agents and keeps shared behavior consistent. |
| Make the org-wide standard the fallback. | Allows useful review when team standards are missing. |
| Keep overlays explicit. | Prevents false claims that a team standard was applied. |
| Separate documented standards from observed patterns. | Avoids turning ticket samples into policy without team owner approval. |
| Keep Jira behavior draft-only. | Direct Jira writes need a separate governed workflow, owner, and evaluation. |
| Keep ROVO as the migrated source of truth. | Mobilitas/MR26 can provide sample tickets, but the agent documentation and inventory entry belong in the ROVO governance space. |

## MR26 June Release Research Seed

Use this as the first concrete fallback research slice when live Jira or a safe export is available:

```text
project = MR26 AND fixVersion = "Mobilitas 2026.06.12"
```

If the Jira instance requires filtering by issue key rather than project, use the equivalent MR26-key export for tickets whose keys begin with `MR26-`, including examples such as `MR26-3082` when present in the result set.

Research goals for the sample:

- Pull 10-15 MR26-key tickets across useful workflow states.
- Record issue type, status, summary shape, description structure, acceptance criteria presence, QA/test notes, deployment/release notes, labels/components, dependencies, and evidence links.
- Separate documented standards from observed patterns.
- Treat the sample as Mobilitas/Mobi Rangers evidence only; do not make it the organization-wide default.
- Publish only safe aggregate observations, not private ticket contents.

## Recommended Next Research Pass

1. Use authenticated Atlassian access to inspect the supplied Confluence folder.
2. Start with the MR26 June release sample using `project = MR26 AND fixVersion = "Mobilitas 2026.06.12"` or equivalent MR26-key export.
3. Resolve exact standard pages for Breaking Backlogs, 404 Errors, MR26 / Mobi Rangers, Mobilizers, and any related teams.
4. Confirm Jira project keys, board names, and filters for each team.
5. Sample 10-15 safe tickets per team across ready, in progress, done, blocked, reopened, or recently refined states.
6. Record only non-sensitive patterns in repo docs.
7. Update team overlays after team-owner review.

## Current Recommendation

Move Jira Ticket Polisher from Candidate / Idea-Draft / Not Ready to Governed agent / In Review / Needs Cleanup in the local inventory. Do not promote to Experimental or Active until live research, owner assignment, Studio copy/capture, and evaluation evidence are complete.
