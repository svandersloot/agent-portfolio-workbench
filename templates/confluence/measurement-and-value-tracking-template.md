# Measurement and Value Tracking

## Purpose

Define how agent success is measured, reviewed, and improved across the ROVO agent library.

## Measurement Principles

- Measure value, not novelty.
- Start lightweight and improve the measurement model over time.
- Prefer directional evidence over no evidence.
- Track both efficiency and quality.
- Review metrics during agent lifecycle checks.

## Portfolio Metrics

| Metric | Definition | Source | Cadence | Owner |
|---|---|---|---|---|
| Adoption | Number of active users or meaningful uses in period | Studio analytics / owner estimate / survey | Monthly | [Owner] |
| Time saved | Estimated minutes saved per successful use | Owner estimate / user survey | Monthly | [Owner] |
| Quality improvement | Reduction in missing information, defects, rework, or review comments | Jira / Confluence / reviewer sample | Quarterly | [Owner] |
| Rework reduction | Fewer corrections after agent-assisted workflow | Jira / review notes | Quarterly | [Owner] |
| User satisfaction | Qualitative usefulness score | Survey / feedback form | Quarterly | [Owner] |
| Governance health | Percent of agents with owner, evaluation, measurement plan, and current review | Governance toolkit report | Monthly | Space admin |

## Per-Agent Metrics Table

| Agent | Owner | Status | Primary Use Case | Adoption | Time Saved | Quality Signal | Last Review | Next Action |
|---|---|---|---|---|---|---|---|---|
| [Agent] | [Owner] | Green / Yellow / Red | [Use case] | [Value] | [Value] | [Signal] | [Date] | [Action] |

## Reporting Cadence

| Review | Cadence | Audience | Output |
|---|---|---|---|
| Agent owner check | Monthly | Agent owner | Updated metrics and issues |
| Working group review | Monthly | Working group | Portfolio review and backlog updates |
| Leadership summary | Quarterly | Stakeholders | Value summary and risks |

## Feedback Loop

1. Capture usage or owner estimate.
2. Review quality and rework signals.
3. Identify patterns or gaps.
4. Update templates, agent instructions, or knowledge sources.
5. Record significant design decisions as ADRs.

## Measurement Notes

[Use this section for caveats, data limitations, and measurement assumptions.]
