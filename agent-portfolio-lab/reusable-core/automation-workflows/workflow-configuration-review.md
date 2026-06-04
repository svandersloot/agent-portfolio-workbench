# Workflow Configuration Review

Use this checklist after a human manually configures a Rovo or automation workflow. The lab does not verify live configuration unless the user supplies the configuration text or screenshots.

## Review Table

| Workflow | Supplied Config Evidence | Expected Contract | Status | Question |
| --- | --- | --- | --- | --- |
| Daily drift report | `[workflow config excerpt]` | `daily-drift-report-contract` | `UNKNOWN` | `[question]` |
| Daily health report | `[workflow config excerpt]` | `daily-health-report-contract` | `UNKNOWN` | `[question]` |

## Checks

- Prompt includes evidence-label requirements.
- Prompt includes freshness and delta rules for daily reports.
- Prompt prevents final readiness, go/no-go, publication, Jira writes, comments, and deployment execution.
- Workflow schedule is described by placeholder or user-supplied value, not invented.
- Output destination is user-provided and human-approved.
- Failure behavior is documented for missing evidence and stale sources.

## Status Labels

- `Ready for Studio parity test`
- `Needs manual config update`
- `Blocked by missing config evidence`
- `UNKNOWN`
