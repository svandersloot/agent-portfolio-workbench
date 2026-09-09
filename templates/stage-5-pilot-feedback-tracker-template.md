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

## Verification Of An Improvement

For a selected improvement, add one short record to its existing Improvement Log row. Use links to existing issues, evaluation cases, outputs, or change logs instead of duplicating a full report. Keep end-user feedback lightweight; the helper drafts the record and the owner reviews it.

| Minimum record | What to capture |
|---|---|
| Feedback and expected result | Link the original observation/first pass and state the expected behavior. Existing evidence labels still apply. |
| Change | Link the applied revision or configuration capture. A proposal is not an applied change. |
| Comparable retest | Link the same scenario's actual result, tested revision/configuration, and relevant existing regression case. Mark missing or materially different conditions `Data Incomplete`. |
| Verification | `Not run`, `Pass`, `Partial`, or `Fail`; name the verifier and the evidence inspected. |

An applied change without a comparable retest remains verification pending. A passing check supports only its tested behavior and conditions; record user usefulness separately as reported/observed/`UNKNOWN`.

For deferred, rejected, or duplicate feedback, record the disposition, reason, owner, and next review trigger or existing-record link. Do not create a verification record or count an improvement.

Add a reusable lesson candidate only when one emerges. Keep its applicability, evidence, limits, and return trigger with the linked record; it is not a reviewed lesson or approved standard.

Reuse the affected agent's existing evaluation cases, change log, and test-run records rather than creating a second test history. Try this minimum record on one real case before adding more structure.

### Synthetic Walkthrough

These hypothetical examples illustrate the record. They are not executed runtime tests, participant feedback, or evidence of pilot value.

| Example | Supplied evidence | Result to record |
|---|---|---|
| Change without retest | Synthetic feedback `EX-1`: original output, expected link, and applied document diff are linked; no rerun was performed. | Verification `Not run`, pending comparable retest; user outcome `UNKNOWN`. No verified improvement claim. |
| Comparable passing retest | Synthetic feedback `EX-2`: the same scenario is rerun against the changed revision under the same conditions; expected behavior, actual output, and reviewer are linked. | Verification `Pass` for the tested case only; user outcome `UNKNOWN` until separately evidenced. A lesson candidate is optional. |
| Deferred or duplicate | Synthetic feedback `EX-3`: the owner defers the change with a reason and review trigger, or links an existing feedback record covering the same observation. No new change or retest occurred. | Disposition `Defer` or `Link duplicate`; verification `Not run`. Follow the named trigger or linked record; do not count a new verified improvement. |

## Promotion Gate Summary

| Question | Answer |
|---|---|
| Did the agent reduce the named pain point? | `[yes/no/partial/Data Incomplete]` |
| Did outputs require heavy editing? | `[yes/no/partial/Data Incomplete]` |
| Were any unsafe outputs observed? | `[yes/no/details]` |
| Are sources still approved and current? | `[yes/no/Data Incomplete]` |
| Is the owner willing to maintain the agent? | `[yes/no/Data Incomplete]` |
| Should the agent stay in pilot, move to team-approved, remediate, or deprecate? | `[decision]` |
