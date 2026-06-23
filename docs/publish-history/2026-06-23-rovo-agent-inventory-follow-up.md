# Rovo Agent Inventory Follow-Up

## Summary

Updated the Rovo Agent Inventory user front door after live page review. The update confirmed the current QA pilot audience and ownership for QA Test Strategy Planner, added the agent to the governed inventory as pilot-only, and linked the approved-agent guide from Agent Governance Home.

## Publish Details

| Page | Page ID | Action | Version Change | Source |
|---|---:|---|---|---|
| User Guide - Using Approved Agents | 5416976453 | Update | 1 -> 2 | `docs/confluence-pages/user-guide-using-approved-agents.md` |
| Agent Inventory | 5280334048 | Update | 9 -> 10 | `docs/confluence-pages/agent-inventory.md` |
| Agent Governance Home | 5281480733 | Storage-preserving update | 4 -> 5 | Live Confluence body, Start Here table row only |

## Commands

Dry-runs:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-using-approved-agents,agent-inventory -UpdateExisting
```

Agent Governance Home was dry-run checked with a storage-preserving Confluence API preview because the page is not currently repo-backed by a Markdown source file. The dry-run planned one Start Here table row:

```text
I want to use an approved or pilot-only agent. -> User Guide - Using Approved Agents
```

Apply:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-using-approved-agents,agent-inventory -UpdateExisting -Apply
```

Agent Governance Home was updated through the Confluence API by preserving the existing storage body and inserting only the new Start Here row.

## Verification Result

- `User Guide - Using Approved Agents` is current at version 2.
- `Agent Inventory` is current at version 10.
- `Agent Governance Home` is current at version 5.
- Agent Governance Home contains the user guide link to page `5416976453`.
- QA Test Strategy Planner is listed as pilot-only for Lisa Porter.
- Shayne Vandersloot is listed as primary owner; backup owner remains `TBD`.
- No Jira writes or ROVO Studio writes were performed.

## Open Follow-Ups

- Confirm the backup owner for QA Test Strategy Planner.
- Confirm the measurement plan and pilot feedback path.
- Capture or publish repo-backed source details for the QA Test Strategy Planner Project Brain if this pilot becomes durable beyond the named pilot audience.
