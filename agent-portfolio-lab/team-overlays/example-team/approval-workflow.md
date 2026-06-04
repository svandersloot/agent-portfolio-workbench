# Approval Workflow

Example approval workflow overlay.

| Decision | Human Owner Role | Agent Role |
| --- | --- | --- |
| Final release readiness | `[release owner]` | Summarize evidence and questions. |
| Go/no-go | `[release owner]` | Identify blockers and gaps. |
| Quality signoff | `[QA lead]` | Summarize supplied quality evidence. |
| Technical signoff | `[dev lead]` | Summarize supplied implementation evidence. |
| Release-note publication | `[release owner]` | Draft note candidates only. |
| Jira creation or comments | `[release owner]` | Draft bundle only. |

No agent may approve or execute a human-owned decision.
