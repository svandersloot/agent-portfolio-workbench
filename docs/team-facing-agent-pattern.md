# Team-Facing Agent Full Pattern

## Status And Ownership

| Field | Value |
|---|---|
| Status | Draft for governance review |
| Primary owner | Shayne Vandersloot |
| Backup owner | Needed; assign before this pattern gates a team promotion |
| Applies to | Team-facing ROVO, Copilot, or similar governed agents, with a lightweight variant for personal, one-off, or low-risk helpers |
| Last reviewed | 2026-07-07 |
| Source basis | `AGENTS.md`, `START-HERE.md`, `docs/toolkit-operating-model.md`, `docs/stage-5-agent-factory-start-here.md`, `docs/confluence-pages/agent-bootstrap-pattern.md`, `docs/confluence-pages/rovo-studio-configuration-field-guide.md`, `docs/reports/runtime-context-map-agent-lab-evaluation-2026-06-11.md` |

## Purpose

Most agents this project plans to build are team-facing: other people rely on their output for real work. Team-facing agents therefore need the fuller agentic development package so risk is reduced before team use, without forcing normal users to learn this repo.

This page defines two variants:

1. A default **full package** for team-facing agents.
2. A clearly separated **lightweight variant** for personal, one-off, or low-risk helpers.

It also separates the kinds of evidence a governed agent needs, so builders do not confuse runtime behavior with setup, governance, evaluation, or promotion evidence.

## Truthful Pitch Framing

Keep the executive and pitch story high-level and accurate.

- ROVO is the user-facing runtime today. Team members consume approved agents through Jira, Confluence, and ROVO/Studio workflows.
- The Agent Lab and this repo are the **proposed approved workshop and control layer** for faster governed development. This is a recommended operating model, not already-official enterprise infrastructure.
- The repo holds the durable specs, context maps, guardrails, evaluations, and promotion evidence. ROVO Studio holds the manually configured runtime.
- Do not claim any Runtime Context Map, guardrail set, or knowledge source plan is live in Studio. It becomes live only after a human manually configures Studio and a parity check confirms it.

Evidence label: the "proposed approved workshop/control layer" framing is `Source-backed` by `docs/stage-5-agent-factory-start-here.md` (control-plane model) and `docs/toolkit-operating-model.md` (Codex-to-ROVO build pipeline). Whether leadership has formally approved it as standard infrastructure is `UNKNOWN` from repo evidence, so pitch wording must stay proposal-level.

## Evidence Layers

A team-facing agent produces evidence in five distinct layers. Keep them separate; do not let one page try to be all five.

| Layer | Question it answers | Primary artifacts | Primary audience |
|---|---|---|---|
| Runtime context | How should the agent behave, route, and source at run time? | Runtime contract, Runtime Context Map, guardrails | Agent and human reviewer |
| Setup | How is the runtime wired into Studio? | Studio setup page, thin bootstrap, knowledge source plan | Human configuring Studio |
| Governance | Who owns it, what status is it, how is value measured, what changed? | Owner/backup owner, measurement plan, change log | Owner, reviewer, manager |
| Evaluation | Does it behave correctly and safely against known prompts? | Evaluation prompt pack, pass/partial/fail results | Owner and stakeholder reviewer |
| Promotion | Is it safe to promote to the named team, and does Studio match the source? | Studio promotion packet, post-Studio parity check | Reviewer/manager and agent owner |

Runtime context is not setup. The runtime/source page tells the agent how to behave; the setup page tells a human how to wire Studio. Do not make an agent depend on a setup page as its behavior source (see `docs/confluence-pages/agent-bootstrap-pattern.md`).

## Default Full Package For Team-Facing Agents

A team-facing agent should have all of the following before team promotion. Each row names the layer so builders can see what kind of evidence it is.

| # | Package element | Layer | What it must contain | Where it lives |
|---|---|---|---|---|
| 1 | Runtime contract | Runtime context | Agent identity, job-to-be-done, routing boundaries, authoritative sources, fallback behavior when a source is unavailable, human-approval and write-action boundaries, tool/skill stance. Kept thin. | Runtime/source Confluence page; thin bootstrap copied to Studio |
| 2 | Runtime Context Map | Runtime context | Compact table of task intent, source to use first, forbidden substitutes, fallback behavior, and smoke-test prompt. | Knowledge source plan page for the agent |
| 3 | Guardrails | Runtime context | Human-owned decisions, prohibited writes, evidence-label requirement, source-failure behavior, and refusal of forbidden substitutes. | Runtime/source page plus guardrail rules |
| 4 | Knowledge source plan | Setup | Authoritative sources, reference-only sources, forbidden substitutes, coverage by source type (Confluence content/space, Jira project/space), and fallback plan. | `*-knowledge-source-plan.md` |
| 5 | Evaluation prompt pack | Evaluation | Source verification, fallback trap, unsafe-write trap, and two to three behavior regressions, each with explicit pass/partial/fail criteria. | `*-evaluation.md` |
| 6 | Studio promotion packet | Promotion | Pilot audience, approved workflows, review gates, test evidence, metrics plan, feedback channel, and go/no-go criteria. | Based on `templates/stage-5-pilot-promotion-packet-template.md` |
| 7 | Owner and backup owner | Governance | Named accountable owner and a backup owner, or an explicit gap owner until one is assigned. | Project Brain / status block |
| 8 | Measurement | Governance | How value and risk are tracked: usage, time-saved estimate, accepted/edited/rejected outputs, review issues, unsafe outputs. | Measurement plan; `templates/stage-5-pilot-feedback-tracker-template.md` |
| 9 | Change log | Governance | Dated record of durable behavior, source, guardrail, and status changes. | `*-change-log.md` |
| 10 | Post-Studio parity check | Promotion | Confirmation that the manually configured Studio agent matches the source: routing, evidence labels, handoff shape, missing-data questions, approval gates, prohibited-write behavior. | Based on `agent-portfolio-lab/manual-promotion/studio-parity-checklist.md` |

Owner and backup owner assignment, `Active`/broadly `Ready` status, and pilot/team promotion remain human-owned decisions. This pattern prepares the evidence; it does not grant approval.

### Element Notes

- **Runtime contract and Runtime Context Map are related but distinct.** The contract is the thin identity and boundary statement. The map is the source-routing table that prevents forbidden substitutes and defines fallback. The Runtime Context Map pilot (`docs/reports/runtime-context-map-agent-lab-evaluation-2026-06-11.md`) improved source-routing clarity for two agents at the artifact level only; live behavior was not run.
- **Guardrails are runtime context, not governance paperwork.** They shape what the agent does at run time: refuse forbidden substitutes, mark missing data, keep decisions human-owned, and never perform unapproved writes.
- **Evaluation is not promotion.** A passing prompt pack is input to a promotion decision, not the decision itself.
- **The parity check closes the loop.** Because this repo never writes to Studio, the only way a Runtime Context Map or guardrail becomes trustworthy in the runtime is a human Studio save followed by a parity check. Until then, treat the runtime as unverified.

## Lightweight Variant For Personal, One-Off, Or Low-Risk Helpers

This variant is deliberately separate from the full package. Use it when an agent is personal, single-use, exploratory, or clearly low-risk, and is not being promoted to a team.

A helper qualifies for the lightweight variant only when all of these hold:

- Audience is the builder or a very small trusted group, not a broader team.
- It is a one-off, prototype, or low-frequency helper.
- It performs no unapproved writes to Jira, Confluence, or Studio and touches no privacy-sensitive or high-blast-radius data.
- It does not imply governance approval, readiness, ownership, or status for anyone else.

Minimum lightweight package:

| # | Element | Requirement |
|---|---|---|
| 1 | Purpose and audience note | One or two lines: what it does and who uses it. |
| 2 | Thin runtime contract | Identity, job-to-be-done, and source-failure behavior. |
| 3 | Core guardrails | Human-owned decisions, no unapproved writes, evidence labels, mark unknowns as `Data Incomplete`/`UNKNOWN`. |
| 4 | Owner | Named owner; backup owner optional while it stays personal. |
| 5 | Smoke check | At least one prompt the builder can rerun to confirm sane behavior. |

Deferred for the lightweight variant unless it is promoted: full evaluation prompt pack, Studio promotion packet, measurement plan, change log, and formal parity check.

### Promotion Trigger

If a lightweight helper starts serving a team, gains write capability, touches sensitive data, or begins implying readiness or approval for others, stop and upgrade it to the full package before team use. Crossing any lightweight boundary above is the trigger, not a calendar date.

## Choosing The Variant

| Signal | Variant |
|---|---|
| Other people depend on the output for real work | Full package |
| Any write, transition, comment, or publish path exists or is planned | Full package |
| Sensitive data, broad discoverability, or approval-implying behavior | Full package |
| Personal or tiny-group, one-off or prototype, read-only, low blast radius | Lightweight variant |
| Uncertain | Default to the full package; document why if you choose lightweight |

## Boundaries And Assumptions

- This is repo-only documentation. It performs no writes to ROVO Studio, Jira, or Confluence and does not authorize any.
- No Runtime Context Map, guardrail set, or knowledge source plan described here is claimed live in Studio. Live status requires a human Studio configuration plus a passing parity check.
- Evidence label: the ten-element full package is `Source-backed` by existing repo artifacts (bootstrap pattern, field guide, Stage 5 lifecycle/promotion stages, Runtime Context Map pilot, evaluation prompt packs, feedback and promotion templates, parity checklist). The lightweight variant's exact thresholds are a proposed default; confirm with the governance steward before treating them as policy.
- Owner, backup owner, status, visibility, and promotion remain human-owned decisions. This page does not mark any agent `Active`, `Ready`, or approved.

## Follow-Ups

- Assign a backup owner for this pattern before it gates a team promotion.
- Consider a Confluence-published version for team-facing audiences once the shape is reviewed; keep it repo-backed and dry-run-first.
- Consider a short checklist companion (full vs lightweight) if builders need a one-page decision aid.
