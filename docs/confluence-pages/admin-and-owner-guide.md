# Admin and Owner Guide

## Purpose

Use this guide to understand who is accountable for governed ROVO agents, what owners and admins are expected to do, how often agents are reviewed, how labels and inventory stay clean, and how agents are deprecated or retired.

This guide documents responsibilities and processes. It does not grant approval. Promotion, ownership assignment, visibility changes, and retirement remain human-owned decisions recorded through the normal review path.

## Roles

| Role | Primary Accountability |
|---|---|
| Space admin | Confluence space structure, page moves, publishing after approval, and label hygiene. |
| Atlassian admin | Studio creation permissions, user access, and any Studio visibility or permission change. |
| Working group / space maintainer | Approves Active or broad Ready status; owns the governance operating model. |
| Agent owner | Accountable for a specific agent's Project Brain, sources, readiness, measurement, and lifecycle status. |
| Backup owner | Covers owner responsibilities when the primary owner is unavailable. |
| Agent Doc Steward | Supports documentation quality, context readiness, and Doc Health checks with the Design Agent. |

## Admin Responsibilities

- Manage who can create agents in ROVO Studio (Atlassian admin), and confirm user access controls manually because local exports do not expose team assignment or discoverability fields (Evidence: Unknown for automated capture).
- Keep the Confluence space structure coherent: move pages instead of copying or recreating them so page history is preserved.
- Publish or update governance pages only through a focused dry-run and explicit approval. Never claim a publish, Studio save, or Jira action happened unless it actually happened.
- Record publish-history evidence after an approved apply (page ID, title, old version, new version, source file, command, timestamp, verification result).
- Keep `.env`, `config/confluence-pages.yml`, `data/raw/`, HARs, cookies, headers, tokens, and private URLs out of Git; run the private-data scan before staging.
- Run the page-family and source-link consistency check before committing a governed-agent page family or publishing plan.

## Owner And Backup-Owner Expectations

Every governed agent should have a named primary owner and a named backup owner, or a documented ownership gap with a remediation owner.

Owners are expected to:

- Keep the Project Brain, knowledge source plan, and lifecycle status current.
- Confirm knowledge sources remain stable, current, and appropriately scoped.
- Maintain readiness evidence and a measurement plan, and act on what the measurements show.
- Keep the last-reviewed date current.
- Raise drift when Confluence status, Studio publication state, or runtime behavior disagree.
- Prepare Studio copy packets for manual configuration rather than expecting automated Studio writes.

Backup owners are expected to be able to perform the same responsibilities when the primary owner is unavailable, and to be named before an agent moves beyond Draft.

Ownership and backup-owner assignment are human-owned decisions. This guide does not assign them.

## Review Cadence

| Trigger | Review Action |
|---|---|
| Monthly | Produce or review the monthly governance snapshot: what changed, what exists, what is ready, what is experimental, what is missing required fields, and duplicate or reuse candidates. |
| On material change | Re-review an agent when its instructions, sources, tools, audience, or risk model change. |
| On status change | Re-check completeness fields when an agent moves between lifecycle statuses. |
| On drift signal | Reconcile when Git, Confluence, Studio, or Jira disagree on status, readiness, ownership, approval, or runtime behavior. |
| Periodic owner review | Owners refresh the last-reviewed date and confirm the agent is still useful, safe, and correctly scoped. |

Use the owner/readiness gap report to find agents missing a primary owner, backup owner, status, readiness, measurement, Project Brain link, or last-reviewed date. Reporting stays field-level and does not use percentage completeness scoring.

## Label And Inventory Hygiene

- Keep the Confluence inventory as the human-readable place people discover agents; keep repo source and the future structured inventory as the checkable source of non-negotiable fields.
- Apply the `agent-governance` label to governed pages, plus specific labels (for example, project-brain, knowledge-source-plan, rovo-studio-configuration, agent-evaluation, agent-measurement, user-guide) that match the page's role.
- Keep manifest entries in `config/confluence-pages.example.yml` aligned with the page-ready drafts under `docs/confluence-pages/` so the page-family consistency check can see the whole family.
- Before adding a new agent, run the Agent Fit Intake and Agent Inventory reuse/duplicate checks to prevent sprawl.
- When reorganizing, move pages to preserve history; do not create duplicate planning or inventory surfaces.

## Retirement And Deprecation Process

Retirement, deprecation, archive, duplicate merge, and resurrection are human-owned decisions. Do not automate or imply them from this repo. The steps below document the process for a human to follow.

| Step | Action |
|---|---|
| 1 | Confirm the reason: a better solution exists, usage or value ended, risk is unacceptable, or the owner is retiring the agent. |
| 2 | Record the decision with an accountable human approver (working group or space maintainer). |
| 3 | Set lifecycle status to `Deprecated` in the Project Brain and inventory. |
| 4 | Point users to the replacement or retirement notes, and remove the agent from recommended lists where possible. |
| 5 | Note the Studio follow-up (visibility or unpublish) as a manual admin action; do not automate the Studio change. |
| 6 | Record the change in the agent's change log and, if pages changed, in publish history after an approved apply. |

Deprecation exit criteria: the inventory, Project Brain, and user-facing docs clearly point to the replacement or retirement notes.

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
- Known Risks and Limitations
- Agent Fit Intake
- Agent Inventory
- Measurement and Value Tracking
- User Guide - Designing Agents
