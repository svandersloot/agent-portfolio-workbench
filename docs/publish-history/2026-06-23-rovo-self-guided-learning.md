# Rovo Self-Guided Learning

## Summary

Published the initial self-guided learning lab for using ROVO agents in Jira. The page is a learner-facing, hands-on path for comparing Ask Rovo, direct named-agent chat, and the Jira `Agents` / `Start work` flow. It includes QA Test Strategy Planner as a draft QA planning feedback option and keeps Jira writes, QA approval, release readiness, and final coverage decisions human-owned.

## Publish Details

| Page | Page ID | Action | Version Change | Source |
|---|---:|---|---|---|
| Self-Guided Learning - Using Rovo Agents in Jira | 5419597825 | Create | N/A -> 1 | `docs/confluence-pages/self-guided-learning-using-rovo-agents-in-jira.md` |

## Parent And Labels

| Field | Value |
|---|---|
| Space key | `ROVO` |
| Parent page | `User Guide - Using Approved Agents` |
| Parent page ID | `5416976453` |
| Labels | `agent-governance`, `user-guide`, `jira-work-item`, `training` |

## Commands

Dry-run:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug self-guided-learning-using-rovo-agents-in-jira
```

Apply:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug self-guided-learning-using-rovo-agents-in-jira -Apply
```

Post-apply verification:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Slug self-guided-learning-using-rovo-agents-in-jira
```

## Verification Result

- Pre-apply dry-run returned `mode: dry-run`, `action: create`, and parent page ID `5416976453`.
- Apply returned `mode: apply`, `action: create`, and page ID `5419597825`.
- Post-apply dry-run returned `action: exists`, page ID `5419597825`, parent page ID `5416976453`, and current version `1`.
- No Jira writes or ROVO Studio writes were performed.
- No additional Confluence pages were published or updated in this operation.

## Notes

- The page is intended as an initial living self-guided learning lab and can be reviewed monthly during early adoption, then quarterly once stable.
- `config/confluence-pages.yml` was updated locally by the publisher and remains ignored by Git.
