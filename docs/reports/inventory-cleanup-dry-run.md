# Inventory Cleanup Dry-Run

Generated from local repo docs, `rovo-page-inventory.csv`, `rovo-iqs-reference-report.csv`, and read-only Confluence export evidence. No Confluence writes were performed.

## Recommendation

Keep `Agent Inventory` as the canonical inventory page and keep `Rovo Agent Inventory Home` as the space overview/root. Do not copy/recreate either page.

## Evidence

| Page | Page ID | Parent | Space | Evidence |
|---|---|---|---|---|
| Agent Inventory | `5280334048` | Agent Governance Home (`5281480733`) | `5298651147` | Local reference report snippet says this page is the canonical inventory of governed ROVO agents and candidate agents. |
| Rovo Agent Inventory Home | `5298651544` | None | `5298651147` | Page inventory places it as the top-level page that parents `Agent Governance Home`. |
| Rovo Agent Inventory Home | `5299109889` | None | None in CSV | Duplicate title with no parent/space in the local page inventory export; treat as stale/legacy until verified. |

## Dry-Run Plan

| Step | Proposed Action | Write? | Acceptance Criteria |
|---|---|---|---|
| 1 | Keep `Agent Inventory` (`5280334048`) as the canonical list of agents, owners, lifecycle status, Project Brain links, readiness, and measurement fields. | No | Inventory remains under `Agent Governance Home`. |
| 2 | Keep `Rovo Agent Inventory Home` (`5298651544`) as the space overview/root, not the canonical inventory. | No | Overview/root keeps navigation purpose and does not duplicate detailed inventory records. |
| 3 | Harvest useful field concepts from `Rovo Agent Inventory Home` into `Agent Inventory`: compliance tier, environment, runbook, SLO, data/privacy, and discoverability/visibility notes. | Future approved update | Canonical inventory gains useful fields without losing page history. |
| 4 | Add a legacy/redirect note to any duplicate or stale inventory home page after confirming its identity. | Future approved update | Users are directed to `Agent Inventory` for records and to `Rovo Agent Inventory Home` for navigation. |
| 5 | Update stale textual references that describe `Rovo Agent Inventory Home` as the inventory. | Future approved update | References use `Agent Inventory` for the canonical record set. |

## Duplicate Page Titles To Review

| Title | Count | Recommended Handling |
|---|---:|---|
| Rovo Agent Inventory Home | 2 | Verify `5298651544` as the overview/root; treat the entry without parent/space as stale until confirmed. |
| Agent Project Brains | 2 | Keep the child of `Agent Governance Home`; verify unparented duplicate before any archive/banner action. |
| Release Health Analyst Project Brain | 3 | Keep `5288362010` under its parent; treat unparented duplicates as migration leftovers until confirmed. |
| Subagent Settings - Performance Test Report Agent (Extension) | 3 | Keep `5287575752` under the Project Brain; verify unparented duplicates before archiving. |
| Evaluation - Release Health Analyst | 3 | Keep `5288034344` under the Project Brain; verify unparented duplicates before archiving. |
| Release Health Analyst Assessment Template | 3 | Keep the child under Release Health Analyst if still needed; verify unparented copies. |

## Link/Reference Notes

- `Agent Inventory` has `IQSCount` 9 and no old URL references in the local reference report.
- `Rovo Agent Inventory Home` does not appear in the local reference report, which suggests fewer textual references in the scanned report data.
- Several agent pages have duplicate title entries with missing `ParentId` or missing `SpaceId`; these should be treated as cleanup candidates, not automatically deleted.

## Proposed Apply Gate

Any future Confluence write should be split into focused dry-runs:

1. Update only `Agent Inventory` with harvested field structure.
2. Update only the canonical `Rovo Agent Inventory Home` with overview language if needed.
3. Update one duplicate/stale page at a time with a legacy banner or move/reparent operation.

Do not copy/recreate pages. Preserve page identity and history.

## Local Source Draft

The first local source draft for the canonical inventory is `docs/confluence-pages/agent-inventory.md`.

Dry-run target:

- Slug: `agent-inventory`
- Page: `Agent Inventory`
- Page ID: `5280334048`
- Parent: `Agent Governance Home` (`5281480733`)

Do not apply this draft until the inventory table is reviewed by the space admin or working group owner.

Dry-run result:

| Field | Value |
|---|---|
| Mode | `dry-run` |
| Slug | `agent-inventory` |
| Page count | `1` |
| Action | `update` |
| Page ID | `5280334048` |
| Parent page ID | `5281480733` |
| Current version | `1` |
| Planned version | `2` |
| Source path | `docs/confluence-pages/agent-inventory.md` |

No apply was run.
