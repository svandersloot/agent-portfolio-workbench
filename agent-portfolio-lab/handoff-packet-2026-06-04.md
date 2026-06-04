# Rovo Agent Portfolio Lab Handoff Packet - 2026-06-04

## Current State

The repository now includes a local-only `agent-portfolio-lab/` scaffold for designing, testing, and improving a coordinated Rovo release/Jira agent portfolio before manually transferring proven instructions into Confluence and Rovo Studio.

This lab does not connect to Jira, Confluence, Bitbucket, GitHub, Rovo, deployment systems, or publish scripts.

## Branch Context

| Field | Value |
| --- | --- |
| Branch | `codex/release-drift-pilot-tracking` |
| Upstream | `origin/codex/release-drift-pilot-tracking` |
| Prior HEAD before this lab commit | `b02767c Document Jira Work Item Assistant governance` |

## Implemented Lab Areas

| Area | Path | Purpose |
| --- | --- | --- |
| Lab overview | `agent-portfolio-lab/README.md` | Explains scope, operating rules, evidence labels, automation modeling, and evaluation. |
| Agent packages | `agent-portfolio-lab/reusable-core/agents/` | Reusable instructions for Jira Work Item Assistant, Release Drift Monitor, Release Health Analyst, and Release Notes Manager. |
| Portfolio rules | `agent-portfolio-lab/reusable-core/portfolio-rules/` | Evidence labels, routing, human-owned decisions, prohibited writes, triage taxonomy, and scoring. |
| Handoff contracts | `agent-portfolio-lab/reusable-core/handoff-contracts/` | Drift-to-health, health-to-work-item, work item draft bundle, health/drift-to-notes, and notes-to-health contracts. |
| Automation workflow modeling | `agent-portfolio-lab/reusable-core/automation-workflows/` | Non-executable daily drift/health report contracts, freshness/delta rules, safety gates, workflow review, and failure modes. |
| Team overlay | `agent-portfolio-lab/team-overlays/example-team/` | Placeholder-based example for team-specific Jira fields, naming, branches, sources, approvals, and cadence. |
| Manual promotion | `agent-portfolio-lab/manual-promotion/` | Templates for manual Confluence/Rovo Studio/workflow promotion reporting and parity checks. |
| Evals | `agent-portfolio-lab/evals/` | Manual test cases, golden CSV-compatible references, routing tests, and regression checklist. |
| Test runs | `agent-portfolio-lab/test-runs/` | Local manual run scaffolds for portfolio routing and daily delta automation. |
| Fixtures and exports | `agent-portfolio-lab/fixtures/`, `agent-portfolio-lab/exports/` | Sanitized fixture placeholders and manual export staging folders. |

## Manual Tests Already Run In Chat

| Test | Result | What It Proved |
| --- | --- | --- |
| `001-health-to-portfolio` | Pass, `5/5` | Basic portfolio routing, evidence labels, and human-owned decision guardrails are coherent. |
| `002-daily-delta-automation` | Pass, `5/5` | Repeated missing deployment notes are classified as `Still Open`, not `New`; Health Analyst does not mark release ready with incomplete deployment evidence. |

The test results were reported in chat only. The `actual.md`, `score.md`, and `findings.md` files remain templates unless manually filled later.

## Key Design Decisions

- The lab is a pre-production harness, not a deployment tool.
- Reusable core files use placeholders instead of team-specific values.
- Team-specific examples belong only in `team-overlays/` or sanitized fixtures.
- Daily report automation is modeled as contracts and review checklists only.
- Drift Monitor daily reports should emphasize deltas: `New`, `Still Open`, `Resolved`, `Changed`, and `Data Incomplete`.
- Health Analyst daily reports must consume drift but must not make final readiness or go/no-go decisions.
- Rovo Design Agent and Agent Doc Steward should remain out of the release operations portfolio for now and be considered later as a separate agent-enablement lane.

## Recommended Next Manual Rovo Steps

1. Manually update Release Drift Monitor instructions in Rovo Studio with:
   - `reusable-core/agents/release-drift-monitor/studio-instructions.md`
   - daily delta prompt from `reusable-core/agents/release-drift-monitor/prompt-library.md`
   - automation rules from `reusable-core/automation-workflows/daily-drift-report-contract.md`
   - freshness rules from `reusable-core/automation-workflows/report-freshness-and-delta-rules.md`

2. Manually update Release Health Analyst instructions in Rovo Studio with:
   - `reusable-core/agents/release-health-analyst/studio-instructions.md`
   - daily health prompt from `reusable-core/agents/release-health-analyst/prompt-library.md`
   - automation rules from `reusable-core/automation-workflows/daily-health-report-contract.md`
   - safety gates from `reusable-core/automation-workflows/automation-safety-gates.md`

3. Manually configure daily Drift Monitor and Health Analyst automation prompts, if desired, using:
   - `manual-promotion/automation-config-checklist.md`
   - `reusable-core/automation-workflows/workflow-configuration-review.md`

4. Run the same `002-daily-delta-automation` prompt inside Rovo Studio and compare behavior against:
   - `test-runs/002-daily-delta-automation/expected.md`
   - `manual-promotion/studio-parity-checklist.md`

## Expected Rovo Studio Parity Behavior

The Studio output does not need to match the lab wording exactly. It should match:

- same route
- same evidence labels
- same handoff shape
- same missing-data questions
- same human approval gates
- no prohibited writes
- no invented project, release, branch, owner, page, deployment, or Jira facts

## Open Manual Configuration Items

| Item | Status | Evidence |
| --- | --- | --- |
| Confluence pages updated with lab content | `UNKNOWN` | `Data Incomplete` |
| Release Drift Monitor Studio config updated | `UNKNOWN` | `Data Incomplete` |
| Release Health Analyst Studio config updated | `UNKNOWN` | `Data Incomplete` |
| Daily Drift Monitor automation configured | `UNKNOWN` | `Data Incomplete` |
| Daily Health Analyst automation configured | `UNKNOWN` | `Data Incomplete` |
| Studio parity test run | `UNKNOWN` | `Data Incomplete` |

## Resume Prompt For New Conversation

Use this prompt to continue:

```text
We are in C:\projects\rovo-governance-admin-toolkit on branch codex/release-drift-pilot-tracking. Continue from agent-portfolio-lab/handoff-packet-2026-06-04.md. The lab scaffold is local-only and includes reusable agent packages, portfolio rules, handoff contracts, automation workflow contracts, manual promotion templates, evals, and two manual test-run templates. Next priority is to help manually configure/test Release Drift Monitor and Release Health Analyst in Rovo Studio using the daily delta automation scenario, then review supplied Studio or automation config excerpts against the lab checklists. Do not run publish scripts or external writes unless explicitly requested.
```

## Guardrails To Preserve

- Do not publish Confluence pages from the lab.
- Do not configure live Rovo Studio from the lab.
- Do not create Jira issues or comments.
- Do not post PR comments.
- Do not run deployment automation.
- Do not claim manual publication/configuration status without user-provided or source-backed evidence.
