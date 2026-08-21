# Release Health Analyst - User Guide & Operations Manual

This is the operations and knowledge-transfer manual for the **Release Health Analyst** ROVO agent. It is the companion to the builder-facing `Release Health Analyst Project Brain` family (Blueprint, Runtime Contract, Studio Setup, Assessment Behavior Rules, Template, Prompt Library, Evaluation). Use the Project Brain family when you need to change how the agent behaves. Use this manual when you need to run, operate, maintain, or hand off the agent day to day.

> **Important:** Release Health Analyst produces decision support, not a decision. The final release go/no-go call always stays with the human release owner. See [Release Health Analyst Overview](#) for what the agent is and is not.

## Overview

Release Health Analyst is a "fail-closed" release governance agent that reads Jira and Confluence evidence for a named release, classifies open items P1-P5, and produces a copy-ready Confluence assessment page covering readiness, blockers, risks, source-completeness gaps, and questions for the release owner. See [Release Health Analyst Overview](release-health-analyst-user-guide-overview.md) for full detail.

## Business Purpose

- Replace ad hoc, manually assembled release-status summaries with a consistent, evidence-grounded assessment.
- Surface P1-P5 blockers and risks before the Release Readiness (RR) call instead of during it.
- Catch source-completeness gaps: items marked done or tested without linked evidence.
- Preserve a run-over-run history (snapshot/fingerprint) so trend and drift are visible over time.

## Key Benefits

- Automated P1-P5 classification tied to production impact, not raw open-item counts.
- Source completeness audits for Jira, code, QA, deployment, and release-note evidence.
- Historical trend and delta tracking between assessment runs.
- Scheduled runs that land ahead of the RR call so the freshest status is ready for human review.
- A consistent question set for release owners instead of one-off status chases.

## Intended Users

| Role | How this manual helps |
| --- | --- |
| Release Managers | Run and interpret assessments; run the RR-call cadence. |
| Release Owners | Understand findings, answer flagged questions, make the final call. |
| QA Coordinators / QA Leads | Confirm test-evidence completeness; close source gaps. |
| Automation Administrators | Configure and maintain the scheduled ROVO Studio automation. |
| Future Agent Owners / Backup Owners | Take over ownership, governance, and change control. |

## How This Manual Is Organized

| Page | Use when you need to... |
| --- | --- |
| [Release Health Analyst Overview](release-health-analyst-user-guide-overview.md) | Understand what the agent does and does not do. |
| [Running a Manual Release Assessment](release-health-analyst-user-guide-manual-assessment.md) | Run an assessment step by step, on demand. |
| [Understanding the Assessment Output](release-health-analyst-user-guide-assessment-output.md) | Read and act on a generated assessment page. |
| [Release Health Automation Setup](release-health-analyst-user-guide-automation-setup.md) | Configure a new scheduled assessment run in ROVO Studio. |
| [Automation Field Reference](release-health-analyst-user-guide-automation-field-reference.md) | Look up a specific automation field, value, or gotcha. |
| [Release Health Assessment Workflow](release-health-analyst-user-guide-workflow.md) | See the end-to-end process as a diagram. |
| [Best Practices](release-health-analyst-user-guide-best-practices.md) | Improve assessment quality through better ticket hygiene. |
| [Known Limitations and Caveats](release-health-analyst-user-guide-known-limitations.md) | Understand what the agent can't see or can't do yet. |
| [Troubleshooting Guide](release-health-analyst-user-guide-troubleshooting.md) | Diagnose a symptom (wrong release, missing data, page in the wrong place, etc.). |
| [Governance and Ownership](release-health-analyst-user-guide-governance.md) | Understand who owns changes and how change control works. |
| [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md) | Log feedback, gaps, and enhancement ideas. |

## Navigation Links to Child Pages

1. Release Health Analyst Overview
2. Running a Manual Release Assessment
3. Understanding the Assessment Output
4. Release Health Automation Setup
5. Automation Field Reference
6. Release Health Assessment Workflow
7. Best Practices
8. Known Limitations and Caveats
9. Troubleshooting Guide
10. Governance and Ownership
11. Continuous Improvement Backlog

## Quick Start Guide

- [ ] **Open** the Release Health Analyst agent.
- [ ] **Launch from a release-specific Confluence page** when possible — the agent picks up the release page as priority context and can infer the fixed version from it.
- [ ] **Verify the identified release version.** The agent may infer the fixVersion from context or prior runs; confirm it against the team's Release filter/JQL before trusting it.
- [ ] **Review the generated assessment** — Executive Summary, Issue Classification, Risks, and Blockers first.
- [ ] **Create or publish the assessment page** only after reviewing the preview; confirm explicitly when the agent asks.
- [ ] **Investigate flagged gaps** — work through Questions for Release Owner and Source Completeness gaps.
- [ ] **Run follow-up assessments as ticket data improves** — rerunning preserves history and updates the fingerprint/snapshot for the next run.

> **Recommendation:** Treat every run as "trust but verify." Release Health Analyst is a detective, not a judge — confirm its evidence before repeating its conclusions to stakeholders.

## Frequently Asked Questions

<details>
<summary><strong>Does Release Health Analyst make the release go/no-go decision?</strong></summary>

No. It provides decision support only — readiness signal, blockers, risks, and gaps. The human release owner always makes the final call. See [Release Health Analyst Overview](release-health-analyst-user-guide-overview.md#what-the-agent-is-not).
</details>

<details>
<summary><strong>Why did it create a brand-new page instead of updating the existing assessment?</strong></summary>

The agent is currently unreliable at editing an existing Confluence page in place, so the operating pattern is to publish a new child page per run and preserve history through the Snapshot Log/Fingerprint instead. See [Known Limitations and Caveats](release-health-analyst-user-guide-known-limitations.md).
</details>

<details>
<summary><strong>Why does it ask me for the fixed version again when I already gave it?</strong></summary>

This is a deliberate fail-closed guardrail: if release identity is fuzzy or unconfirmed, the agent will not produce scope counts or an assessment rather than guess. Confirm the exact fixVersion when asked.
</details>

<details>
<summary><strong>Can it see Bitbucket or Xray directly?</strong></summary>

Not currently. See [Known Limitations and Caveats](release-health-analyst-user-guide-known-limitations.md) for the workaround (linking PRs and QA evidence in ticket comments).
</details>

<details>
<summary><strong>Who can change what the agent does?</strong></summary>

Only the named primary owner or backup owner, through the documented change-control process. See [Governance and Ownership](release-health-analyst-user-guide-governance.md).
</details>

<details>
<summary><strong>Where do I send feedback or report a false positive?</strong></summary>

Log it on the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md) page, or use the Feedback and Improvement Opportunities section at the bottom of every page in this manual.
</details>

## Feedback and Improvement Opportunities

This manual and the agent it documents improve from real usage. Please submit:

- Agent improvement suggestions
- False positives (things the agent flagged that weren't actually issues)
- Missing findings (things a human caught that the agent didn't)
- New reporting requirements
- Automation enhancement ideas

Log these on the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md) page, or route them to the agent's Primary Owner or Backup Owner listed on [Governance and Ownership](release-health-analyst-user-guide-governance.md).
