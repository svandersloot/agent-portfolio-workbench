# User Guide - Release Drift Monitor Handoff Pages

Use this guide when sharing Release Drift Monitor output with dev leads, QA leads, release owners, and Release Health Analyst.

Release Drift Monitor is an early-warning evidence drift monitor. It helps teams see where Jira scope, Bitbucket code evidence, validation evidence, and release-stage expectations are not yet aligned.

It is not a final readiness or go/no-go recommendation.

## How To Read The Handoff Page

| Section | What To Look For | What To Do |
|---|---|---|
| Release metadata | Exact fixVersion, release stage, code-freeze target, and source-truth branch. | Confirm the release identity and branch assumptions are correct before acting on findings. |
| Current Snapshot | Counts for `PASS`, `WARN`, `BLOCK`, and `UNKNOWN`. | Use the counts as a risk signal, not as a readiness decision. |
| Trend History | Whether `WARN`, `BLOCK`, and `UNKNOWN` counts improve over time. | Use the trend to show whether evidence gaps are being cleared before code freeze. |
| Actionable Findings | Owner, issue, evidence route, confidence, and one recommended action. | Start with owner-assigned `WARN` and `BLOCK` rows, then triage actionable `UNKNOWN` rows. |
| Data Incomplete Flags | Sources that are missing, stale, or not linked. | Fix source hygiene: Jira links, Bitbucket PRs, test plans, QA signoff, or accepted exceptions. |
| Release Health Analyst Handoff | Evidence the final readiness agent should consider. | Release Health Analyst verifies the handoff before using it in final readiness analysis. |

## Health States

| State | Meaning | Typical Resolution |
|---|---|---|
| `PASS` | Required evidence exists in the expected source and is fresh enough for the release stage. | No action unless evidence becomes stale or the release stage changes. |
| `WARN` | Evidence is incomplete, inconsistent, late, stale, or likely risky. | Link missing PRs, merge to source-truth branch, attach validation evidence, classify work, or document an accepted exception. |
| `BLOCK` | A required release gate failed or evidence contradicts readiness. | Escalate to release owner and responsible dev/QA lead; clear the gate, fix the contradiction, defer scope, or document an approved exception. |
| `UNKNOWN` | Source access, indexing, mapping, or freshness prevents judgment. | Provide the missing source, owner, Jira link, PR, test evidence, QA signoff, or classification. |

Before code freeze, `BLOCK` should be rare. In Progress work with missing PR, commit, or test evidence is usually `WARN` or `UNKNOWN` unless a hard gate has already failed or release policy says it blocks.

## Common Actions By Role

| Role | Primary Actions |
|---|---|
| Dev lead | Confirm source-truth branch, link PRs/branches/commits to Jira keys, merge approved PRs to the correct branch, and document shared PR mappings. |
| QA lead | Attach test plan, QA run, signoff, or Shared Validation Anchor; map broad validation evidence to covered Jira keys or accepted scope. |
| Release owner | Confirm scope, stage, freeze date, accepted exceptions, deferred items, and Production Defect classification. |
| Release Health Analyst | Use the handoff as evidence only after verifying exact fixVersion, branch, source freshness, unresolved findings, and accepted exceptions. |

## Guidewire Bitbucket Evidence Workaround

During the Mobilitas pilot, Jira Development Panel links may point to CSAA Bitbucket while the application PRs live in Guidewire Bitbucket. That means an empty Development Panel does not always mean code evidence is missing.

Lowest-friction options for dev teams:

1. Add the Guidewire Bitbucket PR URL as a Jira Web Link.
2. Or add this structured Jira comment:

```text
Release evidence:
PR: [Guidewire Bitbucket PR URL]
Target branch: [develop or release/r-xx.x]
Jira keys covered: [KEY-123, KEY-456]
State: [open / merged / declined / unknown]
Validation: [pending / linked separately / not required / unknown]
```

The Release Drift Monitor treats a complete comment from the assignee, dev lead, QA lead, or release owner as medium-confidence code-evidence mapping. An open PR remains `WARN` until merged to the source-truth branch. A merged PR clears code evidence only; `PASS` still requires all required validation evidence.

## Prompt Templates

### Initial Pulse

```text
Run a Release Drift Daily Pulse for fixVersion "[FIXVERSION]".

Release stage: [Before code freeze / At code freeze / After code freeze]
Code freeze target: [YYYY-MM-DD]
Source-truth branch: [develop / release branch]

Use this as a pilot early-warning drift digest, not a final readiness or go/no-go recommendation.

Include:
- Days until code freeze
- Counts by PASS/WARN/BLOCK/UNKNOWN
- Source freshness
- Top actionable WARN/BLOCK/UNKNOWN findings grouped by owner or team
- Evidence route and confidence
- Data incomplete flags
- Next data needed
- Trend History row for the handoff page

Use pre-freeze severity discipline when applicable:
- Do not use BLOCK before code freeze unless a hard gate is already failed, evidence contradicts readiness, or policy says it blocks.
- Do not mark PASS from Jira status, sprint assignment, priority, or owner alignment alone.
```

### Update Existing Handoff Page

```text
Update the existing Release Drift Handoff page for fixVersion "[FIXVERSION]".

Existing handoff page: [PASTE PAGE LINK]
Release stage: [Before code freeze / At code freeze / After code freeze]
Code freeze target: [YYYY-MM-DD]
Source-truth branch: [develop / release branch]

Compare against the current handoff page and update only:
- Current Snapshot
- Trend History
- New or worsened findings
- Resolved drift
- Data incomplete flags

Do not create a duplicate page.
Do not overwrite accepted exceptions or Release Health Analyst notes.
Do not make a final readiness or go/no-go recommendation.

Before writing, summarize the planned changes and ask for approval.
```

### Stakeholder Review

```text
Review this Release Drift Handoff page for fixVersion "[FIXVERSION]" from the perspective of [Dev Lead / QA Lead / Release Owner].

Call out:
- Findings that are actionable
- Findings that look wrong or stale
- Missing evidence sources
- Owner corrections
- Validation or shared test anchor updates
```

## Feedback To Collect During Pilot

| Question | Why It Matters |
|---|---|
| Are the actions clear enough to assign? | Validates whether the handoff reduces coordination work. |
| Are the owners correct? | Reduces false routing and noise. |
| Which findings are false positives? | Calibrates `WARN`, `BLOCK`, and `UNKNOWN` rules. |
| What evidence should count for QA validation? | Improves test evidence matching and Shared Validation Anchor rules. |
| Did this reveal risk earlier than normal? | Measures value against code-freeze surprise reduction. |
