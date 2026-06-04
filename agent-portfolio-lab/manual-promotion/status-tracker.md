# Promotion Status Tracker

Track manual publication and configuration status here when the user supplies evidence.

## Confluence Pages

| Page | Lab Source | Status | Evidence | Last Confirmed |
| --- | --- | --- | --- | --- |
| `[Confluence page]` | `[lab file]` | `UNKNOWN` | `Data Incomplete` | `UNKNOWN` |

## Rovo Studio Agents

| Agent | Lab Source | Studio Status | Evidence | Next Step |
| --- | --- | --- | --- | --- |
| Release Drift Monitor | `reusable-core/agents/release-drift-monitor/` | `UNKNOWN` | `Data Incomplete` | Manually configure and run parity test. |
| Release Health Analyst | `reusable-core/agents/release-health-analyst/` | `UNKNOWN` | `Data Incomplete` | Manually configure and run parity test. |
| Jira Work Item Assistant | `reusable-core/agents/jira-work-item-assistant/` | `UNKNOWN` | `Data Incomplete` | Manually configure and run parity test. |
| Release Notes Manager | `reusable-core/agents/release-notes-manager/` | `UNKNOWN` | `Data Incomplete` | Manually configure and run parity test. |

## Automation Workflows

| Workflow | Lab Contract | Config Status | Safety Gate | Evidence |
| --- | --- | --- | --- | --- |
| Daily drift report | `daily-drift-report-contract` | `UNKNOWN` | `Auto-generated, human-reviewed` | `Data Incomplete` |
| Daily health report | `daily-health-report-contract` | `UNKNOWN` | `Draft-only` or `Auto-generated, human-reviewed` | `Data Incomplete` |

## Status Rules

- Use `UNKNOWN` until the user supplies confirmation or configuration evidence.
- Use `User-provided` when the user confirms a manual update.
- Use `Source-backed` when the user supplies a page export, Studio excerpt, or workflow config excerpt.
- Never infer publication or live configuration from lab readiness alone.
