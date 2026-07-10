# Agent Portfolio Workbench

Git-backed, read-only-first workbench for designing, evaluating, governing, and operating AI agent portfolios across team workflows.

## Quick Start

New contributors should use the Atlassian MCP path first for Jira and Confluence context, the work GitHub identity for source control, and the local `.env` path only when a script explicitly requires direct API access. See [CONTRIBUTING.md](CONTRIBUTING.md) for the complete setup and [docs/mcp-setup.md](docs/mcp-setup.md) for MCP-specific guidance.

Start by reading `AGENTS.md`, `README.md`, `START-HERE.md`, and `docs/toolkit-operating-model.md`. Then run the read-only checks in the contributor guide before opening a branch or pull request.

## Project Areas

- `AGENTS.md`: operating contract for AI-assisted work in this repository.
- `START-HERE.md`: entry point for portfolio workflows, safety boundaries, checks, and commit slices.
- `CONTRIBUTING.md`: MCP-first contributor setup, work-account GitHub fallback, direct-API fallback, validation, and PR expectations.
- `docs/mcp-setup.md`: Atlassian MCP registration, OAuth, troubleshooting, and write boundaries.
- `scripts/`: local automation for direct-API dry-runs, document checks, and sanitized evidence normalization.
- `schemas/`: contracts for normalized and governed output.
- `templates/`: maintained source templates for human-facing documentation and pilot artifacts.
- `docs/`: operator guidance, research, roadmaps, handoffs, reports, and durable governance records.
- `agent-portfolio-lab/`: reusable agent and automation patterns, team overlays, handoffs, fixtures, and manual evaluation workspace.
- `.github/`: validation workflow, code ownership, and pull-request review prompts.
- `data/raw/`: local-only raw captures and unsanitized exports, ignored by Git.

## Current Operating Model

Use this repository for durable design, evidence, evaluation, measurement, governance, and operational handoff artifacts. Use permission-scoped connectors and the relevant live delivery platforms for current context and runtime execution, with human approval gates for any write or access change.

Agent Portfolio Workbench is the builder-facing governance and evidence layer above those runtimes. Confluence is the human-facing portal for approved guidance, inventory views, reports, and navigation; the configured runtime remains authoritative for the behavior that actually runs.

The workbench supports a reusable portfolio lifecycle:

1. Shape a problem and check for an existing agent, automation, template, or other reusable pattern.
2. Create the smallest durable design and governance record when the need is real.
3. Prepare evaluations, measurement, context-readiness, and handoff evidence.
4. Review changes in Git and run the repository checks.
5. Apply approved runtime or documentation changes manually or through a focused, auditable workflow.
6. Keep the repository record aligned with the live system without treating chat history or unsanitized exports as source of truth.

The canonical positioning and audience model is in `docs/agent-portfolio-workbench-positioning.md`. The planned Confluence human-facing entry point is `docs/confluence-pages/agent-portfolio-overview.md`.

Use `docs/next-slash-goals.md` for the current actionable queue, `docs/implementation-backlog.md` for backlog sequencing, and `docs/roadmap.md` for longer-term direction. These files, not this README, are the planning surfaces.

## Governance Front Door

The current local governance front door is defined in:

- `docs/confluence-pages/agent-fit-intake.md`
- `docs/agent-governance-completeness-contract.md`
- `schemas/agent-governance-record.schema.json`
- `docs/stage-5-agent-factory-start-here.md`
- `docs/stage-5-pilot-boundaries.md`
- `docs/stage-5-contributor-helper-guide.md`
- `templates/stage-5-pilot-feedback-tracker-template.md`
- `templates/stage-5-pilot-promotion-packet-template.md`

Use the relevant design record, knowledge-source plan, runtime contract, evaluation, measurement plan, setup guidance, change log, and handoff artifacts for the portfolio item being changed. Run `.\scripts\Test-ConfluencePageFamilyConsistency.ps1` before committing governed page families or publish plans.

## Why This Exists

Operational platforms are where agents, automations, and workflows run. Git should be the audit trail for the durable decisions and evidence around them.

This workbench helps answer:

- What changed in an agent, automation, workflow, or governance record?
- Did knowledge access, tools, permissions, or behavior broaden?
- Does the portfolio item have an owner, status, measurement plan, readiness evidence, and durable design record?
- Which existing solution or pattern should a builder reuse before creating something new?
- Which changes are draft, experimental, blocked, or ready for a human decision?

## Safety Defaults

- Raw captures, unsanitized exports, and private operational overlays are ignored by Git.
- No repository script writes directly to a live delivery platform without an explicit, focused workflow.
- No repository script uses browser cookies or request headers as credentials.
- API tokens belong only in local environment variables and never in prompts, issues, pull requests, or tracked files.
- Read-first and dry-run-first behavior is the default; write capability never implies approval authority.

## Current Maintenance Direction

Keep new maintenance work aligned with the active queue and evidence already in the repository. Prefer small reviewable slices, update companion artifacts when a durable decision changes, and record manual gates or unresolved human decisions plainly in the handoff or pull request.
