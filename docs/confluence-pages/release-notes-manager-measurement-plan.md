# Measurement Plan - Release Notes Manager

## Measurement Status

| Field | Value |
|---|---|
| Agent | Release Notes Manager |
| Lifecycle status | In Review |
| Readiness status | Needs Cleanup |
| Measurement maturity | Draft |
| Review cadence | Release-based during pilot, quarterly after launch |

## Value Hypothesis

Release Notes Manager should reduce the time required to assemble release-note drafts while improving source completeness, audience fit, and review traceability.

## Metrics

| Metric | Baseline | Target | Measurement Method | Cadence |
|---|---|---|---|---|
| Draft preparation time | TBD during first pilot release | 25 percent reduction after two pilot releases | Owner estimate before and after agent-assisted draft | Per release |
| Missing-source flags found before publication | TBD | Increase early detection without increasing post-publication corrections | Count `Data Incomplete` flags and resolved items | Per release |
| Review correction rate | TBD | Reduce repeated review comments after first two pilot releases | Sample release-owner edits or comments | Per release |
| Audience-fit satisfaction | TBD | Release owner rates output useful for intended audience | 1-5 owner rating | Per release |
| Duplicate routing accuracy | TBD | 100 percent of release health requests route to Release Health Analyst | Evaluation prompt review | Monthly during pilot |

## Quality And Risk Signals

| Signal | Good | Warning | Action |
|---|---|---|---|
| Source completeness | Required release sources are available and cited in checklist. | One or more required sources missing. | Mark `Data Incomplete`; ask owner to clear gaps. |
| Human approval | Owner reviews before publication. | User asks agent to publish or approve. | Refuse direct publication and provide review packet. |
| Duplicate boundary | Health/readiness requests route away. | Agent begins scoring health directly. | Update instructions and rerun evaluation. |
| Archive leakage | Mobilitas remains reference only. | Mobilitas language appears as default standard. | Remove from default instructions and add test coverage. |

## Reporting Table

| Release | Date | Mode | Draft time estimate | Data incomplete flags | Review corrections | Owner rating | Notes |
|---|---|---|---|---|---|---|---|
| TBD | TBD | Technical / Business / Sync | TBD | TBD | TBD | TBD | Start after pilot owner is assigned. |

## Review Cadence

- Pilot: review after each release where the agent is used.
- First lifecycle review: after two pilot releases or 30 days, whichever comes first.
- Steady state: quarterly review if promoted beyond pilot.

## Promotion Evidence Needed

- Named primary and backup owner.
- At least one evaluated release-note workflow.
- Confirmed source and permission model.
- Human approval path accepted by release owner.
- Measurement table started with real pilot data.
