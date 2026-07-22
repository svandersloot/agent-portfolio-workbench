# CI Minimum Checks — Required vs Advisory for agent:draft-pr

Status: Minimum-check contract for the governed backlog execution loop (backlog item `8.9`; issue #50)
Companion to: `docs/governed-backlog-execution-loop.md` (§9 activation gates), `docs/reports/github-branch-protection-decision-brief-2026-07-21.md`, `docs/reports/github-main-protection-readback-2026-07-21.md` (live required-check configuration)

This document names the stable CI check(s) and defines which validations are **required** (blocking) versus **advisory** for `agent:draft-pr` eligibility and the S8 pilot.

## Stable check name

The single required status check is the job name:

```
repository-validation
```

(`.github/workflows/validation.yml`, triggered on every pull request and on pushes to `main`.) All blocking validations run as steps inside this one job so the required-check name stays stable for branch-protection configuration. Any failing blocking step makes the whole check fail — deterministic, machine-readable pass/fail for the loop.

## Required (blocking) validations

Every step in `repository-validation` is blocking; a non-zero exit fails the check:

| Step | What it enforces |
|---|---|
| Check committed diff whitespace | `git diff --check` over the PR range — whitespace errors and conflict markers |
| Scan tracked files for private data | `Test-PrivateDataScan.ps1 -Scope AllTracked` — secrets/private-data never land on `main`. **Blocking by explicit decision.** |
| Check stale handoffs | `Test-StaleHandoffs.ps1` — handoff freshness |
| Check Confluence page families | `Test-ConfluencePageFamilyConsistency.ps1` — page-family/source-link integrity |
| Parse JSON schemas | every `schemas/*.json` parses |
| Parse PowerShell scripts | every `*.ps1` under `scripts/` and `.claude/hooks/` parses (AST parser; catches syntax breakage in validation and hook tooling) |
| Run Deny-SecretRead hook offline suite | `Test-DenySecretReadHook.ps1` — the 50-case fixture suite guarding the PreToolUse hook and its exec-form settings wiring |

## Advisory (not blocking, intentionally omitted from the required set)

- Markdown link/format checking — the optional MVP item from #50; may be added later as a separate advisory job so it never destabilizes the required check name.
- Style/lint concerns beyond parseability.

## Relationship to agent:draft-pr eligibility and gate #4

- An issue is eligible for autonomous draft-PR execution only under the full conjunctive rule in `docs/governed-backlog-execution-loop.md` §4; a green `repository-validation` on the draft PR is the CI feedback the per-issue loop (S10) consumes, with at most two correction cycles (§7).
- `.github/workflows/**` is a protected path (§4): workflow changes are excluded from autonomous execution and require human review before merge.
- **S8 activation gate #4 is satisfied only when** `repository-validation` is both running **and designated as a required status check** in the `main` ruleset (the #49 decision brief, applied after the account upgrade, under separate approval, verified by GitHub read-back).

## Constraints

- CI runs repository checks only: no deploys, no live Jira/Confluence/Studio calls, no secrets (`permissions: contents: read`).
- Checks must not print protected file contents; the private-data scan reports findings by path/rule, and the hook suite asserts generic deny reasons.
