# Troubleshooting Guide

Use this table to diagnose a symptom before assuming the agent is wrong or broken. Most symptoms below have a known cause and a known workaround.

| Symptom | Possible Cause | Resolution |
| --- | --- | --- |
| Wrong release identified | Fixed version was inferred from stale context (a prior run, or the wrong release page) rather than confirmed. | Explicitly state the exact fixVersion. Cross-check it against the team's Release filter/JQL before proceeding. See [Running a Manual Release Assessment](release-health-analyst-user-guide-manual-assessment.md). |
| Missing data | Required evidence (Jira scope, QA evidence, code evidence, deployment notes) isn't linked anywhere the agent can read. | Confirm the evidence exists and is linked in the ticket/comment history, not just described. See [Best Practices](release-health-analyst-user-guide-best-practices.md). |
| Incomplete assessment | A required section came back as `Data Incomplete` / `UNKNOWN` because the fail-closed guardrail correctly refused to guess. | This is expected, safe behavior, not a bug. Close the evidence gap and rerun. |
| Page published in unexpected location | The agent defaults to publishing near the bottom of the space instead of nesting under the intended parent unless told explicitly. | Explicitly instruct the agent to create the page **as a child page** of the canonical assessment page. If it still lands in the wrong place, manually drag it into position afterward. |
| Automation did not run | The schedule was disabled, the end date already passed, or the agent connection needs re-authentication after a flow duplication. | Check the flow's enabled/disabled state, start/end dates, and authentication status. See [Automation Field Reference](release-health-analyst-user-guide-automation-field-reference.md). |
| Child page not created | The publishing step requires explicit human confirmation and may have been left pending, or the parent page reference in the flow still points at a prior release's canonical page. | Confirm the pending preview, and verify the Canonical Assessment Page / parent page field is set to the current release's page. |
| Missing trend information | The trend table is not always populated consistently across reruns — a known gap. | Manually confirm the Trend Analysis section against the previous assessment page. Log the gap on the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md). |

> **Important:** If a symptom isn't on this table, don't assume it's expected — log it as a gap on the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md) so it can be added here once diagnosed.

## Feedback and Improvement Opportunities

Please submit agent improvement suggestions, false positives, missing findings, new reporting requirements, and automation enhancement ideas to the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md).
