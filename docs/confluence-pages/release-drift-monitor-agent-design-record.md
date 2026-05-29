# Release Drift Monitor - Agent Design Record

## Design Metadata

| Field | Value |
|---|---|
| Agent name | Release Drift Monitor |
| Status | Draft |
| Owner | TBD |
| Backup owner | TBD |
| Design version | v0.1 |
| Related request | Release drift detection design review |
| Related agents | Release Health Analyst, Release Notes Manager |

## Problem Statement

Release teams can reach code freeze with Jira, Bitbucket, test, and QA evidence out of sync. Today, many inconsistencies are discovered late by the Release Health Analyst or by human review. The Drift Monitor catches those mismatches earlier so teams can resolve them before final release readiness assessment.

## Target Users

| Role | How They Use The Agent |
|---|---|
| Dev lead | Find Jira items whose code evidence is missing, open, or in the wrong branch. |
| QA lead | Find stories that appear ready but lack required validation evidence. |
| Release owner | See release evidence drift before code freeze. |
| Release manager / change stakeholder | Use Drift Monitor history through Release Health Analyst, not as the final decision. |

## Workflow Supported

The agent supports a daily or manual release health pulse. It compares active release scope against source evidence and returns an actionable list of drift findings with status, confidence, explanation, and recommended action.

## Fit Decision

| Field | Value |
|---|---|
| Decision | AGENT CANDIDATE |
| Reason | The workflow is repeatable, source-backed, and high-value, but source rules and false-positive ownership need real-data discovery before launch. |
| Why not simpler? | A prompt cannot reliably preserve source freshness, branch truth, history, and repeated monitoring. |
| Why not broader? | Folding daily drift detection into Release Health Analyst would blur early-warning monitoring with final decision support. |

## Trigger

| Trigger | Phase |
|---|---|
| Manual run against direct JQL results, issue list, or Jira export | Candidate discovery |
| Daily run against pilot release sources | Experimental pilot |
| On-demand code-freeze run | Handoff to Release Health Analyst |

## Inputs And Context Sources

| Source | Type | Authority | Permissions | Freshness | Fallback |
|---|---|---|---|---|---|
| Jira fixVersion or release filter | Jira | System of Record | Read-only | Daily or on demand | Use direct JQL when available; use export as fallback and mark source freshness. |
| Jira issue workflow/status fields | Jira | System of Record | Read-only | Daily or on demand | Mark `UNKNOWN` for status rules not mapped. |
| Jira development links | Jira / Bitbucket | Source Reference | Read-only | Daily or on demand | Search branch, PR title, and commit message patterns if available. |
| Bitbucket branches, PRs, commits | Bitbucket | System of Record for code evidence | Read-only | Daily or on demand | Use direct Bitbucket or Jira development links when available; use human-supplied evidence at lower confidence. |
| ClaimCenter repo | Bitbucket | System of Record for ClaimCenter code evidence | Read-only | Daily or on demand | Use only for PR, branch, commit, and source-truth branch checks. |
| PolicyCenter repo | Bitbucket | System of Record for PolicyCenter code evidence | Read-only | Daily or on demand | Use only for PR, branch, commit, and source-truth branch checks. |
| BillingCenter repo | Bitbucket | System of Record for BillingCenter code evidence | Read-only | Daily or on demand | Use only for PR, branch, commit, and source-truth branch checks. |
| ContactManager repo | Bitbucket | System of Record for ContactManager code evidence | Read-only | Daily or on demand | Use only for PR, branch, commit, and source-truth branch checks. |
| Test evidence fields or links | Jira / QA tool / CI | Validation Evidence | Read-only | Daily or on demand | Mark `WARN` or `UNKNOWN` based on team rule. |
| Release Evidence Ledger | Confluence / structured records | Shared Evidence Layer | Read-only for agents at first | Append per run | If unavailable, produce a proposed ledger table in output. |

## Required Jira Or Confluence Objects

| Object | Type | Purpose |
|---|---|---|
| Target release fixVersion | Jira field | Defines release scope. |
| Team issue-type mapping | Table / page | Defines when code, tests, QA, or docs are required. |
| Source-truth branch rule | Page / release plan | Defines develop vs release branch. Release branches follow `release/r-xx.x`, such as `release/r-64.0`. |
| Approved application repository list | Bitbucket repo list | Defines which repositories can be used for code evidence. |
| Release Evidence Ledger Contract | Confluence / schema | Defines shared evidence records. |

## Skills And Actions

| Skill | Assigned To | Risk Tier | Allowed Use | Approval Required? |
|---|---|---|---|---|
| SearchTool / ContentReadTool | Parent | Tier 1 | Read Jira, Bitbucket, Confluence, and ledger evidence. | No, if already permissioned. |
| Ledger proposal formatting | Parent | Tier 1 | Produce proposed evidence rows for human review. | No. |
| Jira or Bitbucket mutation | None | Tier 3 | Not allowed in initial design. | N/A. |

## Write Actions

| Action | Risk Level | Confirmation Required | Approval Flow |
|---|---|---|---|
| Jira transition or field update | Critical | Not allowed | Future governed workflow only. |
| PR approval or merge | Critical | Not allowed | Future governed workflow only. |
| Confluence ledger write | Medium | Not enabled initially | Human copies or approved automation writes later. |

## Human Approval Points

| Trigger | Approver | Escalation Path |
|---|---|---|
| Promote candidate to experimental pilot | Agent owner and release owner | Working group review. |
| Treat a drift class as automatic `BLOCK` | Release owner plus dev/QA lead | Document rule in ledger contract. |
| Resolve ambiguous team Done mapping | Jira project admin or team lead | Keep state `UNKNOWN` until mapped. |

## Permission Boundaries

- May access: approved Jira release scope, approved Bitbucket PR/branch/commit metadata for ClaimCenter, PolicyCenter, BillingCenter, and ContactManager, release plan pages, test evidence sources, and ledger records.
- May not access: unrelated repositories, restricted customer data, non-release Jira projects, or write-only admin workflows.
- Must never: transition Jira issues, approve or merge PRs, make final go/no-go decisions, infer release readiness from unavailable sources, or claim a missing source is healthy.

## Expected Outputs

| Output | Format | Destination |
|---|---|---|
| Daily Health Pulse | Table plus short summary | Release channel, Confluence, or user response |
| Drift Finding | Ledger-compatible row | Evidence ledger or proposed ledger section |
| Code Freeze Handoff | Drift history summary | Release Health Analyst input |

## Example Prompts

1. Run a drift pulse for fixVersion `[version]` before code freeze using develop as source of truth.
2. Check this JQL result or Jira export for code-required Done items that lack Bitbucket evidence.
3. Summarize unresolved drift that Release Health Analyst should consider at code freeze.

## Test Cases

| Case ID | Category | Prompt | Expected Behavior | Status |
|---|---|---|---|---|
| RDM-TC-01 | Happy path | Check a release where Done stories have merged PRs in develop and test evidence. | Marks applicable records `PASS` with high confidence. | Not Run |
| RDM-TC-02 | Missing code | Jira story is Done but no branch, PR, or commit includes the key. | Marks `WARN` before freeze and recommends code evidence review. | Not Run |
| RDM-TC-03 | Wrong branch | PR is merged to develop after code freeze, but not release branch. | Marks `BLOCK` or high-severity `WARN` based on freeze rule. | Not Run |
| RDM-TC-04 | Missing tests | Test-required story has code evidence but no accepted test evidence. | Marks `WARN` and asks QA lead to confirm evidence. | Not Run |
| RDM-TC-05 | Source unavailable | Bitbucket evidence cannot be read. | Marks `UNKNOWN`, not `PASS`. | Not Run |
| RDM-TC-06 | Non-code item | Documentation or process task is Done and code evidence does not apply. | Does not warn for missing code. | Not Run |
| RDM-TC-07 | Shared code evidence | One merged PR lists multiple Jira keys. | Records shared coverage and applies it to listed keys without requiring duplicate PRs. | Not Run |
| RDM-TC-08 | Shared test evidence | Parent epic test plan lists child stories. | Allows child stories to inherit test evidence through explicit coverage mapping. | Not Run |

## Failure Modes

| Failure Mode | Likelihood | Impact | Mitigation |
|---|---|---|---|
| False positives from team-specific Jira workflows | High | Alert fatigue and loss of trust | Pilot one team first; use `UNKNOWN` for unmapped rules. |
| Weak Jira-to-Bitbucket matching | Medium | Missed or incorrect code evidence | Use match strength and confidence; do not let low confidence produce `PASS`. |
| Over-alerting | Medium | Teams ignore the monitor | Daily digest, changed findings only, high threshold for `BLOCK`. |
| Source access gaps | Medium | Incomplete health view | Fail closed with `UNKNOWN` and explicit source readiness status. |

## Owner And Governance

| Field | Value |
|---|---|
| Primary owner | TBD |
| Backup owner | TBD |
| Purpose | Detect release evidence drift before code freeze. |
| Audience | Dev leads, QA leads, release owners; final summary consumed by Release Health Analyst. |
| Readiness status | Needs Cleanup |
| Project Brain link | Release Drift Monitor Project Brain |
| Last-reviewed date | 2026-05-27 |
| Review cadence | Release-based during pilot |
| Next review date | After first real data sample |
| Retirement criteria | Deprecate or absorb if Release Health Analyst gains reliable low-noise monitoring without blurring decision support. |

## Version History

| Version | Date | Change Summary | Updated By |
|---|---|---|---|
| v0.1 | 2026-05-27 | Initial candidate design from release drift discussion. | Codex governance scaffold |

## Success Metrics

| Metric | Baseline | Target | Measurement Method |
|---|---|---|---|
| Early drift found before code freeze | TBD | At least one actionable finding before freeze in pilot, if drift exists | Compare pulse findings to freeze readiness review |
| False-positive rate | TBD | Less than 20 percent after two pilot pulses | Human disposition of warnings |
| Source unknown rate | TBD | Downward trend as mappings improve | Count `UNKNOWN` findings per pulse |
| Code-freeze surprise reduction | TBD | Fewer new blockers first discovered by Release Health Analyst | Compare drift history to final readiness report |
