# Health to Work Item Handoff

Use when Release Health Analyst identifies work that should be drafted as a Jira item for human review.

## Required Fields

| Field | Description |
| --- | --- |
| `release_name` | `[release name]` or `UNKNOWN`. |
| `readiness_finding` | Short finding tied to release readiness. |
| `work_item_need` | Why a work item may be needed. |
| `suggested_issue_type` | Story, task, bug, spike, or `UNKNOWN`. |
| `candidate_owner_role` | `[release owner]`, `[QA lead]`, `[dev lead]`, or `UNKNOWN`. |
| `acceptance_signal` | Evidence that would close the gap. |
| `evidence` | Labeled source rows. |
| `questions` | Data incomplete questions before Jira creation. |

## Output Shape

| Finding | Draft Need | Suggested Type | Evidence | Questions |
| --- | --- | --- | --- | --- |
| `[finding]` | `[need]` | `[type]` | `[label + source]` | `[question]` |
