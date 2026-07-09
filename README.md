# Agent Portfolio Workbench

Git-backed, read-only-first workbench for designing, evaluating, governing, and operating AI agent portfolios across team workflows.

The first workflow captures a Studio agent configuration response, normalizes it into reviewable Markdown/YAML, and lets Git show meaningful governance changes: instructions, subagents, knowledge sources, tools, web search, and activation state.

The second workflow turns ROVO space improvement plans into maintained Confluence-ready templates and implementation backlog items.

The long-term direction is a lightweight agent portfolio operating system: publish durable governance pages safely, audit workspace health, check agent completeness, evaluate reusable agent and automation patterns, and produce human-facing reports that help builders reuse existing solutions instead of creating duplicate work.

## Project Areas

- `AGENTS.md`: operating contract for Codex and other AI-assisted repo work.
- `START-HERE.md`: entry point for common portfolio workflows, safety boundaries, checks, and commit slices.
- `scripts/`: local automation for Studio export normalization and future Confluence operations.
- `schemas/`: contracts for normalized config output.
- `templates/confluence/`: maintained source templates for governance pages.
- `docs/confluence-pages/`: page-ready governance drafts for publishing or manual creation in Confluence.
- `docs/`: operator guidance, roadmap, improvement plan, and implementation backlog.
- `docs/reports/`: local dry-run reports and governance snapshots.
- `config/`: reusable portfolio and governance config such as labels, page publishing targets, and tracked Studio agent list examples.
- `agent-portfolio-lab/`: local-only reusable-core, team-overlay, handoff, fixture, export, and manual evaluation workspace for coordinated release/Jira agent portfolio testing.
- `docs/stage-5-agent-factory-start-here.md`: repo-backed start-here for the first team pilot of the ROVO agent factory/control-plane model.
- `schemas/agent-governance-record.schema.json`: first structured contract for governed agent completeness.
- `data/raw/`: local-only raw captures, ignored by Git.

## Current Workflow

For AI-assisted planning or implementation, start with `AGENTS.md`, then use `START-HERE.md` and the task-specific source docs. Keep ROVO Studio and Jira manual-only, and use Confluence dry-runs before any approved publish or update.

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
5. `Agent Fit Intake`

The current governance front door is defined locally in:

- `docs/confluence-pages/agent-fit-intake.md`
- `docs/agent-governance-completeness-contract.md`
- `schemas/agent-governance-record.schema.json`
- `docs/stage-5-agent-factory-start-here.md`
- `docs/stage-5-pilot-boundaries.md`
- `docs/stage-5-contributor-helper-guide.md`
- `templates/stage-5-pilot-feedback-tracker-template.md`
- `templates/stage-5-pilot-promotion-packet-template.md`
- `templates/confluence/monthly-governance-snapshot-template.md`
- `docs/studio-visibility-team-assignment-investigation-checklist.md`

The current read-only reports are:

- `docs/reports/inventory-cleanup-dry-run.md`
- `docs/reports/studio-visibility-team-assignment-investigation.md`
- `docs/reports/governance-completeness-dry-run.md`
- `docs/reports/duplicate-agent-discovery-dry-run.md`
- `docs/reports/monthly-governance-snapshot-2026-05.md`
- `docs/reports/page-family-source-link-consistency-checklist.md`
- `docs/reports/owner-readiness-gap-report-template.md`

Builder pattern:

- Use Codex and this repo as the fast workbench for agent ideas, Project Brain scaffolding, Confluence-ready docs, evaluations, measurement plans, and ROVO Studio configuration copy blocks.
- Use ROVO Studio as the Atlassian-facing runtime where the final configuration is copied manually.
- Capture Studio configuration back into this repo for version control and drift review.
- For Stage 5, use this repo as the behind-the-scenes control plane while normal pilot users consume approved agents through Jira, Confluence, and ROVO/Studio workflows.

Use `docs/next-slash-goals.md` for the current actionable queue. It keeps the active top queue, repo-only follow-ups, manual Studio gates, Confluence dry-run items, superseded goals, and completed history in one place so README does not drift into a second planning surface.

Run `.\scripts\Test-ConfluencePageFamilyConsistency.ps1` before committing governed-agent page families or Confluence publish plans.

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
- Agent inventory sync report.
- Confluence page/template publisher update mode.
- API-assisted page move and legacy banner workflow for inventory cleanup.
- Optional Chrome/browser capture once the manual capture workflow proves valuable.
