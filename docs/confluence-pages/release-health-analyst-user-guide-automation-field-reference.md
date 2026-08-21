# Automation Field Reference

Field-by-field reference for the ROVO Studio automation flow that runs Release Health Analyst on a schedule. Use this alongside [Release Health Automation Setup](release-health-analyst-user-guide-automation-setup.md) when configuring or troubleshooting a flow.

## Schedule Settings

| Field Name | Purpose | Example Value | When to Update | Common Mistakes |
| --- | --- | --- | --- | --- |
| Start date | First date the scheduled flow runs. | Day after code freeze | Every release cycle. | Leaving the previous release's start date in place after duplicating the flow. |
| End date | Last date the scheduled flow runs. | Go/No-Go date (or the day before) | Every release cycle. | Setting the wrong time on the end date, or ending it too early so the flow stops before the final review. |
| Run days | Days of the week the flow executes. | Monday, Tuesday, Wednesday, Thursday, Friday | Rarely — only if the RR cadence changes. | Leaving weekend runs enabled when there's no RR call to feed. |
| Run time | Time of day the flow executes. | 11:30 AM | When the RR call time changes. | Not accounting for the ~30 minute lead time needed before the RR call. |
| Enabled / Disabled | Whether the flow is active. | Enabled | After finishing setup, and again after the release ends. | Forgetting to disable the previous release's expired flow, or forgetting to enable the new one after saving. |

## Agent Settings

| Field Name | Purpose | Example Value | When to Update | Common Mistakes |
| --- | --- | --- | --- | --- |
| Agent / persona | Which ROVO agent version the flow invokes. | Release Health Analyst (current version) | When a new agent version is promoted. | Pointing at a retired or "vNext"-in-progress version. |
| Allow agent to execute actions | Whether the `Use agent` step itself can write to Confluence/Jira. | Disabled / `false` | Never — keep disabled. | Enabling this and relying on the agent to publish directly, instead of the separate deterministic `Publish new page` step. |
| Authentication | Connection used by the flow to act as the agent. | Re-authenticated owner session | Immediately after duplicating a flow. | Skipping re-authentication and having the flow silently fail to run. |

## Prompt Settings

| Field Name | Purpose | Example Value | When to Update | Common Mistakes |
| --- | --- | --- | --- | --- |
| Release ID | The release identifier referenced in the prompt instructions. | `9.04` | Every release cycle. | Copying the prior release's ID forward without changing it. |
| Fixed Version | The exact Jira fixVersion the assessment should scope to. | `Mobilitas 2026.09` | Every release cycle. | Using a fuzzy or partial value instead of the exact fixVersion string. |
| Canonical Assessment Page | The initial assessment page that scheduled runs attach child pages to. | Link to the newly created initial page | Every release cycle, after the initial manual run. | Leaving this pointed at the previous release's canonical page. |
| Previous Draft Reference | Instruction telling the agent how to find the most recent prior run for this release. | "Most recent child page under the canonical page titled Release Health ... 9.04" | Every release cycle. | Leaving the previous release's identifier in the reference pattern. |

## Page Publishing Settings

| Field Name | Purpose | Example Value | When to Update | Common Mistakes |
| --- | --- | --- | --- | --- |
| Parent page | Where the published page is nested. | The canonical assessment page for the current release | Every release cycle. | Leaving the parent pointed at last release's canonical page, or leaving it blank (which can cause the page to land at the space root). |
| Page title pattern | Naming convention for each published run, including a timestamp. | `Release Health Analyst Assessment: 9.04 (timestamp, Phoenix time)` | Every release cycle. | Forgetting to update the release identifier portion of the title. |
| Publish vs. draft-only | Whether the flow actually creates/publishes the page, or only prepares content. | Publish as child page | Rarely — confirm at setup. | Assuming a run published when it only drafted, or vice versa. |

> **Caveat:** Owners have observed that duplicating a flow commonly requires re-authenticating the agent connection. Confirm authentication succeeded before assuming the schedule will run.

## Feedback and Improvement Opportunities

Please submit agent improvement suggestions, false positives, missing findings, new reporting requirements, and automation enhancement ideas to the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md).
