# Release Drift Monitor Project Brain

## Project Brain Status

| Field | Value |
|---|---|
| Agent name | Release Drift Monitor |
| Domain | Release and Change Management |
| Lifecycle status | Draft |
| Readiness status | Needs Cleanup |
| Fit decision | Agent candidate for discovery, then experimental pilot |
| Primary owner | TBD |
| Backup owner | TBD |
| Related existing agent | Release Health Analyst |
| Shared contract | Release Evidence Ledger Contract |
| Target pilot | August release candidate, subject to source readiness |
| Last reviewed | 2026-05-28 |
| Next action | Pilot controlled handoff page workflow and Guidewire Bitbucket fallback evidence using Jira Web Links or structured Jira comments. |

## Mission

Release Drift Monitor is an early-warning agent for release evidence drift. It helps dev leads, QA leads, and release owners see when Jira release status, Bitbucket code evidence, test evidence, and QA evidence stop agreeing before code freeze.

The monitor should reduce surprise at code freeze. It should not make final release decisions.

## Relationship To Release Health Analyst

| Agent | Role | Boundary |
|---|---|---|
| Release Drift Monitor | Early warning during the sprint. | Detects and explains evidence mismatches. Does not produce final go/no-go recommendations. |
| Release Health Analyst | Code-freeze and on-demand decision support. | Consumes final ledger state and drift history. Produces readiness summary for release managers and change stakeholders. |

The two agents share the Release Evidence Ledger. The Drift Monitor appends or proposes observations. The Health Analyst consumes those observations as release history.

## Scope

### In Scope

- Identify Jira items in a target release or fixVersion.
- Determine whether code, test, QA, documentation, or no extra evidence is expected.
- Reconcile Jira status with Bitbucket branch, PR, and commit evidence.
- Use Jira Web Links as fallback discovery for PRs, test plans, QA runs, and Confluence evidence when native panels are missing or incomplete.
- Warn when Jira Web Link is the only PR linkage because preferred branch, PR title, PR description, commit, or native development-link practice is missing.
- Use adaptive parent Epic and QA-only story scans for In Progress, Done, near-freeze, test-required, test-conditional, or user-requested deep checks.
- Support Shared Validation Anchors for complex Epics: parent Epic, QA-only story, test plan, QA run, or Confluence validation page with explicit covered keys or accepted scope.
- Classify Production Defects before requiring code evidence: code-required, config-only, data-fix, operational/runbook, analysis/no-change, or unknown.
- Use approved ClaimCenter, PolicyCenter, BillingCenter, and ContactManager repositories for read-only code evidence checks.
- Apply source-truth branch rules: `develop` before code freeze, release branch at code freeze. Release branches follow `release/r-xx.x`, such as `release/r-64.0`.
- Flag missing or failed test evidence when the team rule says tests are required.
- Produce a daily or cadence-based health pulse.
- Create or update one templated Confluence handoff page per exact release after human approval.
- Append or update handoff trend history to support release-risk and ROI tracking.
- Explain `PASS`, `WARN`, `BLOCK`, and `UNKNOWN` states in plain language.
- Preserve unknowns instead of inventing readiness.

### Out Of Scope

- Final go/no-go recommendation.
- Jira transitions, PR approvals, merge actions, or deployment approvals.
- Unrestricted, untemplated, duplicate, or delete-oriented Confluence writes.
- Replacing QA signoff.
- Inferring team-specific Done definitions without documented mapping.
- Broad health scoring already owned by Release Health Analyst.
- Noisy real-time alerting before pilot thresholds are proven.

## Pilot Drift Definition

For the first pilot, the monitor focuses on high-trust reconciliation:

| Condition | Drift Finding |
|---|---|
| Code-required Jira item is Done with no Bitbucket branch, PR, or commit evidence. | Jira Done without verified code evidence. |
| Jira item is Done but related PR is still open. | Status ahead of code merge. |
| Related code exists but is not in the current source-truth branch. | Code evidence in wrong branch for release stage. |
| Test-required item lacks accepted test evidence. | Missing validation evidence. |
| Required test or QA evidence failed. | Failed validation evidence. |
| Required source is inaccessible or stale. | Health state unknown due to missing source evidence. |

## Operating Model

1. User or schedule supplies exact release identifier, Jira project/filter, and release stage.
2. Monitor collects Jira scope and status evidence.
3. Monitor determines expected evidence by issue type and team standards.
4. Monitor checks Bitbucket-linked branch, PR, and commit evidence.
5. Monitor checks available test and QA signals.
6. Monitor writes or proposes ledger records using the Release Evidence Ledger Contract.
7. Monitor returns a compact health pulse showing only changed or actionable findings.
8. For handoff runs, Handoff Summarizer creates or updates one templated Confluence handoff page after human approval.
9. Health Pulse Summarizer may update the current snapshot and append trend-history rows on the existing handoff page after human approval.
10. Humans clear findings in source systems or document accepted exceptions.

## Health State Contract

| State | Meaning | Use Carefully |
|---|---|---|
| `PASS` | Required evidence exists in the expected source and is fresh enough for the release stage. | Do not use when evidence is low-confidence. |
| `WARN` | Evidence is incomplete, inconsistent, late, stale, or likely risky, but not yet a confirmed release blocker. | Default for ambiguous pilot findings. |
| `BLOCK` | Required release evidence contradicts readiness or a required gate failed. | Use sparingly until pilot rules are trusted. |
| `UNKNOWN` | Source access, indexing, mapping, or freshness prevents judgment. | Prefer this over unsupported inference. |

## Alert Strategy

Start with digest-first alerts:

- One daily Health Pulse per release or pilot team.
- Include only new, worsened, or unresolved high-severity findings.
- Group by owner/team when possible.
- Keep `UNKNOWN` visible but separate from confirmed risk.
- Do not page or direct-message individuals until false-positive rates are understood.

Suggested digest limits:

| Limit | Starting Rule |
|---|---|
| Frequency | Once daily during sprint; optional manual run near code freeze. |
| Detail | Top 10 actionable findings, grouped by `BLOCK`, `WARN`, then `UNKNOWN`. |
| Noise control | Suppress unchanged low-risk warnings after two consecutive pulses unless they worsen. |
| Escalation | `BLOCK` at code freeze routes to release owner plus dev/QA lead. |

## Required Linked Artifacts

| Artifact | Page |
|---|---|
| Shared Contract | Release Evidence Ledger Contract |
| Agent Design Record | Release Drift Monitor - Agent Design Record |
| Knowledge Source Plan | Knowledge Source Plan - Release Drift Monitor |
| Subagent Settings | Subagent Settings - Release Drift Monitor |
| ROVO Studio Configuration | ROVO Studio Configuration - Release Drift Monitor |
| Evaluation | Evaluation - Release Drift Monitor |
| Measurement Plan | Measurement Plan - Release Drift Monitor |
| Handoff Template | Template - Release Drift Monitor Handoff Page |
| Pilot Value Model | Release Drift Monitor Pilot Value Model |
| Pilot Tracking Plan | Release Drift Monitor Pilot Tracking Plan |
| Change Log | Change Log - Release Drift Monitor |

## Known Gaps

| Gap | Impact | Remediation |
|---|---|---|
| Primary and backup owners are TBD. | Cannot promote beyond candidate or experimental pilot. | Assign accountable owner and delegate. |
| Team-specific Done definitions are not documented. | Done vs code/test evidence rules may create false positives. | Build team mapping from real Jira workflow data. |
| Test evidence sources vary by team. | Missing-test warnings may be noisy. | Identify accepted test fields, links, or QA conventions. |
| Bitbucket enforcement level is unclear. | Jira-key matching may miss valid work. | Validate branch, PR title, and commit-message patterns in a sample. |
| Application repo scope needs release-by-release confirmation. | Agent may check a repo that is not relevant to a release. | Confirm which approved repos are in scope for each release pulse. |
| Jira Development Panel points to CSAA Bitbucket for some app work. | Empty development panel may create false missing-code findings for Guidewire-hosted application repos. | Use Guidewire Bitbucket PR Web Links or structured Jira release-evidence comments as fallback evidence. |
| Jira Web Link hygiene warnings need pilot calibration. | Valid fallback evidence may still indicate team practice drift. | Warn when Web Link is the only PR linkage; prefer Jira-keyed branch, PR title, PR description, commit, or native development link. |
| Shared Validation Anchor rules need team rollout. | Shared test evidence may not safely satisfy child stories if coverage is vague. | QA lead defines accepted anchors and how covered Jira keys, components, acceptance areas, or QA-approved scope are listed. |
| Production defect classification is not formalized in Jira. | Config-only, data-fix, or analysis-only work may be incorrectly flagged for missing PRs. | Define code-required, config-only, data-fix, operational/runbook, analysis/no-change, and unknown handling. |
| Ledger storage is not finalized. | Long-term automation and auditability remain open. | Start with schema plus Confluence-readable records; revisit external DB later. |
| Handoff page write workflow is newly enabled. | Duplicate pages, stale handoff references, or untemplated output could confuse Release Health Analyst. | Use one canonical page per exact fixVersion, parent validation, human approval, and the handoff template. |

## Launch Decision

Current decision: keep as Draft candidate.

Promote to Experimental only after direct JQL results or a representative Jira export plus one Bitbucket-linked sample prove the ledger can classify at least code-required Jira items with acceptable false-positive rates.
