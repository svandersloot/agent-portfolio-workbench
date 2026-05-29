# Release Evidence Ledger Contract

## Contract Status

| Field | Value |
|---|---|
| Contract version | 1 |
| Effective date | 2026-05-27 |
| Status | Draft |
| Structured schema | `schemas/release-evidence-ledger-record.schema.json` |
| Consumers | Release Drift Monitor, Release Health Analyst |
| Source posture | Append-only evidence records; no agent-owned Jira, Bitbucket, or release mutations. |

## Purpose

The Release Evidence Ledger is the shared evidence layer for release health work. It records what the agents observed about Jira scope, Bitbucket code evidence, tests, QA evidence, source freshness, and release health state at a point in time.

The ledger is not the release decision. It is the evidence trail that lets:

- Release Drift Monitor detect early inconsistency during the sprint.
- Release Health Analyst summarize final readiness at code freeze.
- Humans see why a release item is `PASS`, `WARN`, `BLOCK`, or `UNKNOWN`.

## Why This Exists

Release health work fails when Jira, code, tests, and release decisions are treated as one blended answer. The ledger keeps them separate.

Example: a story can be `Done` in Jira while its PR is still open, merged into the wrong branch, missing test evidence, or blocked by QA. The ledger records those as separate observations instead of collapsing them into a vague health score.

## Evidence Ledger Field Guide

A minimum ledger record answers:

> For this Jira item in this release, what evidence did we expect, what evidence did we observe, what branch counted as truth, what state did that imply, and what should a human do next?

| Field | Meaning | Why It Matters |
|---|---|---|
| `releaseId` | Exact fixVersion, release branch, or release identifier. | Prevents fuzzy release matching. |
| `jiraKey` | Jira issue key. | Main reconciliation handle across Jira and Bitbucket. |
| `sourceTruthStage` | `pre_freeze`, `code_freeze`, `post_freeze`, or `unknown`. | Decides whether develop or release branch should be checked. |
| `sourceTruthBranch` | Branch treated as deployable truth for this observation. | Prevents a merged PR on the wrong branch from looking ready. |
| `driftApplicability` | Whether code, tests, QA, docs, or no release evidence applies. | Avoids requiring code evidence for every Jira item. |
| `evidenceRequirements` | Explicit decision for whether code, test, QA, and documentation evidence are required, conditional, not required, or unknown. | Makes evidence expectations inspectable instead of implied by issue type alone. |
| `evidenceRequirements.workClassification` | Optional classification such as code-required, config-only, data-fix, operational/runbook, analysis/no-change, QA-only, documentation-only, or unknown. | Prevents issue type alone from creating false code/test requirements, especially for production defects. |
| `expectedEvidence` | Evidence types required for this issue. | Makes the rule explicit before scoring. |
| `observedJira` | Status, status category, resolution, fixVersion, updated date. | Shows what Jira actually said at observation time. |
| `codeEvidence` | Branch, PR, commit, and source-truth state. | Separates "PR exists" from "code is in the right branch." |
| `testEvidence` | Automated test state and links when available. | Makes test coverage visible without pretending all tests are equal. |
| `qaEvidence` | Manual QA or signoff state when required. | Keeps human validation separate from automation. |
| `coverageEvidence` | Shared evidence mapping such as one PR, commit, test plan, QA run, or parent epic covering multiple Jira keys. | Allows realistic shared evidence while preserving traceability. |
| `healthState` | `PASS`, `WARN`, `BLOCK`, or `UNKNOWN`. | Provides a stable alert/status vocabulary. |
| `confidence` | `high`, `medium`, or `low`. | Keeps weak evidence from sounding authoritative. |
| `unknownReason` | Why the state could not be determined. | Preserves trust when sources are missing. |
| `explanation` | Plain-language reason for the state. | Makes the finding useful to dev leads, QA leads, and release managers. |
| `recommendedAction` | One concrete human action. | Keeps alerts actionable. |
| `sourceFreshness` | Observation timestamps for Jira, Bitbucket, QA, and CI. | Prevents stale data from producing false confidence. |

## Source Truth Rules

| Release moment | Source-of-truth branch rule |
|---|---|
| Before code freeze | `develop` is the default code source of truth unless the release owner names another integration branch. |
| At code freeze | The release branch is the code source of truth. Release branches follow `release/r-xx.x`, such as `release/r-64.0`. A PR merged only to `develop` is not enough unless the release branch has that commit. |
| After code freeze | The release branch remains source of truth unless a documented patch, cherry-pick, or deployment tag overrides it. |
| Unknown branch | Ledger state should be `UNKNOWN` or `WARN`, not `PASS`. |

## Release Identity Policy

The monitor must not run a drift pulse from vague release language. The preferred release identity is the exact Jira `fixVersion`.

Acceptable release identity inputs:

- Exact `fixVersion`, such as `Mobilitas 2026.07.10`.
- Exact issue list from a release-scoped JQL result.
- Exact release page or plan that clearly names the `fixVersion`.
- Exact release branch plus confirmation of the matching `fixVersion`.

Ambiguous inputs such as `latest release`, `current release`, `next release`, `August release`, or `recent Mobilitas release` should fail closed. The agent may offer to help find candidate releases, but it must not choose one or produce drift counts until the user confirms the exact release identity.

Release branch evidence proves the code source of truth. The Jira `fixVersion` proves release scope. At code freeze, both are needed for high-confidence code readiness.

## Evidence Requirement Rules

The monitor should not decide that every story needs a directly attached PR and directly attached test. That creates friction and false alarms. It should decide what evidence is required from explicit team standards and observable Jira signals.

### Code Required

Use this decision order:

| Priority | Signal | Suggested Result |
|---|---|---|
| 1 | Explicit team standard, release policy, or Jira field says code is required. | `codeRequired = required` |
| 2 | Issue has a linked Bitbucket branch, PR, commit, or development panel entry. | `codeRequired = required` |
| 3 | Issue type is code-bearing for the team, such as Story, Bug, Tech Story, or Production Defect. | `codeRequired = conditional` until team mapping is confirmed. Production Defects default to `unknown` classification until code-required, config-only, data-fix, operational/runbook, or analysis/no-change is identified. |
| 4 | Label, component, summary marker, or parent epic indicates QA-only, test-only, documentation-only, analysis-only, or process-only work. | `codeRequired = not_required` or `conditional`, with source noted. |
| 5 | No rule or signal is available. | `codeRequired = unknown`; do not mark missing code as a blocker. |

For the Mobilitas sample, summary markers such as `QA ONLY` and `DEV ONLY` are useful hints, but they should not be the long-term source of truth. A dedicated Jira field, label convention, component rule, or team-standard mapping would be more reliable.

### Production Defect Classification

Do not assume every Production Defect requires code. Use this classification before requiring PR or commit evidence:

| Classification | Evidence Expectation | Health Handling |
|---|---|---|
| `code_required` | Branch, PR, commit, and source-truth branch evidence. | Missing code is `WARN` before freeze and may become `BLOCK` at freeze. |
| `config_only` | Configuration change, deployment note, change record, or owner-reviewed configuration evidence. | Do not require PR unless team policy says config changes live in code. |
| `data_fix` | Data-fix approval, execution evidence, or controlled change evidence. | Do not require PR unless the data fix is delivered through code. |
| `operational_runbook` | Runbook, operational action, or support execution evidence. | Treat missing execution evidence as `WARN` or `UNKNOWN` depending on stage. |
| `analysis_no_change` | Documented analysis or closure reason explaining why no change is required. | No code evidence required once accepted. |
| `unknown` | Classification is not clear. | Report `WARN` and ask for classification; do not auto-block before freeze. |

### Test Or QA Required

Use this decision order:

| Priority | Signal | Suggested Result |
|---|---|---|
| 1 | Explicit QA standard, release policy, test plan, or Jira field says validation is required. | `testRequired = required` or `qaRequired = required` |
| 2 | Issue is linked to a test plan, test execution, QA signoff, or validation story. | Required evidence can be satisfied by that shared coverage if mapped. |
| 3 | Issue type/team rule normally requires validation. | `testRequired = conditional` until the accepted evidence source is known. |
| 4 | Parent epic has a release test plan that names or traces covered stories. | Child story can inherit coverage if the ledger records the mapping. |
| 5 | No test rule or coverage signal is available. | `testRequired = unknown`; do not treat missing test links as a blocker. |

## Shared Evidence Coverage

Real releases often use shared evidence:

- One PR implements several Jira stories.
- One commit fixes or supports multiple Jira keys.
- One test plan covers a parent epic and its child stories.
- One regression suite validates several related changes.
- One QA signoff covers a grouped work package.

That is acceptable if the coverage is explicit. The ledger should not require duplicate PRs or duplicate test links on every story when the team intentionally uses shared evidence. It should require traceability.

| Shared Evidence Pattern | Acceptable When | Health Handling |
|---|---|---|
| One PR covers multiple stories | PR title, branch, description, Jira development links, or human-reviewed mapping lists the covered Jira keys. | Each covered story can reference the shared PR. Confidence depends on mapping strength. |
| One commit covers multiple stories | Commit message or PR context lists the covered keys, or a human-reviewed mapping exists. | Use lower confidence unless a PR or Jira development link confirms it. |
| Parent epic test plan covers child stories | Test plan or epic explicitly lists included stories, acceptance areas, or traceability markers. | Child stories can inherit test coverage through `coverageEvidence`. |
| Regression suite covers release scope | Suite names release scope, components, or stories clearly enough for QA lead acceptance. | Usually `WARN` or medium confidence unless story-level traceability exists. |
| Manual mapping covers exceptions | Dev lead, QA lead, or release owner documents why evidence applies. | Do not produce high-confidence `PASS` unless accepted by the appropriate owner. |

Coverage evidence should include:

- Evidence type: code, test, QA, documentation, or deployment.
- Evidence id or URL: PR id, commit hash, test plan id, QA run id, Confluence page, or similar.
- Covered Jira keys.
- Coverage scope: single story, shared PR, shared commit, parent epic, test plan, regression suite, release scope, or manual mapping.
- Coverage confidence: high, medium, or low.
- Plain-language explanation of why the evidence covers the story.

If shared evidence exists but does not identify which stories it covers, the correct state is usually `WARN` or `UNKNOWN`, not `PASS`.

## Shared Validation Anchor

For complex Epics, validation evidence should live in one clear Shared Validation Anchor rather than forcing duplicate test links onto every child story. The anchor may be:

- Parent Epic with linked or embedded test coverage.
- Dedicated QA-only story.
- Linked test plan or QA run.
- Confluence validation page accepted by the QA lead.

Child stories may inherit validation evidence from the anchor only when the anchor identifies covered Jira keys, child stories, components, acceptance areas, or QA-approved scope. If the anchor is broad but does not identify coverage, record release-level context but keep story-level confidence `WARN` or `UNKNOWN`.

## Pilot Drift Definition

For the first pilot, drift should mean one of these evidence mismatches:

| Drift Type | Starting State | Suggested Health State |
|---|---|---|
| Jira Done, no code evidence | Code-required Jira item is Done but no branch, PR, or commit evidence is found. | `WARN` before freeze; `BLOCK` at freeze if release-owned code is required. |
| PR open while Jira Done | Jira item is Done but the related Bitbucket PR is still open. | `WARN`; `BLOCK` at freeze if required for release. |
| Open PR evidence only | PR exists but is not merged into the source-truth branch. | Record as observed code evidence, but do not mark release-health `PASS`. Use `WARN` for active work when evidence is incomplete. |
| Merged outside source truth | PR or commit exists but is not in the source-truth branch. | `WARN` before freeze; `BLOCK` at freeze. |
| Missing tests | Test-required item lacks linked automated test, manual test note, or accepted team-standard evidence. | `WARN` until team rule says it blocks. |
| Failed test or QA | Required test or QA evidence is failed. | `BLOCK` when the failure applies to the release. |
| Missing fixVersion | Jira item appears in the release conversation but lacks the exact release fixVersion. | `WARN` or `UNKNOWN`, depending on source. |
| Source unavailable | Jira, Bitbucket, QA, or CI evidence cannot be read. | `UNKNOWN`; do not infer readiness. |

## Discovery Fallback Rules

Jira development panel links and Jira-keyed branch/PR metadata are the preferred way to discover Bitbucket evidence, but they are not the only valid source. The monitor may use Jira Web Links as a fallback evidence discovery path when the native Jira-Bitbucket integration is missing or unreliable.

| Fallback | Acceptable When | Confidence |
|---|---|---|
| Jira Web Link to Bitbucket PR | URL points to a PR and the PR title, branch, description, or linked Jira context contains the Jira key. | Medium to high, depending on source-truth branch verification, plus a hygiene `WARN` if preferred Jira-key linking is missing. |
| Structured Jira comment for Guidewire Bitbucket PR | Assignee, dev lead, QA lead, or release owner comments with PR URL, target branch, covered Jira keys, PR state, and validation state. | Medium when the comment is complete; low when branch, state, or covered keys are missing. |
| Jira Web Link to test plan or QA run | Link target identifies the release, parent epic, covered Jira keys, components, or accepted QA scope. | Medium unless story-level mapping is explicit. |
| Parent epic scan | Child story is In Progress, Done, near code freeze, test-required, test-conditional, or explicitly requested for deep validation review. | Medium when scope is explicit; low or `UNKNOWN` when scope is broad. |

When fallback discovery succeeds, the ledger should record both the evidence URL and the discovery route, such as `jira_web_link` or `parent_epic_scan`.

### Guidewire Bitbucket Fallback

During the Mobilitas pilot, Jira Development Panel links may point to CSAA Bitbucket while application repositories live in Guidewire Bitbucket. For ClaimCenter, PolicyCenter, BillingCenter, and ContactManager work, an empty Jira Development Panel is not proof that code evidence is absent.

Use this low-friction fallback order:

1. Jira Web Link to the Guidewire Bitbucket PR.
2. Structured Jira comment from the assignee, dev lead, QA lead, or release owner.
3. Human-reviewed mapping supplied in the handoff page or current release review.

Preferred structured Jira comment:

```text
Release evidence:
PR: [Guidewire Bitbucket PR URL]
Target branch: [develop or release/r-xx.x]
Jira keys covered: [KEY-123, KEY-456]
State: [open / merged / declined / unknown]
Validation: [pending / linked separately / not required / unknown]
```

If no Development Panel link, Jira Web Link, or structured comment exists, record code evidence as `UNKNOWN` unless Jira status, release stage, or explicit policy creates a separate `WARN` or `BLOCK` risk.

Do not deeply scan parent Epics for every Backlog or To Do item during daily pulses. Early Backlog or To Do items can remain `UNKNOWN` until they enter an evidence-bearing state.

## What Should Not Auto-Block At First

These signals are useful but should start as `WARN` until the pilot proves they are reliable:

- High PR churn.
- Large diff size.
- Many late commits.
- Missing test link when the team accepts another test evidence pattern.
- Ambiguous issue type rules.
- Branch names that lack Jira keys but PR title or commit message includes the key.

## Jira Query And Sample Data

Rovo can use JQL directly when Jira access is available. A CSV export is only a fallback or offline review artifact, not the preferred operating model.

Recommended Jira fields for either direct JQL retrieval or export-based review:

| Field | Why |
|---|---|
| Key | Reconciliation handle. |
| Issue Type | Helps determine whether code or test evidence may apply; do not use as the only rule. |
| Summary | Human explanation. |
| Status | Jira workflow state. |
| Status Category | Cross-team Done/In Progress/To Do normalization. |
| Resolution | Distinguishes Done from abandoned or duplicate. |
| Fix Version/s | Exact release scope. |
| Components | Routing and ownership clues. |
| Labels | Team standards and special handling. |
| Assignee | Follow-up owner candidate. |
| Reporter | Context owner candidate. |
| Updated | Freshness. |
| Linked Issues | Useful for QA, dependency, or parent relationships. |
| Parent Epic / Parent Link | Useful for shared test plan, grouped QA, or parent-level coverage. |
| Development field / Bitbucket links | Best available Jira-to-PR evidence if included. |
| Test fields | Team-specific Xray, Zephyr, checklist, QA, test plan, or custom test fields if present. |
| Deployment Notes | Useful when release readiness overlaps deployment evidence. |

Suggested starting JQL:

```text
fixVersion = "[AUGUST_RELEASE_FIXVERSION]" ORDER BY issuetype, key
```

If the release has more than one project:

```text
fixVersion = "[AUGUST_RELEASE_FIXVERSION]" AND project in ([PROJECT_KEYS]) ORDER BY project, issuetype, key
```

If you want to test only code-required stories first:

```text
fixVersion = "[AUGUST_RELEASE_FIXVERSION]" AND issuetype in (Story, Bug, Task) ORDER BY status, key
```

## Bitbucket Matching Rules

Use the strongest available match first:

| Match Strength | Evidence |
|---|---|
| Strong | Jira development panel links to Bitbucket PR or branch. |
| Strong | Branch name contains the Jira key. |
| Medium | PR title contains the Jira key. |
| Medium | Jira Web Link points to a Bitbucket PR and the PR title, branch, or description contains the Jira key. Include a hygiene warning if this is the only linkage. |
| Medium | Structured Jira comment from assignee, dev lead, QA lead, or release owner includes PR URL, target branch, covered Jira keys, and PR state. |
| Medium | Commit message contains the Jira key. |
| Low | Human-supplied mapping without visible link. |

For the pilot, a low-confidence match should not produce `PASS` without human review.

An open PR can prove work exists, but it does not prove the release branch or `develop` contains the change. Do not place an open PR under high-confidence `PASS`; classify it as observed evidence with `WARN` or incomplete code state until the PR is merged into the current source-truth branch.

## Consumer Responsibilities

| Consumer | Responsibility |
|---|---|
| Release Drift Monitor | Produces daily or cadence-based observations and writes or proposes ledger rows. |
| Release Health Analyst | Consumes final ledger state and drift history to produce release readiness summary and go/no-go support. |
| Human release owner | Decides final release readiness. |
| Dev lead / QA lead | Clears or accepts drift findings during the sprint. |

## Open Decisions

| Decision | Current Position | Owner Needed |
|---|---|---|
| Team-specific Done definitions | Use status category plus team-specific mapping during pilot. | Release manager / Jira project admin |
| Test evidence standard | Require test evidence only when issue type/team criteria say it applies. | QA lead |
| Shared Validation Anchor pattern | Recommended for complex Epics; parent Epic, QA-only story, test plan, or QA run can anchor shared evidence when scope is explicit. | QA lead / release owner |
| Production defect classification | Default to unknown; require classification before deciding whether PR, config, data-fix, operational, or analysis evidence is needed. | Dev lead / release owner |
| False-positive owner | Start with dev lead for code evidence, QA lead for test evidence, release owner for scope evidence. | Release owner |
| Ledger storage | Start as structured schema plus Confluence-readable table; evaluate external DB later. | Agent owner / platform owner |
| Alert delivery | Start with digest-only, no direct noisy pings. | Pilot team |
