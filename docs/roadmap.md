# Roadmap

## Phase 1: Read-Only Version Control

- Capture Studio responses manually with the DevTools snippet.
- Normalize responses into Markdown/YAML.
- Review changes with Git diffs.
- Keep raw captures out of Git.
- Maintain Confluence-ready governance templates as source artifacts.
- Preserve the ROVO space improvement plan and implementation backlog before repo initialization.

## Phase 2: Governance Checks

- Lint normalized configs for risky changes.
- Flag broad knowledge sources.
- Flag high-risk tools without approval language.
- Flag inactive default routing issues.
- Compare Studio config against Confluence `Rovo Studio Configuration` pages.

## Phase 3: Confluence Operations

- Dry-run stale-reference cleanup.
- Apply approved `IQS` to `ROVO` text updates through Confluence REST API.
- Append change-log entries to agent governance pages.
- Sync central Agent Inventory from normalized configs.
- Publish approved templates to Confluence with explicit dry-run and apply modes.
- Use update-mode support for already-created Confluence pages.
- Generate page creation plans for Measurement, Context Readiness, Decision Log, User Guide, and Backlog pages.
- Move/reparent legacy inventory pages and apply archive banners through the API while preserving page identity and history.

## Phase 4: Optional Capture Automation

- Use authenticated Chrome automation to visit configured Studio agent URLs.
- Capture matching GraphQL responses without storing headers or cookies.
- Normalize multiple agents in one run.

Do not build write-back to Studio until Atlassian exposes a stable supported API or the governance need clearly outweighs the risk.

## Near-Term Backlog

See `docs/implementation-backlog.md` for the ROVO audit task breakdown. The highest-return items are:

1. Merge inventory pages.
2. Move CoP notes and create Backlog and Improvement Roadmap.
3. Use publisher update-mode for future page refreshes.
4. Prepare inventory cleanup dry run.
