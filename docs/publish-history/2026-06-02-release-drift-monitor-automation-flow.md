# Publish History - Release Drift Monitor Automation Flow

## Summary

| Field | Value |
|---|---|
| Date | 2026-06-02 |
| Space | Mobilitas Program (`MO`) |
| Rule | July '26 Release Drift |
| Raw export committed | No |
| Sanitized capture | `docs/reports/release-drift-monitor-automation-rule-sanitized-2026-06-02.json` |
| Studio writes | None |
| Jira writes | None |

## Automation Shape

The pilot automation uses a scheduled Confluence rule to generate a Release Drift Monitor daily pulse and publish the result as a draft child page.

| Step | Action | Purpose |
|---|---|---|
| 1 | Scheduled trigger | Runs the pilot flow on the weekday cadence configured in Confluence Automation. |
| 2 | Use agent | Runs Release Drift Monitor with exact Mobilitas 2026.07.10 release metadata and no agent write permissions. |
| 3 | Publish new page | Creates a draft child page under the canonical Mobilitas 2026.07.10 drift page using `{{agentResponse}}`. |

## Governance Decision

- Keep the canonical drift page human-curated during the pilot.
- Do not allow the Rovo agent to edit, append, create, or update Confluence pages directly.
- Let the deterministic Confluence Automation `Publish new page` action create reviewable draft child pages.
- Manually promote useful content from each draft into the canonical page so Confluence version history captures the reviewed update.
- Archive reviewed draft child pages when they are no longer needed in the page tree.

## Redaction

The raw Confluence Automation export contained live Atlassian account IDs, cloud IDs, connection IDs, rule/component UUIDs, checksums, ARIs, space IDs, page IDs, and the specific canonical page URL.

The tracked JSON capture preserves the rule structure and prompt while replacing those live identifiers with placeholders. The raw export filename pattern is now ignored by `.gitignore`.

## Validation

- Reviewed the raw export from Downloads before adding tracked files.
- Confirmed the tracked JSON captures the schedule, disabled agent actions, agent prompt, draft child-page creation, and `{{agentResponse}}` page body.
- Did not commit the raw export.

## Follow-Up

- Confirm the title smart value renders cleanly in Confluence.
- Consider including both `America/Phoenix` and `UTC` in the draft page title after validating Confluence date smart-value syntax.
- Recheck the scheduled trigger UI after edits because the raw export showed a weekday cron expression while the RRULE retained Monday-only metadata.
