# Knowledge Source Plan - Release Drift Monitor

## Source Strategy

Release Drift Monitor uses exact release scope and read-only source evidence. It should prefer structured Jira, Bitbucket, test, and QA evidence over narrative summaries. When evidence is missing or inaccessible, it must mark the state `UNKNOWN` rather than infer readiness.

## Authority Labels

| Label | Meaning |
|---|---|
| System of Record | Authoritative source for scope, status, code, tests, or QA. |
| Source Reference | Useful source that supports evidence but may not prove readiness alone. |
| Validation Evidence | Test, QA, or CI evidence that confirms release work was validated. |
| Shared Evidence Layer | Ledger record used by multiple release agents. |
| Human Override | Explicit release-owner or lead decision that must be documented. |

## Approved Source Map

| Source | Type | Authority | Allowed Use | Freshness | Fallback |
|---|---|---|---|---|---|
| Jira fixVersion or release filter | Jira | System of Record | Identify release scope and Jira status. | Daily during pilot | Use direct JQL when available; use export with timestamp as fallback. |
| Jira issue type and status category | Jira | System of Record | Determine initial evidence expectations. | Daily during pilot | Mark team mapping `UNKNOWN` when status rules are unclear. |
| Jira development links | Jira / Bitbucket | Source Reference | Discover linked branches, PRs, and commits. | Daily during pilot | Search known branch/PR/commit fields; use export only as fallback. |
| Jira Web Links | Jira / Bitbucket / test tools / Confluence | Source Reference | Discover PRs, test plans, QA runs, and release evidence when native panels are missing, unreliable, or pointed at a different Bitbucket instance. | Daily during pilot | Require visible Jira key, release scope, parent epic scope, or human-reviewed mapping before high-confidence PASS; warn when Web Link is the only PR linkage. |
| Structured Jira release-evidence comments | Jira | Source Reference / Human Override | Capture low-friction Guidewire Bitbucket PR evidence when native development links cannot reach the application repos. | Daily during pilot | Require PR URL, target branch, covered Jira keys, PR state, and validation state for medium confidence. |
| Parent epic and child issue tree | Jira | Source Reference | Discover shared PR, test plan, QA signoff, and validation evidence that may cover child stories. | Adaptive during pilot | Scan for In Progress, Done, near-freeze, test-required, or user-requested deep checks; mark child coverage WARN or UNKNOWN when parent evidence does not identify covered scope. |
| Bitbucket branch metadata | Bitbucket | System of Record | Confirm branch existence and Jira key pattern. | Daily during pilot | Mark code evidence low confidence if unavailable. |
| Bitbucket pull requests | Bitbucket | System of Record | Confirm PR state, target branch, and merge timing. | Daily during pilot | Use Jira development panel links if direct read is unavailable. |
| Bitbucket commits | Bitbucket | System of Record | Confirm commit exists in source-truth branch. | Daily during pilot | Require human validation for low-confidence mappings. |
| ClaimCenter repo | Bitbucket | System of Record for code evidence | Verify branches, PRs, commits, and source-truth branch presence for ClaimCenter work. | Daily during pilot | Use Jira development links or human-supplied PR data at lower confidence. |
| PolicyCenter repo | Bitbucket | System of Record for code evidence | Verify branches, PRs, commits, and source-truth branch presence for PolicyCenter work. | Daily during pilot | Use Jira development links or human-supplied PR data at lower confidence. |
| BillingCenter repo | Bitbucket | System of Record for code evidence | Verify branches, PRs, commits, and source-truth branch presence for BillingCenter work. | Daily during pilot | Use Jira development links or human-supplied PR data at lower confidence. |
| ContactManager repo | Bitbucket | System of Record for code evidence | Verify branches, PRs, commits, and source-truth branch presence for ContactManager work. | Daily during pilot | Use Jira development links or human-supplied PR data at lower confidence. |
| CI or automated test results | CI / Bitbucket / Jira | Validation Evidence | Confirm test pass/fail when available. | Per build or daily | Mark `UNKNOWN` if source is unavailable. |
| Manual QA signoff | Jira / test tool / Confluence | Validation Evidence | Confirm QA state for test-required items. | Per release | Ask QA lead to confirm accepted source. |
| Release Evidence Ledger | Schema / Confluence / data source | Shared Evidence Layer | Store observations and drift history. | Per run | Output proposed ledger rows. |
| Release Health Analyst output | Confluence / supplied text | Reference | Compare final readiness with drift history. | At freeze/on demand | Do not use as source for new drift observations. |

## Approved Bitbucket Application Repositories

Use these repositories only for release evidence drift checks: PR existence, PR state, target branch, merge timing, commit presence in source-truth branch, and Jira-key mapping. Do not use them for broad code review, implementation quality scoring, or security analysis in the initial pilot.

| Application | Repository |
|---|---|
| ClaimCenter | `https://bitbucket.insu.dev-1.us-east-1.guidewire.net/projects/STARSYSONE/repos/claimcenter/browse` |
| PolicyCenter | `https://bitbucket.insu.dev-1.us-east-1.guidewire.net/projects/STARSYSONE/repos/policycenter/browse` |
| BillingCenter | `https://bitbucket.insu.dev-1.us-east-1.guidewire.net/projects/STARSYSONE/repos/billingcenter/browse` |
| ContactManager | `https://bitbucket.insu.dev-1.us-east-1.guidewire.net/projects/STARSYSONE/repos/contactmanager/browse` |

During the Mobilitas pilot, these application repositories are in Guidewire Bitbucket, while Jira Development Panel links may point to CSAA Bitbucket. The monitor must not treat an empty Jira Development Panel as proof that code does not exist for these repos.

Low-friction fallback for dev teams:

1. Add the Guidewire Bitbucket PR as a Jira Web Link.
2. If Web Link is not practical, add a structured Jira comment:

```text
Release evidence:
PR: [Guidewire Bitbucket PR URL]
Target branch: [develop or release/r-xx.x]
Jira keys covered: [KEY-123, KEY-456]
State: [open / merged / declined / unknown]
Validation: [pending / linked separately / not required / unknown]
```

The comment should come from the assignee, dev lead, QA lead, or release owner. This is accepted as medium-confidence mapping when complete.

Branch expectations:

- Before code freeze, use `develop` as the default source-truth branch unless the release owner provides another integration branch.
- At code freeze, use the named release branch. Release branches follow the `release/r-xx.x` naming convention, such as `release/r-64.0`.
- If the release branch is not known at code freeze, mark branch evidence `UNKNOWN` instead of passing the item.
- Jira keys are expected in branch names when available, but PR title, PR description, commit message, or Jira development links may also provide evidence.

## Required Input Check

Before returning a confident health pulse, the monitor must confirm:

- Exact release identifier, direct JQL result, issue list, or export.
- Release stage: before code freeze, at code freeze, or after code freeze.
- Source-truth branch: `develop`, release branch using `release/r-xx.x`, or documented override.
- Which issue types require code evidence.
- Which issue types or fields require test evidence.
- Which application repos are in scope for this release.
- Whether Jira development links, Bitbucket, and QA/test sources are available.
- Whether Jira Web Links are accepted as a fallback discovery source for PRs and test plans.
- Whether Guidewire Bitbucket PRs are represented by Jira Web Links or structured Jira comments.
- Whether the release uses a Shared Validation Anchor: parent Epic, QA-only story, linked test plan, QA run, or Confluence validation page.
- How Production Defects are classified when code may not be required.

## Data Incomplete Flags

| Flag ID | Missing or incomplete data | Impact | How to clear |
|---|---|---|---|
| RDM-DI-001 | Exact release identifier is missing. | Scope cannot be trusted. | Provide fixVersion, release link, issue list, or export. |
| RDM-DI-002 | Release stage is missing. | Source-truth branch cannot be selected. | Confirm pre-freeze, code freeze, or post-freeze. |
| RDM-DI-003 | Source-truth branch is unclear. | Code evidence may be checked against the wrong branch. | Confirm develop, release branch such as `release/r-64.0`, or override. |
| RDM-DI-004 | Team Done/status mapping is unknown. | Done-related drift may be noisy. | Provide workflow/status mapping. |
| RDM-DI-005 | Bitbucket source is inaccessible. | Code evidence cannot be verified. | Grant access, provide Jira development links, or paste PR data. |
| RDM-DI-006 | Test evidence standard is unknown. | Missing-test findings may be unreliable. | QA lead defines accepted evidence. |
| RDM-DI-007 | Jira-to-Bitbucket key matching is weak. | Code evidence confidence is low. | Confirm branch/PR/commit key rules. |
| RDM-DI-008 | Jira Web Link is the only PR linkage. | Code evidence may be valid but does not follow preferred Jira-key branch/PR linking practice. | Add Jira key to branch, PR title, PR description, native development link, or accepted mapping. |
| RDM-DI-011 | Jira Development Panel points to CSAA Bitbucket while app PRs live in Guidewire Bitbucket. | Empty development panel cannot prove missing app code evidence. | Add Guidewire Bitbucket PR as Jira Web Link or structured release-evidence comment. |
| RDM-DI-009 | Shared Validation Anchor is missing or unmapped. | Shared test evidence may not safely pass child stories. | QA lead confirms parent Epic, QA-only story, test plan, QA run, or Confluence page and how covered keys/scope are identified. |
| RDM-DI-010 | Production Defect classification is unknown. | Agent cannot know whether PR evidence, config evidence, data-fix evidence, operational evidence, or analysis evidence is required. | Classify as code-required, config-only, data-fix, operational/runbook, analysis/no-change, or another team-approved category. |

## Source Handling Rules

- Use exact fixVersion or provided issue list only.
- Do not use "latest release" inference.
- Before code freeze, treat `develop` as the default code source of truth.
- At code freeze, treat the release branch as source of truth. Expected release branch naming is `release/r-xx.x`.
- If a Jira key appears in branch, PR title, or commit message, record match strength.
- If the Jira development panel is missing evidence, scan Jira Web Links for Bitbucket PRs, test plans, QA runs, and Confluence evidence before concluding evidence is absent.
- If PR evidence is discovered only through a Jira Web Link, treat it as usable fallback evidence but include a hygiene warning that preferred Jira-key branch/PR linking is missing or incomplete.
- For ClaimCenter, PolicyCenter, BillingCenter, and ContactManager work, check Jira Web Links and structured Jira comments when the Development Panel does not show Guidewire Bitbucket PRs.
- If no Development Panel link, Jira Web Link, or structured comment exists for Guidewire-hosted app work, mark code evidence `UNKNOWN` unless status, stage, or release policy creates a separate risk.
- If a child story lacks direct test evidence, scan the parent Epic and sibling QA-only stories only when the child is In Progress, Done, near code freeze, test-required, test-conditional, or the user asks for a deep scan.
- Treat parent Epic, QA-only story, linked test plan, QA run, or Confluence validation page as a Shared Validation Anchor only when the covered Jira keys, child stories, components, acceptance areas, or QA-approved scope are explicit.
- For Production Defects, default classification to unknown until code-required, config-only, data-fix, operational/runbook, or analysis/no-change evidence is identified.
- Do not mark `PASS` from low-confidence code evidence alone.
- Do not require code evidence for non-code issue types unless team rules say it applies.
- Allow one PR, commit, test plan, QA run, or regression suite to cover multiple Jira keys only when the coverage scope is explicit.
- Record shared evidence coverage with covered Jira keys, coverage scope, confidence, and explanation.
- Keep `UNKNOWN` separate from `WARN`; unavailable data is not proof of risk or readiness.

## Knowledge Source Review

| Review item | Status | Notes |
|---|---|---|
| Jira query fields identified | Draft | See Release Evidence Ledger Contract. |
| Bitbucket matching rules identified | Draft | Branch name is expected to include issue key, but enforcement needs validation. |
| Approved Bitbucket repos documented | Done | ClaimCenter, PolicyCenter, BillingCenter, and ContactManager repos are documented for read-only code evidence checks. |
| Branch source-truth rule identified | Draft | Develop before freeze; release branch at freeze. Release branches follow `release/r-xx.x`. |
| Jira Web Link fallback identified | Accepted for pilot | Manual testing confirmed PR discovery can work through Jira Web Links when the PR title contains the Jira key; findings should warn when Web Link is the only linkage. |
| Guidewire Bitbucket fallback identified | Accepted for pilot | Development Panel may point to CSAA Bitbucket while application repos are in Guidewire Bitbucket; use Jira Web Links or structured Jira release-evidence comments as fallback. |
| Shared Validation Anchor pattern identified | Accepted for pilot | Use parent Epic, QA-only story, linked test plan, QA run, or Confluence page when covered keys or accepted scope are explicit. |
| Adaptive parent Epic scan identified | Accepted for pilot | Scan parent context for In Progress, Done, near-freeze, test-required, or user-requested deep checks rather than every Backlog or To Do item. |
| Production Defect classification identified | Draft | Default to unknown until code-required, config-only, data-fix, operational/runbook, or analysis/no-change is confirmed. |
| Test evidence standards confirmed | Open | Needs team/QA input. |
| Team workflow mapping confirmed | Open | Needs real Jira data. |
| Ledger storage chosen | Open | Start with schema plus Confluence-readable table. |
