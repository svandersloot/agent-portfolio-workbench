# Operator Guide

This guide is for the person maintaining the ROVO governance space and agent library.

## Capture A Studio Agent

1. Open the target agent in ROVO Studio.
2. Open DevTools.
3. Go to Console.
4. Paste the contents of `scripts/studio-response-capture.js`.
5. Refresh the Studio page.
6. Wait until the page has loaded.
7. Run:

```js
copyStudioAgentCaptures()
```

8. Save the copied JSON to:

```text
data/raw/<agent-slug>.studio-response.json
```

Raw files are ignored by Git because they may contain internal IDs and private URLs.

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

## Use The ROVO Improvement Plan

Before making structural Confluence updates, review:

```text
docs/rovo-space-improvement-plan.md
docs/implementation-backlog.md
templates/confluence/
config/governance-labels.yml
```

Use the templates as maintained source files. When a Confluence page is created or updated from a template, update the source template first if the page structure changes.

## First Confluence Changes To Make

1. Merge `Agent Inventory` and `Rovo Agent Inventory Home`.
2. Create `Measurement and Value Tracking` from `templates/confluence/measurement-and-value-tracking-template.md`.
3. Create `Context Readiness Checklist` from `templates/confluence/context-readiness-checklist-template.md`.
4. Create `User Guide - Designing Agents` from `templates/confluence/user-guide-designing-agents-template.md`.
5. Create `Backlog and Improvement Roadmap` from `templates/confluence/backlog-and-improvement-roadmap-template.md`.
