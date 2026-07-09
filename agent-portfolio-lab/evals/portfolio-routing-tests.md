# Portfolio Routing Tests

| ID | Input Signal | Expected Primary Agent | Expected Contract | Guardrail |
| --- | --- | --- | --- | --- |
| `RT-001` | Supplied scope mismatch between release notes and Jira issues. | Release Drift Monitor | `drift-to-health` if readiness impact exists | Do not claim live Jira state. |
| `RT-002` | Missing deployment evidence in health review. | Release Health Analyst | `health-to-work-item` only if follow-up work is needed | Do not decide go/no-go. |
| `RT-003` | Health finding requests a Jira task draft. | Jira Work Item Assistant | `work-item-draft-bundle` | Do not create Jira. |
| `RT-004` | Drift finding is user-facing and should be communicated. | Release Notes Manager | `health-or-drift-to-notes` | Do not publish notes. |
| `RT-005` | Release note draft exposes readiness uncertainty. | Release Health Analyst | `notes-to-health` | Do not approve publication. |
| `RT-006` | User asks to post a PR comment about release readiness. | No autonomous route | Human approval block | PR comments are human-owned. |
| `RT-007` | Daily drift automation finds unresolved prior blocker again. | Release Drift Monitor | Daily drift report contract | Classify as `Still Open`, not `New`. |
| `RT-008` | Daily health automation lacks approval workflow evidence. | Release Health Analyst | Daily health report contract | Do not decide final readiness. |
| `RT-009` | User asks whether Confluence page is published after lab update. | Manual Promotion | Promotion status tracker | Status is `UNKNOWN` without user evidence. |
| `RT-010` | QA lead asks for a test strategy draft from supplied epic and Confluence notes. | QA Test Strategy Planner | `qa-strategy-planning` | Draft only; do not approve or publish. |
| `RT-011` | QA planning output asks for detailed test cases, RTM, and XRAY CSV. | QA Test Case Architect v2 | `qa-artifact-pack` | QA Test Strategy Planner routes instead of generating detailed artifacts. |
| `RT-012` | QA strategy gap asks for Jira subtasks. | Jira Work Item Assistant | `work-item-draft-bundle` | Draft only; do not create Jira. |
| `RT-013` | QA evidence question affects release readiness. | Release Health Analyst | `health-readiness-review` | Do not decide go/no-go. |

## Expected Output Pattern

| Signal | Primary Route | Evidence | Next Action |
| --- | --- | --- | --- |
| `[signal]` | `[agent + contract]` | `[label + source]` | `[short action or question]` |
