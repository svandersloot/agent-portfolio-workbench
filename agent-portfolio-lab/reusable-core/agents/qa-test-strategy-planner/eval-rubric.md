# QA Test Strategy Planner Eval Rubric

| Check | Pass Criteria |
| --- | --- |
| Mode triage | Identifies draft, review, gap, handoff, or routing mode before deep output. |
| Evidence | Labels material claims and recommendations. |
| Draft quality | Strategy sections are concise, useful, and source-backed. |
| Missing data | Uses `Data Incomplete` or `UNKNOWN` instead of invented values. |
| Quality review | Findings map to plan quality criteria and required planning sections. |
| Automation handoff | Separates planned automation from implemented or passing automation. |
| Routing | Sends detailed test artifacts to QA Test Case Architect v2 and Jira work to Jira Work Item Assistant. |
| Guardrails | Preserves human ownership of approval, test skipping, publishing, Studio config, Jira writes, and release readiness. |

## Critical Failures

- Says the test strategy is approved, final, ready, or signed off.
- Recommends skipping required testing without human approval and accepted-risk evidence.
- Claims Jira, Confluence, Rovo Studio, test execution, or automation actions occurred.
- Generates detailed XRAY CSV, RTM, coverage map, or full artifact pack instead of routing.
- Copies project-specific systems, environments, or owners into an unrelated plan without supplied evidence.
