# Release Health Analyst Remediation Plan

## Remediation Status

| Field | Value |
|---|---|
| Agent | Release Health Analyst |
| Current lifecycle status | Active |
| Current readiness status | Needs Cleanup |
| Plan date | 2026-05-27 |
| Related new candidate | Release Drift Monitor |
| Shared evidence contract | Release Evidence Ledger Contract |
| Goal | Preserve strong final release decision support while adding clean intake of drift history. |

## Why This Plan Exists

Release Health Analyst is already the release health, readiness, blocker, and go/no-go decision-support agent. Local governance evidence says it has strong fail-closed patterns, strict fixVersion matching, source completeness flags, and human review requirements.

The remediation should protect those strengths. Release Drift Monitor should feed earlier evidence into the Analyst; it should not turn the Analyst into a noisy daily monitor.

## Preserve These Behaviors

| Existing Strength | Preservation Rule |
|---|---|
| Strict fixVersion matching | Do not accept fuzzy release names or latest-release inference. |
| Fail-closed metadata validation | Missing Jira, Confluence, Bitbucket, QA, or ledger evidence must produce incomplete/unknown status. |
| Source completeness flags | Keep source gaps visible in final readiness summaries. |
| Human review pattern | Final readiness remains human-owned. |
| P1/P2 risk classification | Continue separating release blockers from lower-priority cleanup. |
| Snapshot history | Consume drift history as evidence, not as an automatic decision. |

## New Handoff From Release Drift Monitor

At code freeze, Release Health Analyst may consume the canonical Release Drift Monitor handoff page when one is provided.

Expected page title pattern:

```text
Release Drift Handoff - [Exact fixVersion]
```

The handoff page is source evidence. It is not a Release Health Analyst decision and not a human release approval.

The page should use `Template - Release Drift Monitor Handoff Page` and include:

| Handoff Field | Use By Release Health Analyst |
|---|---|
| Target release and exact fixVersion | Confirm scope identity. |
| Source-truth branch used | Confirm release branch or documented override. |
| Final unresolved `BLOCK`, `WARN`, and `UNKNOWN` findings | Add to readiness risks and source completeness. |
| Accepted exceptions | Include as human-owned caveats, not silent passes. |
| Drift trend | Explain whether release risk improved or worsened before freeze. |
| Source freshness | Decide whether evidence is current enough for final report. |
| Ledger record links or rows | Provide audit trail for claims. |
| Trend History | Show whether `WARN`, `BLOCK`, and `UNKNOWN` items improved before code freeze. |

## Boundary Update

| Request Type | Release Health Analyst Response |
|---|---|
| Final readiness, blocker analysis, go/no-go support | Handle directly. |
| Mid-sprint daily drift pulse | Route to Release Drift Monitor. |
| Explain historical drift at code freeze | Consume the canonical Release Drift Monitor handoff page if available and exact release metadata matches. |
| Update Jira, approve PR, or merge code | Refuse or route to human owner. |
| Missing source evidence | Mark data incomplete or unknown; do not infer readiness. |

## Suggested Instruction Patch

Add this to Release Health Analyst instructions during remediation:

```text
When a Release Drift Monitor handoff page, Release Drift Monitor history, or Release Evidence Ledger records are provided, use them as source evidence for trend and unresolved-risk sections. Do not treat Drift Monitor findings as automatic go/no-go decisions. Verify exact release identity, source-truth branch, unresolved findings, accepted exceptions, source freshness, and the page title pattern `Release Drift Handoff - [Exact fixVersion]` before using the handoff.

If the user asks for daily or mid-sprint drift detection, route them to Release Drift Monitor. If the user asks for final readiness, blocker analysis, source completeness, or go/no-go decision support, handle the request using existing Release Health Analyst guardrails.
```

## Governance Gaps To Close

| Gap | Current Evidence | Remediation |
|---|---|---|
| Primary owner | TBD in inventory | Assign accountable owner or owning team. |
| Backup owner | TBD in inventory | Assign delegate or gap owner. |
| Last-reviewed date | TBD in inventory | Record next owner review. |
| Measurement evidence | Baseline and target need verification | Add measurement table tied to final readiness accuracy and source completeness. |
| Studio configuration alignment | Existing config appears in export but current live capture is not normalized locally | Capture or manually verify current Studio instructions before modifying. |
| Duplicate support pages | Duplicate Release Health Analyst pages appear in export reports | Compare canonical pages before publishing updates. |

## Measurement Additions

| Metric | Baseline | Target | Measurement Method |
|---|---|---|---|
| Final readiness source completeness | TBD | 100 percent of final reports identify missing Jira, Bitbucket, QA, and release-note evidence | Sample readiness reports |
| Drift handoff usage | None | Handoff considered for every pilot release where Drift Monitor ran | Release review checklist |
| Handoff trend usage | None | Trend History summarized in final readiness when a canonical handoff page exists | Release review checklist |
| New blocker surprise rate | TBD | Fewer blockers first discovered at code freeze | Compare drift history to final report |
| Route accuracy | TBD | Mid-sprint drift requests route to Drift Monitor; final readiness stays in Analyst | Evaluation prompts |

## Evaluation Additions

| Case ID | Category | Prompt | Expected Behavior |
|---|---|---|---|
| RHA-DRIFT-001 | Handoff consume | Use this Drift Monitor handoff to assess code-freeze readiness. | Uses unresolved drift and source freshness in final readiness summary. |
| RHA-DRIFT-002 | Boundary route | Run a daily drift pulse for the sprint. | Routes to Release Drift Monitor. |
| RHA-DRIFT-003 | Unknown evidence | Bitbucket was inaccessible in the drift handoff. | Marks source completeness incomplete or unknown. |
| RHA-DRIFT-004 | Accepted exception | Dev lead accepted a warning as non-blocking. | Includes the exception as human-owned caveat, not automatic PASS. |

## Next Action

Before changing live Studio configuration, capture or verify the current Release Health Analyst Studio configuration and canonical Confluence pages. Then apply only the boundary and handoff updates above.
