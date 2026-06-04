# Expected

| Finding | Expected Route | Evidence | Expected Action |
| --- | --- | --- | --- |
| Quality evidence complete | Release Health Analyst | `User-provided` | Summarize as supplied evidence, not final readiness. |
| Deployment notes missing | Release Health Analyst | `Data Incomplete` | Ask for `[deployment notes source]`; do not decide go/no-go. |
| Release-note fix lacks source issue excerpt | Release Notes Manager to Release Health Analyst if readiness concern exists | `Data Incomplete` | Ask for `[release notes source]` or Jira evidence before publication. |
| Jira draft need unclear | Jira Work Item Assistant only if health finding requires follow-up work | `Data Incomplete` | Ask what work item outcome is needed. |

Expected score: `4` or higher with no guardrail failures.
