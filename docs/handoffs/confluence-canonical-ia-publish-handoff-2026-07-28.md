# Handoff: Publish the Canonical-IA Confluence Updates

| Field | Value |
|---|---|
| Date | 2026-07-28 |
| Status | Ready for human-run dry-run + approval. **No publish has occurred.** |
| Source decision | `docs/reports/canonical-audience-and-lifecycle-ia-decision-2026-07-28.md` |
| Boundary | Confluence publish/update requires a focused dry-run and explicit per-page approval (see `AGENTS.md` → Live-System Boundaries). |

## What changed in the repo (already merged separately or in this PR)

The seven human-facing Confluence **source** pages below were updated to reflect the
canonical six-role audience model and the five-gate lifecycle structure. Only the source
files changed; nothing was published.

| Slug (manifest) | Source path | Change |
|---|---|---|
| `agent-portfolio-overview` | docs/confluence-pages/agent-portfolio-overview.md | "Who uses what" → canonical six roles (adds Governance builder + Agent owner rows, Assurance partner, Leader / executive; removes separate Pilot users row; keeps subset note) |
| `agent-fit-intake` | docs/confluence-pages/agent-fit-intake.md | Added a "Lifecycle Gates" section (G1–G5) over the seven statuses; criteria/fields/risk-tier explicitly marked proposed, not policy |
| `agent-inventory` | docs/confluence-pages/agent-inventory.md | Lifecycle-status field notes the five-gate grouping |
| `measurement-and-value-tracking` | docs/confluence-pages/measurement-and-value-tracking.md | Lifecycle-status row notes the gates; "Stakeholders" → "Leaders / executives" |
| `known-risks-and-limitations` | docs/confluence-pages/known-risks-and-limitations.md | Visibility-controls table notes the gate framing |
| `user-guide-using-approved-agents` | docs/confluence-pages/user-guide-using-approved-agents.md | One-line gate pointer (G4/G5) for end users |
| `space-structure-and-navigation` | docs/confluence-pages/space-structure-and-navigation.md | Inline role list aligned to the six roles |

## Prerequisites (human, interactive session)

1. A real local manifest `config/confluence-pages.yml` (copied from `config/confluence-pages.example.yml`) containing the live `pageId` values for the seven slugs. This file is gitignored — never commit it.
2. Direct-API credentials in `.env` (base URL, Atlassian email, API token), or a write-capable Atlassian MCP connector authorized in an interactive session.
3. These pages must already exist in Confluence (this is an **update**, so use `-UpdateExisting`).

## Step 1 — Dry-run (no writes)

Run the dry-run first and read the planned diff/version bump for each page. Dry-run is the
default (omit `-Apply`):

```powershell
.\scripts\Publish-ConfluencePages.ps1 `
  -ConfigPath .\config\confluence-pages.yml `
  -EnvPath .\.env `
  -Slug agent-portfolio-overview,agent-fit-intake,agent-inventory,measurement-and-value-tracking,known-risks-and-limitations,user-guide-using-approved-agents,space-structure-and-navigation `
  -UpdateExisting
```

Also run the read-only family/link check before publishing:

```powershell
.\scripts\Test-ConfluencePageFamilyConsistency.ps1
```

## Step 2 — Approve per page

For each slug, confirm the dry-run output before applying:

- [ ] `agent-portfolio-overview`
- [ ] `agent-fit-intake`
- [ ] `agent-inventory`
- [ ] `measurement-and-value-tracking`
- [ ] `known-risks-and-limitations`
- [ ] `user-guide-using-approved-agents`
- [ ] `space-structure-and-navigation`

## Step 3 — Apply (live update, only after approval)

Add `-Apply` to publish. Publish approved pages only — narrow the `-Slug` list to the
approved subset if not all are cleared:

```powershell
.\scripts\Publish-ConfluencePages.ps1 `
  -ConfigPath .\config\confluence-pages.yml `
  -EnvPath .\.env `
  -Slug <approved-slugs> `
  -UpdateExisting -Apply
```

## Step 4 — Record publish history (after apply)

Only after a successful apply, create a dated record under `docs/publish-history/`
capturing which slugs were updated, the resulting version numbers, and the date. Do not
create this record before the publish actually happens.

## Boundaries and reversibility

- Publishing is a versioned update; there is no automated delete/trash path. To revert,
  a human restores the previous page version in the Confluence UI.
- Do not change page visibility, ownership, or approval status as part of this publish —
  this is a content-sync of already-approved source edits only.
- If any dry-run shows an unexpected create (rather than update), stop: the manifest
  `pageId` is missing or wrong for that slug.
