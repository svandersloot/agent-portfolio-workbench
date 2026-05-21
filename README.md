# ROVO Governance Admin Toolkit

Small, read-only-first tools for managing ROVO agent governance from Studio and Confluence exports.

The first workflow captures a Studio agent configuration response, normalizes it into reviewable Markdown/YAML, and lets Git show meaningful governance changes: instructions, subagents, knowledge sources, tools, web search, and activation state.

The second workflow turns ROVO space improvement plans into maintained Confluence-ready templates and implementation backlog items.

The long-term direction is a lightweight governance operating system: publish core governance pages safely, audit space health, check agent governance completeness, and produce human-facing reports that help builders reuse existing agents instead of creating duplicate work.

## Project Areas

- `scripts/`: local automation for Studio export normalization and future Confluence operations.
- `schemas/`: contracts for normalized config output.
- `templates/confluence/`: maintained source templates for governance pages.
- `docs/confluence-pages/`: page-ready governance drafts for publishing or manual creation in Confluence.
- `docs/`: operator guidance, roadmap, improvement plan, and implementation backlog.
- `config/`: reusable governance config such as labels, page publishing targets, and tracked Studio agent list examples.
- `data/raw/`: local-only raw captures, ignored by Git.

## Current Workflow

### Studio Config Versioning

1. Open a ROVO Studio agent details page.
2. Run `scripts/studio-response-capture.js` in DevTools Console.
3. Do not refresh the browser tab. Use Studio's in-app navigation to open a different agent or view, then return to the target agent so Studio fetches the details again.
4. Wait until the Console logs at least one captured Studio response.
5. Run `copyStudioAgentCaptures()` in DevTools Console.
6. Save the copied JSON to `data/raw/<agent-slug>.studio-response.json`.
7. Normalize it:

```powershell
.\scripts\Normalize-StudioExport.ps1 `
  -RawPath .\data\raw\improvements-to-design-agent.studio-response.json `
  -OutDir .\agents
```

8. Review the generated files under `agents/<agent-slug>/`.
9. Commit only the normalized files, docs, and scripts.

If Studio will not refetch through in-app navigation, use Chrome DevTools Network with Preserve log enabled, refresh the page, click through the editor panes/scenarios, and search Network responses for a unique phrase from the visible agent instructions, such as `You are the` plus the agent name. Copy the response body that contains the instruction text plus configuration fields such as `knowledgeSources` or `conversationStarters`. A response with only agent/scenario names is a partial shell and is not enough for normalization. If you need to export a HAR, run `scripts/Extract-StudioResponsesFromHar.ps1` first so the raw capture is reduced to just the Studio agent responses before normalization:

Some Studio responses include parent instructions and scenario routing but omit full subagent instructions. Those are still useful; the normalizer records the captured fields and marks omitted subagent instructions as not captured.

```powershell
.\scripts\Inspect-StudioHar.ps1 `
  -HarPath .\data\raw\improvements-to-design-agent.studio-response.har

.\scripts\Extract-StudioResponsesFromHar.ps1 `
  -HarPath .\data\raw\improvements-to-design-agent.studio-response.har `
  -OutPath .\data\raw\improvements-to-design-agent.studio-response.json
```

### ROVO Space Improvement Planning

The current ROVO audit is captured in:

- `docs/rovo-space-improvement-plan.md`
- `docs/toolkit-operating-model.md`
- `docs/implementation-backlog.md`
- `docs/confluence-pages/`
- `templates/confluence/`
- `config/governance-labels.yml`

Completed slash goal:

```text
/goal Create the Governance and Safety Confluence section under Agent Governance Home, then create Measurement and Value Tracking, Context Readiness Checklist, and User Guide - Designing Agents under it from the finalized repo drafts, using an API dry-run before any write.
```

The finalized page drafts are:

1. `docs/confluence-pages/governance-and-safety.md`
2. `docs/confluence-pages/measurement-and-value-tracking.md`
3. `docs/confluence-pages/context-readiness-checklist.md`
4. `docs/confluence-pages/user-guide-designing-agents.md`

Completed Confluence pages:

1. `Governance and Safety`
2. `Measurement and Value Tracking`
3. `Context Readiness Checklist`
4. `User Guide - Designing Agents`

The next recommended actions are:

1. Merge the two inventory pages.
2. Move CoP notes under Working Group Notes and create the Backlog page.
3. Use the publisher update-mode for future page refreshes.
4. Continue inventory cleanup.

## Why This Exists

Studio is the operational UI. Git should be the audit trail.

This toolkit helps answer:

- What changed in an agent?
- Did knowledge access broaden?
- Did a tool get added?
- Did a subagent become active or inactive?
- Are instructions drifting from governance standards?
- Does each governed agent have an owner, status, measurement plan, readiness evidence, and Project Brain?
- Which existing agent or pattern should a builder reuse before creating something new?

## Safety Defaults

- Raw Studio responses are ignored by Git.
- The normalizer strips noisy GraphQL and UI implementation fields.
- No script writes back to Studio.
- No script uses browser cookies or request headers.
- API tokens belong only in local environment variables.

## Next Scripts To Add

- Confluence stale-reference cleanup dry run.
- Publish history records for page updates.
- Governance linter for normalized agent configs.
- Agent governance completeness report.
- Agent inventory sync report.
- Confluence page/template publisher update mode.
- API-assisted page move and legacy banner workflow for inventory cleanup.
- Optional Chrome/browser capture once the manual capture workflow proves valuable.
