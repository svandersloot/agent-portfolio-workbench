# GitHub Main-Branch Protection Read-Back — 2026-07-21

Status: Live configuration verified by API read-back after the human-approved settings action
Companion to: `docs/reports/github-branch-protection-decision-brief-2026-07-21.md`, `docs/ci-minimum-checks.md`, `docs/governed-backlog-execution-loop.md` (§9 activation gates), issues #49/#50/#51

This report records the applied `main` branch ruleset and its read-back verification. It contains configuration facts only; no tokens, credentials, or private data.

## Context verified before applying

- Repository: **public**, owner type **User**, default branch **`main`**.
- No pre-existing rulesets, classic branch protection, or effective branch rules — no conflicts.
- Workflow job/check name confirmed exactly **`repository-validation`** (`.github/workflows/validation.yml`, extended by PR #68, merged 2026-07-21).
- `CODEOWNERS` is `* @svandersloot` — **no independent reviewer exists yet**; approving-review and code-owner-review requirements are deliberately deferred until a second acknowledged owner exists.
- History audit of all reachable refs (455 unique filenames ever tracked): the only sensitive-pattern match is `.env.example`, a placeholder-only template. No `.env`, HAR, cookie/token/secret/credential artifacts, `data/raw/`, `data/exports/`, or private manifest files were ever tracked. No history rewrite needed.

## Applied ruleset (single active branch ruleset)

- **Name:** `main-protection` · **ID:** `19465731` · **Target:** branch · **Enforcement:** `active`
- **Created:** 2026-07-21T19:36:53Z · **Read-back verified:** 2026-07-21T19:37:28Z

### Conditions

- Include: `refs/heads/main` only. Exclude: none. A probe of a non-target branch name returned zero effective rules.

### Rules (as read back live)

| Rule | Configuration |
|---|---|
| `pull_request` | Require a PR before merging; `required_approving_review_count: 0`; code-owner review **not** required; last-push approval **not** required; review-thread resolution **not** required; stale-review dismissal off; allowed merge methods: merge, squash, rebase (API default) |
| `required_status_checks` | Required check: **`repository-validation`** (exactly one); `strict_required_status_checks_policy: true` (branch must be up to date before merging) |
| `non_fast_forward` | Force pushes to `main` blocked |
| `deletion` | Deletion of `main` blocked |

### Bypass actors

- **None** (`bypass_actors: []`). Protections apply to admins; no standing bypass. Emergency override remains the documented procedure only: explicit approval → temporary ruleset change → restoration → read-back → receipt.

### Deliberately not enabled (per the approved policy)

Approving reviews (0 while solo-maintained), code-owner approval, signed commits, deployments, merge queue, automation identities or new bypass actors.

## Effect

- Changes reach `main` only through pull requests with a passing, up-to-date `repository-validation` check; direct pushes, force pushes, and branch deletion are refused for all actors including admins.
- This is the platform **process floor** accepted for S8 gate #3; merge remains human-only under the operating contract. The shared-credential residual risk and future machine-identity hardening item remain as recorded in the decision brief.
- Gate #4's "running **and required**" condition is now technically in place (extended check merged via PR #68 and designated required here); gate status changes themselves remain human-approved and are **not** made by this report.

## Boundaries respected

- Single settings action performed under explicit human approval: creation of ruleset `main-protection`. No billing, plan, visibility, permission, secret, ownership, label, project-field, issue-state, or merge action was performed.
