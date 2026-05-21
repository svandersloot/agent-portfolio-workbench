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
| Performance Test Report Agent (Extension) | Extension | Draft | Needs Cleanup | Analyze performance test reports and metric deltas. | Performance, release, and engineering stakeholders | Adithya Varma Jaiswal | TBD | Performance Test Report Agent (Extension) Project Brain | Performance Test Report Agent Guide and related Project Brain pages | Search/get/create noted in blueprint; preview required before publishing | Measurement plan needed | Pilot audience needs confirmation | Performance data; confirm data/privacy notes | TBD | Complete backup owner, audience, readiness, measurement, and review date. |
| Jira Ticket Polisher | Candidate | Idea / Draft | Not Ready | Improve Jira issue quality and handoff clarity. | Jira users and delivery teams | TBD | TBD | Jira Ticket Polisher Project Brain Draft | TBD | TBD | TBD | Not ready for broad discovery | TBD | TBD | Keep as candidate until Project Brain completeness is proven. |

## Duplicate And Legacy Notes

| Area | Evidence | Recommended Handling |
|---|---|---|
| Rovo Agent Inventory Home | One root/overview page and one unparented duplicate row appear in local inventory export. | Keep `Rovo Agent Inventory Home` as overview/root. Verify duplicate before any legacy note. |
| Release Health Analyst Project Brain | Three same-title rows appear in local inventory export. | Keep the parented page under the active Project Brain structure; compare unparented copies before any archive/banner action. |
| Release Health Analyst support pages | Duplicate blueprint, evaluation, knowledge source, and assessment template rows appear. | Treat parented pages as likely canonical; compare bodies before cleanup. |
| Performance Test Report Agent support pages | Duplicate subagent settings and change-log rows appear. | Treat pages under the Project Brain as likely canonical; compare bodies before cleanup. |

## Builder Reuse Checks

Before creating a new governed agent, check:

- Rovo Design Agent for agent intake/design support.
- Agent Doc Steward for governance documentation support.
- Release Health Analyst for release/change health workflows.
- Performance Test Report Agent (Extension) for performance report analysis.
- Jira Ticket Polisher candidate before starting new Jira issue-quality work.

## Review Notes

- This draft is based on local export evidence and repo reports, not a live Studio write.
- Studio visibility and team assignment controls still need manual Studio/admin confirmation.
- Missing owner, backup owner, measurement, readiness, or last-reviewed fields should block promotion to broadly approved `Active` status.
