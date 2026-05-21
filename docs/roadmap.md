# Roadmap

## Phase 1: Read-Only Version Control

- Capture Studio responses manually with the DevTools snippet.
- Normalize responses into Markdown/YAML.
- Review changes with Git diffs.
- Keep raw captures out of Git.
- Maintain Confluence-ready governance templates as source artifacts.
- Preserve the ROVO space improvement plan and implementation backlog before repo initialization.

## Phase 2: Governance Checks

- Define the Agent Fit Intake contract.
- Define the non-negotiable governance fields for every governed ROVO agent.
- Define lifecycle statuses: Idea, Draft, In Review, Experimental, Active, Needs Remediation, and Deprecated.
- Investigate Studio team assignment and discoverability controls for draft and experimental agents.
- Lint normalized configs for risky changes.
- Flag broad knowledge sources.
- Flag high-risk tools without approval language.
- Flag inactive default routing issues.
- Flag missing owner, status, measurement plan, readiness evidence, Project Brain link, or last-reviewed date.
- Compare Studio config against Confluence `Rovo Studio Configuration` pages.

## Phase 3: Confluence Operations

- Dry-run stale-reference cleanup.
- Apply approved `IQS` to `ROVO` text updates through Confluence REST API.
- Append change-log entries to agent governance pages.
- Sync central Agent Inventory from normalized configs.
- Publish approved templates to Confluence with explicit dry-run and apply modes.
- Use update-mode support for already-created Confluence pages.
- Write local publish-history records with page ID, old version, new version, source file, command, and verification result.
- Generate page creation plans for Measurement, Context Readiness, Decision Log, User Guide, and Backlog pages.
- Move/reparent legacy inventory pages and apply archive banners through the API while preserving page identity and history.

## Phase 4: Inventory And Reporting

- Move toward a hybrid inventory where Confluence remains human-readable and a structured local inventory file supports checks and reports.
- Generate human-facing reports for new agents, duplicate candidates, governance gaps, stale pages, and recent page updates.
- Generate a monthly governance snapshot for leadership and interested builders.
- Produce builder-facing "what already exists" summaries before new agent work begins.

## Phase 5: Optional Capture Automation

- Use authenticated Chrome automation to visit configured Studio agent URLs.
- Capture matching GraphQL responses without storing headers or cookies.
- Normalize multiple agents in one run.

Do not build write-back to Studio until Atlassian exposes a stable supported API or the governance need clearly outweighs the risk.

## Near-Term Backlog

See `docs/implementation-backlog.md` for the ROVO audit task breakdown. The highest-return items are:

1. Merge inventory pages.
2. Move CoP notes and create Backlog and Improvement Roadmap.
3. Update the ROVO Design Agent flow to use Agent Fit Intake.
4. Investigate Studio team assignment and discoverability controls.
5. Design the monthly governance snapshot.
6. Define the first structured agent inventory/completeness contract.
