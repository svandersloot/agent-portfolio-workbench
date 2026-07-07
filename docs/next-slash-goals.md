# Next Slash Goals

These goals are executable from the current local repo state. Confluence writes should still be dry-run-first.

## 1. Completed: Apply Space Structure Update

```text
/goal Review and apply the Space Structure and Navigation update from docs/confluence-pages/space-structure-and-navigation.md to Confluence page 5281218620. Run scripts/Publish-ConfluencePages.ps1 -Slug space-structure-and-navigation -UpdateExisting first and confirm the dry-run shows currentVersion 1 and plannedVersion 2. Apply only after confirmation with -Apply, then verify the live page contains Governance and Safety and its child pages.
```

Applied result:

- Page: `Space Structure and Navigation`
- Page ID: `5281218620`
- Previous version: `1`
- Current version: `2`
- Source: `docs/confluence-pages/space-structure-and-navigation.md`
- Apply command: `.\scripts\Publish-ConfluencePages.ps1 -Slug space-structure-and-navigation -UpdateExisting -Apply`
- Verified body includes `Governance and Safety`, `Measurement and Value Tracking`, `Context Readiness Checklist`, and `User Guide - Designing Agents`.

## 2. Use Generic Publisher Update-Mode

```text
/goal Use the generic Confluence publisher update-mode for future markdown-backed page updates. Keep config/confluence-pages.yml as the local source of page IDs, keep config/confluence-pages.example.yml tracked with null IDs, require dry-run before -Apply, and use -Slug for targeted existing-page updates.
```

Acceptance checks:

- Default dry-run reports existing pages as `exists`.
- `-UpdateExisting` reports `currentVersion` and `plannedVersion`.
- `-Slug <slug> -UpdateExisting` limits the plan to one intended page.
- `.env` and `config/confluence-pages.yml` remain ignored.

## 3. Started: Add Publish History Records

```text
/goal Add local publish-history records for Confluence page updates. For every API-assisted apply, record page ID, page title, old version, new version, source file, command, timestamp, and verification result under docs/publish-history/. Keep dry-run-first behavior and do not include tokens or private config values.
```

Acceptance checks:

- A publish-history file is created for the Agent Fit Intake page publish.
- Future apply runs can produce a similar record.
- The record is safe to commit.

## 4. Inventory Cleanup Dry-Run

```text
/goal Produce an inventory cleanup plan with no Confluence writes. Treat Agent Inventory as the likely canonical inventory page unless new evidence contradicts it, treat Rovo Agent Inventory Home as the space overview/root, compare references to both, and recommend history-preserving link updates, page moves, or legacy/banner steps without copy/recreate.
```

Read-only evidence so far:

- `Rovo Agent Inventory Home` (`5298651544`) is the space overview/root and parent of `Agent Governance Home`.
- `Agent Inventory` (`5280334048`) is a child of `Agent Governance Home`.
- `Agent Inventory` body says it is the canonical inventory of governed ROVO agents and candidate agents.
- Text references exist to both titles; page-ID text references were not found.

Recommended no-write plan:

1. Keep `Agent Inventory` as the canonical inventory page.
2. Keep `Rovo Agent Inventory Home` as the space overview/root rather than trying to merge it into inventory.
3. Update pages that refer to old inventory wording so links and labels point users to `Agent Inventory`.
4. Avoid copy/recreate. If any pages must move, use move/reparent operations so history is preserved.

## 5. Completed Locally: Define Agent Governance Completeness Contract

```text
/goal Define the first structured agent governance completeness contract. Capture the non-negotiable fields for every governed ROVO agent, choose a local structured format for future inventory records, and create a dry-run report shape that identifies missing owner, backup owner, status, purpose, audience, knowledge sources, tools or skills, measurement plan, readiness status, Project Brain link, and last-reviewed date.
```

Acceptance checks:

- Contract is explicit and easy for builders to understand.
- The model supports leadership reporting and builder reuse.
- The first version does not require every existing page to be migrated at once.

Completed local artifacts:

- `docs/agent-governance-completeness-contract.md`
- `schemas/agent-governance-record.schema.json`
- `docs/confluence-pages/agent-fit-intake.md`

## 6. Completed: Publish Agent Fit Intake And Status Policy

```text
/goal Finalize and publish the Agent Fit Intake and lifecycle status policy for ROVO agents. Review docs/confluence-pages/agent-fit-intake.md, confirm the Design Agent can recommend prompt, automation, existing-agent extension, Confluence template, agent candidate, new governed agent, or not ready, and publish it under Governance and Safety after a dry-run.
```

Applied result:

- Page: `Agent Fit Intake`
- Page ID: `5301174273`
- Parent: `Governance and Safety`
- Parent page ID: `5297995845`
- Version: `1`
- Source: `docs/confluence-pages/agent-fit-intake.md`
- Publish history: `docs/publish-history/2026-05-21-agent-fit-intake.md`

Acceptance checks:

- Intake supports chat-driven requests and Design Agent-guided scaffolding.
- Intake routes ideas to prompt, automation, existing-agent extension, new governed agent, agent candidate, or not ready.
- Status definitions are clear enough for builders and leadership reporting.
- Active/Ready approval is limited to the space maintainer and Atlassian admins.
- Experimental agents are intended for a select audience while Studio visibility controls are investigated.

## 7. Completed Locally: Update Design Agent Intake Flow

```text
/goal Update the ROVO Design Agent guidance so new agent ideas start with Agent Fit Intake. The Design Agent should route ideas to prompt, automation, existing-agent extension, Confluence template, agent candidate, new governed agent, or not ready; require the minimum Project Brain scaffolding fields before recommending build; and check inventory for duplicates before recommending a new governed agent.
```

Acceptance checks:

- Design Agent uses `Agent Fit Intake` as the front door.
- Design Agent can explicitly recommend not building an agent.
- Design Agent requires owner, backup owner or needed note, status, knowledge sources, tools/actions, measurement idea, and readiness risks before scaffolding a Project Brain.
- Design Agent checks for existing agents or pages before recommending `New governed agent`.

Completed local artifacts:

- `docs/confluence-pages/agent-fit-intake.md`
- `templates/confluence/agent-design-record-template.md`
- `templates/confluence/agent-governance-review-template.md`

Confluence status:

- Not applied in this goal.
- Run `.\scripts\Publish-ConfluencePages.ps1 -Slug agent-fit-intake -UpdateExisting` and confirm it shows exactly one intended page before requesting approval to apply.

## 8. Started Locally: Investigate Studio Visibility Controls

```text
/goal Investigate ROVO Studio team assignment and discoverability controls for Draft, In Review, and Experimental agents. Determine whether experimental agents can be limited to a select audience, document who can change visibility, and update the governance policy with recommended controls.
```

Acceptance checks:

- Documents what Studio can and cannot restrict today.
- Defines a practical control for Experimental agents.
- Confirms Active/Ready approval remains limited to the space maintainer and Atlassian admins.

Completed local artifact:

- `docs/studio-visibility-team-assignment-investigation-checklist.md`

Next action:

- Execute the checklist read-only against relevant Studio views. Do not save or change Studio assignment/visibility.

## 9. Completed Locally: Design Monthly Governance Snapshot

```text
/goal Design the monthly ROVO agent governance snapshot. Define the sections, data inputs, and report format for leadership and interested builders, including what changed, what exists, what is ready, what is experimental, what is missing required governance fields, and what duplicate or reuse opportunities were found.
```

Acceptance checks:

- Report is human-facing and concise.
- Report can eventually be generated from inventory, publish history, and governance completeness checks.
- Report helps people find existing agents before creating duplicate work.

Completed local artifact:

- `templates/confluence/monthly-governance-snapshot-template.md`

## 10. Completed: Apply Governance Front Door Updates

```text
/goal Review the local Agent Fit Intake update, then run .\scripts\Publish-ConfluencePages.ps1 -Slug agent-fit-intake -UpdateExisting as a dry-run. Apply only after confirming the plan shows exactly one intended page: Agent Fit Intake, page ID 5301174273, currentVersion 1, plannedVersion 2. Do not change Studio.
```

Applied result:

- `Agent Fit Intake` updated from version `1` to `2`.
- `Governance and Safety` updated from version `1` to `2`.
- `Measurement and Value Tracking` updated from version `1` to `2`.
- `User Guide - Designing Agents` updated from version `1` to `2`.
- Publish history: `docs/publish-history/2026-05-21-governance-front-door-updates.md`.
- No Studio changes were made; Studio configuration remains a manual copy step.

Acceptance checks:

- Dry-runs targeted exactly one intended page per command.
- Applies were run after approval.
- Post-apply dry-runs confirmed all four pages at `currentVersion: 2`.
- Publish history records old version, new version, source file, command, timestamp, and verification result.

## 11. Completed Locally: Governance Reporting Slice

```text
/goal Execute the next governance backlog slice excluding manual Studio edits. Work dry-run-first and do not write to Studio. First, complete the Agent Inventory cleanup dry-run: treat Agent Inventory as canonical unless evidence contradicts it, treat Rovo Agent Inventory Home as the overview/root, compare references to both, and recommend history-preserving link updates, moves, or legacy/banner steps without copy/recreate. Then run the read-only Studio visibility/team-assignment investigation using the local checklist and document what can and cannot be restricted for Draft, In Review, and Experimental agents. Next, implement local read-only reporting artifacts for the first governance completeness report, duplicate-agent discovery report, and monthly governance snapshot using the existing completeness contract, inventory evidence, publish history, and current repo docs. Update docs/implementation-backlog.md, docs/next-slash-goals.md, docs/roadmap.md, and any needed templates or docs. Do not publish Confluence changes unless a focused dry-run shows exactly one intended page and I approve the apply step. Keep .env and config/confluence-pages.yml out of Git. End by validating JSON/Markdown where applicable and committing safe local changes.
```

Completed local artifacts:

- `docs/reports/inventory-cleanup-dry-run.md`
- `docs/reports/studio-visibility-team-assignment-investigation.md`
- `docs/reports/governance-completeness-dry-run.md`
- `docs/reports/duplicate-agent-discovery-dry-run.md`
- `docs/reports/monthly-governance-snapshot-2026-05.md`

Acceptance checks:

- No Studio writes were performed.
- No Confluence writes were performed.
- Inventory cleanup remains a dry-run plan with history-preserving recommendations.
- Studio visibility report clearly states that local exports do not prove team assignment/discoverability controls and require manual Studio/admin confirmation.
- Completeness, duplicate-agent, and monthly snapshot reports use the existing contract and local evidence.

## 12. Next: Inventory Cleanup Apply Plan

```text
/goal Prepare focused Confluence update plans from docs/reports/inventory-cleanup-dry-run.md. First, update only the local source draft needed for Agent Inventory to add the completeness contract fields and harvested inventory-home field concepts. Then run a dry-run that targets exactly Agent Inventory. Do not apply until I approve. Do not copy/recreate pages, and do not write to Studio.
```

Acceptance checks:

- Plan preserves `Agent Inventory` as canonical and `Rovo Agent Inventory Home` as overview/root.
- Any proposed Confluence write targets exactly one intended page.
- Legacy/banner actions for duplicate pages remain separate per-page dry-runs.

Status:

- Local draft created at `docs/confluence-pages/agent-inventory.md`.
- Manifest example updated with `agent-inventory`.
- Local ignored manifest can dry-run against page `5280334048`.
- Dry-run confirmed `pageCount: 1`, `action: update`, `currentVersion: 1`, and `plannedVersion: 2`.
- No apply has been run.

## 13. Completed: Review And Apply Agent Inventory Update

```text
/goal Review docs/confluence-pages/agent-inventory.md and the dry-run evidence in docs/reports/inventory-cleanup-dry-run.md. If approved, run .\scripts\Publish-ConfluencePages.ps1 -Slug agent-inventory -UpdateExisting -Apply, then verify a post-apply dry-run reports currentVersion 2 and plannedVersion 3. Do not update Rovo Agent Inventory Home or duplicate pages in the same operation. Do not write to Studio.
```

Acceptance checks:

- Apply targeted exactly `Agent Inventory`, page ID `5280334048`.
- No duplicate/stale pages were changed.
- Publish history records the update.
- `config/confluence-pages.yml` remains ignored and out of Git.

Applied result:

- `Agent Inventory` updated from version `1` to `2`.
- Post-apply dry-run confirmed `currentVersion: 2` and `plannedVersion: 3`.

## 14. Completed Locally: Codex-To-Rovo Agent Build Pipeline Pattern

```text
/goal Document Codex and this repo as the technical-builder workbench for shaping governed ROVO agents faster, while keeping ROVO Studio as the Atlassian-facing runtime configured manually. Keep this pattern in repo-only operating documents, and do not add Studio write-back.
```

Acceptance checks:

- Operating model names Codex as the builder workbench and ROVO Studio as the runtime.
- Repo README and operating model explain the technical builder pattern.
- Studio writes remain manual only.
- Confluence-facing user guide does not document this internal Codex pipeline.

Result:

- Pattern kept in repo-only docs.
- `User Guide - Designing Agents` was corrected to remove the accidentally published Codex pipeline and is now version `5`.
- Publish history: `docs/publish-history/2026-05-21-codex-rovo-pattern-and-inventory.md`.

## 15. Ready: Manual Studio Configuration And Capture

```text
/goal Prepare the manual ROVO Studio copy packet for the Design Agent from the published Agent Fit Intake, User Guide, and Agent Inventory changes. Do not write to Studio. Produce clear parent instructions, scenario/routing guidance, conversation starter suggestions, knowledge source checklist, and a post-copy capture checklist so the Studio configuration can be manually updated and then captured back into this repo.
```

Acceptance checks:

- Copy packet separates instructions, routing, starters, knowledge sources, and verification checklist.
- No Studio write is attempted.
- Packet references the published Confluence pages as the source of truth.
- Post-copy capture path uses the existing read-only Studio capture workflow.

Prepared packet:

- `docs/handoffs/design-agent-studio-copy-handoff.md`

## 16. Next: Execute Design Agent Studio Update And Capture

```text
/goal Execute the Design Agent manual Studio update and capture loop from docs/handoffs/design-agent-studio-copy-handoff.md. First, inspect the handoff packet, README.md, docs/operator-guide.md, docs/confluence-pages/agent-fit-intake.md, docs/confluence-pages/agent-inventory.md, and current git status. Do not write to Studio directly from Codex. If I have not manually applied the Studio update yet, guide me through copying the parent instructions, scenario/routing guidance, conversation starters, knowledge source checklist, and tool/skill safety stance into ROVO Studio. If I have already applied it, start with capture and verification. After the manual save, capture the Studio response, normalize it, compare the normalized config against the handoff packet, update safe repo docs/reports if needed, keep .env, config/confluence-pages.yml, data/raw, HARs, cookies, headers, and tokens out of Git, then commit safe local changes.
```

Acceptance checks:

- Confirms whether Studio already matches the packet before recommending another manual edit.
- Does not attempt an automated Studio write.
- Captures and normalizes the saved Studio configuration.
- Verifies parent instructions, routing, starters, knowledge sources, and tools/skills.
- Updates inventory/completeness docs only from proven captured evidence.
- Commits safe local artifacts only.

## 17. Completed: Publish Design Agent Studio Configuration Source

```text
/goal Publish the latest Rovo Design Agent vNext Studio Configuration source to the existing Confluence page `Rovo Design Agent vNext - Rovo Studio Configuration` (page ID `5281349770`). Use docs/confluence-pages/rovo-design-agent-vnext-rovo-studio-configuration.md and slug rovo-design-agent-vnext-rovo-studio-configuration. First run .\scripts\Publish-ConfluencePages.ps1 -Slug rovo-design-agent-vnext-rovo-studio-configuration -UpdateExisting and confirm it shows exactly one intended page, page ID 5281349770. Apply only after approval. Do not write to Studio.
```

Acceptance checks:

- Dry-run targeted exactly `Rovo Design Agent vNext - Rovo Studio Configuration`, page ID `5281349770`.
- Published content replaces app/Forge routing with agent candidate routing.
- Published content preserves the parent and five-subagent Studio configuration structure.
- Parent conversation starters are 85 characters or fewer.
- Subagent triggers, subagent instructions, knowledge sources, and skills remain copy-paste code blocks.
- Only subagents have triggers; only the parent agent has conversation starters.
- Post-copy capture workflow remains repo-only and is not published into this Confluence page.
- Published content keeps Codex/repo-only pipeline language out of Confluence.
- Studio update remains manual after the page publish.

Applied result:

- `Rovo Design Agent vNext - Rovo Studio Configuration` updated from version `1` to `2`.
- Post-apply dry-run confirmed `currentVersion: 2` and `plannedVersion: 3`.
- Publish history: `docs/publish-history/2026-05-21-design-agent-studio-configuration.md`.

## 18. Next: Manual Studio Copy And Capture

```text
/goal Use the published Rovo Design Agent vNext - Rovo Studio Configuration page as the source for the manual ROVO Studio update. Do not write to Studio from Codex. Guide me through manually copying the parent fields, parent conversation starters, and subagent trigger/instruction/knowledge/skill blocks into ROVO Studio. After I save Studio manually, capture the current Studio configuration, normalize it, compare it against the published page and docs/handoffs/design-agent-studio-copy-handoff.md, update safe repo docs/reports from proven captured evidence, keep .env, config/confluence-pages.yml, data/raw, HARs, cookies, headers, and tokens out of Git, then commit safe local changes.
```

Acceptance checks:

- Uses Confluence page `5281349770` as the manual Studio source.
- Does not attempt an automated Studio write.
- Verifies parent starters are under 85 characters.
- Verifies triggers exist only on subagents.
- Captures and normalizes Studio configuration after the manual save.
- Commits safe normalized artifacts and docs only.

## 19. Completed Locally: ROVO Governance Backlog Feasibility Review

```text
/goal Evaluate the remaining ROVO governance backlog for feasibility and value. Do not write to Studio or Confluence. Review docs/next-slash-goals.md, docs/implementation-backlog.md, docs/roadmap.md, docs/reports, and current Atlassian public API evidence. Classify each backlog item as Now / Later / Drop based on whether it is achievable with supported APIs or safe manual process, whether it improves governance, and whether it creates maintenance burden. Produce a decision table, update the backlog and next slash goals, and commit safe repo-only changes.
```

Decision source:

- `docs/implementation-backlog.md` now includes the Now / Later / Drop decision table.

API/platform conclusion:

- Supported now: Confluence REST page updates, page reads, page creation, focused page moves/reparents, repo-only reports, and manual ROVO Studio/admin governance checks.
- Manual only: ROVO Studio-created agent configuration and Studio visibility/user-access changes.
- Dropped from active backlog: Studio write-back, percentage-based Doc Steward completeness scoring, the standalone quarterly review template, and a duplicate Confluence backlog/roadmap page.

## 20. Next: Confirm Studio Governance Controls Manually

```text
/goal Confirm ROVO Studio governance controls manually without saving changes. Use docs/studio-visibility-team-assignment-investigation-checklist.md and current Atlassian public guidance to inspect who can create agents, who can edit/manage the Design Agent, whether Open to all users can be disabled, whether specific users can be added, and whether group/team-based user access restriction is unavailable. Do not write to Studio. Capture only safe notes in docs/reports/studio-visibility-team-assignment-investigation.md, then update backlog status if evidence changes.
```

Acceptance checks:

- Confirms creation controls, edit/manager controls, and user access controls from Studio/admin UI.
- Does not change Studio settings or agent permissions.
- States whether Experimental agents can be limited to individual pilot users, groups/teams, or only manual promotion controls.
- Keeps raw captures, headers, cookies, and tokens out of Git.

## 21. Completed Locally: Make Governance Reports Repeatable

```text
/goal Make the repo-only governance reports repeatable without Confluence or Studio writes. Use the Agent Inventory, publish history, completeness contract, normalized Studio captures if present, and existing docs/reports to define the smallest repeatable process for governance completeness, duplicate-agent discovery, and the monthly governance snapshot. Prefer scripts or checklists only where they reduce manual drift. Do not add Studio write-back or percentage-based completeness scoring.
```

Acceptance checks:

- Completeness output remains field-level and evidence-based.
- Duplicate discovery compares one duplicate group at a time before any cleanup recommendation.
- Monthly snapshot can be regenerated from named source inputs.
- No new quarterly review template is created.

Completed local artifacts:

- `docs/reports/governance-report-generation-process.md`
- `scripts/Test-GovernanceReportInputs.ps1`
- `docs/implementation-backlog.md` note added to backlog item 8.4

Result:

- Documented the smallest repeatable, repo-only process for the three governance reports (governance completeness, duplicate-agent discovery, monthly governance snapshot), with named source inputs, per-report regeneration steps, and field-level output rules.
- Completeness output stays field-level: a present/total field **count** and a missing/unproven field list, never a percentage score.
- Duplicate discovery compares one duplicate group at a time and stops at "compare/verify" before any human-owned cleanup.
- Monthly snapshot regenerates from named inputs (Agent Inventory, publish history, completeness contract, existing reports, snapshot template; normalized Studio captures only if present).
- Added `scripts/Test-GovernanceReportInputs.ps1`, a read-only preflight that confirms each report's named inputs exist; verified in read-only mode (`Missing required inputs: 0`, exit 0). No Confluence, Studio, or Jira writes; no quarterly review template created.
- Known drift left for backlog item `8.10`: the completeness contract and snapshot template still carry legacy percentage-completeness wording; the process doc instructs field-level counts instead.

## 22. Later: Builder Pilot And Retrospective

```text
/goal After the Design Agent Studio copy/capture is current and Studio governance controls are confirmed, run a small builder pilot through Agent Fit Intake and the Design Agent. Track whether the builder reuses an existing agent, extends an existing agent, creates a candidate, or decides not to build. Capture lessons and update only the smallest necessary repo docs.
```

Acceptance checks:

- Pilot does not start until Studio manual configuration and governance controls are verified.
- Feedback is tied to actual builder behavior, not hypothetical template work.
- Retrospective updates are scoped to the intake, inventory, user guide, or reports that demonstrably need changes.

## 23. Completed Locally: Release Notes Manager Governed Migration Scaffold

```text
/goal Migrate Release Notes Manager through the Codex-first governed agent flow. Do not write to Studio. First inspect the old-space export and current repo docs for Release Notes Manager, Release Health Analyst, Release Management Assistant, Mobilitas Release Notes Agent, and release/change patterns. Decide whether Release Notes Manager should be a standalone governed agent, an extension, a reusable pattern, or deprecated/archive reference. Then scaffold safe repo artifacts for the chosen path: Project Brain, Agent Design Record, Knowledge Source Plan, Subagent Settings, ROVO Studio Configuration copy blocks, Evaluation, Measurement Plan, Change Log, and Agent Inventory update. Keep Studio configuration copy-paste blocks user-facing and keep repo-only technical workflow out of Confluence. Run Confluence dry-runs only; do not apply without approval. Keep .env, config/confluence-pages.yml, data/raw, exports, cookies, headers, and tokens out of Git. End by updating docs/next-slash-goals.md and committing safe local changes.
```

Decision:

- Release Notes Manager is scaffolded as a standalone governed agent in `In Review`.
- Release Health Analyst remains the release health/readiness agent.
- Release Management Assistant remains a later overlap-review item.
- Mobilitas Release Notes Agent remains archive/reference only.

Artifacts:

- `docs/confluence-pages/release-notes-manager-project-brain.md`
- `docs/confluence-pages/release-notes-manager-agent-design-record.md`
- `docs/confluence-pages/release-notes-manager-knowledge-source-plan.md`
- `docs/confluence-pages/release-notes-manager-subagent-settings.md`
- `docs/confluence-pages/release-notes-manager-rovo-studio-configuration.md`
- `docs/confluence-pages/release-notes-manager-evaluation.md`
- `docs/confluence-pages/release-notes-manager-measurement-plan.md`
- `docs/confluence-pages/release-notes-manager-change-log.md`
- `docs/reports/release-notes-manager-migration-decision.md`

Acceptance checks:

- No Studio writes were made.
- ROVO Studio configuration remains manual copy-paste content.
- Repo-only migration rationale stays in `docs/reports/`, not the Studio copy page.
- Confluence dry-run planned eight Release Notes Manager pages as creates; no apply flag was used.
- After approval, Confluence apply created eight Release Notes Manager pages under `Release and Change Agents`; post-apply dry-run confirmed each page exists at version `1`.
- Ignored local files stay out of Git: `.env`, `config/confluence-pages.yml`, `data/raw`, exports, cookies, headers, and tokens.

## 24. Next: Release Notes Manager Manual Review And Pilot Gate

```text
/goal Review the Release Notes Manager governed scaffold with the release owner. Confirm primary owner, backup owner, approved Jira and Confluence sources, release-note template, pilot audience, and whether Release Management Assistant owns any overlapping coordination workflows. Do not write to Studio from Codex. If approved, manually copy the Studio configuration blocks from the published ROVO Studio Configuration - Release Notes Manager page into Studio, then run the evaluation prompts and capture safe repo evidence.
```

Acceptance checks:

- Owner and backup owner are assigned before pilot.
- Release Health Analyst boundary remains clear.
- Mobilitas-specific content remains archive/reference only.
- Evaluation prompts pass before launch or broad visibility.
- Studio changes, if any, are manual and later captured back into safe repo artifacts.

## 25. Completed Locally: Jira Ticket Polisher Governed Migration Scaffold

```text
/goal Migrate Jira Ticket Polisher through the Codex-first governed agent flow. Do not write to Studio. Do not update Jira tickets directly. Use live Atlassian research when available, with local exports, Jira CSVs, or pasted samples as fallback. First inspect the current repo, the old-space export, the supplied Confluence folder, and existing governance artifacts. Research the organization-wide ticket quality standard and the MOBRM team standard as the only active standards for the current pilot. Scaffold Project Brain artifacts, organization-wide standard, MOBRM overlay, research report, inventory update, and Confluence dry-runs only. Keep private config and raw captures out of Git.
```

Decision:

- Jira Ticket Polisher was scaffolded as a governed agent in `In Review`, then archived/superseded on 2026-06-09 after Jira Work Item Assistant absorbed the active review/polish workflow.
- Studio behavior is draft-only; no Jira update, transition, assign, rank, or comment actions are enabled.
- Organization-wide ticket quality standard is the fallback for any ticket.
- Active standards are limited to the organization-wide standard and MOBRM team standard.
- MOBRM applies to `MOBRM-*` tickets and board `7690` context after the ROVO standard is published or supplied.
- Related keys such as `MR26`, `M26`, and `CLE` do not trigger MOBRM standards by themselves.

Artifacts:

- `docs/confluence-pages/jira-ticket-polisher-project-brain.md`
- `docs/confluence-pages/jira-ticket-polisher-agent-design-record.md`
- `docs/confluence-pages/jira-ticket-polisher-knowledge-source-plan.md`
- `docs/confluence-pages/jira-ticket-polisher-subagent-settings.md`
- `docs/confluence-pages/jira-ticket-polisher-rovo-studio-configuration.md`
- `docs/confluence-pages/jira-ticket-polisher-evaluation.md`
- `docs/confluence-pages/jira-ticket-polisher-measurement-plan.md`
- `docs/confluence-pages/jira-ticket-polisher-change-log.md`
- `docs/confluence-pages/jira-ticket-quality-standard.md`
- `docs/confluence-pages/jira-ticket-polisher-team-standards-draft-overlays.md`
- `docs/reports/jira-ticket-polisher-migration-research.md`

Acceptance checks:

- No Studio writes were made.
- No Jira writes were made.
- The active standards page is scoped to org-wide plus MOBRM only.
- Config examples and local dry-run manifest include the new page slugs.
- `config/confluence-pages.yml` remains ignored and out of Git.

## 26. Next: Jira Ticket Polisher MOBRM Standards Publish And Pilot Gate

Superseded on 2026-06-09. Do not run this goal as written. Active ticket review, polishing, standards alignment, gap checking, improved field drafting, and comment drafting now belong to Jira Work Item Assistant's Ticket Review / Polish workflow. Keep Jira Ticket Polisher pages visible as archived/superseded historical reference only.

```text
/goal Publish the Jira Ticket Polisher active standards set after approval. Keep the migrated agent in the ROVO agent inventory and governance space. Use only the Organization-Wide Jira Ticket Quality Standard and MOBRM Team Jira Standards for the current active standards page. Publish or update the Team Jira Standards index under Jira Ticket Polisher, publish MOBRM Team Jira Standards under that index, update the active standards index, and run dry-runs before applying. Confirm `MOBRM-*` and MOBRM board `7690` trigger the MOBRM overlay; confirm non-MOBRM tickets use the org-wide fallback and state `No team overlay applied`; confirm `MR26`, `M26`, and `CLE` references do not trigger MOBRM by themselves. Do not write to Jira or Studio without a separate governed decision.
```

Acceptance checks:

- ROVO-facing standards page lists only the organization-wide standard and MOBRM.
- MOBRM standard is published under `Team Jira Standards`.
- Non-MOBRM tickets use org-wide fallback only.
- Related release or epic keys do not trigger MOBRM automatically.
- Jira Ticket Polisher remains archived/superseded and is not configured as a separate active Studio agent.
- Evaluation prompts include one MOBRM overlay case, one org-wide fallback case, and one wrong-overlay boundary case.

## 27. Completed Locally: Stage 5 Agent Factory Pilot Readiness

```text
/goal Build the Stage 5 agent factory pilot-readiness slice. Reframe the governance project as the behind-the-scenes source of truth and control plane for approved ROVO agents, while normal pilot users consume agents through Jira, Confluence, and ROVO/Studio workflows. Create the smallest useful repo-backed artifacts: a Stage 5 start-here page, audience map, agent lifecycle and promotion stages, approved/prohibited/escalate catalog, duplicate-prevention workflow, pilot metrics and feedback tracker, contributor/helper guide, and first pilot promotion packet outline. Do not publish Confluence changes, write to Studio, write to Jira, or begin org-wide rollout. Keep Claude Code migration as a future tracked lane, not a blocker for the initial pilot.
```

Completed local artifacts:

- `docs/stage-5-agent-factory-start-here.md`
- `docs/stage-5-pilot-boundaries.md`
- `docs/stage-5-contributor-helper-guide.md`
- `templates/stage-5-pilot-feedback-tracker-template.md`
- `templates/stage-5-pilot-promotion-packet-template.md`
- `docs/confluence-pages/agent-inventory.md` duplicate-prevention workflow update

Acceptance checks:

- Start-here page clearly separates governance builders from normal ROVO agent users.
- Lifecycle covers pain point, intake, duplicate check, spec, context review, prototype, dry-run, review, pilot approval, team promotion, metrics, improvement, deprecation, and retirement.
- Promotion stages define entry criteria, approver, required evidence, allowed audience, ROVO/Studio use, and expansion review.
- Approved/prohibited/escalate catalog names the initial pilot boundaries and escalation triggers.
- Duplicate-prevention workflow requires inventory search and reuse/improve/merge/reject/new decision before new-agent work.
- Metrics and feedback loop measure whether agents reduce pain points, save time, improve quality, and preserve human decision-making.
- Contributor/helper guidance defines what helpers can do with Codex and what requires approval.
- Claude Code migration is listed as a future lane and does not expand the pilot scope.

Next action:

- Select the first 1-2 pilot agents and run the Stage 5 readiness review from `docs/stage-5-agent-factory-start-here.md`.

## 28. Completed Locally: Governance Maintainability Backlog Slice

```text
/goal Implement the first governance maintainability slice from docs/implementation-backlog.md Milestone 8. Do not publish Confluence changes, write to Studio, write to Jira, or push. First inspect README.md, docs/roadmap.md, docs/implementation-backlog.md, docs/next-slash-goals.md, docs/confluence-pages/, config/confluence-pages.example.yml, docs/handoffs/, docs/reports/, and current git status. Then create the smallest repo-only implementation that helps a teammate start and helps maintainers catch drift: a start-here guide or equivalent, a page-family/source-link consistency checklist or script, and an owner/readiness gap report shape. Keep outputs field-level and evidence-based, do not use percentage completeness scoring, and preserve private config and raw captures. End by validating Markdown/JSON/YAML where practical and propose clean commit slices.
```

Acceptance checks:

- A teammate can identify the correct next workflow without live explanation.
- The first check catches missing Project Brain linked artifacts, missing setup/runtime/knowledge/evaluation links, missing manifest entries, or source-link drift.
- Owner/readiness output lists missing fields rather than percentage scores.
- No Confluence, Jira, or Studio writes are performed.
- `.env`, `config/confluence-pages.yml`, `data/raw`, HARs, cookies, headers, tokens, and unsanitized exports remain out of Git.
- The implementation can be committed independently from unrelated Studio setup or infographic work.

Completed local artifacts:

- `START-HERE.md`
- `scripts/Test-ConfluencePageFamilyConsistency.ps1`
- `docs/reports/page-family-source-link-consistency-checklist.md`
- `docs/reports/owner-readiness-gap-report-template.md`
- Manifest example entry for `docs/confluence-pages/rovo-studio-configuration-field-guide.md`

Validation:

- `.\scripts\Test-ConfluencePageFamilyConsistency.ps1` reports zero issues against `config/confluence-pages.example.yml`.

## 29. Completed Locally: Governance Maintainability Guardrails Slice

```text
/goal Extend the governance maintainability track without touching live systems. Add stale-handoff detection and no-secret/private-data scanning for candidate commit slices. Keep checks repo-only and read-only by default, preserve `.env`, `config/confluence-pages.yml`, `data/raw`, HARs, cookies, headers, tokens, and unsanitized exports, and update only the smallest companion docs needed to make the checks discoverable.
```

Acceptance checks:

- Stale-handoff output flags referenced files, dates, and superseded packets without deleting handoffs.
- Private-data scan flags risky tracked or candidate files before commit.
- Checks are read-only by default and safe to run locally.
- No Confluence, Jira, or Studio writes are performed.

Completed local artifacts:

- `scripts/Test-StaleHandoffs.ps1`
- `scripts/Test-PrivateDataScan.ps1`
- `START-HERE.md` maintainability check guidance
- `docs/implementation-backlog.md` status updates for backlog items 8.6 and 8.7

Validation:

- `.\scripts\Test-StaleHandoffs.ps1 -WarnOnly` flags the older 2026-06-08 deployment-notes handoff, referenced files newer than that handoff, the undated Design Agent handoff, and the Jira Ticket Polisher supersession marker.
- `.\scripts\Test-PrivateDataScan.ps1` passes the current candidate commit slice with one warning for an existing Atlassian URL in `docs/next-slash-goals.md` and no blocking secret findings.
- `.\scripts\Test-PrivateDataScan.ps1 -Scope AllTracked -WarnOnly` reports existing Atlassian URL warnings for tracked repo-backed docs and no blocking secret findings.

## 30. Next: Refresh Merge-Readiness Guardrail Before Commits

```text
/goal Refresh the merge-readiness report before the next commit-ready slice. Use current git status, stale-handoff output, private-data scan output, and the changed-file list to produce a concise commit-slice recommendation. Keep the report repo-only, do not publish Confluence, do not write to Studio, do not write to Jira, and do not push unless explicitly asked.
```

Acceptance checks:

- Commit-slice guidance is generated from current branch and working-tree evidence.
- Private-data and stale-handoff guardrails are included in the validation evidence.
- Unrelated local files remain out of the proposed commit.

## 31. Later: Claude Code Migration Readiness Slice

```text
/goal Prepare the future Claude Code/work-backed migration readiness slice. Start from current AGENTS.md, START-HERE.md, docs/roadmap.md, docs/implementation-backlog.md, the maintainability guardrail scripts, and Stage 5 pilot boundaries. Do not resurrect or merge the deleted stale codex/agentic-operating-contract branch as-is. Define what belongs in Claude Code, what remains Confluence/ROVO Studio-facing, what approval gate is required before migration, and what Claude-specific settings or SOPs are safe companion artifacts.
```

Acceptance checks:

- Migration remains future-only until the work-backed Claude Code environment and approval path are confirmed.
- Any Claude-specific operating file is derived from current `AGENTS.md` and `START-HERE.md`, not the deleted stale branch.
- The plan preserves no Studio write-back, no Jira writes, Confluence dry-run-first publishing, and private-data guardrails.
- Readiness checklist covers branch strategy, PR review, CI/checks, secrets handling, publish workflow, evidence capture, and stakeholder communication.

Status:

- Accepted on 2026-06-29. `docs/claude-code-adoption-plan.md` is the accepted governance reference and `.claude/settings.json` implements the read-only allowlist and deny paths derived from current repo truth.
- Remaining future slice: CI/automated checks (tracked under backlog item 8.9).

## 32. Completed Locally: Pilot Runtime Context Maps For Source Routing

```text
/goal Pilot Runtime Context Maps for governed ROVO agent source routing. Start with docs/handoffs/runtime-context-map-demo-handoff-2026-06-11.md, AGENTS.md, README.md, START-HERE.md, docs/toolkit-operating-model.md, docs/confluence-pages/agent-bootstrap-pattern.md, and the selected pilot agents' Knowledge Source Plans and Studio setup/configuration pages. Do not write to Studio, Jira, or Confluence. Do not claim Runtime Context Maps are live. Add a compact Runtime Context Map section to one or two pilot Knowledge Source Plans that names user/task intent, source to use first, forbidden substitutes, fallback behavior, and smoke test prompt. Update Studio setup pages only if the map changes the human knowledge-source checklist. Validate with git diff --check, private-data scan, and manual cross-read.
```

Acceptance checks:

- Runtime Context Map is small enough to support routing instead of becoming a giant governance page.
- Each row names task intent, source to use first, forbidden substitute, fallback behavior, and smoke test prompt.
- The pilot starts with 1-2 agents, not all documented agents.
- No Studio, Jira, or Confluence writes are performed.
- Final handoff states that the map is repo-only until manually configured and verified in Studio.

Completed local artifacts:

- `agent-portfolio-lab/test-runs/003-runtime-context-map-pilot/`
- `docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md`
- `docs/confluence-pages/jira-work-item-assistant-studio-setup.md`
- `docs/confluence-pages/jira-work-item-assistant-change-log.md`
- `docs/confluence-pages/release-notes-manager-knowledge-source-plan.md`
- `docs/confluence-pages/release-notes-manager-studio-setup.md`
- `docs/confluence-pages/release-notes-manager-change-log.md`
- `docs/reports/runtime-context-map-agent-lab-evaluation-2026-06-11.md`

Result:

- Added compact Runtime Context Map sections for Jira Work Item Assistant and Release Notes Manager only.
- Added Studio setup review notes so manual configurators can verify mapped sources and forbidden substitutes after Studio setup.
- Ran a local Agent Lab artifact-level evaluation and recorded both agents as improved for source-routing clarity, with live-output score not run.

## 33. Next: Team-Facing Agent Full Pattern

```text
/goal Define the fuller agentic development pattern as the default for team-facing ROVO, Copilot, or similar agents. Start from AGENTS.md, START-HERE.md, docs/toolkit-operating-model.md, docs/stage-5-agent-factory-start-here.md, docs/confluence-pages/agent-bootstrap-pattern.md, docs/confluence-pages/rovo-studio-configuration-field-guide.md, and the Runtime Context Map pilot evidence. Do not write to Studio, Jira, or Confluence. Document the minimum full package for team-facing agents: runtime contract, Runtime Context Map, guardrails, knowledge source plan, evaluation prompt pack, Studio promotion packet, owner/backup owner, measurement, change log, and post-Studio parity check. Also document a lightweight variant for personal, one-off, or low-risk helpers. Keep pitch language truthful: ROVO is the user-facing runtime today, while the Agent Lab/repo pattern is the proposed approved workshop/control layer for faster governed development.
```

Acceptance checks:

- Team-facing agents have a clear default package that mirrors agentic AI development best practices without making normal ROVO users read the repo.
- The pattern distinguishes runtime context from setup, governance, evaluation, and promotion evidence.
- Lightweight exceptions are allowed for personal, one-off, or low-risk helpers.
- Pitch wording avoids claiming the Agent Lab is already official enterprise infrastructure.
- No live Studio, Jira, or Confluence writes are performed.
- No Runtime Context Map is claimed live until a human manually configures and verifies Studio knowledge sources.

## 34. Completed Locally: Principles Foundation For Collaborators

```text
/goal Create a repo-facing principles foundation for incoming collaborators. Start from AGENTS.md, START-HERE.md, docs/toolkit-operating-model.md, docs/stage-5-agent-factory-start-here.md, docs/stage-5-contributor-helper-guide.md, docs/stage-5-pilot-boundaries.md, and docs/implementation-backlog.md. Do not write to Studio, Jira, or Confluence. Assess where the repo already follows primary values and first-principles reasoning, where it is inconsistent or implicit, and add the smallest collaborator-facing guidance needed to make the foundation repeatable. Frame Biblical principles in work-safe operating language for shared enterprise use: truthfulness, stewardship, humility, service, justice/fairness, care for people, and accountability. Treat first-principles reasoning as the secondary design method: define the actual problem, identify source truth, reduce scope, expose assumptions, test the smallest useful slice, and avoid unnecessary complexity. Add backlog/checklist items for any gaps that should not be fixed in the first slice.
```

Acceptance checks:

- The foundation helps a new collaborator understand why the repo uses read-only-first, dry-run-first, source-of-truth order, human-owned decisions, evidence labels, runtime context maps, and small reviewable slices.
- Guidance distinguishes personal moral foundation from enterprise-safe shared wording.
- The checklist is actionable, not philosophical only.
- It identifies current gaps without claiming the repo follows the principles perfectly everywhere.
- No live Studio, Jira, or Confluence writes are performed.

Completed local artifact:

- `docs/principles-foundation.md`

Result:

- Created `docs/principles-foundation.md` mapping the operating model to seven enterprise-safe primary values (truthfulness, stewardship, humility, service, justice/fairness, care for people, accountability), each linked to existing repo rules with an honest per-value repo status.
- Documented first-principles reasoning as the secondary design method (define the actual problem, identify source truth, reduce scope, expose assumptions, test the smallest useful slice, avoid unnecessary complexity) and added an actionable collaborator checklist covering truth-before-usefulness, people-impact review, stewardship/reuse, smallest useful slice, evidence labels, human-owned decisions, and source-failure behavior.
- Distinguished the maintainer's personal moral foundation from enterprise-safe shared wording and kept sectarian phrasing out of anything that could reach agent runtime.
- Included an honest gap assessment: adherence is strong on truthfulness, stewardship, humility, and accountability, but uneven or implicit on fairness across page families and on explicitly naming people-impact; the doc does not claim perfect adherence.
- Updated backlog item 7.12. No live Studio, Jira, or Confluence writes; no Publish-*.ps1 run.

## 35. Completed Locally: Regression Prompt Pack Pilot (Backlog 8.5)

```text
/goal Create a small, consistent regression prompt pack for the two pilot agents, Jira Work Item Assistant and Release Notes Manager. Each pack covers source verification, fallback trap, unsafe-write trap, and 2-3 behavior regressions with explicit pass/partial/fail criteria. Reuse the Runtime Context Map smoke tests and live regression evidence already in the repo. Keep the work repo-only and dry-run-first. Do not write to Studio, Jira, or Confluence. Do not claim any pack was run against a live agent.
```

Acceptance checks:

- Each pilot agent has a small prompt pack with source verification, fallback trap, unsafe-write trap, and three behavior regressions.
- Every prompt has explicit pass / partial / fail criteria.
- The packs reuse existing Runtime Context Map smoke tests and live regression evidence rather than duplicating it.
- The work is repo-only; no live-system writes occur; nothing is claimed as a live test result.

Completed local artifacts:

- `docs/confluence-pages/jira-work-item-assistant-evaluation.md` `Regression Prompt Pack` section (`JWA-R1`-`JWA-R6`).
- `docs/confluence-pages/release-notes-manager-evaluation.md` `Regression Prompt Pack` section (`RNM-R1`-`RNM-R6`).
- `docs/implementation-backlog.md` status updates for backlog item 8.5.

Result:

- Added a `Regression Prompt Pack` section to each pilot agent's evaluation page; no new page was created and no manifest change was needed.
- Each pack seeds R1/R2 from the agent's Runtime Context Map smoke tests and forbidden-substitute / fallback columns, R3 from the existing unsafe-write evaluation case, and R4-R6 from the live regression and golden runbook reports.
- Packs are labeled repo-only prompts plus expected-behavior criteria; results are recorded with the existing `Test Run` block in `docs/reports/deployment-notes-agent-live-regression-2026-06-08.md` only after a human runs them.
- Confluence publishing of the new sections is deferred to goal 36 below.

## 36. Next: Publish Regression Prompt Pack Sections

```text
/goal After the Regression Prompt Pack shape is reviewed and approved, publish the updated Jira Work Item Assistant and Release Notes Manager evaluation pages to Confluence. Run .\scripts\Publish-ConfluencePages.ps1 -Slug jira-work-item-assistant-evaluation -UpdateExisting and .\scripts\Publish-ConfluencePages.ps1 -Slug release-notes-manager-evaluation -UpdateExisting as dry-runs first, confirm each plan targets exactly one intended page with the expected currentVersion and plannedVersion, and apply only after explicit approval. Do not write to Studio or Jira. Record a publish-history entry for each applied page.
```

Acceptance checks:

- Each dry-run targets exactly one intended page before any apply.
- Apply runs only after the pack shape is approved and the dry-run is confirmed.
- A publish-history record is created under `docs/publish-history/` for each applied page.
- `config/confluence-pages.yml` remains ignored and out of Git.
- No Studio or Jira writes occur.

Status:

- Done 2026-06-29. Both evaluation pages were published after dry-run review and explicit approval; publish history recorded in `docs/publish-history/2026-06-29-regression-prompt-packs.md`.
