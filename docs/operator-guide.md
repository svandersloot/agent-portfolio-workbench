# Operator Guide

This guide is for the person maintaining the ROVO governance space and agent library.

## Capture A Studio Agent

1. Open the target agent in ROVO Studio.
2. Open DevTools.
3. Go to Console.
4. Paste the contents of `scripts/studio-response-capture.js`.
5. Do not refresh the browser tab. A browser refresh removes the Console hook.
6. Use Studio's in-app navigation to open a different agent or view, then return to the target agent so Studio fetches the details again.
7. Wait until the Console logs at least one captured Studio response.
8. Run:

```js
copyStudioAgentCaptures()
```

9. Save the copied JSON to:

```text
data/raw/<agent-slug>.studio-response.json
```

Raw files are ignored by Git because they may contain internal IDs and private URLs.

If Studio will not refetch through in-app navigation, use Chrome DevTools Network instead. Console JavaScript cannot read response bodies that DevTools already captured, so use one of these Network export paths.

### Option A: Copy One Response

1. Open DevTools Network.
2. Enable Preserve log.
3. Select Fetch/XHR, or filter for `graphql`.
4. Click Clear so only the next reload is captured.
5. Refresh the page, then click through the agent editor panes or scenarios that show instructions, knowledge, and tools.
6. Use DevTools Search across Network responses for a unique phrase from the visible agent instructions. For example:

```text
You are the
Design Agent
Evaluation Planner
```

7. If the instruction phrase is not found, search for one of these field names:

```text
instructions
knowledgeSources
conversationStarters
```

8. Open the response that contains the instruction phrase or `agentStudio_agentById` plus configuration fields.
9. Copy the response body into `data/raw/<agent-slug>.studio-response.json`.

A response that only contains `id`, `name`, `permissions`, and scenario names is a partial agent shell. It is useful for inventory, but it is not enough for normalization.

A response that contains parent `instructions`, `conversationStarters`, and `knowledgeSources` is enough for a parent-agent capture. It may still omit full subagent instructions; in that case the normalizer records subagent names, active/default state, invocation descriptions, and marks subagent instructions as not captured.

### Option B: Save And Filter A HAR

1. Open DevTools Network.
2. Enable Preserve log.
3. Click Clear so only the next reload is captured.
4. Refresh the page.
5. Right-click the request list.
6. Choose `Save all as HAR with content`.
7. Save it to `data/raw/<agent-slug>.studio-response.har`.
8. Inspect which responses contain the governance fields:

```powershell
.\scripts\Inspect-StudioHar.ps1 `
  -HarPath .\data\raw\<agent-slug>.studio-response.har
```

9. Extract only the Studio agent responses:

```powershell
.\scripts\Extract-StudioResponsesFromHar.ps1 `
  -HarPath .\data\raw\<agent-slug>.studio-response.har `
  -OutPath .\data\raw\<agent-slug>.studio-response.json
```

Normalize the smaller `.studio-response.json` file.

## Normalize For Review

Run:

```powershell
.\scripts\Normalize-StudioExport.ps1 `
  -RawPath .\data\raw\<agent-slug>.studio-response.json `
  -OutDir .\agents
```

Review:

```text
agents/<agent-slug>/agent.yml
agents/<agent-slug>/parent-instructions.md
agents/<agent-slug>/knowledge-sources.yml
agents/<agent-slug>/tools.yml
agents/<agent-slug>/subagents/
```

## Review Checklist

- Did any tool get added?
- Did any tool risk tier become high?
- Did knowledge access broaden?
- Did web search or deep research turn on?
- Did a subagent become active or inactive?
- Did instructions change governance behavior?
- Do conversation starters still route users appropriately?

## Commit Guidance

Commit normalized files only. Do not commit:

- `data/raw/`
- `.env`
- request headers
- cookies
- copied `fetch` commands
- API tokens

Suggested commit message:

```text
Capture ROVO Studio config for <agent name>
```

## Local Git History And Rollback

This repo is useful as a local audit trail as soon as changes are committed. Git history lives in the local `.git` directory until the repo is pushed to a remote such as Bitbucket.

Use small checkpoint commits after each coherent governance operation:

```powershell
git status --short
git diff
git add README.md docs scripts config .env.example .gitignore
git commit -m "Publish governance Confluence drafts"
```

Do not add `.env`, `data/raw/`, or `config/confluence-pages.yml`.

Common local rollback paths:

| Need | Command | Notes |
|---|---|---|
| See recent history | `git log --oneline --decorate -10` | Shows local commits only. |
| See what changed in a commit | `git show <commit>` | Use before reverting. |
| Undo one committed change safely | `git revert <commit>` | Creates a new commit that reverses the old one. Preferred for auditability. |
| Restore one file from the last commit | `git restore <path>` | Use only for uncommitted changes you no longer want. |
| Compare current work to last commit | `git diff` | Useful before every publish or commit. |
| Tag a known-good checkpoint | `git tag local-good-YYYYMMDD` | Tags are local until pushed. |

For Confluence itself, Git can restore the repo draft and manifest state, but it does not automatically roll back the live page. To roll back a Confluence page, either use Confluence page history in the UI or publish a previous repo draft as a new page version after confirming the target page ID and planned version.

## Use The ROVO Improvement Plan

Before making structural Confluence updates, review:

```text
docs/rovo-space-improvement-plan.md
docs/implementation-backlog.md
docs/confluence-pages/
templates/confluence/
config/governance-labels.yml
config/confluence-pages.example.yml
```

Use `templates/confluence/` as reusable template source files. Use `docs/confluence-pages/` as page-ready drafts for the first governance pages. When a Confluence page is created or updated from a draft and the reusable structure changes, update the matching template too.

## Future Confluence API Setup

The repository is prepared for API-assisted publishing. Use `scripts/Publish-ConfluencePages.ps1` to dry-run or create configured pages from `config/confluence-pages.yml`.

Before running API publishing:

1. Copy `.env.example` to `.env`.
2. Set `ATLASSIAN_SITE`, `CONFLUENCE_API_BASE`, `CONFLUENCE_SPACE_KEY`, `ATLASSIAN_EMAIL`, and `ATLASSIAN_API_TOKEN`.
3. Copy `config/confluence-pages.example.yml` to `config/confluence-pages.yml`.
4. Fill in real `pageId` and `parentPageId` values once pages exist.
5. Keep `.env` and `config/confluence-pages.yml` out of Git.

Dry-run the configured page plan:

```powershell
.\scripts\Publish-ConfluencePages.ps1
```

Create missing pages only after reviewing the dry-run:

```powershell
.\scripts\Publish-ConfluencePages.ps1 -Apply
```

Dry-run an update for one existing page:

```powershell
.\scripts\Publish-ConfluencePages.ps1 `
  -Slug space-structure-and-navigation `
  -UpdateExisting
```

Apply an existing-page update only after reviewing the current and planned versions:

```powershell
.\scripts\Publish-ConfluencePages.ps1 `
  -Slug space-structure-and-navigation `
  -UpdateExisting `
  -Apply
```

The publisher creates missing pages, records returned page IDs in local `config/confluence-pages.yml`, and can update existing pages when `-UpdateExisting` is passed. Use `-Slug` when applying updates so only the intended page changes.

## First Confluence Changes To Make

1. Update `Space Structure and Navigation` so it matches the actual page tree.
2. Merge `Agent Inventory` and `Rovo Agent Inventory Home` by moving/archiving the legacy page rather than copying it, so page history is preserved.
3. Create `Backlog and Improvement Roadmap` from `templates/confluence/backlog-and-improvement-roadmap-template.md`.
4. Move CoP notes under Working Group Notes.
5. Add update-mode support to the Confluence publisher.
