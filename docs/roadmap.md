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
- Done locally: define the non-negotiable governance fields for every governed ROVO agent in `docs/agent-governance-completeness-contract.md` and `schemas/agent-governance-record.schema.json`.
- Done locally: define lifecycle statuses: Idea, Draft, In Review, Experimental, Active, Needs Remediation, and Deprecated.
- Local read-only Studio visibility investigation completed from repo/export evidence; manual Studio/admin confirmation is still required.
- Current public ROVO Studio guidance supports manual/admin creation, edit, manager, and individual user-access controls; group/team-based agent access restriction is not currently supported.
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
- Started: generate human-facing reports for new agents, duplicate candidates, governance gaps, stale pages, and recent page updates.
- Started: generate a monthly governance snapshot for leadership and interested builders.
- Done locally: maintain a monthly governance snapshot template for leadership and builders.
- Use field-level completeness reporting rather than percentage scores.
- Do not create a separate quarterly review template unless leadership asks for a distinct quarterly cadence.
- Produce builder-facing "what already exists" summaries before new agent work begins.

## Phase 5: Optional Capture Automation

- Use authenticated Chrome automation to visit configured Studio agent URLs.
- Capture matching GraphQL responses without storing headers or cookies.
- Normalize multiple agents in one run.

Do not build write-back to Studio until Atlassian exposes a stable supported API or the governance need clearly outweighs the risk.

## Near-Term Backlog

See `docs/implementation-backlog.md` for the ROVO audit task breakdown. The highest-return items are:

1. Manually copy the published Design Agent guidance into ROVO Studio and capture normalized evidence.
2. Confirm Studio creation, edit/manager, and user-access controls with manual Studio/admin inspection.
3. Make the completeness, duplicate-agent, and monthly snapshot reports repeatable.
4. Compare duplicate page bodies before any legacy-banner, archive, move, or reparent action.
5. Move CoP notes and Formatting Standards with supported Confluence move/manual process.
6. Publish/create Known Risks and Admin and Owner Guide only through focused dry-run and approval.
