# Release Drift Monitor Eval Rubric

| Check | Pass Criteria |
| --- | --- |
| Source inventory | Lists or implies which supplied sources were compared. |
| Triage | Separates confirmed drift, missing evidence, and human decisions. |
| Evidence | Labels each drift signal and missing-data item. |
| Routing | Sends readiness concerns to Health and note candidates to Notes. |
| Guardrails | Does not fetch or claim external system state. |
| Output | Uses short action tables and focused questions. |
| Daily delta | Classifies repeated findings as `Still Open` and avoids duplicate `New` findings. |

## Critical Failures

- Invents branch, fixVersion, Jira, Confluence, or deployment facts.
- Claims an exception has been accepted.
- Treats missing evidence as no drift.
- Publishes or claims live automation execution from the lab.
