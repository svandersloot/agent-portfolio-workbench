# Work Item Draft Bundle

Use when Jira Work Item Assistant prepares a local draft bundle for human review. This contract must not create or update Jira.

## Required Fields

| Field | Description |
| --- | --- |
| `jira_project` | `[Jira project]` or `UNKNOWN`. |
| `issue_type` | Supplied or inferred with label. |
| `summary` | Short candidate summary. |
| `description` | Concise problem, context, and requested outcome. |
| `acceptance_criteria` | Testable bullets, each evidence-labeled where possible. |
| `labels_or_components` | Supplied values only, or `UNKNOWN`. |
| `fix_version` | `[fixVersion]` or `UNKNOWN`. |
| `blocked_questions` | Questions that must be answered before creation. |
| `human_approval` | Required owner and approval step. |

## Output Shape

| Candidate Jira Field | Draft Value | Evidence |
| --- | --- | --- |
| Project | `[Jira project or UNKNOWN]` | `[label]` |
| Issue Type | `[type]` | `[label]` |
| Summary | `[summary]` | `[label]` |
| Description | `[description]` | `[label]` |
| Acceptance Criteria | `[criteria]` | `[label]` |

## Guardrail

End every bundle with: `Draft only. Jira creation, update, and comment posting require human approval.`
