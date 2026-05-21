# Agent Design Record: [Agent Name]

## Design Metadata

| Field | Value |
|---|---|
| Agent name | [Name] |
| Status | Draft / In Review / Green / Yellow / Red / Retired |
| Owner | [Name] |
| Backup owner | [Name] |
| Design version | [v1.0 / YYYY-MM-DD] |
| Related request | [Link to Jira issue or intake form] |
| Related agents | [Links to related Project Brains] |

## Problem Statement

[What business problem does this agent solve? Who is affected? What happens today without the agent?]

## Target Users

| Role | How They Use The Agent |
|---|---|
| [Role] | [Usage] |

## Workflow Supported

[Describe the end-to-end workflow this agent supports. What is the trigger? What are the steps? What is the output?]

## Fit Decision

| Field | Value |
|---|---|
| Decision | PROMPT ONLY / DEFAULT ROVO / AUTOMATION FLOW / EXTEND EXISTING / CREATE NEW / APP-FORGE CANDIDATE / NOT READY |
| Reason | [Why this is the right-sized solution] |
| Why not simpler? | [Why a simpler solution will not work] |
| Why not broader? | [Why this should not merge into an existing agent] |

## Trigger

[What initiates this agent? User prompt, schedule, event, automation?]

## Inputs And Context Sources

| Source | Type | Authority | Permissions | Freshness | Fallback |
|---|---|---|---|---|---|
| [Source] | Confluence / Jira / Slack / External | System of Record / Process Authority / Reference | [Access level] | Real-time / Daily / Weekly | [What to do if unavailable] |

## Source-Of-Truth Pages

| Page | Purpose | Space |
|---|---|---|
| [Page title with link] | [Why this page matters] | [Space key] |

## Required Jira Or Confluence Objects

| Object | Type | Purpose |
|---|---|---|
| [Object] | Project / Filter / Board / Space / Page | [Purpose] |

## Skills And Actions

| Skill | Assigned To | Risk Tier | Allowed Use | Approval Required? |
|---|---|---|---|---|
| [Skill] | Parent / Subagent | Tier 0-3 | [Specific use] | Yes / No |

## Write Actions

| Action | Risk Level | Confirmation Required | Approval Flow |
|---|---|---|---|
| [Action] | Low / Medium / High / Critical | Yes / No | [Who approves] |

## Human Approval Points

| Trigger | Approver | Escalation Path |
|---|---|---|
| [When human must approve] | [Role/person] | [What happens if no response] |

## Escalation Path

[When should the agent stop and escalate? To whom? What information should the escalation include?]

## Permission Boundaries

- May access: [list]
- May not access: [list]
- Must never: [list]

## Expected Outputs

| Output | Format | Destination |
|---|---|---|
| [Output] | Page / Comment / Message / Report | [Where it goes] |

## Example Prompts

1. [Beginner task prompt]
2. [High-value workflow prompt]
3. [Governance/safety prompt]

## Test Cases

| Case ID | Category | Prompt | Expected Behavior | Status |
|---|---|---|---|---|
| TC-01 | Happy path | [Prompt] | [Expected] | Pass / Fail / Not Run |
| TC-02 | Negative case | [Prompt] | [Expected] | Pass / Fail / Not Run |
| TC-03 | Permission blocker | [Prompt] | [Expected] | Pass / Fail / Not Run |
| TC-04 | Unsafe action | [Prompt] | [Expected] | Pass / Fail / Not Run |
| TC-05 | Stale source | [Prompt] | [Expected] | Pass / Fail / Not Run |

## Failure Modes

| Failure Mode | Likelihood | Impact | Mitigation |
|---|---|---|---|
| [Mode] | Low / Medium / High | [Impact] | [Mitigation] |

## Owner And Governance

| Field | Value |
|---|---|
| Primary owner | [Name] |
| Backup owner | [Name] |
| Review cadence | Monthly / Quarterly / Release-based |
| Next review date | [Date] |
| Retirement criteria | [When to deprecate] |

## Version History

| Version | Date | Change Summary | Updated By |
|---|---|---|---|
| v1.0 | [Date] | Initial design | [Name] |

## Success Metrics

| Metric | Baseline | Target | Measurement Method |
|---|---|---|---|
| Time saved per use | [Current] | [Target] | [How measured] |
| Adoption | [Current] | [Target] | [How measured] |
| Output quality score | [Current] | [Target] | [How measured] |
| Rework or correction rate | [Current] | [Target] | [How measured] |
