# Release Health Analyst Overview

Release Health Analyst is a high-integrity, fail-closed release governance analyst. It classifies release items P1-P5, produces a copy-ready release health assessment, and keeps a run-over-run history for trend analysis. It never owns the final go/no-go decision.

## What the Agent Does

- Creates a source-backed release health baseline from current Jira and Confluence evidence.
- Reruns or refreshes an existing assessment page as new evidence appears, without losing prior context.
- Classifies open items using a consistent P1-P5 taxonomy tied to production impact.
- Surfaces status-versus-comment conflicts (for example, a ticket marked `Done` whose latest comment says validation is still pending) as a question rather than silently trusting either signal.
- Prepares (but does not send) follow-up drafts for open items after explicit human confirmation.
- Compares a Release Drift Monitor handoff against the current assessment when one is available.

## What Problems It Solves

Before this agent, release status was assembled manually each cycle: someone read through dozens of tickets, guessed at severity, and often missed that a "Done" item had no linked test evidence. That process was slow, inconsistent between release managers, and easy to get wrong under RR-call time pressure. Release Health Analyst standardizes that work into a repeatable, evidence-cited pass that runs the same way every time.

## Release Readiness Assessment Capabilities

| Capability | What it produces |
| --- | --- |
| Initial baseline | A first assessment page for a release, with `Baseline` trend values. |
| Rerun / refresh | An updated page that preserves useful prior content and shows what changed. |
| Drift-handoff comparison | A comparison against Release Drift Monitor evidence, treated as supporting evidence only. |
| Open-item follow-up triage | A triage table deciding the best next action per open item (Jira comment draft, outreach, evidence request, owner question, or no action). |

## Risk Identification

Status is calibrated to production impact, not raw open-item counts:

| Signal | Meaning | When it applies |
| --- | --- | --- |
| RED — `Blocked` | Any open P1, unresolved `BLOCK`, failed release gate, or evidence contradicting readiness. |
| YELLOW — `At risk` | No P1, but production-relevant evidence is incomplete (pending prod-scope QA, unverified merges, prod-impacting open items). |
| GREEN — `Ready with caveats` | No P1; all production-scope items Done with verified QA and code evidence; only non-production cleanup or human-acknowledged carryovers remain. |
| UNKNOWN | Scope or required evidence cannot be determined. |

`Ready with caveats` is decision support, not approval — the agent will never state a release is approved or cleared.

## Gap Detection

- **Fail-closed evidence handling:** missing evidence is marked `Data Incomplete` / `UNKNOWN`, never treated as a pass.
- **Comment-over-status rule:** when a ticket's status and its comments disagree, the agent raises a status-verification question and records an evidence note. It does not recommend deferring, reopening, or moving the item — that disposition is a human decision.

## Source Completeness Audits

The agent checks whether claimed work has linked evidence, across:

- Jira scope and issue state
- Code evidence (PR/commit references in ticket comments — see [Known Limitations and Caveats](release-health-analyst-user-guide-known-limitations.md) for the Bitbucket visibility gap)
- QA/testing evidence (linked test results — Xray connector is pending)
- Deployment and change evidence
- Release notes
- Owner approval

## Trend Analysis

Every assessment page carries an Assessment Fingerprint: a compact summary of the run date, release identity, evidence sources, and P1/P2-P3/exception/unknown counts. The next run reads that fingerprint to know what already happened, so it can build on the prior assessment instead of starting cold or repeating itself.

## Delta Tracking

On a rerun, the agent produces a `What Changed Since The Current Page` table (previous state vs. new state, with reason/evidence) and moves items that are no longer current into `Resolved Or Superseded Items` with the reason recorded — rather than silently deleting them.

## Confluence Publishing Capabilities

By default the agent returns copy-ready page content for a human to paste. Create Page and Edit Page are available only when explicitly requested, and always require a preview plus explicit human confirmation before saving.

> **Caveat:** In practice, the agent is not yet reliable at editing an existing Confluence page in place. The current operating pattern is to publish a new child page per run rather than overwrite the previous one. See [Known Limitations and Caveats](release-health-analyst-user-guide-known-limitations.md).

## What the Agent Is Not

> **Caveat:** Does not replace release ownership. The human release owner still owns the release and the final decision.

> **Caveat:** Does not replace human review. Every finding should be read and confirmed, not forwarded as-is.

> **Caveat:** Does not guarantee correctness. Output quality is a direct function of ticket and documentation hygiene — see [Best Practices](release-health-analyst-user-guide-best-practices.md).

> **Caveat:** Requires trust-but-verify validation. Confirm evidence before repeating a finding to stakeholders or acting on a recommendation.

## Feedback and Improvement Opportunities

Please submit agent improvement suggestions, false positives, missing findings, new reporting requirements, and automation enhancement ideas to the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md).
