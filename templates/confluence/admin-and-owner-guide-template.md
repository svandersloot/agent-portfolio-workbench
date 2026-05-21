# Admin and Owner Guide

## Purpose

Define how space admins, working group leads, and agent owners maintain the ROVO governance space.

## Space Admin Responsibilities

- Maintain page hierarchy.
- Maintain labels.
- Archive legacy or duplicate pages.
- Keep `Agent Governance Home` and `Space Structure and Navigation` current.
- Run or coordinate periodic governance toolkit exports.
- Ensure raw Studio captures are not committed or broadly shared.

## Agent Owner Responsibilities

- Keep Project Brain current.
- Maintain Studio configuration documentation.
- Review knowledge sources and permissions.
- Maintain evaluation cases.
- Track value and measurement signals.
- Update Change Log after meaningful changes.
- Assign a backup owner.

## Review Cadence

| Review | Cadence | Owner | Output |
|---|---|---|---|
| Agent owner review | Monthly | Agent owner | Updated status and metrics |
| Governance working group review | Monthly | Working group lead | Decisions, patterns, backlog updates |
| Portfolio review | Quarterly | Space admin | Portfolio health and leadership summary |

## Label Management

Use standard labels from `config/governance-labels.yml`.

Required labels:

- `rovo-agent`
- `project-brain`
- `agent-governance`
- `agent-template`
- `agent-evaluation`
- `agent-adr`
- `context-readiness`
- `agent-measurement`
- `agent-intake`

## Agent Lifecycle

| Status | Meaning | Required Action |
|---|---|---|
| Idea | Proposed need or use case, not yet shaped | Run Agent Fit Intake and route to the lightest useful solution |
| Draft | Early design or Project Brain scaffold exists | Complete ownership, purpose, audience, source, tool, and readiness fields |
| In Review | Candidate design exists | Governance review, inventory check, context readiness, and evaluation |
| Experimental | Pilot use only | Limit audience, collect feedback, and monitor risks |
| Active | Approved and maintained | Regular review, measurement, and source upkeep |
| Needs Remediation | Known ownership, source, measurement, safety, or duplicate gap | Track remediation or pause use |
| Deprecated | Replaced, retired, or no longer recommended | Point users to replacement guidance and archive/label legacy pages |

## Retirement Process

1. Confirm agent is no longer needed or has been replaced.
2. Update Agent Inventory status.
3. Update Project Brain with retirement reason.
4. Archive or label legacy pages.
5. Record decision in ADR if the retirement is significant.
