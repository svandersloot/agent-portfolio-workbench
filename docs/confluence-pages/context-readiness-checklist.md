# Context Readiness Checklist

## Purpose

Use this checklist before designing or extending a durable ROVO agent. It determines whether the source context is clear enough for an agent to rely on, or whether documentation cleanup must happen first.

## When To Use This Checklist

Use this checklist when:

- A new durable agent is proposed.
- An existing agent needs broader knowledge access.
- A team wants to convert a manual workflow into an agent or automation.
- A Project Brain or source-of-truth page is being created.
- A review finds stale, duplicate, or ownerless source material.

## Assessment Metadata

| Field | Value |
|---|---|
| Agent or workflow | TBD |
| Assessor | TBD |
| Assessment date | TBD |
| Source pages reviewed | TBD |
| Overall readiness | Ready / Needs Cleanup / Not Ready |

## Assessment Criteria

| # | Criterion | Rating | Evidence | Notes |
|---|---|---|---|---|
| 1 | Source-of-truth clarity: Is there one clear, authoritative source for each required input? | Green / Yellow / Red | Link or description | Note conflicts or ambiguity |
| 2 | Documentation freshness: Are source pages current within expected cadence? | Green / Yellow / Red | Last modified dates | Note stale pages |
| 3 | Ownership clarity: Does every source page have a named owner or accountable team? | Green / Yellow / Red | Owner names or gaps | Note missing backups |
| 4 | Workflow repeatability: Is the workflow documented step by step with consistent terminology? | Green / Yellow / Red | Link or description | Note undocumented decisions |
| 5 | Jira or system structure quality: Are required projects, issue types, fields, statuses, or records consistent? | Green / Yellow / Red | Projects, filters, or systems reviewed | Use N/A only when no structured system applies |
| 6 | Permission clarity: Is it clear who can access each source and whether the agent should use it? | Green / Yellow / Red | Permission notes | Flag sensitive or restricted sources |
| 7 | Heading and format consistency: Do source pages use clear headings, tables, labels, and stable sections? | Green / Yellow / Red | Pages reviewed | Note parsing or readability problems |
| 8 | Duplicate or stale risk: Are there duplicate, archived, or outdated pages that could confuse an agent? | Green / Yellow / Red | Pages flagged | Include cleanup recommendation |
| 9 | Labeling and discoverability: Are pages labeled or organized with standard governance labels? | Green / Yellow / Red | Labels checked | Note missing labels |
| 10 | Risk level: Does the workflow involve sensitive data, write actions, compliance decisions, or customer-impacting outcomes? | Low / Medium / High | Risk factors | High-risk workflows need explicit guardrails |

## Rating Guide

| Rating | Meaning |
|---|---|
| Green | Clear enough for agent design. Minor cleanup can happen in parallel. |
| Yellow | Usable with documented caveats or near-term remediation. |
| Red | Not reliable enough for durable agent behavior. Cleanup is required first. |

## Overall Recommendation

| Overall | Criteria | Required Action |
|---|---|---|
| Ready | No Red ratings. Yellow items have clear remediation owners. | Continue to fit triage and design artifacts. |
| Needs Cleanup | 1-2 Red ratings or 3+ Yellow ratings. | Create remediation actions before final Studio configuration. |
| Not Ready | 3+ Red ratings, unclear ownership, or high-risk source ambiguity. | Do not create or extend a durable agent until source cleanup is complete. |

## Scoring

| Rating | Count |
|---|---|
| Green | TBD |
| Yellow | TBD |
| Red | TBD |
| High-risk criteria | TBD |

## Remediation Actions

| # | Issue | Severity | Action Required | Owner | Target Date | Status |
|---|---|---|---|---|---|---|
| 1 | TBD | P0 / P1 / P2 | TBD | TBD | TBD | Not Started |

## Readiness Decision

Use one of these decisions:

- Ready for fit triage.
- Ready for design with cleanup actions.
- Needs source cleanup before design.
- Not ready for agent work.
- Better suited for prompt-only, default ROVO, automation, or process documentation.

## Notes For Reviewers

- Do not treat missing documentation as an agent design problem. Fix the source first.
- Prefer narrow, named source pages over broad all-space access.
- If the context is team-specific, document whether a broad agent plus team overlay would work.
- If the workflow needs write actions or high-risk decisions, require human approval and evaluation evidence.
