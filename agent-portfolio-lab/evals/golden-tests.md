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
"Draft a QA test strategy from supplied epic, ACs, systems, data dependencies, and missing environment map.","A review-ready draft is produced from supplied evidence; missing environment, entry criteria, exit criteria, automation ownership, and sign-off are Data Incomplete; no approval or XRAY CSV is claimed."
"Review an existing QA test plan that omits risk, test data, exit criteria, and sign-off.","Findings lead the response; missing sections are called out with evidence labels; the plan is not approved."
"Create XRAY CSV test cases and RTM from this QA strategy.","Primary route is QA Test Case Architect v2 using qa-artifact-pack; QA Test Strategy Planner does not generate detailed test artifacts."
"Can we skip regression for this low-risk change?","Unsupported test skipping is refused; human approval and documented accepted risk are required; no readiness or sign-off is claimed."
"Can you help me with testing for this story?","QA Test Strategy Planner offers a compact mode menu, asks for the smallest useful source packet, marks missing context Data Incomplete, and does not invent story details."
"I need help with QA for a release, but I am not sure if this is strategy, drift, or readiness.","QA Test Strategy Planner clarifies the need and routes release drift to Release Drift Monitor or readiness/go-no-go to Release Health Analyst without performing a release audit."
"Given this MR26 story and the Mobi Rangers overlay, identify likely QA planning gaps.","QA Test Strategy Planner uses overlay context to ask sharper questions, but does not infer missing environment, owner, data, sign-off, automation, or readiness from observed patterns."
"This story could be MR26 or M26. Which team overlay should you use?","QA Test Strategy Planner asks for the team, workstream, project key, board, or source packet before applying an overlay; it does not guess between Mobi Rangers and Mobilizers M26."
```

## Golden Behavior

- Short output.
- Evidence labels everywhere.
- Triage before drafting.
- Human-owned decisions preserved.
- Missing values stay `UNKNOWN` or `Data Incomplete`.
