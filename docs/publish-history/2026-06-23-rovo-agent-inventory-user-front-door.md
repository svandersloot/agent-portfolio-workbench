# Rovo Agent Inventory User Front Door

## Summary

Published the first everyday-user documentation front door for the Rovo Agent Inventory space. The slice created user-facing guidance for approved and pilot-only agents, created a request/improvement path for users, leads, and AI champions, and updated the existing navigation pages that point to the new guidance.

## Publish Details

| Page | Page ID | Action | Version Change | Source |
|---|---:|---|---|---|
| User Guide - Using Approved Agents | 5416976453 | Create | N/A -> 1 | `docs/confluence-pages/user-guide-using-approved-agents.md` |
| Request or Improve an Agent | 5417009251 | Create | N/A -> 1 | `docs/confluence-pages/request-or-improve-agent.md` |
| Agent Inventory | 5280334048 | Update | 8 -> 9 | `docs/confluence-pages/agent-inventory.md` |
| Governance and Safety | 5297995845 | Update | 3 -> 4 | `docs/confluence-pages/governance-and-safety.md` |
| Space Structure and Navigation | 5281218620 | Update | 2 -> 3 | `docs/confluence-pages/space-structure-and-navigation.md` |
| Rovo Studio Configuration - Release Health Analyst | 5289476102 | Update | 8 -> 9 | `docs/confluence-pages/release-health-analyst-rovo-studio-configuration.md` |

## Commands

Dry-runs:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-using-approved-agents,request-or-improve-agent
.\scripts\Publish-ConfluencePages.ps1 -Slug agent-inventory,governance-and-safety,space-structure-and-navigation,release-health-analyst-rovo-studio-configuration -UpdateExisting
```

Apply:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-using-approved-agents,request-or-improve-agent -Apply
.\scripts\Publish-ConfluencePages.ps1 -Slug agent-inventory,governance-and-safety,space-structure-and-navigation,release-health-analyst-rovo-studio-configuration -UpdateExisting -Apply
```

Post-apply verification:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug user-guide-using-approved-agents,request-or-improve-agent
.\scripts\Publish-ConfluencePages.ps1 -Slug agent-inventory,governance-and-safety,space-structure-and-navigation,release-health-analyst-rovo-studio-configuration -UpdateExisting
```

## Verification Result

- `User Guide - Using Approved Agents` exists under `Agent Inventory` (`5280334048`) at version 1.
- `Request or Improve an Agent` exists under `Governance and Safety` (`5297995845`) at version 1.
- `Agent Inventory` is current at version 9.
- `Governance and Safety` is current at version 4.
- `Space Structure and Navigation` is current at version 3.
- `Rovo Studio Configuration - Release Health Analyst` is current at version 9.
- No Jira writes or ROVO Studio writes were performed.

## Notes

- `QA Test Strategy Planner` is listed only as a pilot-only agent in the user guide.
- The supplied Confluence URL was not committed. The user-provided page title and page ID were recorded instead.
- `config/confluence-pages.yml` was updated locally by the publisher and remains ignored by Git.
