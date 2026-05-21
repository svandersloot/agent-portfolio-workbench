# ROVO Governance Admin Toolkit

Small, read-only-first tools for managing ROVO agent governance from Studio and Confluence exports.

The first workflow captures a Studio agent configuration response, normalizes it into reviewable Markdown/YAML, and lets Git show meaningful governance changes: instructions, subagents, knowledge sources, tools, web search, and activation state.

The second workflow turns ROVO space improvement plans into maintained Confluence-ready templates and implementation backlog items.

## Project Areas

- `scripts/`: local automation for Studio export normalization and future Confluence operations.
- `schemas/`: contracts for normalized config output.
- `templates/confluence/`: maintained source templates for governance pages.
- `docs/`: operator guidance, roadmap, improvement plan, and implementation backlog.
- `config/`: reusable governance config such as labels and tracked Studio agent list examples.
- `data/raw/`: local-only raw captures, ignored by Git.

## Current Workflow

### Studio Config Versioning

1. Open a ROVO Studio agent details page.
2. Run `scripts/studio-response-capture.js` in DevTools Console.
3. Refresh the Studio page.
4. Run `copyStudioAgentCaptures()` in DevTools Console.
5. Save the copied JSON to `data/raw/<agent-slug>.studio-response.json`.
6. Normalize it:

```powershell
.\scripts\Normalize-StudioExport.ps1 `
  -RawPath .\data\raw\improvements-to-design-agent.studio-response.json `
  -OutDir .\agents
```

7. Review the generated files under `agents/<agent-slug>/`.
8. Commit only the normalized files, docs, and scripts.

### ROVO Space Improvement Planning

The current ROVO audit is captured in:

- `docs/rovo-space-improvement-plan.md`
- `docs/implementation-backlog.md`
- `templates/confluence/`
- `config/governance-labels.yml`

The first five recommended actions are:

1. Merge the two inventory pages.
2. Create Measurement and Value Tracking.
3. Create Context Readiness Checklist.
4. Create User Guide - Designing Agents.
5. Move CoP notes under Working Group Notes and create the Backlog page.

## Why This Exists

Studio is the operational UI. Git should be the audit trail.

This toolkit helps answer:

- What changed in an agent?
- Did knowledge access broaden?
- Did a tool get added?
- Did a subagent become active or inactive?
- Are instructions drifting from governance standards?

## Safety Defaults

- Raw Studio responses are ignored by Git.
- The normalizer strips noisy GraphQL and UI implementation fields.
- No script writes back to Studio.
- No script uses browser cookies or request headers.
- API tokens belong only in local environment variables.

## Next Scripts To Add

- Confluence stale-reference cleanup dry run.
- Governance linter for normalized agent configs.
- Agent inventory sync report.
- Confluence page/template publisher with dry-run mode.
- Optional Chrome/browser capture once the manual capture workflow proves valuable.
