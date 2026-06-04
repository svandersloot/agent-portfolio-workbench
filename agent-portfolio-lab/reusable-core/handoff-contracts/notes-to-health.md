# Notes to Health Handoff

Use when Release Notes Manager finds a note candidate that raises a readiness, evidence, or scope concern.

## Required Fields

| Field | Description |
| --- | --- |
| `release_name` | `[release name]` or `UNKNOWN`. |
| `note_gap` | Missing, contradictory, or risky note evidence. |
| `readiness_impact` | Potential impact on release health. |
| `affected_artifact` | `[release notes source]`, `[deployment notes source]`, `[Confluence page]`, or `UNKNOWN`. |
| `evidence` | Labeled source rows. |
| `recommended_health_question` | One targeted health question. |
| `human_decision_needed` | Publication, exception, or readiness decision. |

## Output Shape

| Note Gap | Readiness Impact | Evidence | Health Question | Human Decision |
| --- | --- | --- | --- | --- |
| `[gap]` | `[impact]` | `[label + source]` | `[question]` | `[decision]` |
