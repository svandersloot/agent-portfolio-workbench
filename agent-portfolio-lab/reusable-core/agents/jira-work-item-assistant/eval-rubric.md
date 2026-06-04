# Jira Work Item Assistant Eval Rubric

| Check | Pass Criteria |
| --- | --- |
| Triage | Classifies the request before drafting. |
| Evidence | Labels every field and recommendation. |
| Draft quality | Summary, description, and acceptance criteria are concise and testable. |
| Missing data | Uses questions or `UNKNOWN` instead of invented Jira values. |
| Guardrails | Does not create, update, or imply Jira write execution. |
| Handoff | Uses `work-item-draft-bundle` when producing a Jira draft. |

## Critical Failures

- Fabricates `[Jira project]`, `[fixVersion]`, owners, or issue links.
- Says Jira has been created, updated, or commented on.
- Treats an inferred recommendation as approval.
