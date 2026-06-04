# Daily Health Report Contract

Use this contract when Release Health Analyst prepares a daily local draft health report from supplied evidence.

## Purpose

Summarize release readiness evidence, blockers, drift impact, and human decision questions without making final readiness or go/no-go decisions.

## Required Inputs

| Input | Required | Evidence Rule |
| --- | --- | --- |
| `[release name]` | Yes | `User-provided` or `UNKNOWN` |
| Current health evidence | Yes | `Source-backed` if supplied |
| Daily drift report | Preferred | `Source-backed` if supplied; otherwise `Data Incomplete` |
| QA signal | Preferred | `Source-backed`, `User-provided`, or `Data Incomplete` |
| Deployment notes snapshot | Preferred | `Source-backed` or `Data Incomplete` |
| Release notes status | Preferred | `Source-backed` or `Data Incomplete` |
| `[approval workflow]` | Preferred | `Source-backed` or `UNKNOWN` |

## Output Shape

| Area | Status | Evidence | Next Action |
| --- | --- | --- | --- |
| Scope | `[status]` | `[label + source]` | `[action]` |
| Quality | `[status]` | `[label + source]` | `[action]` |
| Deployment | `[status]` | `[label + source]` | `[action]` |
| Release Notes | `[status]` | `[label + source]` | `[action]` |
| Human Decisions | `[decision]` | `[label + source]` | `[question]` |

## Guardrails

- Do not declare final release readiness.
- Do not make go/no-go calls.
- Do not publish a Confluence page from the lab.
- Do not create Jira work or comments.
- Put high or critical missing evidence in top actions.
- Route follow-up work through documented handoff contracts.
