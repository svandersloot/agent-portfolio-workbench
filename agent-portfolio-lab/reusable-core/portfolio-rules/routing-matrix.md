# Routing Matrix

Use this matrix after triage and before drafting.

| Signal | Primary Agent | Handoff Contract | Human Gate |
| --- | --- | --- | --- |
| Missing or conflicting release readiness evidence | Release Health Analyst | `health-to-work-item` if work is needed | Final readiness and go/no-go |
| Scope, branch, fixVersion, or deployment-note mismatch | Release Drift Monitor | `drift-to-health` | Exception acceptance |
| Missing Jira fields, unclear acceptance criteria, or duplicate work | Jira Work Item Assistant | `work-item-draft-bundle` | Jira creation and comments |
| User-facing change, known issue, or publication candidate | Release Notes Manager | `health-or-drift-to-notes` or `notes-to-health` | Release-note publication |
| Ambiguous source ownership | Release Health Analyst | `health-to-work-item` if follow-up is needed | Owner assignment |
| Publication or external update requested | No autonomous route | Human approval block | Publication or write decision |

## Parent Agent Limits

- Maximum 5 subagents per parent agent.
- Fewer than 5 skills or tools per agent or subagent unless explicitly approved.
- Prefer no write-capable tools in reusable core instructions.
