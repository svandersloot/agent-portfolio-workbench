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

For feedback selected for action, link one short verification record from its existing Improvement Log row. Use an existing issue, report section, or evaluation record when it already contains the evidence. Keep end-user feedback lightweight; the helper drafts the record and the owner reviews it.

| Field | Record |
|---|---|
| Feedback reference | Stable row ID, issue/comment, or report anchor; preserve the original observation and first-pass output. |
| Evidence basis | Existing evidence label plus whether the claim is user-reported, directly observed, or inferred. |
| Baseline and expected result | Original scenario/output reference, affected revision or configuration, and explicit pass/partial/fail criteria. Mark missing baseline evidence `Data Incomplete`. |
| Disposition | Apply, defer, reject, or link duplicate; rationale, accountable owner, and next review date or trigger. |
| Change evidence | Applied commit/diff, document revision, or authorized runtime configuration capture. A proposal is not an applied change. |
| Retest evidence | Same scenario, actual output/result reference, date, tested revision/configuration, and relevant existing regression case IDs. Record material differences in test conditions. |
| Verification | `Not run`, `Pass`, `Partial`, or `Fail`; name the verifier and the evidence they actually inspected. |
| User outcome | Reported usefulness or observed workflow effect and its measurement basis; `UNKNOWN` when unavailable. |
| Lesson candidate | Only when reusable: applicability, concrete action, supporting evidence, limits or contrary evidence, and reviewer/decision owner. Otherwise retain the observation as evidence only. |
| Reuse and return | Link the result back to the original feedback; name the next similar task or review that should retrieve this record and check for recurrence. Record any later inclusion decision and approved destination separately. |

1. Preserve the original result and append the change and retest; do not rewrite the first pass.
2. Record expected behavior before applying the change and retesting. If criteria change, preserve both versions and explain the change.
3. An applied change without a comparable retest remains verification pending. Missing or non-comparable evidence is `Data Incomplete`; do not record `Pass` from it.
4. A passing check supports only the tested behavior and conditions. It does not establish user benefit, recurrence prevention, or promotion readiness.
5. Deferred, rejected, and duplicate feedback receive explicit dispositions; they are not verified improvements.
6. A lesson candidate is not a reviewed lesson or approved standard. Inclusion, sharing, promotion, ownership, and live-system decisions retain their existing human approval boundaries.

Reuse the affected agent's existing evaluation cases, change log, and test-run records rather than creating a second test history. Before similar work, retrieve applicable feedback and candidate limits; append any new result to the linked record.

### Synthetic Walkthrough

These hypothetical examples illustrate the record. They are not executed runtime tests, participant feedback, or evidence of pilot value.

| Example | Supplied evidence | Result to record |
|---|---|---|
| Change without retest | Synthetic feedback `EX-1`: the original output omitted a source link. Baseline output and expected link are preserved; an applied document diff exists, but no rerun was performed. | Disposition `Apply`; verification `Not run`, pending comparable retest; user outcome `UNKNOWN`. No verified improvement claim. |
| Comparable passing retest | Synthetic feedback `EX-2`: the same missing-link scenario is rerun against the changed revision under the same conditions. The expected criterion was recorded before the change; baseline, diff, actual passing output, and reviewer are linked. | Verification `Pass` for the tested case only; user outcome `UNKNOWN` until separately evidenced. Any reusable interpretation remains a lesson candidate. |
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
