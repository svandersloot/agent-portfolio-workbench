# Duplicate-Agent Discovery Dry-Run Report

Generated from local page inventory and reference snippets. No Confluence or Studio writes were performed.

## Summary

The strongest duplicate signals are duplicate Confluence pages around agent artifacts, not necessarily duplicate active agents. The biggest user-facing governance risk is that builders may find stale copies of Release Health Analyst and Performance Test Report Agent support pages and assume they are canonical.

## Duplicate Signals

| Candidate Area | Evidence | Likely Canonical | Risk | Recommendation |
|---|---|---|---|---|
| Agent Inventory vs Rovo Agent Inventory Home | `Agent Inventory` exists under `Agent Governance Home`; `Rovo Agent Inventory Home` exists as root/overview and also has an unparented duplicate row. | `Agent Inventory` for records; `Rovo Agent Inventory Home` for overview/root. | Confusion about where to check before creating agents. | Keep both roles distinct; add redirect/legacy notes only after focused dry-runs. |
| Release Health Analyst Project Brain | Three pages with same title; only `5288362010` has parent `5281218643` and space `5298651147`. | `5288362010` | Builders may reference stale unparented copies. | Keep `5288362010`; verify and legacy-banner unparented copies. |
| Performance Test Report Agent (Extension) subagent settings | Three pages with same title; only `5287575752` is under Project Brain `5288624243`. | `5287575752` | Studio config work may copy stale subagent settings. | Keep child page under Project Brain; verify unparented copies. |
| Release Health Analyst evaluations | Three evaluation pages; one canonical child under Project Brain and two unparented entries. | `5288034344` if current evaluation evidence remains valid. | Evaluation status and launch readiness may be unclear. | Keep canonical child; reconcile or archive unparented copies. |
| Release Health Analyst knowledge source plan | Two pages; one child under Project Brain and one unparented. | `5288099858` | Agent may be configured from stale source plan. | Keep child page; legacy-banner duplicate if stale. |
| Blueprint - Release Health Analyst | Two pages; one child under Project Brain and one unparented. | `5288951842` | Design evidence may split across copies. | Keep child page; compare content before any archive action. |

## Builder Reuse Guidance

| New Request Looks Like | Reuse Check |
|---|---|
| Agent design, intake, or governance scaffolding | Check Rovo Design Agent and Agent Doc Steward before creating a new agent. |
| Release/change health, fixVersion, deployment readiness, or release risk | Check Release Health Analyst first. |
| Performance test reports, regression summaries, or metric delta analysis | Check Performance Test Report Agent (Extension) first. |
| Jira ticket polishing or issue-quality cleanup | Check Jira Ticket Polisher draft before creating a new candidate. |

## Dry-Run Actions Before Any Write

1. Compare duplicate page bodies for Release Health Analyst Project Brain copies.
2. Compare duplicate evaluation and knowledge-source pages for Release Health Analyst.
3. Compare duplicate subagent setting pages for Performance Test Report Agent.
4. Add a legacy note to stale duplicates one page at a time only after confirming canonical target.
5. Update `Agent Inventory` with a `Reuse before creating` column or note after approval.

## Report Limits

- The local CSV identifies duplicate titles and parent/space relationships, not semantic equivalence.
- This report does not prove whether duplicate pages are archived, restricted, or intentionally retained.
- No duplicate active Studio agents were proven from the local evidence alone.
