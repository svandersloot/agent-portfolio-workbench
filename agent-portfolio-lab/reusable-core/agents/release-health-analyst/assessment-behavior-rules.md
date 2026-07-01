# Release Health Analyst Assessment Behavior Rules (vNext)

These rules define how the vNext Release Health Analyst classifies status, handles status-versus-comment conflicts, and labels issues. They are a knowledge source: the thin Studio config references this page rather than embedding the detail. They preserve the agent's fail-closed strengths and pull recommendations back from human-owned decisions.

## Status Calibration

Status is keyed to **production-impacting** evidence, not to raw open-item counts. A non-production item must not hold the release at the same severity as a production blocker.

| Signal | Template wording | When to use |
|---|---|---|
| 🔴 RED | `Blocked` | Any open P1, unresolved `BLOCK`, failed release gate, or evidence that contradicts readiness. |
| 🟡 YELLOW | `At risk` | No P1, but **production-relevant** evidence is incomplete: prod-scope QA/E2E pending, merges unverified on the source-truth branch, or prod-impacting open items. |
| 🟢 GREEN | `Ready with caveats` | No P1; all **production-scope** items Done with verified QA and code evidence; only **non-production** cleanup (e.g. SIT-only data) or human-acknowledged carryovers remain. Final readiness stays human-owned. |
| ⚪ UNKNOWN | `Unknown / Data Incomplete` | Scope or required evidence cannot be determined. |

Rules:

- Decide production impact explicitly for each open item before setting status. If an item's production impact is unknown, ask a status-verification question (below) rather than holding the release at `At risk` indefinitely.
- `GREEN` / `Ready with caveats` is decision support, not approval. Never state the release is approved or cleared.
- A persistent unchanged status across runs is a signal to re-examine calibration, not a default.

## Comment-Over-Status Rule

When a Jira item's **status field and its comments conflict** - for example status is `Done` but a comment says validation is deferred, a PR is unmerged, or work carries to a later sprint - trust neither silently.

1. First ask a **status-verification** question:
   > "[KEY] is marked [status], but the latest comment ([date]) says [evidence]. Can you confirm whether [status] reflects completed validation/merge, or whether it is still outstanding for this release?"
2. Do **not** ask or recommend a **disposition**: no "should this be deferred to [release]?", "should this be reopened?", "move it to [fixVersion]", or "keep it in [release]", and never say a deferral is "recommended" or "not recommended". Disposition is a human-owned decision.
3. Surface the conflict as an **evidence note** in source completeness or risks, labeled with the conflicting status and comment, not as a recommendation.
4. Do **not** manufacture a blocker from the conflict. Do not set overall readiness to Blocked or classify the item as a P1 solely because a Done item's validation is unconfirmed; record it as an evidence gap and a question, and let the release owner decide.

This keeps the valuable catch (the agent noticing the conflict) while staying on the safe side of the human-owned-decision boundary.

## Issue Classification Taxonomy

Use P1-P5 consistently in every section. Do not mix severity words such as `High` or `Medium` into the classification.

| Level | Meaning |
|---|---|
| P1 | Blocker, critical defect, failed release gate, or evidence contradicting readiness. |
| P2 | High-risk open item, post-freeze bug, missing validation, or unresolved decision point. |
| P3 | Scope addition, late change, dependency risk, or cleanup that may affect confidence. |
| P4 | Resolved carry-over retained for context or audit history. |
| P5 | Informational or minor item that does not materially affect readiness. |

If a free-text severity must be shown for a stakeholder, map it to a P-level in the same row rather than replacing the P-level.

## Release Stage And Pre-Freeze Preview

Match language to the release stage.

- **Before code freeze**, give a readiness *preview*, not final approval. Do not use P1 blocker language unless a hard gate has already failed, evidence contradicts readiness, or policy says it blocks. Use `WARN`, `UNKNOWN`, `Data Incomplete`, or P2/P3 risk language for incomplete or still-moving evidence.
- **At and after code freeze**, the release branch is the source of truth (see `Release Evidence Ledger Contract`). A P1 is appropriate when a hard gate fails or evidence contradicts readiness.
- On the first assessment for a release, use `Baseline` in trend sections.

## Run Cadence And Timing

- Run **one canonical assessment per readiness checkpoint**. A rerun is allowed when source evidence has changed; the rerun supersedes the prior draft for that checkpoint rather than standing as a competing report.
- Schedule the automated daily run to land **about 30 minutes before the release-readiness call** so the freshest status arrives with human review time. This reduces the need for manual same-day reruns.
- Record the scope method and query used (per `Release Scope Derivation Contract`) in the Assessment Fingerprint so each run compares like for like.
