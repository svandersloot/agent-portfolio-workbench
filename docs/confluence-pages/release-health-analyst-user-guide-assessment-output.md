# Understanding the Assessment Output

Every Release Health Analyst assessment follows the structure defined in `Template - Release Health Analyst Assessment Page`. This page explains each part of that output in plain language for release managers, owners, and QA leads who need to act on it — it does not replace the template itself.

## Executive Summary

**Purpose:** The single most important read on the page — is the release ready, and why.

**Example content:** "At risk — one P1 blocker (MR26-3245) awaits a merge confirmation; QA evidence for the CCC integration change is not yet linked."

**Recommended actions:** Read this first. If it says `At risk` or `Blocked`, go straight to P1 Blockers and Questions For Release Owner before reading anything else.

## Overall Health Rating

**Purpose:** The calibrated readiness signal behind the Executive Summary: `Ready with caveats`, `At risk`, `Blocked`, or `Unknown / Data Incomplete`.

**Example content:** `Blocked` — mapped from a RED signal because an open P1 exists.

**Recommended actions:** Treat `Ready with caveats` as decision support, not approval. Confirm the caveats are acceptable to the release owner before treating the release as clear.

## Release Status

**Purpose:** Where the release currently sits in its lifecycle — pre-freeze, code freeze, release readiness, or post-freeze — captured in the Assessment Fingerprint.

**Example content:** `Release stage: Post code freeze (freeze date 2026-08-18)`.

**Recommended actions:** Confirm this matches the real calendar date for code freeze. Language changes by stage — a pre-freeze run should read as a preview, not a final verdict.

## Priority Findings

**Purpose:** The P1-P5 Issue Classification table — the scannable severity breakdown.

**Example content:**

| Category | Meaning | Count |
| --- | --- | --- |
| P1 | Blockers, critical defects, failed gates | 1 |
| P2 | High-risk open items, post-freeze bugs | 3 |
| P3 | Scope additions, late changes, cleanup | 2 |

**Recommended actions:** Focus review time on P1 and P2 rows. P4/P5 rows are for audit context, not action.

## Questions for Release Owner

**Purpose:** The specific, minimal set of questions a human release owner needs to answer to make or confirm the final decision.

**Example content:** "Can you confirm MR26-3301's validation comment reflects a merged fix, or is it still outstanding for this release?"

**Recommended actions:** Answer these directly, ideally on the underlying Jira ticket, so the next assessment run picks up the resolution automatically.

## Recommendations

**Purpose:** Action-oriented, evidence-tied suggestions — never a disposition decision (the agent will not say "defer this" or "reopen this").

**Example content:** "Request QA evidence link for MR26-3299 before the RR call."

**Recommended actions:** Assign an owner to each recommendation that doesn't already have one.

## Risks

**Purpose:** P2/P3 risks and cleanup items, grouped by theme, owner, deadline, aging item, test gap, or deployment dependency — kept separate from P1 blockers.

**Example content:** "Aging ticket MR26-3210 has had no comment activity in 9 days; risk of being missed before freeze."

**Recommended actions:** Route to the named or needed owner; re-check at the next rerun.

## Blockers

**Purpose:** Active P1 blockers only. This section stays visible even with zero active blockers (`None identified from current evidence`).

**Example content:** "MR26-3245 — CCC Integration failure blocking release; owner: TBD; required action: confirm hotfix merge."

**Recommended actions:** Treat every row here as release-critical until resolved or explicitly re-classified in a later run.

## Follow-Up Actions

**Purpose:** The `Next Assessment Instructions` section — what evidence to gather and what should trigger the next rerun.

**Example content:** "Rerun after QA signs off on the CCC integration change, or the day before the next RR call, whichever comes first."

**Recommended actions:** Use this as your task list between now and the next run.

## Snapshot Log

**Purpose:** The Assessment Fingerprint and its short summary string — the mechanism that lets the next run know what already happened, without depending on the same chat session.

**Example content:** `release=Mobilitas 2026.09 stage=post-freeze freeze=2026-08-18 status=Blocked trend=Worsening p1=1 p2p3=3 unknown=0`.

**Recommended actions:** Don't delete or edit this block manually — it's how the agent avoids repeating itself on rerun.

## Historical Trend Information

**Purpose:** The Trend Analysis table comparing the previous assessment to the current one (`Baseline` on the first run).

**Example content:**

| Metric | Previous | Current | Trend |
| --- | --- | --- | --- |
| P1 count | 0 | 1 | Worsening |
| Open items | 12 | 9 | Improving |

**Recommended actions:** A worsening trend close to code freeze warrants an earlier-than-scheduled rerun.

> **Caveat:** Owners have observed that the trend table is not always maintained consistently across reruns. Confirm it populated correctly, and log a gap if it didn't — see [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md).

## Feedback and Improvement Opportunities

Please submit agent improvement suggestions, false positives, missing findings, new reporting requirements, and automation enhancement ideas to the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md).
