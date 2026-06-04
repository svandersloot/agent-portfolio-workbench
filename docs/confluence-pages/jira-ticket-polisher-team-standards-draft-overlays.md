# Jira Ticket Polisher Standards - Active Set

Use this page to identify the active standards Jira Ticket Polisher may apply during the current pilot. The standards themselves live under the shared Jira Ticket Standards tree so Jira Work Item Assistant, Jira Ticket Polisher, and future Jira hygiene agents use the same source of truth. Keep the active set intentionally small until additional team standards are reviewed and approved.

## Active Standards

| Standard | Status | Applies when | Source |
|---|---|---|---|
| Organization-Wide Jira Ticket Quality Standard | Active draft / default fallback | Every ticket review | `docs/confluence-pages/jira-ticket-quality-standard.md` |
| Team Jira Standards | Active index | Approved team overlays in the active set | `docs/confluence-pages/team-jira-standards.md` |
| MOBRM Team Jira Standards | Published active overlay | Jira project key is `MOBRM`, or approved MOBRM board `7690` is visible | `docs/confluence-pages/team-jira-standards.md` > `docs/confluence-pages/mobrm-team-jira-standards.md` |

## Current Scope

- Apply the organization-wide standard to every ticket review.
- Apply the MOBRM overlay automatically for `MOBRM-*` tickets.
- Use MOBRM board `7690` as confirming evidence when board context is visible.
- Do not apply any other team overlay unless the user explicitly supplies an approved team standard for that request.
- Do not use related release or epic keys such as `MR26`, `M26`, or `CLE` to trigger the MOBRM overlay.
- Clearly state `No team overlay applied` when reviewing tickets outside the active standard set.

## Evidence Policy

Keep three kinds of evidence separate:

| Evidence type | Meaning | Can the agent apply it as a team overlay? |
|---|---|---|
| Documented standard | A team-owned Confluence page, board policy, or explicit team owner instruction. | Yes, when current, accessible, and in the active set. |
| Observed pattern | Repeated structure or field usage seen in sampled tickets. | No, use as research evidence only. |
| Proposed standard | Draft recommendation for team review. | No, unless the team owner supplies or approves it for the request. |

## MOBRM Overlay Summary

MOBRM is the only team-specific overlay in the current active set.

| Field | Value |
|---|---|
| Team | MOBRM |
| Jira project key | `MOBRM` |
| Board | MOBRM board `7690` |
| Owner | Shane Vandersloot |
| Backup owner | Harish |
| Source page | `MO` page `5266898945`, `MOBRM Team Jira Standards`, version `3` |
| ROVO page | `docs/confluence-pages/team-jira-standards.md` > `docs/confluence-pages/mobrm-team-jira-standards.md` |

## Detection Rules

| Ticket signal | Agent behavior |
|---|---|
| Ticket key starts with `MOBRM-` | Apply organization-wide standard plus MOBRM overlay. |
| Project key is `MOBRM` | Apply organization-wide standard plus MOBRM overlay. |
| Board context is MOBRM board `7690` | Treat as confirming evidence for MOBRM overlay. |
| Ticket references `MR26`, `M26`, or `CLE` only | Do not apply MOBRM overlay from that signal alone. |
| No active team standard matches | Apply organization-wide standard only and state `No team overlay applied`. |

## Future Team Standards

Additional team standards should be added only after they have:

- A documented team-owned source page.
- Exact project key, board, or filter mapping.
- Owner and backup owner.
- Review date or cadence.
- Clear automatic-application rules.
- Explicit `does not apply when` boundaries to prevent false matches.

Until then, keep future teams out of this active standards page.

Future approved team standards should be children of `Team Jira Standards`, under the shared `Jira Ticket Standards` parent, not direct children of an individual agent Project Brain.
