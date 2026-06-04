# Publish History - Follow-Up Triage Prompt Pattern

Published prompt-library and Studio configuration updates for release follow-up triage.

## Summary

| Field | Value |
|---|---|
| Date | 2026-06-04 |
| Space | ROVO |
| Studio writes | None |
| Jira writes | None |

## Pages Updated

| Page | Page ID | Published Version | Source |
|---|---|---:|---|
| Prompt Library - Release Drift Monitor Handoff Pages | `5333385319` | 2 | `docs/confluence-pages/release-drift-monitor-prompt-library.md` |
| ROVO Studio Configuration - Release Drift Monitor | `5318770794` | 15 | `docs/confluence-pages/release-drift-monitor-rovo-studio-configuration.md` |
| Change Log - Release Drift Monitor | `5318574194` | 9 | `docs/confluence-pages/release-drift-monitor-change-log.md` |
| Prompt Library - Release Health Analyst Assessment Pages | `5334073374` | 4 | `docs/confluence-pages/release-health-analyst-assessment-prompts.md` |
| Rovo Studio Configuration - Release Health Analyst | `5289476102` | 6 | `docs/confluence-pages/release-health-analyst-rovo-studio-configuration.md` |
| Subagent Settings - Jira Work Item Assistant | `5349081089` | 5 | `docs/confluence-pages/jira-work-item-assistant-subagent-settings.md` |
| ROVO Studio Configuration - Jira Work Item Assistant | `5349113857` | 6 | `docs/confluence-pages/jira-work-item-assistant-rovo-studio-configuration.md` |
| Change Log - Jira Work Item Assistant | `5349244929` | 7 | `docs/confluence-pages/jira-work-item-assistant-change-log.md` |

## Change

Added a shared follow-up triage pattern with agent-specific prompt blocks:

- Release Drift Monitor: `Post-Draft Follow-Up Triage` and `Applicable Follow-Up Drafting`.
- Release Health Analyst: `Open Item Follow-Up Triage` and `Assessment Follow-Up Drafting`.
- Jira Work Item Assistant: comment-drafting guardrails for release health, release drift, and open-item follow-up lists.

The pattern requires agents to triage before drafting comments, use outreach when evidence is missing, require exact Jira target/comment pairs for bulk comment drafts, and avoid Jira or Confluence writes.

## Publish Result

Dry-run targeted exactly eight existing pages, all with `action: update`.

Apply completed successfully and updated the pages to the versions listed above.

## Manual Studio Follow-Up

- Refresh Release Drift Monitor Studio instructions from `ROVO Studio Configuration - Release Drift Monitor` if the live agent should handle post-draft follow-up requests naturally.
- Refresh Release Health Analyst Studio instructions from `Rovo Studio Configuration - Release Health Analyst` if the live agent should handle open-item follow-up triage naturally.
- Refresh Jira Work Item Assistant Studio instructions and Subagent Settings if the live agent should use the new comment applicability guardrail.
