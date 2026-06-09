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

## Maintainability And Auditability Track

Before adding broader automation, make the repo easier for another builder to maintain and audit:

- Done locally: add `START-HERE.md` for common workflows and safe commit slices.
- Done locally: add page-family, source-link, and manifest consistency checks for governed agent artifacts.
- Done locally: add an owner, backup owner, readiness, measurement, and last-reviewed gap report template.
- Add stale-handoff detection so old packets do not silently become the operating source.
- Add no-secret/private-data scanning before commits or future CI.
- Keep completeness reporting field-level and evidence-based rather than percentage-based.

## Stage 5 Operating Model Track

Before expanding beyond one initial team, reframe the project as a lightweight ROVO agent factory and governance control plane:

- Done locally: separate the behind-the-scenes builder audience from normal ROVO agent users in `docs/stage-5-agent-factory-start-here.md`.
- Done locally: document the path from team pain point to approved ROVO agent, including lifecycle and promotion stages.
- Done locally: define a first-pilot approved/prohibited/escalate catalog in `docs/stage-5-pilot-boundaries.md`.
- Done locally: strengthen duplicate prevention through intake, inventory search, similar-agent comparison, and explicit reuse/improve/merge/reject/new decisions.
- Done locally: create manual pilot usage and feedback tracking in `templates/stage-5-pilot-feedback-tracker-template.md`.
- Done locally: define helper/contributor boundaries so one or two people can use Codex to draft specs, tests, templates, and promotion packets without changing live Studio, Jira, or Confluence state without approval.

The Stage 5 track should prove that a small builder group can create useful, approved, non-duplicative agents for a team while normal users only need the approved ROVO agents and lightweight feedback/escalation paths.

## Phase 5: Optional Capture Automation

- Use authenticated Chrome automation to visit configured Studio agent URLs.
- Capture matching GraphQL responses without storing headers or cookies.
- Normalize multiple agents in one run.

Do not build write-back to Studio until Atlassian exposes a stable supported API or the governance need clearly outweighs the risk.

## Future Claude Code Migration Lane

Track Claude Code migration as a separate future lane after the initial Stage 5 pilot model is stable. The migration plan should identify which repo-backed specs, checks, tests, and promotion records belong in Claude Code, what remains Confluence/Studio-facing, and what approval gate is required before any migration changes the operating model.

## Near-Term Backlog

See `docs/implementation-backlog.md` for the ROVO audit task breakdown. The highest-return items are:

1. Review the Stage 5 pilot promotion packet and select the first 1-2 pilot agents.
2. Run the Stage 5 pilot readiness review before any team promotion.
3. Extend governance maintainability checks with stale-handoff detection.
4. Add no-secret/private-data scanning and merge-readiness refresh checks.
5. Manually copy the published Design Agent guidance into ROVO Studio and capture normalized evidence.
6. Confirm Studio creation, edit/manager, and user-access controls with manual Studio/admin inspection.
