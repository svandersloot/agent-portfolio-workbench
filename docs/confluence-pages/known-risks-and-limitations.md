# Known Risks and Limitations

## Purpose

Use this page to understand what ROVO agent governance can and cannot control today, where the platform limits us, and which risks require human judgment or workarounds.

This page is honest about current constraints on purpose. Governance should not imply controls that do not exist. When a limitation affects readiness, visibility, ownership, or approval, treat it as a reason to slow down, not a detail to hide.

Evidence labels are used throughout:

- Confirmed: supported by Atlassian public guidance or repeatable local evidence.
- Partial: some evidence exists, but the control or behavior is not fully verified.
- Unknown: not proven by current local evidence; needs manual Studio or admin confirmation.

## Platform Limitations

| Limitation | What It Means | Evidence |
|---|---|---|
| No supported Studio configuration write-back | ROVO Studio-created agent configuration must be changed manually in Studio. This repo and its scripts do not write to Studio, and there is no supported API for writing Studio-created agent configuration. Forge `rovo:agent` supports app-defined Forge agents only, not edits to Studio-created agents. | Confirmed |
| Group or team-based agent access restriction not supported | Studio cannot currently restrict agent access by group or team. Agents can be restricted to individually added users, which does not scale as a discoverability control for Draft, In Review, or Experimental agents. | Confirmed |
| Limited durable version control in Studio | Studio does not yet provide enough version history for durable governance. Git is used as the local audit trail for source drafts, scripts, manifests, and publish history instead. | Confirmed |
| Normalized export omits visibility and team fields | The normalized Studio schema captures `isPublished`, knowledge sources, tools, web search, deep research, and subagent activation, but not team assignment, sharing scope, visibility, discoverability, editors, or viewers. Drift on those fields cannot be detected from current captures. | Confirmed |
| Studio visibility and discoverability controls unproven | Whether Draft, In Review, or Experimental agents can be hidden from broad discovery, and who can change team assignment or visibility, is not proven by local evidence. | Unknown |
| Agent skills are not governance automation | ROVO agent skills can perform some Confluence or Jira actions on the user's behalf after confirmation, but they are not a substitute for deterministic governance automation or Studio configuration write-back. | Confirmed |
| Confluence databases not fit for release-health dashboards | A pilot showed Confluence database CSV import and saved views work, but dashboard consumption was too clunky to rely on for release-health tracking. | Confirmed |

Sources for the platform-limitation evidence: `docs/reports/studio-visibility-team-assignment-investigation.md`, the platform evidence in `docs/implementation-backlog.md`, and `docs/toolkit-operating-model.md`.

## Organizational Risks

| Risk | Description | Impact |
|---|---|---|
| Implied approval | Governance content, drafts, or agent output implies an agent is Active, Ready, or broadly approved when a human has not approved it. | False confidence; unsafe promotion. |
| Ownership gaps | An agent has no clear primary owner or backup owner, so review, remediation, and retirement stall. | Stale or drifting agents. |
| Status drift | Confluence inventory status, Studio publication state (`isPublished`), and actual runtime behavior disagree. | Users trust the wrong signal. |
| Over-broad discoverability | Draft or Experimental agents become discoverable to a broad audience because group/team restriction is not available. | Unready agents used as if approved. |
| Duplicate agents | Builders create overlapping agents because inventory or reuse checks were skipped. | Sprawl and maintenance burden. |
| Stale knowledge sources | Agents point at outdated or overly broad sources, degrading answer quality and trust. | Unreliable behavior. |
| Private-data leakage | Raw exports, tokens, cookies, headers, or private URLs enter Git, prompts, or shared drafts. | Security and privacy exposure. |
| Governance-as-decoration | Evaluations, measurement plans, or reviews exist but are not used to decide whether to keep or change an agent. | Unmeasured, unaccountable agents. |

## Mitigations

| Risk Area | Mitigation |
|---|---|
| Implied approval | Keep Active, broad Ready, pilot promotion, owner assignment, and retirement as human-owned decisions. Agents draft and check; they do not approve. |
| Ownership gaps | Require primary owner and backup owner (or a documented gap with a remediation owner) in the governance completeness fields before an agent moves beyond Draft. |
| Status drift | Treat repo source and Confluence inventory as the governance status of record; report drift between Confluence status and Studio `isPublished` when captures exist, instead of silently choosing one surface. |
| Over-broad discoverability | Use the interim lifecycle controls below until Studio visibility controls are confirmed. |
| Duplicate agents | Run the Agent Fit Intake and Agent Inventory reuse/duplicate checks before recommending a new governed agent. |
| Stale knowledge sources | Scope knowledge sources narrowly and explicitly, and use the Context Readiness Checklist before durable build. |
| Private-data leakage | Keep `.env`, `config/confluence-pages.yml`, `data/raw/`, HARs, cookies, headers, tokens, and private URLs out of Git. Run the private-data scan before staging or committing. |
| Governance-as-decoration | Use evaluations and measurement as evidence for keep/change/deprecate decisions, not as documentation theater. |

## Workarounds

Until platform controls improve, use these documented workarounds.

### Interim Visibility Controls By Lifecycle Status

Because group or team access restriction is not supported and Studio discoverability controls are unproven (Evidence: Unknown), rely on documentation and process discipline rather than a hard platform control.

| Lifecycle Status | Interim Control |
|---|---|
| Draft | Treat as not approved in the Confluence inventory and Project Brain. Avoid broad promotion. |
| In Review | Share links only with reviewers and owners until Studio controls are confirmed. |
| Experimental | Document the pilot audience in the Project Brain and inventory. Do not describe the agent as broadly approved. |
| Active | Require governance approval plus intended-audience documentation before broad discoverability. |
| Needs Remediation | Add remediation notes and pause promotion. |
| Deprecated | Point users to replacement guidance and remove the agent from recommended lists where possible. |

### Configuration And Version Control

- Use this repo and dry-run-first tooling for durable governance content; treat Studio as the manually configured runtime.
- Prepare Studio copy packets and guide a human through manual copy steps instead of automating Studio writes.
- Capture Studio configuration back into this repo after a human saves it, so Git shows meaningful drift on the fields the schema does support.

### Drift And Reconciliation

When Git, Confluence, Studio, or Jira disagree in a way that affects current truth, readiness, status, ownership, approval, or runtime behavior, stop and report the drift and recommend the smallest reconciliation path.

## Human-Owned Decisions

Humans still own:

- Active, broad Ready, or pilot promotion status.
- Pilot or broad visibility.
- Primary owner and backup owner assignment.
- Agent retirement, deprecation, archive, duplicate merge, or resurrection.
- Studio visibility, team assignment, or permission changes.
- Policy exceptions or approval-authority changes.
- Jira and Confluence writes.

## Related Pages

- Governance and Safety
- Admin and Owner Guide
- Agent Fit Intake
- Context Readiness Checklist
- Measurement and Value Tracking
- Agent Inventory
