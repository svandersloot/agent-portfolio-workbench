# Canonical IA Confluence Publish

## Summary

Published the canonical six-role audience model and five-gate lifecycle structure (decision `docs/reports/canonical-audience-and-lifecycle-ia-decision-2026-07-28.md`, source edits in PR #124) from repo `main` into the `ROVO` space. Because several live pages trailed repo `main`, each update is a full source sync, not only the IA delta. Two tracked pages were deferred: `Space Structure and Navigation` (source still carries a pre-existing `` `n `` escape artifact to fix first) and `Known Risks and Limitations` (not yet created live).

## Publish Details

| Page | Page ID | Action | Version Change | Source |
|---|---:|---|---|---|
| Agent Portfolio Overview | 5480316931 | Update | 1 -> 2 | `docs/confluence-pages/agent-portfolio-overview.md` |
| Agent Fit Intake | 5301174273 | Update | 3 -> 4 | `docs/confluence-pages/agent-fit-intake.md` |
| Agent Inventory | 5280334048 | Update | 10 -> 11 | `docs/confluence-pages/agent-inventory.md` |
| Measurement and Value Tracking | 5298913358 | Update | 2 -> 3 | `docs/confluence-pages/measurement-and-value-tracking.md` |
| User Guide - Using Approved Agents | 5416976453 | Update | 2 -> 3 | `docs/confluence-pages/user-guide-using-approved-agents.md` |

## What Changed Per Page

| Page | Change |
|---|---|
| Agent Portfolio Overview | "Who uses what" table rewritten to the canonical six roles; pilot users kept as a temporary subset note. |
| Agent Fit Intake | Added the "Lifecycle Gates" (G1–G5) section over the seven statuses, with risk-tier / entry-exit criteria / added fields marked proposed and not yet policy; "ROVO agent" wording made platform-neutral. |
| Agent Inventory | Lifecycle-status field notes the five-gate grouping; inventory row updates carried from repo main (QA Test Strategy Planner backup owner, team overlays, review date; reuse-check list). |
| Measurement and Value Tracking | Lifecycle-status signal notes the five gates; leadership-summary audience changed from "Stakeholders" to "Leaders / executives". |
| User Guide - Using Approved Agents | End-user/pilot-subset framing; one-line G4/G5 gate note; section retitled "Pilot-Approved Capabilities". |

## Method

Published through the Atlassian MCP connector (`updateConfluencePage`, `contentFormat: markdown`), site `csaaig.atlassian.net`, with explicit per-page human approval and a pilot-first sequence (Agent Portfolio Overview verified before the remaining four). This did not use `scripts/Publish-ConfluencePages.ps1`. The version-controlled source of truth is repo `main`. See the plan in `docs/handoffs/confluence-canonical-ia-publish-handoff-2026-07-28.md`.

## Deferred

| Page | Page ID | Reason |
|---|---:|---|
| Space Structure and Navigation | 5281218620 | Repo source retains a pre-existing `` `n `` escape artifact; fix source before publishing. |
| Known Risks and Limitations | (none) | Not yet created as a live page; publishing would be a create, decided separately. |

## Reversibility

MCP writes are not self-reversible. To revert a page, restore its previous version from the Confluence page history (… → Page History) in the UI.
