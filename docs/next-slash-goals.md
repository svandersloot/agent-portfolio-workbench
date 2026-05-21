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
