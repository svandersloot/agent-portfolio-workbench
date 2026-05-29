# Agent Inventory

Use this page as the canonical inventory of governed ROVO agents and agent candidates. Builders should check this inventory before requesting a new governed agent.

`Rovo Agent Inventory Home` is the space overview/root. It should not be used as the detailed inventory record source.

## Inventory Policy

- Keep one canonical row per governed agent, extension, or serious agent candidate.
- Link each durable agent to its Project Brain.
- Track lifecycle status separately from readiness status.
- Record owner, backup owner, audience, knowledge sources, tools or skills, measurement, and last-reviewed date before broad launch.
- Use `Needs Cleanup` when required governance fields are missing.
- Do not delete or recreate duplicate pages as part of cleanup. Use focused legacy notes, moves, or reparenting only after review.

## Required Inventory Fields

| Field | Purpose |
|---|---|
| Agent | Current display name. |
| Type | Governed agent / Extension / Candidate / Meta-agent. |
| Lifecycle status | Idea / Draft / In Review / Experimental / Active / Needs Remediation / Deprecated. |
| Readiness status | Ready / Needs Cleanup / Not Ready. |
| Purpose | What outcome the agent supports. |
| Audience | Intended users, team, role, or group. |
| Primary owner | Accountable owner or owning team. |
| Backup owner | Backup owner, delegate, or documented gap owner. |
| Project Brain | Source-of-truth Project Brain link. |
| Knowledge sources | Main source pages, spaces, Jira projects, filters, or approved sources. |
| Tools or skills | Tools, skills, actions, and notable risk tier. |
| Measurement plan | Value signal, baseline or estimate method, quality/risk signal, and cadence. |
| Visibility notes | Intended discoverability, pilot audience, or Studio visibility/team-assignment uncertainty. |
| Compliance/data notes | Compliance tier, environment, SLO/runbook, data/privacy notes, or N/A. |
| Last reviewed | Last owner, reviewer, or working-group review date. |
| Next action | Remediation, review, launch, consolidate, deprecate, or monitor. |

## Current Inventory Draft

| Agent | Type | Lifecycle status | Readiness status | Purpose | Audience | Primary owner | Backup owner | Project Brain | Knowledge sources | Tools or skills | Measurement plan | Visibility notes | Compliance/data notes | Last reviewed | Next action |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| Rovo Design Agent | Meta-agent | Active / Draft update | Needs Cleanup | Guide builders through agent fit intake, reuse checks, and design scaffolding. | Builders, reviewers, working group members | TBD | TBD | Rovo Design Agent Project Brain | Agent Fit Intake, Agent Inventory, Pattern Library, Templates, Agent Project Brains | Studio configuration exists; verify current tools/skills manually | Track avoided duplicate builds and design packet completeness | Studio visibility controls need manual confirmation | TBD | TBD | Manually copy published intake guidance into Studio and backfill completeness fields. |
| Agent Doc Steward | Meta-agent | Draft | Needs Cleanup | Build and review governance documentation infrastructure. | Agent owners, maintainers, working group | TBD | TBD | Agent Doc Steward Project Brain | Templates, Project Brain docs, governance pages | Doc Health Gate and Studio configuration exist | Add measurement and completeness checks | Studio visibility controls need manual confirmation | TBD | TBD | Update Doc Health Gate for measurement and completeness contract. |
| Release Health Analyst | Governed agent | Active | Needs Cleanup | Support release/change health assessment and reporting. | Release and change stakeholders | TBD | TBD | Release Health Analyst Project Brain | Release Health Analyst knowledge source plan, evaluations, Studio configuration | Studio configuration and subagent settings exist | Baseline and target metrics need verification | Intended audience needs confirmation | Release/change data; confirm privacy/compliance notes | TBD | Add backup owner, last-reviewed date, and verified measurement plan. |
| Release Drift Monitor | Candidate | Draft | Needs Cleanup | Detect release evidence drift before code freeze by reconciling Jira scope, Bitbucket code evidence, test evidence, QA evidence, and source freshness. | Dev leads, QA leads, release owners; Release Health Analyst as code-freeze consumer | TBD | TBD | Release Drift Monitor Project Brain | Jira fixVersion or export, Bitbucket branch/PR/commit evidence, test/QA evidence, Release Evidence Ledger | Proposed read-only Jira/Bitbucket/Confluence search; no mutations | Draft measurement plan created; needs pilot data | Pilot digest audience only until false-positive rate is known | Release/change/code evidence; confirm source permissions and privacy notes | 2026-05-27 | Validate against real Jira/Bitbucket sample and decide whether to move to Experimental for August release. |
| Release Notes Manager | Governed agent | In Review | Needs Cleanup | Draft, review, and synchronize release notes from approved release sources. | Release owners, product partners, engineering leads, release/change stakeholders | TBD | TBD | Release Notes Manager Project Brain | Jira release scope, release plans, release-note drafts/templates, Release Health Analyst output as reference, Mobilitas archive as example only | Proposed read-only Jira/Confluence search; no write or publish actions enabled | Draft measurement plan created; baseline needs pilot data | Pilot audience and Studio visibility need confirmation | Release/change data; confirm privacy/compliance notes and source permissions | 2026-05-21 | Confirm owner, backup owner, approved sources, manual Studio configuration, and evaluation before launch. |
| Performance Test Report Agent (Extension) | Extension | Draft | Needs Cleanup | Analyze performance test reports and metric deltas. | Performance, release, and engineering stakeholders | Adithya Varma Jaiswal | TBD | Performance Test Report Agent (Extension) Project Brain | Performance Test Report Agent Guide and related Project Brain pages | Search/get/create noted in blueprint; preview required before publishing | Measurement plan needed | Pilot audience needs confirmation | Performance data; confirm data/privacy notes | TBD | Complete backup owner, audience, readiness, measurement, and review date. |
| Jira Ticket Polisher | Governed agent | In Review | Needs Cleanup | Improve Jira ticket quality, handoff clarity, acceptance criteria, and readiness by applying an organization-wide standard plus the active MOBRM team overlay when applicable. | Jira users, product owners, analysts, developers, QA, and delivery teams | TBD | TBD | Jira Ticket Polisher Project Brain | Organization-Wide Jira Ticket Quality Standard, Jira Ticket Polisher Standards - Active Set, MOBRM Team Jira Standards, selected Jira ticket context | Proposed read-only Jira/Confluence search; draft-only output; no Jira update, transition, assign, rank, or comment actions enabled | Draft measurement plan created; baseline needs pilot data | Pilot audience and Studio visibility need confirmation | Jira issue metadata and team workflow context; confirm source permissions and privacy notes before pilot | 2026-05-29 | Confirm owner, backup owner, MOBRM standards publishing, manual Studio configuration, and evaluation before launch. |

## Duplicate And Legacy Notes

| Area | Evidence | Recommended Handling |
|---|---|---|
| Rovo Agent Inventory Home | One root/overview page and one unparented duplicate row appear in local inventory export. | Keep `Rovo Agent Inventory Home` as overview/root. Verify duplicate before any legacy note. |
| Release Health Analyst Project Brain | Three same-title rows appear in local inventory export. | Keep the parented page under the active Project Brain structure; compare unparented copies before any archive/banner action. |
| Release Health Analyst support pages | Duplicate blueprint, evaluation, knowledge source, and assessment template rows appear. | Treat parented pages as likely canonical; compare bodies before cleanup. |
| Performance Test Report Agent support pages | Duplicate subagent settings and change-log rows appear. | Treat pages under the Project Brain as likely canonical; compare bodies before cleanup. |
| Release Notes Manager legacy source | Old-space evidence lists Release Notes Manager as active/review-needed and useful for technical, business, and sync modes. | Keep the new Project Brain in review; do not promote until owner, source, Studio, and evaluation gaps are cleared. |
| Mobilitas Release Notes Agent | Old-space evidence calls this project-specific and domain-specific. | Keep as archive/reference only; do not use Mobilitas language as organization-wide default instructions. |
| Jira Ticket Polisher legacy source | Old-space evidence identifies Jira Ticket Polisher as the best pilot for org-wide ticket standards plus team overlays. | Keep the new Project Brain in review; do not promote until owner, live team research, Studio, and evaluation gaps are cleared. |

## Builder Reuse Checks

Before creating a new governed agent, check:

- Rovo Design Agent for agent intake/design support.
- Agent Doc Steward for governance documentation support.
- Release Health Analyst for release/change health workflows.
- Release Drift Monitor for mid-sprint release evidence drift detection before code freeze.
- Release Notes Manager for release-note drafting, audience rewriting, and source synchronization.
- Performance Test Report Agent (Extension) for performance report analysis.
- Jira Ticket Polisher before starting new Jira issue-quality or ticket-polishing work.

## Review Notes

- This draft is based on local export evidence and repo reports, not a live Studio write.
- Studio visibility and team assignment controls still need manual Studio/admin confirmation.
- Missing owner, backup owner, measurement, readiness, or last-reviewed fields should block promotion to broadly approved `Active` status.
