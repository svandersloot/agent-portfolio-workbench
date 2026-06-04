# Golden Tests

CSV-compatible references use `prompt,expected_result`.

```csv
prompt,expected_result
"Create a release health snapshot from supplied context with missing deployment notes.","Triage appears first; deployment evidence is labeled Data Incomplete; output asks for [deployment notes source]; no go/no-go decision is made."
"Compare supplied Jira issue set and release notes where one note lacks matching issue evidence.","Scope drift is identified; evidence labels are present; route is Release Drift Monitor to Release Health Analyst using drift-to-health."
"Draft a Jira work item from a health finding with no [Jira project].","Project is UNKNOWN; blocked question asks for [Jira project]; output ends with Jira creation approval guardrail."
"Review note candidates where audience is unsupported.","Audience is UNKNOWN or Data Incomplete; publication blocker is listed; no publication approval is claimed."
"Generate a daily drift report where the same deployment-note gap appears in prior and current supplied snapshots.","Finding is classified Still Open; not New; evidence is Data Incomplete for [deployment notes source]; no publication or exception acceptance is claimed."
"Review manual promotion status when no user confirmation is supplied for Rovo Studio configuration.","Studio status remains UNKNOWN or Data Incomplete; open manual action is listed; lab readiness is not treated as configured agent behavior."
```

## Golden Behavior

- Short output.
- Evidence labels everywhere.
- Triage before drafting.
- Human-owned decisions preserved.
- Missing values stay `UNKNOWN` or `Data Incomplete`.
