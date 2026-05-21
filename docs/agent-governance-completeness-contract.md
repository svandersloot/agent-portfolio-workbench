# Agent Governance Completeness Contract

This contract defines the minimum fields required for every governed ROVO agent. It is intentionally small enough to support the current Confluence inventory and structured enough to power future reports.

## Contract Status

| Field | Value |
|---|---|
| Contract version | 1 |
| Effective date | 2026-05-21 |
| Scope | Governed ROVO agents and candidate agents that move beyond `Idea` |
| Canonical human page | `Agent Fit Intake` |
| Structured schema | `schemas/agent-governance-record.schema.json` |
| Migration posture | New and updated agents should use this contract first; existing agents can be remediated over time. |

## Required Fields

| Field | Type | Required For | Completeness Rule |
|---|---|---|---|
| `agentName` | Text | All records | Must identify the agent or candidate by its current display name. |
| `owner` | Text or object | Draft and above | Must name a primary owner or accountable owning team. |
| `backupOwner` | Text or object | Draft and above | Must name a backup owner/delegate, or include a gap note and remediation owner. |
| `status` | Enum | All records | Must be one of `Idea`, `Draft`, `In Review`, `Experimental`, `Active`, `Needs Remediation`, or `Deprecated`. |
| `purpose` | Text | Draft and above | Must explain why the agent exists and the outcome it supports. |
| `audience` | Text or list | Draft and above | Must describe intended users, team, role, or group and any visibility constraints. |
| `knowledgeSources` | List | Draft and above | Must name approved source pages, spaces, Jira projects, filters, or other sources. |
| `toolsOrSkills` | List | Draft and above | Must list tools, skills, actions, and risk tier; `none` is acceptable only when explicit. |
| `measurementPlan` | Object | In Review and above | Must include value signal, baseline/estimate method, quality/risk signal, and cadence. |
| `readinessStatus` | Enum | Draft and above | Must be `Ready`, `Needs Cleanup`, or `Not Ready`, with evidence or remediation notes. |
| `projectBrainLink` | URL or page reference | Draft and above | Must link to the Project Brain or scaffold. |
| `lastReviewedDate` | Date | In Review and above | Must be an ISO date for the last owner, reviewer, or working-group review. |

## Lifecycle Status Policy

| Status | Policy |
|---|---|
| Idea | The request is being shaped. It may be a prompt, automation, template, app, existing-agent extension, new agent, or not ready. It does not require a complete Project Brain. |
| Draft | The agent design or Project Brain scaffold exists. Required ownership, purpose, audience, source, tool, and readiness fields should be captured before review. |
| In Review | The agent package is being checked for fit, duplicate risk, ownership, source readiness, measurement, and safety. It should not be promoted to Active without reviewer approval. |
| Experimental | The agent can be piloted with a select audience, defined guardrails, and active owner monitoring. It should not be represented as broadly approved. |
| Active | The agent is approved for intended use, discoverable to the right audience, governed by a current Project Brain, and has accepted measurement and review cadence. |
| Needs Remediation | The agent has a material gap such as stale sources, missing owner, risky tool use, duplicate overlap, failed evaluation, or missing measurement. Remediation must be tracked. |
| Deprecated | The agent is retired, replaced, or no longer recommended. Inventory and Project Brain pages should point to replacement guidance or retirement notes. |

## Readiness Rules

| Readiness Status | Meaning |
|---|---|
| Ready | Source context, ownership, permissions, guardrails, and measurement are sufficient for the current lifecycle step. |
| Needs Cleanup | The agent can continue only with tracked remediation, caveats, or a limited pilot audience. |
| Not Ready | Do not build, extend, launch, or broaden the agent until blocking gaps are resolved. |

## Dry-Run Report Shape

Future completeness checks should produce a read-only report with this shape.

| Column | Purpose |
|---|---|
| Agent | Display name from inventory or normalized Studio export. |
| Status | Current lifecycle status. |
| Completeness | Percent of required fields present for the current lifecycle step. |
| Missing Required Fields | Comma-separated list of missing fields. |
| Readiness | Ready, Needs Cleanup, or Not Ready. |
| Duplicate Or Reuse Signal | Existing agent, extension candidate, template candidate, or none found. |
| Risk Notes | Tool, source, permission, or audience concerns. |
| Recommended Action | Promote, keep in review, remediate, consolidate, deprecate, or keep as idea. |
| Owner | Primary owner or gap. |
| Last Reviewed | Last-reviewed date or gap. |

## Compatibility Notes

- This contract does not require every existing Confluence page to be migrated immediately.
- Older Green/Yellow/Red measurement language can map into readiness and remediation status during migration.
- `Active` and `Ready` are separate concepts: `Active` is lifecycle status; `Ready` is readiness evidence.
- Prompts, automations, templates, and app candidates can be recorded as intake outcomes without becoming governed agents.
