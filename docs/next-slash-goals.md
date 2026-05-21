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
/goal Publish the latest Rovo Design Agent vNext Studio Configuration source to the existing Confluence page https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5281349770/Rovo+Design+Agent+vNext+-+Rovo+Studio+Configuration. Use docs/confluence-pages/rovo-design-agent-vnext-rovo-studio-configuration.md and slug rovo-design-agent-vnext-rovo-studio-configuration. First run .\scripts\Publish-ConfluencePages.ps1 -Slug rovo-design-agent-vnext-rovo-studio-configuration -UpdateExisting and confirm it shows exactly one intended page, page ID 5281349770. Apply only after approval. Do not write to Studio.
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

## 21. Next: Make Governance Reports Repeatable

```text
/goal Make the repo-only governance reports repeatable without Confluence or Studio writes. Use the Agent Inventory, publish history, completeness contract, normalized Studio captures if present, and existing docs/reports to define the smallest repeatable process for governance completeness, duplicate-agent discovery, and the monthly governance snapshot. Prefer scripts or checklists only where they reduce manual drift. Do not add Studio write-back or percentage-based completeness scoring.
```

Acceptance checks:

- Completeness output remains field-level and evidence-based.
- Duplicate discovery compares one duplicate group at a time before any cleanup recommendation.
- Monthly snapshot can be regenerated from named source inputs.
- No new quarterly review template is created.

## 22. Later: Builder Pilot And Retrospective

```text
/goal After the Design Agent Studio copy/capture is current and Studio governance controls are confirmed, run a small builder pilot through Agent Fit Intake and the Design Agent. Track whether the builder reuses an existing agent, extends an existing agent, creates a candidate, or decides not to build. Capture lessons and update only the smallest necessary repo docs.
```

Acceptance checks:

- Pilot does not start until Studio manual configuration and governance controls are verified.
- Feedback is tied to actual builder behavior, not hypothetical template work.
- Retrospective updates are scoped to the intake, inventory, user guide, or reports that demonstrably need changes.
