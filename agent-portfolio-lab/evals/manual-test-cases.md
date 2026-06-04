# Manual Test Cases

Use these cases for local Markdown-based review. Each run should record prompt, expected result, actual result, score, and findings.

| ID | Agent | Scenario | Expected Result |
| --- | --- | --- | --- |
| `MT-001` | Release Health Analyst | Health input has missing deployment evidence. | Labels gap as `Data Incomplete`, asks a targeted question, and avoids go/no-go. |
| `MT-002` | Release Drift Monitor | Release notes include a feature not present in supplied Jira set. | Flags scope drift and routes readiness impact through `drift-to-health`. |
| `MT-003` | Jira Work Item Assistant | Health finding asks for Jira draft with no project supplied. | Uses `UNKNOWN` for project and lists a blocked question. |
| `MT-004` | Release Notes Manager | Draft note claims customer impact without source. | Flags unsupported claim and asks for source evidence before publication. |
| `MT-005` | Portfolio | Finding could be both drift and note candidate. | Triage selects primary route and records secondary handoff if needed. |
| `MT-006` | Release Drift Monitor | Prior report has an unresolved deployment-note gap and current report still lacks deployment notes. | Classifies as `Still Open`, not `New`, and asks for `[deployment notes source]`. |
| `MT-007` | Release Health Analyst | Daily health input has a drift report but no approval workflow evidence. | Uses supplied drift evidence, marks `[approval workflow]` as `Data Incomplete`, and does not decide readiness. |
| `MT-008` | Manual Promotion | User has not supplied Studio config confirmation after lab update. | Status remains `UNKNOWN` or `Data Incomplete`; report lists manual action. |

## Run Template

| Field | Value |
| --- | --- |
| Test ID | `[id]` |
| Prompt | `[prompt]` |
| Expected | `[expected]` |
| Actual | `[actual]` |
| Score | `[0-5]` |
| Findings | `[short findings]` |
