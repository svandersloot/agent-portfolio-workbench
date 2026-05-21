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

## Agent Lifecycle

| Status | Meaning | Required Action |
|---|---|---|
| Draft | Idea or early design | Fit triage and context readiness |
| In Review | Candidate design exists | Governance review and evaluation |
| Green | Approved and maintained | Regular review and measurement |
| Yellow | Known issues or stale docs | Remediation plan |
| Red | Unsafe, stale, or blocked | Pause use and remediate |
| Retired | No longer active | Archive or mark legacy |

## Retirement Process

1. Confirm agent is no longer needed or has been replaced.
2. Update Agent Inventory status.
3. Update Project Brain with retirement reason.
4. Archive or label legacy pages.
5. Record decision in ADR if the retirement is significant.
