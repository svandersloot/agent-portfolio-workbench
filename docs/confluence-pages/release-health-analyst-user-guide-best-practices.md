# Best Practices

The quality of a Release Health Analyst assessment is directly a function of the quality of the release documentation it reads. This page documents the ticket and documentation hygiene practices that produce the most useful assessments.

## Data Quality Principles

- Write ticket updates as if the next reader has no other context — because the agent doesn't have any other context either.
- Prefer explicit evidence (a link, a comment, a status) over implicit assumption. If it isn't written down, the agent will mark it `Data Incomplete` or `UNKNOWN` — which is the correct, safe behavior, but it costs a follow-up question.
- Resolve status-versus-comment conflicts at the source. If a ticket is `Done` but the real state is "merged, pending validation," update the comment or the status so they agree.

## Maintaining Ticket History

Keep a running, dated history of what actually happened on a ticket — deployments, environment promotions, file imports, validation results — not just a final status flip.

> **Recommendation:** The companion `Jira Work Item Assistant` agent can draft a ticket comment from a short spoken or typed description of what you just did, and will confirm with you before posting. Using it to keep history current is one of the fastest ways to improve the next Release Health Analyst run.

## Updating Story Statuses

Keep statuses synchronized with reality in near real time, not batched at the end of the sprint. A stale status is one of the most common sources of a status-versus-comment conflict the agent has to flag as a question instead of resolving automatically.

## Adding Evidence

Attach or link the artifact, not just a description of it: the build log, the test run, the deployment record, the PR. A sentence saying "tested" is not evidence; a link to the test result is.

## Linking Supporting Records

Cross-reference related tickets, PRs, and pages directly in the ticket rather than relying on tribal knowledge of "how things usually connect." The agent can only follow evidence it can see.

## Documenting Testing Results

State pass/fail explicitly and link the underlying evidence, even for informal or exploratory testing. "Looks fine" without a link reads as a source-completeness gap, not a pass.

## Documenting Release Decisions

When a release owner accepts an exception or makes a disposition call (defer, reopen, move fixVersion), record who made the call and why, directly on the ticket or release page. The agent will surface accepted exceptions as human-owned caveats — it needs the decision written down to do that correctly.

## Good vs. Poor Ticket Hygiene

| Poor hygiene | Good hygiene |
| --- | --- |
| Status flipped to `Done` with no comment. | Status flipped to `Done` with a comment: "Merged in PR #482, deployed to SIT 2026-08-14, QA signed off 2026-08-15 (see linked test run)." |
| "Tested, looks good." | "Regression suite run 2026-08-15, 42/42 passed. Link: [test run]." |
| A defer/reopen decision made verbally in a meeting, never written down. | "Release owner (Jane) accepted this as a known issue for 9.04 on 2026-08-18; residual risk: low; revisit if repeated in prod." |
| PR merged with no ticket reference. | PR description and ticket comment cross-link each other. |

## Feedback and Improvement Opportunities

Please submit agent improvement suggestions, false positives, missing findings, new reporting requirements, and automation enhancement ideas to the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md).
