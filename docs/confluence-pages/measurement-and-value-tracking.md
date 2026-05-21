# Measurement and Value Tracking

## Purpose

Use this page to define how the ROVO agent portfolio measures value, quality, adoption, and governance health. The goal is not perfect analytics on day one; the goal is enough evidence to make better decisions about which agents to keep, improve, consolidate, or retire.

## Measurement Principles

- Measure value, not novelty.
- Prefer directional evidence over no evidence.
- Keep owner estimates visible when system analytics are unavailable.
- Track both efficiency and quality.
- Review measurement during launch, lifecycle reviews, and retirement decisions.
- Treat missing measurement as a governance gap, not a blocker for every small experiment.

## Portfolio Metrics

| Metric | Definition | Source | Cadence | Owner |
|---|---|---|---|---|
| Adoption | Number of active users, meaningful uses, or owner-estimated uses during the period | Studio analytics, owner estimate, survey, support channel signals | Monthly | Agent owner |
| Time saved | Estimated minutes saved per successful use or per workflow cycle | Owner estimate, user survey, before/after sampling | Monthly | Agent owner |
| Quality improvement | Reduction in missing information, defects, review comments, or incomplete handoffs | Jira, Confluence review, reviewer sample, QA notes | Quarterly | Agent owner + reviewer |
| Rework reduction | Fewer corrections, clarifications, or repeated manual steps after agent-assisted work | Jira, review notes, support requests, retrospective notes | Quarterly | Agent owner |
| User satisfaction | Qualitative usefulness and trust signal from target users | Survey, feedback form, working group notes | Quarterly | Agent owner |
| Governance health | Percent of agents with current owner, context readiness, evaluation evidence, measurement plan, and review date | Governance tracker or manual audit | Monthly | Space admin |
| Consolidation signal | Agents or ideas that should be merged, retired, or handled by default ROVO/prompt/automation instead | Agent inventory, fit triage notes, usage review | Quarterly | Working group |

## Per-Agent Metrics Table

| Agent | Owner | Status | Primary Use Case | Adoption | Time Saved | Quality Signal | Governance Health | Last Review | Next Action |
|---|---|---|---|---|---|---|---|---|---|
| Improvements to Design Agent | TBD | Yellow | Route agent ideas to the least complex governed solution | Baseline needed | Baseline needed | Track avoided agent sprawl and design package completeness | Needs measurement baseline | TBD | Define baseline and first review date |

## Status Definitions

| Status | Meaning | Expected Action |
|---|---|---|
| Green | The agent has evidence of value, current ownership, scoped knowledge, and recent review | Continue monitoring |
| Yellow | The agent is useful but has measurement, ownership, source, or evaluation gaps | Add remediation action and review date |
| Red | The agent is risky, stale, unused, duplicative, or lacks required governance controls | Pause, redesign, consolidate, or retire |

## Minimum Measurement Plan For A Durable Agent

Each durable agent should document:

- Primary user group.
- Primary workflow outcome.
- Baseline manual workflow or current pain point.
- Expected value signal.
- Quality or risk signal.
- Owner and review cadence.
- Data source or estimate method.
- Retirement or consolidation trigger.

## Reporting Cadence

| Review | Cadence | Audience | Output |
|---|---|---|---|
| Agent owner check | Monthly | Agent owner | Updated metric row, open issues, owner notes |
| Working group review | Monthly | ROVO working group | Portfolio risks, consolidation candidates, backlog updates |
| Leadership summary | Quarterly | Stakeholders | Value summary, adoption trends, quality signals, risk themes |
| Lifecycle review | At launch, major change, or retirement | Owner + reviewer | Decision to launch, continue, revise, consolidate, or retire |

## Feedback Loop

1. Capture usage, owner estimate, or survey signal.
2. Review quality and rework evidence.
3. Identify gaps in source content, instructions, skills, or routing.
4. Update the agent design record, Project Brain, instructions, knowledge sources, or evaluations.
5. Record material design decisions as ADRs.
6. Update the implementation backlog when the pattern affects more than one agent.

## Measurement Notes

- Studio analytics may not provide every useful measure. Owner estimates are acceptable when clearly labeled.
- Avoid false precision. A rough but reviewed estimate is better than an empty field.
- Use measurement to support governance decisions, not to punish early experimentation.
- If an agent cannot identify a plausible value signal, reconsider whether it should exist as a durable agent.
