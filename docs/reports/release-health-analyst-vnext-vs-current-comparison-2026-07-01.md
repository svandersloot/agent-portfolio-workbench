# Release Health Analyst - vNext vs Current Comparison And Value Report

| Field | Value |
|---|---|
| Date | 2026-07-01 |
| Release under review | Mobilitas 2026.07.10 |
| Evidence window | 2026-06-19 to 2026-06-29 |
| Evidence source | 16 daily draft assessment pages (two parallel series) under MO page `5407670376`, read-only |
| Recommendation | Standardize on vNext; retire/supersede the older series |

## Scope Of Evidence

Two daily series assessed the same release in parallel: the older **Release Health Assessment Draft** series and the newer **vNext Release Health Assessment Draft** series. Both were read read-only from Confluence. Human-confirmed operational facts were supplied by the release owner and are labeled as such.

## Head-To-Head Verdict

vNext is the stronger analyst on the dimensions that matter:

| Dimension | vNext | Current series |
|---|---|---|
| Scope | Converged to `fixVersion`-only, capturing all release items across M26 and MR26 | Kept an `AND project = "M26"` filter, excluding legitimate MR26 items on the same fixVersion |
| Comment reading | Read comment nuance; caught a `Done` item whose comments showed validation was deferred | Trusted the status field at face value |
| Readiness ownership | Framed decisions as questions for the release owner | Declared "GREEN and ready for deployment" on 06-29 |
| Structure | Carryover-vs-new-scope table with owners, first-seen, and release impact | Flatter output |

vNext's weaknesses were presentation and consistency, not correctness: an undifferentiated always-YELLOW status color, occasional early scope inconsistency, mixed severity vocabulary, and a follow-up question that leaned toward a human-owned disposition.

## The 06-29 Decisive Case

On 06-29, the two series reached opposite conclusions for the same release:

- **vNext** stayed YELLOW, read the comments on the case-sensitivity item (marked `Done`, but SIT validation deferred to Sprint 7), and surfaced it plus a late-breaking SIT-only bug. It kept readiness human-owned.
- **Current** went GREEN and declared the release "ready for deployment," treating the same `Done` item as fully validated.

vNext's caution was the more trustworthy behavior, given ticket hygiene is still maturing. Its one flaw was phrasing the follow-up as a deferral decision rather than a status-verification question - now fixed (see below).

## Confirmed Value (Human-Verified)

- Release management **reads and acts on** the assessments and uses them **live on release-readiness calls**.
- Saves the release owner **at least ~1 hour per run** otherwise spent chasing statuses.
- The Mobilitas 2026.07.10 release is **on track and ahead of schedule**, deploying 2026-07-10 - consistent with the improving trend the assessments tracked.
- Jira facts were **accurate**, with minor edge-case nuances expected until further training.
- The persistent QA/SIT and Bitbucket "Data Incomplete / WARN" flags were **upstream process gaps** (external Guidewire Bitbucket, maturing ticket hygiene), not agent errors. The flagging is a feature: it gave evidence to push teams on PR-merge comments and test-case linking.

## Recommendation

Standardize on vNext. The correctness advantages are real and the weaknesses were calibration/consistency issues now addressed.

## Improvements Applied This Cycle

- **Scope:** per-team `Release Scope Derivation Contract` and `Release Scope Definition` (fixVersion-only for Mobilitas; no project-filter toggling).
- **Status calibration:** production-impact rubric (RED/YELLOW/GREEN) so non-production-only items do not hold the release at `At risk`.
- **Comment-over-status:** ask a status-verification question when status and comments conflict; never recommend a human-owned disposition.
- **Taxonomy:** consistent P1-P5.
- **Cadence:** one canonical run per checkpoint, timed ~30 minutes before the readiness call.
- **Thin Studio config:** behavior lives in referenced, versioned knowledge sources.

Lab verification: `agent-portfolio-lab/test-runs/004-vnext-behavior-calibration/` simulates the three key behaviors and passes; live behavior still requires the manual Studio update and smoke prompts.

## Remaining / Human-Owned

- Manually update the vNext Studio agent from the thinned configuration and run the smoke prompts.
- Decide whether to formally retire the older series so only one canonical assessment per day is produced.

## Boundaries

Confluence access for this report was read-only. No Studio, Jira, or release-decision actions were taken. Final release readiness remains human-owned.
