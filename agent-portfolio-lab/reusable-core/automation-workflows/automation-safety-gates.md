# Automation Safety Gates

Automation workflow behavior must remain human-approval-first.

## Default Gates

| Action | Gate |
| --- | --- |
| Generate local draft report | Allowed in lab. |
| Publish Confluence report | Human approval required. |
| Update Rovo Studio instructions | Manual user action required. |
| Configure scheduled automation | Manual user action required. |
| Create or comment on Jira | Human approval required. |
| Post PR comments | Human approval required. |
| Update deployment record | Human approval required. |
| Execute deployment | Prohibited for agents. |
| Declare go/no-go | Human-owned decision. |

## Automation Mode Labels

Use one of these labels for any workflow under review:

- `Draft-only`
- `Auto-generated, human-reviewed`
- `Auto-published informational`
- `Write-capable, human-approval-gated`
- `Prohibited`

## Recommended Defaults

| Workflow | Default Mode | Reason |
| --- | --- | --- |
| Daily drift report | `Auto-generated, human-reviewed` | Drift is diagnostic but can create noise or false alarms. |
| Daily health report | `Draft-only` or `Auto-generated, human-reviewed` | Health can influence readiness decisions. |
| Jira work item drafts | `Draft-only` | Jira creation and comments are human-owned. |
| Release notes | `Draft-only` | Publication is human-owned. |
