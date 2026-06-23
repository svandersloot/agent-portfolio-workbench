# Agent Inventory

Use this page as the canonical inventory of governed ROVO agents and agent candidates. Builders should check this inventory before requesting a new governed agent.

`Rovo Agent Inventory Home` is the space overview/root. It should not be used as the detailed inventory record source.

## User-Facing Starting Points

| Need | Start With |
|---|---|
| Find an approved agent for everyday use | `User Guide - Using Approved Agents` |
| Request a new agent or improve an existing agent | `Request or Improve an Agent` |
| Review the full governed inventory and status fields | This page |

The approved-user guide must show only source-backed `Active` or `Team Approved` agents for the intended audience. Do not infer approval from useful, promising, pilot-only, or draft inventory rows.

## Inventory Policy

- Keep one canonical row per governed agent, extension, or serious agent candidate.
- Link each durable agent to its Project Brain.
- Track lifecycle status separately from readiness status.
- Record owner, backup owner, audience, knowledge sources, tools or skills, measurement, and last-reviewed date before broad launch.
- Use `Needs Cleanup` when required governance fields are missing.
- Do not delete or recreate duplicate pages as part of cleanup. Use focused legacy notes, moves, or reparenting only after review.
- Keep pilot-only, experimental, draft, in-review, needs-cleanup, candidate, archived, superseded, and historical-reference agents out of the everyday approved-agent list.

## Required Inventory Fields

| Field | Purpose |
|---|---|
| Agent | Current display name. |
| Type | Governed agent / Extension / Candidate / Meta-agent. |
| Lifecycle status | Idea / Draft / In Review / Experimental / Active / Needs Remediation / Deprecated / Archived / Superseded. |
| Readiness status | Ready / Needs Cleanup / Not Ready / Historical Reference. |
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
| Jira Work Item Assistant | Governed agent | In Review | Needs Cleanup | Turn Kanban, task, release context, and existing Jira cards into rich, source-backed Jira work item drafts, ticket review/polish guidance, proposed team standards, and common-task guidance that humans and AI can assess consistently. | Requesters, release owners, delivery leads, product owners, developers, QA, and new team members | TBD | TBD | Jira Work Item Assistant Project Brain | MOBRM pilot board/project, Kanban board context, selected Jira issues, Organization-Wide Jira Ticket Quality Standard, approved team standards, proposed team standards, Jira Work Item Draft Bundle | Proposed read-only Jira/Confluence search; future Jira create/bulk-create requires explicit human approval and governed write path | Draft measurement plan created; baseline needs pilot data | MOBRM first pilot confirmed; Studio visibility and write tooling need confirmation | Jira work item data; legacy MO source folder can be archived/superseded after review; confirm privacy notes before pilot | 2026-06-09 | Fold Jira Ticket Polisher review/polish behavior into the existing five-subagent model, rerun evaluation, and keep Jira writes disabled. |
| QA Test Case Architect v2 | Governed agent candidate | Draft | Needs Cleanup | Generate the required QA artifact package from production ticket packs, including FeatureBrief XML, TestSuite XRAY CSV text, CoverageMap CSV, RTM CSV, E2E scenarios, MiniTestPlan, TestSummary, ConflictLog, and TBDLog. | QA Engineers, SDETs, Test Leads, and Project Managers in CSAA IG NextGen and QA AI Ops | Needs confirmation; Shayne Vandersloot is likely candidate from intake report | TBD | QA Test Case Architect v2 Project Brain | TICKET_PACK_COMBINED.xml; QA Standard - Test Case Template For Rovo Agents; sanitized golden-copy XRAY CSV example; Jira story exports; SharePoint-hosted Confluence exports; architecture diagrams; API schemas | Read-only file/Jira/Confluence/image/schema retrieval; CSV/XML/TXT text generation only; no write actions enabled | Draft measurement plan created; baseline needs pilot ticket-pack data and validation-gate evidence | Draft only; Studio visibility and team assignment need confirmation before pilot | QA artifact data; users must avoid or confirm permitted handling for PII/PHI; XRAY import remains manual/Copilot-assisted until approved connector exists | 2026-06-11 | Confirm owner, backup owner, Ticket Pack Builder handoff, QA template source, remaining golden-copy examples, manual XRAY/Copilot flow, and evaluation evidence. |
| Performance Test Report Agent (Extension) | Extension | Draft | Needs Cleanup | Analyze performance test reports and metric deltas. | Performance, release, and engineering stakeholders | Adithya Varma Jaiswal | TBD | Performance Test Report Agent (Extension) Project Brain | Performance Test Report Agent Guide and related Project Brain pages | Search/get/create noted in blueprint; preview required before publishing | Measurement plan needed | Pilot audience needs confirmation | Performance data; confirm data/privacy notes | TBD | Complete backup owner, audience, readiness, measurement, and review date. |
| Jira Ticket Polisher | Governed agent | Archived / Superseded | Historical Reference | Historical record for the retired standalone ticket-polishing service area. Active ticket drafting, review, polish, standards alignment, gap checking, and comment drafting now belong to Jira Work Item Assistant. | Historical governance reviewers only | TBD | TBD | Jira Ticket Polisher Project Brain | Organization-Wide Jira Ticket Quality Standard, Team Jira Standards, MOBRM Team Jira Standards, selected Jira ticket context | No active Studio configuration; preserve draft-only historical guardrails; do not enable Jira update, transition, assign, rank, or comment actions | Historical draft measurement plan retained; use Jira Work Item Assistant measurement for active workflow | Do not present as a separate active user-facing agent; pages remain visible with superseded notice | Jira issue metadata and team workflow context; confirm source permissions and privacy notes only if reopening is approved | 2026-06-09 | Keep as archive/superseded reference and route active work to Jira Work Item Assistant Ticket Review / Polish workflow. |

## Duplicate And Legacy Notes

| Area | Evidence | Recommended Handling |
|---|---|---|
| Rovo Agent Inventory Home | One root/overview page and one unparented duplicate row appear in local inventory export. | Keep `Rovo Agent Inventory Home` as overview/root. Verify duplicate before any legacy note. |
| Release Health Analyst Project Brain | Three same-title rows appear in local inventory export. | Keep the parented page under the active Project Brain structure; compare unparented copies before any archive/banner action. |
| Release Health Analyst support pages | Duplicate blueprint, evaluation, knowledge source, and assessment template rows appear. | Treat parented pages as likely canonical; compare bodies before cleanup. |
| Performance Test Report Agent support pages | Duplicate subagent settings and change-log rows appear. | Treat pages under the Project Brain as likely canonical; compare bodies before cleanup. |
| Release Notes Manager legacy source | Old-space evidence lists Release Notes Manager as active/review-needed and useful for technical, business, and sync modes. | Keep the new Project Brain in review; do not promote until owner, source, Studio, and evaluation gaps are cleared. |
| Mobilitas Release Notes Agent | Old-space evidence calls this project-specific and domain-specific. | Keep as archive/reference only; do not use Mobilitas language as organization-wide default instructions. |
| Jira Ticket Polisher legacy source | Old-space evidence identified Jira Ticket Polisher as the best early pilot for org-wide ticket standards plus team overlays. Jira Work Item Assistant now covers the practical service area. | Keep the pages as archive/superseded reference and route active Jira issue-quality or ticket-polishing work to Jira Work Item Assistant. |

## Builder Reuse Checks

Before creating a new governed agent, check:

- Rovo Design Agent for agent intake/design support.
- Agent Doc Steward for governance documentation support.
- Release Health Analyst for release/change health workflows.
- Release Drift Monitor for mid-sprint release evidence drift detection before code freeze.
- Release Notes Manager for release-note drafting, audience rewriting, and source synchronization.
- QA Test Case Architect v2 for QA test case generation, AC coverage mapping, RTM drafting, and XRAY CSV preparation.
- Performance Test Report Agent (Extension) for performance report analysis.
- Jira Work Item Assistant before starting new Jira issue-quality, ticket-review, or ticket-polishing work.

## Duplicate Prevention Workflow

Before starting new-agent work, record a duplicate decision in the intake notes, Project Brain scaffold, or promotion packet.

| Field | Required content |
|---|---|
| Submitted idea | Plain-language request or pain point. |
| Target pain point | Workflow friction the agent would reduce. |
| Inventory matches reviewed | Existing agents, candidates, extensions, or Project Brains checked. |
| Similar-agent comparison | Overlap in audience, sources, workflow, tools, and expected output. |
| Decision | Reuse / Improve / Merge / Reject / New. |
| Rationale | Why the decision is safest and least duplicative. |
| Proposed owner | Accountable owner or owning team. |
| Backup owner | Backup owner, delegate, or gap/remediation owner. |
| Naming check | Whether the proposed name conflicts with an existing agent or page. |
| Next review date | ISO date for follow-up, pilot review, or remediation review. |

Use `New` only when reuse, improvement, merge, or rejection are not sufficient.

## Review Notes

- This draft is based on local export evidence and repo reports, not a live Studio write.
- Studio visibility and team assignment controls still need manual Studio/admin confirmation.
- Missing owner, backup owner, measurement, readiness, or last-reviewed fields should block promotion to broadly approved `Active` status.
