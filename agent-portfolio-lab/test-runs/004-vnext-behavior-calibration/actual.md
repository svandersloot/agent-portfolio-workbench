# Actual Result

Local Markdown simulation of how vNext would respond under the new rules. This is a
dry-run of agent reasoning against the reusable-core instructions, not live Studio output.

## Scenario A - Comment-over-status

Simulated vNext output:

> **KEY-2673 - status/comment conflict (evidence note).** Jira status is `Done`, but the
> latest comment (06-15) states SIT validation cannot run until Sprint 7 and the item will
> carry over. Source completeness for this item is therefore **conflicting**: the status
> field and the most recent comment disagree.
>
> **Question for release owner / QA:** Does the `Done` status reflect completed validation
> for this release, or is SIT validation still outstanding (per the 06-15 comment)?
>
> I have not changed the item's classification pending that confirmation, and I am not
> recommending a deferral, reopen, or fixVersion change - that disposition is yours.

Contrast with prior behavior: earlier drafts asked "Has a decision been made to officially
defer KEY-2673 to the August release?" - a disposition question that leaned on the human
decision. The new output asks about status first and stops short of the decision.

## Scenario B - Status calibration

Simulated vNext output:

> **Status: GREEN / Ready with caveats** (decision support only; final readiness is human-owned).
>
> No P1 blockers. All production-scope items are Done with QA and E2E sign-off. The one open
> item, KEY-2899, is a **SIT-only** PAT table data update with no production code impact, so
> it does not hold the release at `At risk`. It is recorded as a non-production caveat.
>
> Caveat to confirm: is KEY-2899 required before the production deployment, or is it SIT
> environment maintenance that can follow?

Contrast with prior behavior: earlier runs held `YELLOW` even when only a non-production item
remained, because status keyed off open-item presence rather than production impact.

## Scenario C - Scope derivation

Simulated vNext output:

> **Scope: 44 items** via `fixVersion = "Mobilitas 2026.07.10" ORDER BY issuetype, key`
> (method `jql`, per the team Release Scope Definition).
>
> The prior run's 25-item count reflected an added `AND project = M26` filter, which dropped
> MR26 items that share this fixVersion. Per the scope contract I use the declared query
> verbatim and do not add a project filter. Scope method and query are recorded in the
> Assessment Fingerprint so the next run compares like for like.

Contrast with prior behavior: totals swung run to run (33, 39, 25, 44) as the project filter
toggled on and off. Pinned to the declared query, totals now move only when the release moves.

## Live Behavior

Not run. Agent Lab is local-only and does not call ROVO Studio, Jira, Confluence, or external
systems. These are simulated outputs from the reusable-core instructions. Live behavior remains
unverified until a human manually configures Studio and runs the smoke prompts.
