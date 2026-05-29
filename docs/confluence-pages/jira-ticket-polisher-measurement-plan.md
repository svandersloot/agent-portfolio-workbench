# Measurement Plan - Jira Ticket Polisher

## Measurement Status

| Field | Value |
|---|---|
| Agent | Jira Ticket Polisher |
| Lifecycle status | In Review |
| Readiness status | Needs Cleanup |
| Measurement maturity | Draft |
| Review cadence | Monthly during pilot, quarterly after launch |

## Value Hypothesis

Jira Ticket Polisher should reduce time spent clarifying tickets and improve ticket readiness, acceptance criteria quality, QA handoff clarity, and team-standard consistency.

## Metrics

| Metric | Baseline | Target | Measurement Method | Cadence |
|---|---|---|---|---|
| Ticket clarification loops | TBD during pilot | Fewer repeated clarification comments after first pilot month | Sample ticket comments or owner review notes | Monthly |
| Review time | TBD | 20 percent reduction in manual pre-refinement review time | Owner estimate before and after agent-assisted review | Monthly |
| Missing-field detection | TBD | Increase early detection of missing acceptance, QA, dependency, and release context | Count flagged gaps and resolved items | Monthly |
| Draft usefulness | TBD | Ticket owner rates draft improvements useful at 4 or higher on 1-5 scale | Owner rating after use | Monthly |
| Overlay accuracy | TBD | 100 percent of evaluations state whether team overlay was applied | Evaluation review | Monthly during pilot |
| Mutation safety | TBD | 100 percent refusal of direct Jira update requests | Evaluation review | Monthly during pilot |

## Quality And Risk Signals

| Signal | Good | Warning | Action |
|---|---|---|---|
| Source traceability | Output names org standard, team overlay status, and ticket fields reviewed. | Output gives generic advice without source status. | Update Studio instructions and rerun evaluation. |
| Team overlay handling | Missing team standards are clearly labeled. | Agent implies a team standard was applied without source evidence. | Treat as P1 remediation. |
| Evidence discipline | Missing information becomes questions or flags. | Agent invents requirements or test expectations. | Treat as P1 remediation. |
| Jira mutation safety | Agent returns draft-only content. | Agent attempts or promises direct Jira updates. | Treat as P0 remediation. |

## Reporting Table

| Team or board | Date | Tickets reviewed | Team overlay status | Average review time | Gaps found | Owner rating | Notes |
|---|---|---|---|---|---|---|---|
| TBD | TBD | TBD | Approved / Draft / Missing | TBD | TBD | TBD | Start after pilot owner is assigned. |

## Review Cadence

- Pilot: review after each team sample or every two weeks, whichever comes first.
- First lifecycle review: after 30 days or after at least 20 pilot ticket reviews.
- Steady state: quarterly review if promoted beyond pilot.

## Promotion Evidence Needed

- Named primary and backup owner.
- Approved organization-wide standard.
- At least one approved or intentionally missing team overlay decision.
- Evaluation run showing draft-only behavior and source traceability.
- Measurement table started with real pilot data.
