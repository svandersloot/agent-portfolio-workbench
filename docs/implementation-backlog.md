# ROVO Governance Implementation Backlog

This backlog translates the ROVO space audit into trackable work. It can be copied into Jira or used as a local planning artifact until Jira tracking exists.

## Feasibility And Value Review

Reviewed on 2026-05-21 against local reports, roadmap, and current Atlassian public evidence.

Decision rules:

- `Now`: supported by Confluence REST API, safe manual Studio/admin process, or repo-only reporting; improves governance without much ongoing upkeep.
- `Later`: useful but dependent on more evidence, adoption, or a clearer operating need.
- `Drop`: not worth carrying in the active backlog because it depends on unsupported Studio write-back, duplicates another control, or adds recurring maintenance without enough governance value.

Current API and platform evidence:

- Confluence Cloud REST API v2 supports page create, read, update, title update, and space page listing. Focused dry-run/apply page updates remain feasible when page IDs and versions are known.
- Atlassian documents a Confluence move API path and manual move behavior that preserves incoming links, so history-preserving moves/reparents are feasible after focused review.
- ROVO Studio public guidance supports manual/admin governance controls: admins can manage who can create in Studio, owners can add editors/managers, agents can be restricted to individually added users, and group/team-based agent access restriction is currently not supported.
- Forge `rovo:agent` supports app-defined Forge agents, and the Forge bridge `rovo` API can open Rovo conversations, but this is not a supported API for writing ROVO Studio-created agent configuration.
- ROVO agent skills can perform some Confluence/Jira actions on the user's behalf after confirmation, but they are not a replacement for deterministic governance automation or Studio configuration write-back.

## Decision Table

| ID | Decision | Rationale | Next Handling |
|---|---|---|---|
| 1.1 | Now | Canonical inventory update has already landed and duplicate cleanup is high governance value. | Continue only focused legacy/banner or move plans after page-body comparison. |
| 1.2 | Now | Manual Confluence move is supported and low maintenance. | Move CoP notes under Working Group Notes when a space admin can verify target parent. |
| 1.3 | Now | Manual Confluence move is supported and improves findability. | Move Formatting Standards under Governance and Safety after confirming page identity. |
| 1.4 | Later | Pattern child pages may help reuse, but the value is lower than inventory, duplicate cleanup, and reporting. | Revisit after builders actively use the Pattern Library. |
| 1.5 | Now | Completed with supported Confluence update flow. | Keep as done; refresh only when structure changes. |
| 1.6 | Later | Ongoing home-page refresh is useful but should follow real structure changes. | Do not create standalone work until another structure change lands. |
| 2.1 | Now | Template exists and supports front-door governance. | Keep as source material; publish/update only through focused dry-run. |
| 2.2 | Now | Completed and directly supports readiness governance. | Keep as done. |
| 2.3 | Now | Governance review template is high-value and safe as Confluence/template content. | Keep in active backlog if not already published or linked. |
| 2.4 | Later | ADR template exists, but ADR overhead should be reserved for material decisions. | Keep template available; do not prioritize publishing. |
| 2.5 | Later | Decision index is useful only once ADR volume exists. | Revisit after at least one material ADR is written. |
| 3.1 | Now | Governance and Safety exists and is the right container. | Continue only targeted child-page moves or creates. |
| 3.2 | Now | Known Risks and Limitations is governance-critical and safe as a Confluence page. | Publish/create after focused dry-run and approval. |
| 3.3 | Later | Context readiness checking is valuable, but Doc Health Gate implementation depends on current Doc Steward configuration. | Fold into the Doc Steward manual update/capture loop. |
| 3.4 | Later | Measurement checks are valuable, but should be implemented with Doc Steward changes, not as a separate drift point. | Fold into Doc Steward update/capture work. |
| 3.5 | Later | First ADRs are useful only when decisions need durable traceability. | Write ADRs opportunistically for real decisions; avoid template theater. |
| 3.6 | Now | Completed contract is central to inventory and reporting. | Keep as done and use for repeatable reports. |
| 4.1 | Now | Completed and published front-door flow reduces duplicate agent creation. | Keep as done; align Studio manually. |
| 4.2 | Now | Readiness pre-check is already in the intake flow. | Keep as done. |
| 4.3 | Now | Inventory dedup check is already in the intake flow. | Keep as done. |
| 4.4 | Later | Risk tier is already represented in contract/guidance, but every-output enforcement depends on captured Studio config. | Verify during manual Studio copy/capture before adding more process. |
| 4.5 | Later | Measurement checks improve governance, but should move with Doc Steward configuration evidence. | Bundle with Doc Steward manual Studio update/capture. |
| 4.6 | Drop | A percentage score can create false precision and maintenance burden; missing-field reporting is clearer. | Use field-level completeness reports instead of a score. |
| 4.7 | Later | Evaluation scenarios are useful after agent configs stabilize; maintaining broad scenario sets too early is costly. | Revisit after the Design Agent and Doc Steward captures are current. |
| 4.8 | Now | Manual Studio/admin confirmation is supported and resolves a key governance uncertainty. | Confirm creation, edit, and user-access controls manually; do not automate Studio writes. |
| 5.1 | Now | Completed page supports value tracking. | Keep as done. |
| 5.2 | Now | Per-agent success metrics are governance-critical and safe as Project Brain/inventory updates. | Backfill metrics through focused page updates. |
| 5.3 | Drop | Monthly snapshots already cover portfolio review at a lighter cadence and lower maintenance cost. | Do not create a separate quarterly template unless leadership requests it. |
| 5.4 | Now | Publish history is low-cost audit evidence and already started. | Standardize records for every API-assisted apply. |
| 5.5 | Now | Completeness report directly supports governance and can remain repo-only/read-only. | Make it repeatable from inventory, publish history, and normalized captures. |
| 5.6 | Now | Duplicate discovery prevents sprawl and supports safe cleanup. | Compare duplicate groups one at a time before any banner/archive/move. |
| 5.7 | Now | Monthly snapshot is already useful and lower burden than quarterly reviews. | Make future snapshots repeatable from source evidence. |
| 6.1 | Now | User guide is published and supports builder behavior. | Keep as done; update only through focused dry-run. |
| 6.2 | Now | Admin and owner guide clarifies ownership, review cadence, and retirement. | Publish/create after Known Risks or as a focused governance page. |
| 6.3 | Drop | This local backlog already functions as the roadmap; publishing another backlog page risks duplicate planning surfaces. | Keep backlog/roadmap in repo unless there is a clear Confluence audience. |
| 6.4 | Later | Pilot is valuable, but only after Studio manual config and visibility controls are confirmed. | Schedule after capture verifies current Design Agent behavior. |
| 6.5 | Later | Retrospective depends on a real pilot. | Revisit after 6.4. |
| 7.1 | Now | The operating model needs a clear front door for the small builder group, separate from the normal ROVO user experience. | Create a repo-backed Stage 5 start-here page for the ROVO agent factory/control-plane model. |
| 7.2 | Now | Stage 5 depends on a repeatable path from pain point to approved agent, not only standalone governance pages. | Document the agent lifecycle and promotion stages with entry criteria, evidence, approvers, and allowed audience. |
| 7.3 | Now | Pilot users need clear boundaries without reading the whole repo. | Create an approved/prohibited/escalate catalog for the initial team pilot. |
| 7.4 | Now | Duplicate prevention is a primary value of the control plane and must be operational before team promotion. | Add a practical duplicate-check workflow and required comparison fields to the inventory guidance. |
| 7.5 | Now | A Stage 5 pilot needs evidence that agents reduce pain points, not just evidence that docs exist. | Create a lightweight pilot metrics and feedback tracker for ROVO agent usage. |
| 7.6 | Now | One or two helpers can accelerate the project if their safe contribution boundary is explicit. | Create contributor/helper guidance for Codex-assisted spec, template, test, and promotion-packet work. |
| 7.7 | Later | Claude Code migration should be tracked, but it should not distract from proving the Stage 5 operating model with one team. | Add a separate future migration lane after the pilot control-plane artifacts are stable. |
| 8.1 | Now | The repo is strong but hard to enter cold; a small start-here guide reduces live handoff burden. | Create a repo start-here guide for builders and maintainers. |
| 8.2 | Now | Project Brain page families, setup pages, runtime pages, and manifest entries are now numerous enough to drift. | Add a page-family and source-link consistency check before publishing or committing. |
| 8.3 | Now | Owner, backup owner, status, and last-reviewed gaps block transferability and pilot promotion. | Add a lightweight owner/readiness gap report over Project Brain and setup pages. |
| 8.4 | Now | Publish history is valuable but still too manual. | Generate local publish-history records from Confluence publisher output after approved applies. |
| 8.5 | Now | Regression prompts are high-value but scattered across evaluations, reports, and handoffs. | Generate or maintain small regression prompt packs per governed agent. |
| 8.6 | Now | Handoff packets can age quickly when live page versions or source pages change. | Add stale-handoff detection based on dates, referenced files, and known live versions. |
| 8.7 | Now | Local ignore rules are good, but work-backed migration needs a second guardrail. | Add a no-secret/private-data scan for tracked and candidate commit files. |
| 8.8 | Later | Claude Code/work-backed migration is important after the operating model is stable. | Track migration readiness checks separately from the first automation slice. |

Dropped boundary:

- Do not build Studio write-back. Keep ROVO Studio configuration manual until Atlassian exposes a stable supported API for Studio-created agent configuration.

## Milestone 1: Space Cleanup

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 1.1 | Merge Agent Inventory pages | P0 | None | Space admin + Michael Holian | Dry-run plan exists at `docs/reports/inventory-cleanup-dry-run.md`. Next: approve focused Confluence updates to add harvested fields to `Agent Inventory` and clarify `Rovo Agent Inventory Home` as overview/root without copy/recreate. |
| 1.2 | Move CoP 5/15/26 under Working Group Notes | P1 | None | Space admin | CoP page is a child of Working Group Notes. |
| 1.3 | Move Confluence Formatting Standards under Governance and Safety | P1 | None | Space admin | Governance and Safety parent exists. Formatting Standards is a child page. |
| 1.4 | Promote Pattern Library patterns to child pages | P2 | None | Working group lead | Each core pattern is individually linkable. Parent page is an index. |
| 1.5 | Update Space Structure and Navigation | P1 | 1.1-1.4 | Space admin | Done: page `5281218620` updated from version 1 to version 2 using `docs/confluence-pages/space-structure-and-navigation.md`. |
| 1.6 | Update Agent Governance Home | P1 | 1.1-1.5 | Space admin | Done: `Governance and Safety` is linked from the recommended structure list. Continue refreshing this page as later structure changes land. |

## Milestone 2: Template Creation

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 2.1 | Create Agent Design Record Template | P0 | None | Working group lead | Template exists under Templates and includes sections from `templates/confluence/agent-design-record-template.md`; status and fit decision options now match Agent Fit Intake. |
| 2.2 | Create Context Readiness Checklist | P0 | None | Working group lead | Done: page-ready draft exists at `docs/confluence-pages/context-readiness-checklist.md`; Confluence page created under `Governance and Safety`. |
| 2.3 | Create Agent Governance Review Template | P1 | None | Working group lead | Template exists under Templates with human-facing checklist and required completeness fields. |
| 2.4 | Create Agent ADR Template | P1 | None | Working group lead | Template exists under Templates. |
| 2.5 | Create Decision Log index page | P1 | 2.4 | Working group lead | Page exists with ADR naming convention. |

## Milestone 3: Governance Model

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 3.1 | Create Governance and Safety section | P0 | 1.3 | Working group lead | Done: parent page exists under Agent Governance Home. Remaining children to move or create include Governance Review Checklist, Known Risks and Limitations, and Formatting Standards. |
| 3.2 | Create Known Risks and Limitations page | P1 | None | Working group lead | Page includes platform limitations, organizational risks, mitigations, and workarounds. |
| 3.3 | Add Context Readiness Assessment to Doc Health Gate | P1 | 2.2 | Meta-agent owner | Doc Health Gate includes context readiness as a P1 audit check. |
| 3.4 | Add measurement plan check to Doc Health Gate | P1 | 5.1 | Meta-agent owner | Doc Health Gate includes measurement plan as a P1 check. |
| 3.5 | Create first three ADRs | P2 | 2.4, 2.5 | Working group lead | ADRs exist for Project Brain pattern, fit triage framework, and meta-agent collaboration model. |
| 3.6 | Define governance completeness contract | P0 | 4.1 | Working group lead | Done locally: `docs/agent-governance-completeness-contract.md` and `schemas/agent-governance-record.schema.json` define required owner, backup owner, status, purpose, audience, knowledge sources, tools or skills, measurement plan, readiness status, Project Brain link, and last-reviewed date. |

## Milestone 4: Meta-Agent Enhancement

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 4.1 | Add Agent Fit Intake to Design Agent flow | P0 | None | Meta-agent owner | Done locally: `docs/confluence-pages/agent-fit-intake.md` defines the Design Agent intake sequence and routing rules for prompt, automation, existing-agent extension, Confluence template, agent candidate, new governed agent, or not ready. Confluence update still requires focused dry-run and approval before apply. |
| 4.2 | Add context readiness pre-check to Design Agent | P1 | 2.2 | Meta-agent owner | Done locally: intake flow requires readiness status before a new governed agent recommendation; critical gaps route to `Not ready`. |
| 4.3 | Add inventory dedup check to Design Agent | P1 | 1.1 | Meta-agent owner | Done locally: intake flow requires `Agent Inventory` and related Project Brain checks before recommending `New governed agent`. |
| 4.4 | Add risk tier classification to Design Agent output | P2 | None | Meta-agent owner | Risk tier appears in every design packet. |
| 4.5 | Update Doc Steward to check measurement plans | P1 | None | Meta-agent owner | Missing measurement plan is flagged as P1. |
| 4.6 | Update Doc Steward to generate completeness score | P2 | None | Meta-agent owner | Doc Health Gate output includes completeness percentage. |
| 4.7 | Update Evaluation Library with new scenarios | P2 | 4.1-4.5 | Meta-agent owner | At least three new test cases per meta-agent cover new capabilities. |
| 4.8 | Investigate Studio visibility and team assignment | P1 | None | Atlassian admin + space admin | Local read-only investigation exists at `docs/reports/studio-visibility-team-assignment-investigation.md`. Next: manually confirm Studio/admin controls because local exports do not expose team assignment or discoverability fields. |

## Milestone 5: Measurement And Reporting

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 5.1 | Create Measurement and Value Tracking page | P0 | None | Working group lead | Done: page-ready draft exists at `docs/confluence-pages/measurement-and-value-tracking.md`; Confluence page created under `Governance and Safety`. |
| 5.2 | Add success metrics to Release Health Analyst Project Brain | P1 | 5.1 | Agent owner | Release Health Analyst includes baseline and target metrics. |
| 5.3 | Create quarterly review template | P2 | 5.1 | Working group lead | Template exists for portfolio review. |
| 5.4 | Add publish-history records | P1 | 5.1 | Space admin | Started: `docs/publish-history/2026-05-21-agent-fit-intake.md` records page ID, old version, new version, source file, command, timestamp, and verification result. Next: automate or standardize this for every API-assisted apply. |
| 5.5 | Create governance completeness report | P1 | 1.1, 5.4 | Space admin | First read-only dry-run exists at `docs/reports/governance-completeness-dry-run.md`. Next: make it repeatable after inventory cleanup and normalized Studio captures are current. |
| 5.6 | Create duplicate-agent discovery report | P1 | 1.1 | Working group lead | First read-only dry-run exists at `docs/reports/duplicate-agent-discovery-dry-run.md`. Next: compare duplicate page bodies one page group at a time before any legacy-banner or archive action. |
| 5.7 | Create monthly governance snapshot | P1 | 5.5, 5.6 | Space admin | First snapshot exists at `docs/reports/monthly-governance-snapshot-2026-05.md`; reusable template exists at `templates/confluence/monthly-governance-snapshot-template.md`. Next: generate future snapshots from inventory, completeness, publish history, and intake data. |

## Milestone 6: Pilot And Feedback Loop

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 6.1 | Create User Guide - Designing Agents | P1 | 1.5, 2.1 | Working group lead | Done: page-ready draft exists at `docs/confluence-pages/user-guide-designing-agents.md`; Confluence page created under `Governance and Safety`. |
| 6.2 | Create Admin and Owner Guide | P2 | None | Space admin | Page exists with admin responsibilities, label management, review cadence, and retirement process. |
| 6.3 | Create Backlog and Improvement Roadmap | P1 | None | Working group lead | All open CoP action items are migrated. |
| 6.4 | Run pilot with one new builder | P1 | 6.1 | Working group lead | Builder completes process and at least three improvements are identified. |
| 6.5 | Conduct post-pilot retrospective | P2 | 6.4 | Working group lead | Retrospective notes and template updates are documented. |

## Milestone 7: Stage 5 Agent Factory Pilot Readiness

This milestone reframes the governance project as a behind-the-scenes ROVO agent factory and governance control plane. The first target is one initial team pilot, not org-wide rollout.

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 7.1 | Create Stage 5 agent factory start-here page | P0 | 6.1 | Governance steward | Page explains that normal users consume approved ROVO agents in Jira/Confluence, while builders use the repo as the source of truth for specs, tests, approvals, metrics, and retirement decisions. |
| 7.2 | Document audience separation | P0 | 7.1 | Governance steward | Audiences are defined for governance builders, agent owners, pilot users, reviewers/managers, and security/legal/compliance stakeholders; each audience lists what they use, what they should not need, decisions owned, and required artifacts. |
| 7.3 | Document agent lifecycle and promotion stages | P0 | 7.1 | Governance steward + agent owners | Lifecycle covers pain point, intake, duplicate check, spec, context review, prototype, dry-run, human review, pilot approval, team promotion, metrics, improvement, deprecation, and retirement. Promotion stages define entry criteria, approver, evidence, allowed audience, ROVO/Studio use, and expansion review. |
| 7.4 | Create approved/prohibited/escalate catalog for the pilot | P0 | 7.3 | Governance steward + reviewer/manager | Catalog names approved pilot workflows, prohibited autonomous writes/decisions, and escalation triggers for manager, security, legal, or compliance review. |
| 7.5 | Strengthen duplicate-prevention workflow | P1 | 7.3, 1.1 | Working group lead | Agent Inventory guidance requires idea intake, inventory search, similar-agent comparison, reuse/improve/merge/reject/new decision, naming convention, owner, backup owner, and review date. |
| 7.6 | Define pilot metrics and feedback loop | P1 | 5.1, 7.4 | Pilot lead + agent owners | Tracker captures usage, pain point addressed, time saved estimate, output accepted/edited/rejected, review issues, unsafe outputs, feedback, and improvement decision. |
| 7.7 | Create contributor/helper guide | P1 | 7.1 | Governance steward | Guide explains what helpers can draft with Codex, what requires approval, how to update specs/templates/tests, and how to prepare ROVO/Studio promotion packets without changing live systems. |
| 7.8 | Build first pilot promotion packet | P1 | 7.3, 7.4, 7.6 | Agent owner + helper | Packet identifies 1-2 initial ROVO agents, target pilot audience, approved workflows, review gates, test evidence, metrics plan, feedback channel, and go/no-go criteria. |
| 7.9 | Run Stage 5 pilot readiness review | P1 | 7.1-7.8 | Governance steward + reviewer/manager | Review confirms the pilot can start without live explanation from the maintainer and that ROVO users do not need the repo to use approved agents safely. |
| 7.10 | Track future Claude Code migration lane | P2 | 7.9 | Governance steward | Separate backlog lane exists for eventual Claude Code migration scope, dependencies, risks, and decision gate; it does not block the initial Stage 5 pilot. |

## Milestone 8: Maintainability, Auditability, And Migration Readiness

This milestone turns the governance workflow assessment into implementable slices. The aim is to make the repo easier to maintain, audit, automate, transfer to another teammate, and eventually migrate into a work-backed Claude Code or repo environment without weakening the current manual approval boundaries.

Keep these boundaries:

- Do not publish to Confluence without a focused dry-run and explicit approval.
- Do not write to Jira.
- Do not write to ROVO Studio.
- Do not add Studio write-back.
- Keep private config, raw captures, HARs, cookies, headers, tokens, and unsanitized exports out of Git.

| ID | Summary | Priority | Dependencies | Suggested Owner | Acceptance Criteria |
|---|---|---|---|---|---|
| 8.1 | Create repo start-here guide | P0 | None | Governance steward | `START-HERE.md` or equivalent tells a teammate where to begin for new agent intake, existing agent update, Confluence publishing, Studio setup, regression testing, handoff creation, and safe commit slices. |
| 8.2 | Add page-family and source-link consistency check | P0 | Existing Confluence page family pattern | Governance steward | Check identifies missing Project Brain linked artifacts, missing manifest entries, missing setup/runtime/knowledge/evaluation links, duplicate source links, and forbidden-substitute gaps before publish or commit. |
| 8.3 | Add owner/readiness gap report | P0 | Completeness contract | Governance steward + agent owners | Report lists governed agents with missing primary owner, backup owner, status, readiness, measurement, Project Brain link, or last-reviewed date; output remains field-level and does not use percentage scoring. |
| 8.4 | Standardize publish-history generation | P1 | Confluence publisher output | Space admin | After an approved apply, maintainer can create a safe local record with page ID, title, old version, new version, source file, command, timestamp, and verification result without tokens or private config. |
| 8.5 | Create regression prompt pack workflow | P1 | Evaluation pages and live regression packets | Agent owners | Each pilot agent has a small prompt pack with source verification, fallback trap, unsafe write, and 2-3 behavior regressions plus pass/partial/fail criteria. |
| 8.6 | Add stale handoff detection | P1 | Handoff packets and source pages | Governance steward | Report flags handoffs whose referenced files, live versions, or reviewed dates are older than current repo evidence and recommends update, supersede, or keep. |
| 8.7 | Add no-secret/private-data scan | P1 | `.gitignore` and safe fixture rules | Governance steward | Scan flags tokens, cookies, auth headers, raw exports, private config, suspicious page manifests, and unsanitized local-private material before commit. |
| 8.8 | Refresh merge-readiness report before commits | P1 | Current git state | Governance steward | Commit-slice plan is regenerated from current `git status` and does not rely on stale branch or HEAD evidence. |
| 8.9 | Track Claude Code/work-backed repo readiness | P2 | Stage 5 readiness review | Governance steward | Repo has a checklist for branch strategy, PR review, CI checks, secrets handling, publish workflow, evidence capture, and stakeholder communication before migration. |
| 8.10 | Align completeness contract wording with field-level reporting | P2 | Completeness contract and backlog decision table | Governance steward | Contract and report templates no longer recommend percentage completeness where field-level missing-data reporting is the chosen policy. |
