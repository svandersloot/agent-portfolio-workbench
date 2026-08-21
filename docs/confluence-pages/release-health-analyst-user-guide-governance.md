# Governance and Ownership

This page documents who owns Release Health Analyst, how changes to it are controlled, and what future owners need to know to take it over safely.

> **Important:** This page describes the governance process. It does not itself grant or change ownership, approval authority, or Studio access — those remain human-owned decisions made outside this manual.

## Agent Ownership Model

| Field | Value |
| --- | --- |
| Agent | Release Health Analyst |
| Domain | Release and Change Management |
| Primary Owner | Shayne Vandersloot |
| Backup Owner | Hareesh Kumar Munaganuri |
| Source of truth for behavior | `Release Health Analyst Project Brain` and its linked family (Runtime Contract, Assessment Behavior Rules, Template, Prompt Library) |
| Review cadence | Quarterly lifecycle review |

## Primary Owner

The primary owner is accountable for the agent's behavior, Studio configuration, knowledge sources, and this documentation family staying in sync. Today, admin access to the ROVO Studio configuration is held only by the primary owner.

> **Caveat:** Broader admin access for Automation Administrators is still being arranged. Until it is, changes to the live Studio configuration route through the primary owner.

## Backup Owner Process

The backup owner exists so the agent isn't a single point of failure. The intent is that the backup owner can step in for reviews, minor updates, and continuity if the primary owner is unavailable — through the same change-control process below, not through ad hoc access.

## Change Control Process

- Changes to agent behavior should go through the owner or backup owner, not be made directly in Studio by anyone with access.
- The goal is to avoid ad hoc modifications that could silently break the agent for everyone using it.
- Proposed changes should be reviewed against the current Runtime Contract, Assessment Behavior Rules, Template, and Prompt Library before being applied in Studio.
- After a Studio change is made, capture the updated configuration back into the repo-backed documentation so it stays recoverable.

## Version Control Expectations

Durable behavior (parent instructions, knowledge sources, templates, prompt library) should be tracked in Git-backed source documents, not held only in ROVO Studio's own state. This is what makes the agent's configuration recoverable if Studio state is lost or a change needs to be rolled back — the repo-backed copy is the version-controlled record.

- Avoid ad hoc modifications made only in Studio with no corresponding repo update.
- Use the documented review and approval process for any durable change.
- Maintain a recoverable, repo-backed configuration record at all times.

## Roles and Responsibilities

| Role | Responsibilities |
| --- | --- |
| Primary Owner | Accountable for agent behavior, Studio configuration, and documentation accuracy; approves changes. |
| Backup Owner | Steps in for continuity; participates in review; can execute approved changes when the primary owner is unavailable. |
| Automation Administrator | Configures and maintains the scheduled automation flow per release cycle; does not change agent behavior directly. |
| Release Manager / Release Owner | Runs and interprets assessments; provides feedback on findings; does not change agent configuration. |
| QA Coordinator / QA Lead | Confirms and closes QA evidence gaps flagged by the agent; provides feedback on assessment accuracy. |

## Feedback and Improvement Opportunities

Please submit agent improvement suggestions, false positives, missing findings, new reporting requirements, and automation enhancement ideas to the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md).
