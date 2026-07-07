# Governance Report Generation Process

This process makes the three repo-only governance reports repeatable without any
Confluence, ROVO Studio, or Jira writes. It names the source inputs, gives the
smallest steps to regenerate each report, and fixes the field-level output rules so
successive runs stay comparable.

The three reports covered here are:

- Governance completeness report (`docs/reports/governance-completeness-dry-run.md`)
- Duplicate-agent discovery report (`docs/reports/duplicate-agent-discovery-dry-run.md`)
- Monthly governance snapshot (`docs/reports/monthly-governance-snapshot-YYYY-MM.md`)

## Boundaries

- Read-only and repo-only. This process never publishes to Confluence, never writes to
  ROVO Studio, never writes to Jira, and never runs a `Publish-*.ps1` apply.
- Completeness stays **field-level**. Report the count of present required fields and
  the list of missing or unproven fields. Do **not** compute a percentage completeness
  score. (Backlog decisions `4.6` and `8.10` chose field-level reporting over a score.)
- `Unknown` means the field was not proven by the local evidence used, not that it is
  absent from Confluence or Studio.
- Duplicate discovery compares one duplicate group at a time before any cleanup
  recommendation. Do not batch legacy-banner, move, or archive actions.
- Do not create a quarterly review template. The monthly snapshot is the portfolio
  cadence (backlog decision `5.3`).

## Named Source Inputs

| Input | Path | Used By | Notes |
|---|---|---|---|
| Agent Inventory | `docs/confluence-pages/agent-inventory.md` | All three | Canonical inventory rows, lifecycle/readiness status, owners, Project Brain links, duplicate/legacy notes. |
| Completeness contract | `docs/agent-governance-completeness-contract.md` | Completeness, snapshot | Required-field list and lifecycle/readiness policy. |
| Structured schema | `schemas/agent-governance-record.schema.json` | Completeness | Field names and types for the record contract. |
| Publish history | `docs/publish-history/` | Snapshot | Confluence page changes and applied governance updates for "What Changed". |
| Existing reports | `docs/reports/governance-completeness-dry-run.md`, `docs/reports/duplicate-agent-discovery-dry-run.md`, `docs/reports/inventory-cleanup-dry-run.md` | Snapshot, duplicate | Prior findings to roll forward and diff against. |
| Snapshot template | `templates/confluence/monthly-governance-snapshot-template.md` | Snapshot | Section shape for a new month. |
| Project Brain pages | `docs/confluence-pages/*-project-brain.md` | Completeness | Per-agent field evidence when present. |
| Normalized Studio captures | `agents/<agent-slug>/` | Completeness (optional) | Tools/skills/knowledge-source evidence **only if a capture exists**. None are present today; mark tools/skills `Unknown` when absent. |

Evidence label: the `agents/` capture directory does not exist in the repo at the time
of writing, so completeness runs currently rely on inventory, contract, Project Brain,
and report evidence only.

## Preflight: Confirm Inputs Are Present

Run the read-only input check before regenerating any report:

```powershell
.\scripts\Test-GovernanceReportInputs.ps1
```

It lists each report's named inputs and whether each is present, and it exits non-zero
if a required input is missing (use `-WarnOnly` to report without failing, and
`-Report <name>` to scope to one report). The check performs no writes and calls no
live system. A missing optional input (such as Studio captures) is reported but does not
fail the run.

## Report 1: Governance Completeness

Output stays field-level. Source of the current shape:
`docs/reports/governance-completeness-dry-run.md`.

1. Confirm inputs with the preflight check.
2. List the governed or candidate agents with Project Brain evidence from
   `docs/confluence-pages/agent-inventory.md` (skip `Idea`-only rows without a Brain).
3. For each agent, walk the required fields in
   `docs/agent-governance-completeness-contract.md` (`agentName`, `owner`,
   `backupOwner`, `status`, `purpose`, `audience`, `knowledgeSources`, `toolsOrSkills`,
   `measurementPlan`, `readinessStatus`, `projectBrainLink`, `lastReviewedDate`).
4. Mark each field `Present`, `Missing`, or `Unknown` with the file/section that proves
   it. Use `Unknown` when local evidence does not prove the field.
5. Build the summary table with these columns: Agent, Status Evidence,
   Completeness (present/total field **count**, e.g. `8/11`), Readiness, Missing Or
   Unproven Required Fields, Recommended Action.
6. Set Recommended Action from the contract's lifecycle and readiness policy. Do not
   recommend `Active` or broad `Ready` promotion; that is a human-owned decision.
7. Keep the field-level notes and "Next Dry-Run Inputs Needed" sections so the next run
   knows what evidence to look for.

Field-level output rules:

- Completeness is a **count** (`present/total`), never a percentage.
- Every agent row lists missing/unproven fields by name.
- New readiness values are `Ready`, `Needs Cleanup`, or `Not Ready` only.

## Report 2: Duplicate-Agent Discovery

Source of the current shape: `docs/reports/duplicate-agent-discovery-dry-run.md`.

1. Confirm inputs with the preflight check.
2. Read the "Duplicate And Legacy Notes" section of
   `docs/confluence-pages/agent-inventory.md` and any prior signals in
   `docs/reports/inventory-cleanup-dry-run.md`.
3. Treat **one duplicate group at a time**. For each group record: Candidate Area,
   Evidence, Likely Canonical, Risk, Recommendation.
4. Prefer the parented page under the active Project Brain structure as likely canonical;
   compare page bodies before recommending any legacy banner, move, or archive.
5. Keep the recommendation to "compare before cleanup". Do not recommend a batch cleanup
   and do not imply approval for archive, merge, or retirement (human-owned decisions).
6. Refresh the "Builder Reuse Guidance" rows from the current inventory so builders reuse
   before creating.
7. Keep the "Report Limits" section: duplicate titles and parent/space relationships are
   not proof of semantic equivalence, archival, or duplicate live agents.

Field-level output rules:

- One group per row; no cross-group merge recommendations.
- Recommendation column stops at "compare" or "verify" until a human approves cleanup.

## Report 3: Monthly Governance Snapshot

Regenerate a new dated file (`docs/reports/monthly-governance-snapshot-YYYY-MM.md`) from
the named inputs, using `templates/confluence/monthly-governance-snapshot-template.md`
as the section shape.

1. Confirm inputs with the preflight check.
2. Copy the section structure from the template.
3. Executive Summary counts come from `docs/confluence-pages/agent-inventory.md`
   (agents with Project Brain evidence, active/active-like, draft/scaffolding) and from
   the duplicate report (duplicate groups needing review).
4. "What Changed" comes from `docs/publish-history/` entries dated within the snapshot
   month, each cited to its publish-history file.
5. "Portfolio By Lifecycle Signal" and "Reuse And Duplicate Opportunities" come from the
   inventory and the duplicate-discovery report.
6. "Governance Completeness Themes" come from the completeness report's field-level notes.
7. State that no Confluence or Studio writes were performed and that visibility controls
   remain unproven from local evidence unless a manual Studio/admin check says otherwise.

Field-level output rules:

- The Governance Completeness table in the snapshot uses the same present/total **count**
  and missing-field list as Report 1. Fill the template's Completeness cell with the field
  count (e.g. `8/11`), never a percentage. (The template and contract now describe
  field-level counts directly; the earlier percentage wording was reconciled under backlog
  item `8.10`.)
- Keep the snapshot concise and human-facing for leadership and builders.

## Validation

Run the checks that match the changed surface:

```powershell
git status --short
git diff --check
.\scripts\Test-PrivateDataScan.ps1
.\scripts\Test-GovernanceReportInputs.ps1
```

For docs-only report changes, a manual cross-read against the named inputs is the primary
check; state that validation was manual. Do not claim any Confluence publish, Studio save,
or Jira action happened.

## Reconciled Drift

- The completeness contract "Dry-Run Report Shape" and the monthly snapshot template
  previously described a percentage "Completeness" column. Under backlog item `8.10` both now
  describe field-level present/total counts and a missing-or-unproven field list, matching the
  chosen policy (backlog decision `4.6`) and this process doc.
