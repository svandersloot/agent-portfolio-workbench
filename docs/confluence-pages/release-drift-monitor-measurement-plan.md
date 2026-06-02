# Measurement Plan - Release Drift Monitor

## Measurement Status

| Field | Value |
|---|---|
| Agent | Release Drift Monitor |
| Lifecycle status | Draft |
| Readiness status | Needs Cleanup |
| Measurement maturity | Draft |
| Review cadence | Per pilot pulse and release-based review |

## Value Hypothesis

Release Drift Monitor should reduce late release surprises by detecting Jira, code, test, and QA evidence mismatches before code freeze.

## Operating Tracker

Use `Release Drift Monitor Pilot Tracking Plan` for the daily pulse review workflow, finding dispositions, coaching log, source-hygiene improvements, rule tuning backlog, and Release Health Analyst handoff boundary.

This page remains the metric source of truth. The tracking plan defines how the pilot records enough operating evidence to keep these measures usable over time.

## Metrics

| Metric | Baseline | Target | Measurement Method | Cadence |
|---|---|---|---|---|
| Early drift findings | TBD | Meaningful drift found before code freeze when present | Compare daily pulse to final release assessment | Per pulse |
| False-positive rate | TBD | Less than 20 percent after two pilot pulses | Human disposition of WARN/BLOCK findings | Per pulse |
| Unknown evidence rate | Initial sample has Bitbucket/test/QA unknown | Downward trend as sources improve | Count `UNKNOWN` findings by source | Per pulse |
| Code-freeze surprise rate | TBD | Fewer new blockers first discovered at freeze | Compare Drift Monitor history to Release Health Analyst report | Per release |
| Time to clear drift | TBD | Open findings trend down before code freeze | Track unresolved findings across pulses | Per release |
| Handoff reuse by Release Health Analyst | TBD | Handoff page considered for every release where Drift Monitor ran | Release Health Analyst readiness review references the handoff page or records why it was not used | Per release |
| Resolved drift before freeze | TBD | Increasing count of drift items cleared before code freeze | Trend History rows on the handoff page | Per release |
| Unknown reduction before freeze | TBD | `UNKNOWN` count decreases as source evidence is linked | Compare first and latest handoff page snapshots | Per release |
| Guidewire fallback adoption | TBD | Dev teams use Web Links or structured comments for app PRs when Development Panel cannot see Guidewire Bitbucket | Count findings cleared by `jira_web_link` or `structured_jira_comment` discovery route | Per pulse |

## Quality And Risk Signals

| Signal | Good | Warning | Action |
|---|---|---|---|
| Source specificity | Exact fixVersion and branch stage are known. | User asks for latest or broad release. | Ask for exact release metadata. |
| Code evidence confidence | Jira dev link or Bitbucket branch/PR/commit evidence maps strongly to key. | Only low-confidence human mapping exists. | Require review before PASS. |
| Test evidence clarity | QA lead confirms accepted evidence source. | Test standard varies or is unknown. | Use WARN/UNKNOWN and document team rule. |
| Alert quality | Findings include one actionable next step. | Digest repeats stale low-risk warnings. | Suppress unchanged low-risk items. |
| Boundary control | Final readiness routes to Release Health Analyst. | Monitor starts making go/no-go recommendations. | Update instructions and rerun evaluation. |
| Handoff page control | One templated handoff page exists per exact fixVersion. | Duplicate pages, untemplated output, or missing approval. | Stop publishing, reconcile canonical page, and rerun publish-safety evaluation. |
| Guidewire fallback quality | Web Link or structured comment includes PR URL, target branch, covered keys, state, and validation state. | Comment says "code done" without link, branch, or state. | Ask for complete structured release-evidence comment. |

## Reporting Table

| Release | Pulse Date | Stage | Source Branch | Rows Checked | PASS | WARN | BLOCK | UNKNOWN | False Positives | Notes |
|---|---|---|---|---|---|---|---|---|---|---|
| Mobilitas 2026.07.10 | 2026-05-27 | Pre-freeze sample | develop assumed, not verified | 48 | N/A | N/A | N/A | Bitbucket/test/QA unknown | TBD | Jira CSV has scope/status/deployment notes only. |
| Mobilitas 2026.07.10 | 2026-05-28 | Manual pre-freeze pilot | develop | 48 | 0 | 2 | 0 | 46 | TBD | Web Link fallback found PR `#3442`; parent Epic `CLE-114` scan found no specific Copart validation evidence yet. |

## Handoff Page Trend Table

Each canonical handoff page should include this trend table so ROI can be measured without mining Confluence page version history.

| Pulse Date | Stage | Source Branch | PASS | WARN | BLOCK | UNKNOWN | New Drift | Resolved Drift | Data Gaps | Notes |
|---|---|---|---:|---:|---:|---:|---:|---:|---:|---|
| TBD | TBD | TBD | TBD | TBD | TBD | TBD | TBD | TBD | TBD | First pilot handoff not yet created. |

Use the trend table to show:

- Drift found before code freeze.
- Drift resolved before Release Health Analyst final review.
- Unknown evidence reduced as Jira, Bitbucket, test, and QA links improve.
- Warnings accepted as human-owned exceptions.
- Whether Release Health Analyst reused the handoff page.

## Pilot Learning Signals

| Signal | Observation | Measurement Impact |
|---|---|---|
| Jira Web Link fallback | Manual testing found a Bitbucket PR through a Jira Web Link when the native development panel was unavailable. | Track how often fallback links clear code-evidence UNKNOWN findings and how often they produce hygiene warnings for missing preferred Jira-key linkage. |
| Shared Validation Anchor scan | Parent Epic and associated stories were useful search scope for shared QA evidence, even though no specific matching evidence was found yet. | Track whether adaptive parent Epic, QA-only story, test-plan, QA-run, or Confluence anchor scans reduce false missing-test warnings. |
| High UNKNOWN rate | 46 of 48 items were UNKNOWN while still To Do or Backlog. | Treat early UNKNOWN volume as source readiness signal, not release failure. |
| Production defect classification | `MR26-308` needed code-required vs config-only confirmation. | Track dispositions across code-required, config-only, data-fix, operational/runbook, analysis/no-change, and unknown. |

## Review Cadence

- Candidate discovery: review after each real data sample.
- Experimental pilot: review after each daily pulse for the first release.
- First lifecycle review: after the August pilot or after two complete pulse cycles.

## Promotion Evidence Needed

- Named primary and backup owner.
- One pilot release with real Jira and Bitbucket evidence.
- Team-specific Done/status mapping.
- Accepted test/QA evidence source.
- False-positive disposition captured.
- Release Health Analyst handoff tested.
