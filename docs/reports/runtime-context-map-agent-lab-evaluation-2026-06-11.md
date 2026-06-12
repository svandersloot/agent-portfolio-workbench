# Runtime Context Map Agent Lab Evaluation - 2026-06-11

## Scope

This report records a local Agent Lab pass for the Runtime Context Map pilot on:

- Jira Work Item Assistant
- Release Notes Manager

Agent Lab is local-only. This pass did not call ROVO Studio, Jira, Confluence, Bitbucket, or any live system.

## Result

| Agent | Artifact-level result | Live behavior result | Notes |
|---|---|---|---|
| Jira Work Item Assistant | Improved | Not run | Runtime Context Map now separates Deployment Notes, normal ticket work, MOBRM overlay, status comments, and readiness route-away. |
| Release Notes Manager | Improved | Not run | Runtime Context Map now separates deployment work packages, technical release notes, sync checks, business summaries, and readiness route-away. |

## What Improved

For both agents, the map moves source routing from scattered setup guidance into a compact table with:

- User or task intent.
- Source to use first.
- Forbidden substitutes.
- Fallback behavior.
- Smoke test prompt.

The improvement is strongest for Deployment Notes behavior. Both maps now explicitly prevent using MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, generic Jira hygiene pages, or Studio memory as substitutes for `Deployment Notes Standard for Jira Work Items`.

## What Is Still Unproven

The live agents have not been retested after this repo change. Do not claim Studio behavior improved until a human manually:

- Updates or verifies the Studio knowledge sources.
- Runs the mapped smoke prompts.
- Confirms source retrieval, forbidden-substitute refusal, fallback behavior, and write-safety behavior.

## Evidence

| Evidence | Path |
|---|---|
| Agent Lab run | `agent-portfolio-lab/test-runs/003-runtime-context-map-pilot/` |
| Jira Work Item Assistant map | `docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md` |
| Release Notes Manager map | `docs/confluence-pages/release-notes-manager-knowledge-source-plan.md` |
| Jira Work Item Assistant setup note | `docs/confluence-pages/jira-work-item-assistant-studio-setup.md` |
| Release Notes Manager setup note | `docs/confluence-pages/release-notes-manager-studio-setup.md` |

## Recommendation

Proceed to manual Studio smoke testing for both agents. Treat this lab run as approval to test the map, not as proof that live ROVO behavior changed.
