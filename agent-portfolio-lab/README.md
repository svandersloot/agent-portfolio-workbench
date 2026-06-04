# Rovo Agent Portfolio Lab

This lab is a local-only workspace for simulating, testing, and improving a coordinated Rovo release and Jira agent portfolio before proven instructions are manually transferred into Confluence and Rovo Studio.

The lab does not connect to Jira, Confluence, Bitbucket, GitHub, Rovo, deployment systems, or publish scripts. All examples are Markdown or CSV-ready references intended for manual review.

## Portfolio

- `jira-work-item-assistant`: triages release findings and drafts human-reviewed Jira work item bundles.
- `release-drift-monitor`: compares supplied release signals and identifies drift, gaps, and stale assumptions.
- `release-health-analyst`: summarizes readiness from supplied evidence and routes follow-up work.
- `release-notes-manager`: drafts release-note candidates from supplied notes, health findings, and approved context.

New agents should be added as `reusable-core/agents/[agent-slug]/` with the same package files:

- `identity.md`
- `studio-instructions.md`
- `boundaries.md`
- `prompt-library.md`
- `eval-rubric.md`

## Directory Map

- `reusable-core/agents/`: reusable base agent packages without team-specific values.
- `reusable-core/portfolio-rules/`: shared evidence, routing, scoring, and write-safety rules.
- `reusable-core/handoff-contracts/`: handoff shapes between portfolio agents.
- `reusable-core/automation-workflows/`: non-executable daily report contracts, safety gates, and workflow review criteria.
- `manual-promotion/`: templates for reporting manual Confluence, Rovo Studio, and automation configuration work.
- `team-overlays/example-team/`: example placeholders for team-specific conventions.
- `fixtures/sanitized/`: sanitized example inputs safe to commit.
- `fixtures/local-private/`: ignored-style working area for private local material; do not commit sensitive data.
- `evals/`: manual Markdown and CSV-compatible evaluation references.
- `test-runs/`: local run records that compare prompt, expected result, actual result, score, and findings.
- `exports/`: staging folders for manually prepared Confluence, Rovo Studio, or eval CSV copy blocks.

## Operating Rules

Use placeholders in reusable core content, including `[release name]`, `[fixVersion]`, `[source-truth branch]`, `[Jira project]`, `[Confluence page]`, `[release owner]`, `[QA lead]`, `[dev lead]`, `[deployment notes source]`, `[release notes source]`, `[approval workflow]`, and `[team overlay]`.

Team-specific values belong only in `team-overlays/` or sanitized fixtures. Do not hardcode company names, team names, Jira project keys, fixVersions, branch names, Confluence page IDs, internal URLs, owner names, or deployment windows in reusable core files.

Default outputs should stay short and operational:

- action tables
- top actions
- evidence-labeled questions
- handoff blocks

## Evidence Labels

Every claim, recommendation, and drafted output should carry one of these labels:

- `Source-backed`
- `User-provided`
- `Inferred from supplied context`
- `Data Incomplete`
- `UNKNOWN`

## Human-Owned Decisions

Agents may prepare analysis and drafts, but humans own final decisions for release readiness, go/no-go, release approval, release-note publication, Jira creation, Jira comment posting, Confluence publication, PR comments, deployment record updates, deployment execution, and exception acceptance.

## Automation Workflow Modeling

Automation workflow files in this lab are contracts and review checklists only. They may describe daily Drift Monitor and Health Analyst reports, freshness rules, delta behavior, failure modes, and human approval gates. They must not define runnable jobs, schedules, connectors, webhooks, or external writes.

Daily reports should default to short deltas:

- top 3 actions
- new since prior snapshot
- still open
- resolved
- evidence gaps
- handoff blocks

Manual publication, Rovo Studio configuration, and automation workflow setup remain outside the lab and must be tracked as `User-provided`, `Source-backed`, `Data Incomplete`, or `UNKNOWN`.

## Evaluation

The first slice is manual and file-based. Use Markdown test cases and CSV-compatible `prompt,expected_result` references. Include routing tests, handoff tests, guardrail tests, and regression checks. Do not add automation that calls external systems.
