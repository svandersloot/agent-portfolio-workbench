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

## 3. Add Publish History Records

```text
/goal Add local publish-history records for Confluence page updates. For every API-assisted apply, record page ID, page title, old version, new version, source file, command, timestamp, and verification result under docs/publish-history/. Keep dry-run-first behavior and do not include tokens or private config values.
```

Acceptance checks:

- A publish-history file is created for the Space Structure update already applied.
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

## 5. Define Agent Governance Completeness Contract

```text
/goal Define the first structured agent governance completeness contract. Capture the non-negotiable fields for every governed ROVO agent, choose a local structured format for future inventory records, and create a dry-run report shape that identifies missing owner, backup owner, status, purpose, audience, knowledge sources, tools or skills, measurement plan, readiness status, Project Brain link, and last-reviewed date.
```

Acceptance checks:

- Contract is explicit and easy for builders to understand.
- The model supports leadership reporting and builder reuse.
- The first version does not require every existing page to be migrated at once.

## 6. Define Agent Fit Intake And Status Policy

```text
/goal Finalize and publish the Agent Fit Intake and lifecycle status policy for ROVO agents. Review docs/confluence-pages/agent-fit-intake.md, confirm the Design Agent can recommend prompt, automation, existing-agent extension, Confluence template, app candidate, new governed agent, or not ready, and publish it under Governance and Safety after a dry-run.
```

Acceptance checks:

- Intake supports chat-driven requests and Design Agent-guided scaffolding.
- Intake routes ideas to prompt, automation, existing-agent extension, new governed agent, app candidate, or not ready.
- Status definitions are clear enough for builders and leadership reporting.
- Active/Ready approval is limited to the space maintainer and Atlassian admins.
- Experimental agents are intended for a select audience while Studio visibility controls are investigated.

## 7. Design Monthly Governance Snapshot

```text
/goal Design the monthly ROVO agent governance snapshot. Define the sections, data inputs, and report format for leadership and interested builders, including what changed, what exists, what is ready, what is experimental, what is missing required governance fields, and what duplicate or reuse opportunities were found.
```

Acceptance checks:

- Report is human-facing and concise.
- Report can eventually be generated from inventory, publish history, and governance completeness checks.
- Report helps people find existing agents before creating duplicate work.
