# Stage 5 Pilot Feedback Tracker Template

Use this tracker during the first team pilot. It is intentionally manual for the first pass. Do not require automated usage telemetry before the pilot can start.

## Pilot Metadata

| Field | Value |
|---|---|
| Pilot name | `[team / workflow / date]` |
| Agent | `[agent name]` |
| Lifecycle stage | `Pilot Approved` |
| Pilot audience | `[named team or users]` |
| Agent owner | `[name/team]` |
| Backup owner | `[name/team or gap owner]` |
| Reviewer/manager | `[name/team]` |
| Feedback channel | `[Confluence page / Jira issue / form / chat channel]` |
| Review cadence | `[weekly / after N uses / date]` |
| Start date | `[YYYY-MM-DD]` |
| Next review date | `[YYYY-MM-DD]` |

## Usage And Feedback Rows

| Date | User or role | Workflow | Pain point addressed | Source context used | Output accepted/edited/rejected | Time saved estimate | Review issue | Unsafe output | Feedback | Improvement decision | Owner | Follow-up date |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `[YYYY-MM-DD]` | `[name/role]` | `[workflow]` | `[pain point]` | `[page/issue/source]` | `[accepted/edited/rejected]` | `[minutes or range]` | `[none/gap]` | `[none/issue]` | `[feedback]` | `[keep/improve/remediate/deprecate]` | `[owner]` | `[YYYY-MM-DD]` |

## Review Summary

| Signal | Current evidence | Decision |
|---|---|---|
| Usage | `[number of uses or Data Incomplete]` | `[continue/adjust/stop]` |
| Pain-point reduction | `[observed reduction or Data Incomplete]` | `[continue/adjust/stop]` |
| Time saved | `[estimate method and total/range]` | `[continue/adjust/stop]` |
| Output quality | `[accepted/edited/rejected pattern]` | `[continue/adjust/stop]` |
| Review issues | `[count and severity]` | `[continue/adjust/stop]` |
| Unsafe outputs | `[none or incident summary]` | `[continue/remediate/stop]` |
| User feedback | `[themes]` | `[continue/adjust/stop]` |
| Source freshness | `[current/stale/unknown]` | `[continue/remediate/stop]` |

## Improvement Log

| Decision date | Decision | Rationale | Required change | Owner | Due date | Evidence label |
|---|---|---|---|---|---|---|
| `[YYYY-MM-DD]` | `[keep/improve/remediate/deprecate/promote]` | `[why]` | `[change]` | `[owner]` | `[YYYY-MM-DD]` | `[User-provided/Source-backed/Data Incomplete/UNKNOWN]` |

## Promotion Gate Summary

| Question | Answer |
|---|---|
| Did the agent reduce the named pain point? | `[yes/no/partial/Data Incomplete]` |
| Did outputs require heavy editing? | `[yes/no/partial/Data Incomplete]` |
| Were any unsafe outputs observed? | `[yes/no/details]` |
| Are sources still approved and current? | `[yes/no/Data Incomplete]` |
| Is the owner willing to maintain the agent? | `[yes/no/Data Incomplete]` |
| Should the agent stay in pilot, move to team-approved, remediate, or deprecate? | `[decision]` |
