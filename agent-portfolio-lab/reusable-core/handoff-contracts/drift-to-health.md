# Drift to Health Handoff

Use when Release Drift Monitor finds a drift signal that may affect release readiness.

## Required Fields

| Field | Description |
| --- | --- |
| `release_name` | `[release name]` or `UNKNOWN`. |
| `fix_version` | `[fixVersion]` or `UNKNOWN`. |
| `drift_summary` | One sentence describing the mismatch. |
| `affected_scope` | Feature, issue set, branch, note, runbook, or artifact affected. |
| `severity` | `Critical`, `High`, `Medium`, or `Low`. |
| `evidence` | Source-backed rows with supplied artifact names. |
| `missing_evidence` | Data incomplete items needed for readiness assessment. |
| `recommended_health_question` | One targeted question for Release Health Analyst. |
| `human_decision_needed` | Any exception, approval, or go/no-go decision. |

## Output Shape

| Drift | Severity | Evidence | Health Question | Human Decision |
| --- | --- | --- | --- | --- |
| `[summary]` | `[severity]` | `[label + source]` | `[question]` | `[decision or none]` |
