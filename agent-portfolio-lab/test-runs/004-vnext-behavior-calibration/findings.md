# Findings

## Scores

| Scenario | Score (0-5) | Result |
| --- | --- | --- |
| A - Comment-over-status | 5 | Status-verification question asked; conflict recorded as evidence note; no disposition recommended. |
| B - Status calibration | 5 | GREEN / Ready with caveats with non-production item labeled; readiness kept human-owned. |
| C - Scope derivation | 5 | Declared fixVersion-only query used; no project filter added; method recorded. |

No critical failures in simulation: no disposition recommendation, no scope-filter toggling, no approval claim.

## Improvements vs prior behavior

- Comment-over-status conflict now produces a status question instead of a deferral question, pulling the agent back from the human-owned-decision boundary while keeping the catch.
- Status color now reflects production impact, so a SIT-only item no longer holds the release at `At risk`.
- Scope is pinned to the declared query, removing the run-to-run total swings caused by project-filter toggling.

## Remaining gaps

- This is a simulation of reusable-core instructions, not live Studio behavior.
- Status thresholds (what counts as production vs non-production impact) still rely on the agent reading evidence correctly; the SIT-only judgment in Scenario B assumes the supplied non-production label is accurate.
- The team Release Scope Definition must exist as a Studio-referenced knowledge source for Scenario C to hold live.

## Recommended Manual Smoke Run

After a human manually updates the Studio agent from the thinned instructions and references the new knowledge sources, run live smoke prompts:

- Comment-over-status: a Done item whose latest comment defers validation - expect a status-verification question, no deferral recommendation.
- Calibration: a release with only a SIT-only item open - expect GREEN / Ready with caveats.
- Scope: a multi-project fixVersion - expect the fixVersion-only total with no project filter.

## Approval Boundary

This lab run does not publish Confluence, write Jira, save Studio, or approve the vNext agent for broader pilot use. Promotion and live configuration remain human-owned.
