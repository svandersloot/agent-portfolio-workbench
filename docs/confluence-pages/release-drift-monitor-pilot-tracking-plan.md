# Release Drift Monitor Pilot Tracking Plan

## Purpose

This page defines how the Release Drift Monitor pilot will be reviewed during Mobilitas release cycles and how its evidence will feed Release Health Analyst.

The pilot is intended to make evidence gaps visible earlier, improve story and source hygiene over time, and create a clean code-freeze handoff. It does not make final release readiness decisions.

## Pilot Scope

| Field | Value |
|---|---|
| Pilot focus | Mobilitas release evidence drift before code freeze |
| Initial active handoff date | 2026-06-23 code freeze |
| Daily pulse owner | TBD |
| Review participants | Release owner, QA lead or delegate, delivery lead or delegate, Release Drift Monitor operator |
| Downstream consumer | Release Health Analyst |
| Final readiness owner | Human release owner |

## Daily Pulse Review

Each daily pulse should be reviewed as a source-hygiene and release-evidence signal, not as a release decision.

| Step | Review Action | Output |
|---|---|---|
| Confirm release identity | Verify exact release name, fixVersion, source branch, and release stage. | Pulse is accepted for the intended release or marked invalid. |
| Scan open findings | Review unresolved `BLOCK`, `WARN`, and `UNKNOWN` findings first. | Findings are assigned a disposition and next owner. |
| Separate risk from noise | Decide whether each finding is an actual release risk, missing source evidence, stale evidence, accepted exception, or false positive. | Disposition table is updated. |
| Push fixes to source | Ask teams to update Jira, PRs, QA evidence, Confluence, or exception notes in the source system. | Source record improves before the next pulse. |
| Track repeated themes | Identify recurring gaps by team, evidence type, source, or rule. | Coaching log and tuning backlog are updated. |
| Preserve trend | Record counts and notable deltas. | Measurement plan and handoff trend table stay usable. |

## Disposition Categories

Use a consistent disposition for every material finding. A finding can be real and still not be a blocker.

| Category | Meaning | Expected Follow-up |
|---|---|---|
| True release risk | Evidence indicates a real unresolved blocker, risk, or readiness gap. | Assign owner, action, due date, and release impact. |
| Source hygiene gap | Work may be acceptable, but Jira, PR, QA, or Confluence evidence is incomplete or hard to verify. | Update the source record and track as coaching opportunity. |
| Accepted exception | A human owner accepts residual risk or a release caveat. | Record accepting owner, rationale, residual risk, and revisit condition. |
| Stale or inaccessible evidence | Evidence exists but freshness, permissions, or source ownership is unclear. | Refresh source, grant access, or identify authoritative owner. |
| Rule tuning needed | The monitor found a pattern, but the check is too broad, too strict, or missing team context. | Add to tuning backlog with example keys and desired behavior. |
| False positive | The finding is not a real gap after source review. | Record why, source proof, and whether rule or mapping should change. |
| Not actionable | The finding is too vague to assign or correct. | Tighten prompt/check wording or suppress until evidence improves. |

## Metrics To Track

The Measurement Plan remains the metric source of truth. During each pulse review, capture enough data to maintain these measures without mining page history later.

| Metric Area | What To Capture | Why It Matters |
|---|---|---|
| Open findings | Counts of `PASS`, `WARN`, `BLOCK`, and `UNKNOWN` by pulse. | Shows whether evidence quality is improving before freeze. |
| New versus carryover | Which findings are new, repeated, resolved, or severity-changed. | Separates fresh risk from aging hygiene debt. |
| False positives | Count, theme, affected rule, and source proof. | Shows whether the monitor is becoming more trusted. |
| Source hygiene fixes | Jira comments, PR links, branch evidence, QA links, exception notes, or Confluence updates added after a pulse. | Shows whether the pilot changes team behavior. |
| Time to clear | First seen date, owner assignment date, source update date, and cleared date. | Measures whether gaps are moving earlier in the cycle. |
| Unknown reduction | `UNKNOWN` count by source area and reason. | Measures access, freshness, and ownership improvement. |
| Handoff reuse | Whether Release Health Analyst referenced the handoff or recorded why it did not. | Tests whether pre-freeze evidence improves readiness assessment. |
| Late surprises | New readiness items first discovered after code freeze or during final approval. | Measures whether early drift monitoring reduced release surprises. |

## Review Log Template

Use this table on the release-specific tracking page or in the daily pulse child page.

| Pulse Date | Release Stage | Total Findings | New | Carryover | Resolved | False Positives | Source Hygiene Fixes | Coaching Themes | Notes |
|---|---|---:|---:|---:|---:|---:|---:|---|---|
| TBD | TBD | TBD | TBD | TBD | TBD | TBD | TBD | TBD | TBD |

## Finding Disposition Template

| Finding ID Or Jira Key | Evidence Area | Status | Disposition | Owner | Source Update Needed | Due Date | Release Impact | Rule Tuning Needed |
|---|---|---|---|---|---|---|---|---|
| TBD | TBD | `WARN` | TBD | TBD | TBD | TBD | TBD | TBD |

## Coaching And Source Hygiene Log

Use this log to convert noisy pilot findings into team guidance instead of treating every repeat finding as a release escalation.

| Theme | Example Evidence | Affected Team Or Source | Coaching Message | Source Standard To Improve | Status |
|---|---|---|---|---|---|
| Missing PR linkage | TBD | TBD | Link PR, branch, or commit evidence from Jira. | Jira-keyed PR title, branch name, PR description, commit, Web Link, or structured release-evidence comment. | Open |
| Missing QA evidence | TBD | TBD | Link accepted test evidence where release owner and QA can verify it. | QA run, test plan, Confluence validation anchor, or approved Jira comment. | Open |
| Unclear accepted exception | TBD | TBD | Record who accepted the risk and what must be revisited. | Accepted owner, rationale, residual risk, revisit trigger. | Open |

## Rule Tuning Backlog

| Rule Or Check | Symptom | Example Keys | Proposed Adjustment | Decision |
|---|---|---|---|---|
| TBD | TBD | TBD | TBD | TBD |

## Code-Freeze Handoff

At code freeze on 2026-06-23, create the canonical Release Drift Handoff page for the exact Mobilitas release.

The handoff should include:

- release identity and source-truth branch,
- daily pulse trend summary,
- unresolved `BLOCK`, `WARN`, and `UNKNOWN` findings,
- accepted exceptions and human owners,
- source freshness and inaccessible-source notes,
- source hygiene improvements completed before freeze,
- false-positive and tuning themes that should not be treated as final readiness blockers,
- remaining questions for Release Health Analyst and the release owner.

## Release Health Analyst Boundary

Release Health Analyst should use the Release Drift Handoff as code-freeze baseline evidence for the first July assessment.

After the first assessment, Release Health Analyst owns the readiness record. The handoff remains historical baseline evidence, but newer Jira, QA, deployment, release-note, owner, Confluence, and release assessment evidence supersedes it.

Release Drift Monitor findings must not become automatic go/no-go decisions. Final readiness remains human-owned.

## Benefit Review

Review benefits after the July handoff and again after at least two complete pulse cycles.

| Benefit Question | Evidence To Compare |
|---|---|
| Were important gaps found before code freeze? | First pulse date versus code-freeze or final readiness discovery date. |
| Did teams fix source records earlier? | Source hygiene fixes logged after daily pulses. |
| Did false positives decline? | Disposition trend and rule tuning backlog. |
| Did `UNKNOWN` volume fall? | First pulse counts versus latest pre-freeze pulse and handoff. |
| Did Release Health Analyst start cleaner? | Initial July assessment source completeness and carryover/new-scope classification. |
| Were late surprises reduced? | Items first found after code freeze or during final approval. |

## Commit-Safe Evidence Rules

- Keep raw Studio and Confluence Automation exports out of Git.
- Commit sanitized captures only after redacting account IDs, cloud IDs, connection IDs, rule IDs, component IDs, checksums, ARIs, page IDs, space IDs, and private URLs.
- Do not write to Studio directly from Codex.
- For Confluence publishing, run a dry-run before any apply.
