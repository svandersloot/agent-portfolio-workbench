# Template - Release Drift Monitor Handoff Page

Use this template when Release Drift Monitor creates or updates the canonical Confluence handoff page for one exact release.

Create one normal Confluence page per release, not a live doc. Use this page title pattern:

```text
Release Drift Handoff - [Exact fixVersion]
```

Example:

```text
Release Drift Handoff - Mobilitas 2026.07.10
```

The handoff page is evidence for Release Health Analyst. It is not a final go/no-go decision.

## How To Use This Page

| Audience | Use |
|---|---|
| Dev leads | Link PRs, confirm merge target, fix wrong-branch evidence, and document shared PR mappings. |
| QA leads | Attach test plans, QA runs, signoff, or Shared Validation Anchors with covered Jira keys or accepted scope. |
| Release owners | Confirm scope, freeze date, accepted exceptions, deferrals, and Production Defect classification. |
| Release Health Analyst | Use this handoff as evidence only after verifying exact fixVersion, source-truth branch, source freshness, unresolved findings, and accepted exceptions. |

## Guidewire Bitbucket Evidence Workaround

If Jira Development Panel links point to CSAA Bitbucket but application PRs live in Guidewire Bitbucket, an empty Development Panel is not proof that code evidence is missing.

Preferred low-friction evidence:

1. Jira Web Link to the Guidewire Bitbucket PR.
2. Structured Jira comment:

```text
Release evidence:
PR: [Guidewire Bitbucket PR URL]
Target branch: [develop or release/r-xx.x]
Jira keys covered: [KEY-123, KEY-456]
State: [open / merged / declined / unknown]
Validation: [pending / linked separately / not required / unknown]
```

## Required Page Metadata

| Field | Value |
|---|---|
| Exact fixVersion | `[Exact Jira fixVersion]` |
| Release stage | `[Before code freeze / At code freeze / After code freeze]` |
| Code freeze target | `[YYYY-MM-DD or Unknown]` |
| Source-truth branch | `[develop / release/r-xx.x / documented override]` |
| Jira scope source | `[JQL, export, issue list, or release page]` |
| Jira issue count | `[count]` |
| Last pulse timestamp | `[timestamp and timezone]` |
| Prepared by | `Release Drift Monitor` |
| Intended consumer | `Release Health Analyst` |

## Current Snapshot

Keep this section current. Replace it on each approved update.

| State | Count | Meaning |
|---|---:|---|
| PASS | `[count]` | Required evidence exists in the expected source and is fresh enough. |
| WARN | `[count]` | Evidence is incomplete, inconsistent, late, stale, or likely risky. |
| BLOCK | `[count]` | Required release evidence contradicts readiness or a required gate failed. |
| UNKNOWN | `[count]` | Source access, indexing, mapping, or freshness prevents judgment. |

## Trend History

Append one row per approved pulse. Do not remove prior rows unless a human asks for cleanup.

| Pulse Date | Stage | Source Branch | PASS | WARN | BLOCK | UNKNOWN | New Drift | Resolved Drift | Data Gaps | Notes |
|---|---|---|---:|---:|---:|---:|---:|---:|---:|---|
| `[YYYY-MM-DD]` | `[stage]` | `[branch]` | `[count]` | `[count]` | `[count]` | `[count]` | `[count]` | `[count]` | `[count]` | `[short note]` |

## Actionable Findings

Group findings by owner, team, or Epic when release scope is large.

| Priority | Jira Key | Owner / Team | Finding | Evidence State | Recommended Action |
|---|---|---|---|---|---|
| `[P1/P2/P3]` | `[KEY]` | `[owner/team]` | `[finding]` | `[PASS/WARN/BLOCK/UNKNOWN]` | `[one action]` |

## Resolved Drift

Append items when drift is cleared.

| Cleared Date | Jira Key | Previous State | Resolution Evidence | Notes |
|---|---|---|---|---|
| `[YYYY-MM-DD]` | `[KEY]` | `[WARN/BLOCK/UNKNOWN]` | `[PR/test/QA/comment/link]` | `[short note]` |

## Shared Evidence And Validation Anchors

| Anchor / Evidence | Type | Covered Jira Keys Or Scope | Confidence | Notes |
|---|---|---|---|---|
| `[PR, test plan, QA run, Epic, or Confluence page]` | `[code/test/QA/deployment]` | `[keys or explicit scope]` | `[high/medium/low]` | `[why it applies]` |

## Accepted Exceptions

| Jira Key | Exception | Accepted By | Evidence Link Or Comment | Expiration / Follow-Up |
|---|---|---|---|---|
| `[KEY]` | `[exception]` | `[owner]` | `[link/comment]` | `[date/action]` |

## Data Incomplete Flags

| Source | Status | Impact | Needed Next |
|---|---|---|---|
| Jira | `[complete/incomplete/unknown]` | `[impact]` | `[next action]` |
| Bitbucket | `[complete/incomplete/unknown]` | `[impact]` | `[next action]` |
| Test / QA | `[complete/incomplete/unknown]` | `[impact]` | `[next action]` |
| Ledger / Handoff history | `[complete/incomplete/unknown]` | `[impact]` | `[next action]` |

## Release Health Analyst Handoff

Release Health Analyst should use this page as source evidence only after verifying:

- Exact fixVersion matches the requested release.
- Source-truth branch matches the release stage.
- Source freshness is acceptable.
- Unresolved `BLOCK`, `WARN`, and `UNKNOWN` findings are still current.
- Accepted exceptions are human-owned and documented.

Release Drift Monitor does not make final readiness or go/no-go recommendations.

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
