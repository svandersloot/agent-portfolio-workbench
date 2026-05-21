# Next Slash Goals

These goals are executable from the current local repo state. Confluence writes should still be dry-run-first.

## 1. Apply Space Structure Update

```text
/goal Review and apply the Space Structure and Navigation update from docs/confluence-pages/space-structure-and-navigation.md to Confluence page 5281218620. Run scripts/Publish-ConfluencePages.ps1 -Slug space-structure-and-navigation -UpdateExisting first and confirm the dry-run shows currentVersion 1 and plannedVersion 2. Apply only after confirmation with -Apply, then verify the live page contains Governance and Safety and its child pages.
```

Current dry-run:

- Page: `Space Structure and Navigation`
- Page ID: `5281218620`
- Current version: `1`
- Planned version: `2`
- Source: `docs/confluence-pages/space-structure-and-navigation.md`
- Command: `.\scripts\Publish-ConfluencePages.ps1 -Slug space-structure-and-navigation -UpdateExisting`

## 2. Use Generic Publisher Update-Mode

```text
/goal Use the generic Confluence publisher update-mode for future markdown-backed page updates. Keep config/confluence-pages.yml as the local source of page IDs, keep config/confluence-pages.example.yml tracked with null IDs, require dry-run before -Apply, and use -Slug for targeted existing-page updates.
```

Acceptance checks:

- Default dry-run reports existing pages as `exists`.
- `-UpdateExisting` reports `currentVersion` and `plannedVersion`.
- `-Slug <slug> -UpdateExisting` limits the plan to one intended page.
- `.env` and `config/confluence-pages.yml` remain ignored.

## 3. Inventory Cleanup Dry-Run

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
