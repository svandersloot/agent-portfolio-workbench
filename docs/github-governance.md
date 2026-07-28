# GitHub Governance

Status: Canonical record of this repository's GitHub platform governance — branch
protection, security/supply-chain settings, Actions posture, code ownership, and the
staged collaboration plan.

Companion to: `docs/reports/github-branch-protection-decision-brief-2026-07-21.md`
(the human decisions), `docs/reports/github-main-protection-readback-2026-07-21.md`
(the live ruleset read-back), `docs/ci-minimum-checks.md` (required-vs-advisory CI),
`SECURITY.md` (vulnerability reporting), `.github/CODEOWNERS`, `.github/dependabot.yml`.

This document is the single place that describes **how GitHub itself is configured to
protect this repository**. `AGENTS.md` remains the canonical operating contract for
AI-assisted work; this file is the platform-governance record it points to. Repository
settings recorded here were applied by the human account owner. Changing GitHub settings
is a Human-Owned Decision under `AGENTS.md`; this document records state and plan — it
does not authorize an agent to change settings.

## Repository posture

- Visibility: **public**, owner type **User**, default branch **`main`**.
- Maintainership: **one solo maintainer today**, with independent collaborators expected
  later. Several settings below are deliberately staged for that transition.
- All repository-file changes go through a pull request on a feature branch. Direct
  pushes to `main` are blocked for all actors, including admins.

## Branch protection — `main` ruleset

The active `main-protection` ruleset (id `19465731`, enforcement `active`) applies to
`refs/heads/main` and requires:

- A pull request before merging.
- The GitHub Actions status check **`repository-validation`** to pass
  (`.github/workflows/validation.yml`; see `docs/ci-minimum-checks.md`).
- The PR branch to be up to date with `main` before merging
  (`strict_required_status_checks_policy: true`).
- All PR conversations resolved before merging.
- Force pushes and branch deletion blocked.

### Staged solo-maintainer settings (deliberately deferred)

Held at their current values on purpose while the repo is solo-maintained:

- **Required approvals: 0.** GitHub forbids self-approval, so requiring ≥1 review would
  block the sole maintainer's own PRs. Raise to 1 only when a second acknowledged owner
  exists.
- **Repository-admin emergency bypass: Always allow.** The Repository admin role retains
  a standing bypass for genuine emergency recovery only. Everyday changes still go
  through the PR + check floor.
- **No** deployment, release, environment, linear-history, signed-commit,
  code-owner-review, code-quality, or coverage gate is required.

> Note on bypass: this handoff's staged posture keeps a **repository-admin emergency
> bypass ("Always allow")**. The earlier decision brief and read-back recorded
> `bypass_actors: []` with an emergency *procedure* (temporary ruleset change →
> restoration → read-back → receipt) instead of a standing bypass. Whichever is live in
> GitHub is the source of truth; reconciling the two is a Human-Owned Decision. Either
> way, admin bypass is for **emergency recovery only**, never routine merges.

### Staged collaboration plan

When at least one independent maintainer is reliably available, update `main-protection`
to:

- Require **one** approving review.
- **Dismiss stale approvals** on new pushes.
- Require approval of the **most recent reviewable push**.
- Require **code-owner review** for the designated paths in `.github/CODEOWNERS`.

Revisit deployment environments, release gates, signed-commit requirements, and a merge
queue only when this repository has actual deployments/releases or a larger maintainer
group. They are intentionally not configured now.

## Security and supply chain

Enabled in repository settings (applied by the human owner):

- Private vulnerability reporting — reporters use the Security tab; see `SECURITY.md`.
- Dependency graph.
- Dependabot alerts, malware alerts, security updates, and grouped security updates.
- Secret scanning and push protection.
- GitHub-managed **CodeQL default setup**.

### Dependabot

`.github/dependabot.yml` configures **only** the `github-actions` ecosystem — the only
version-updateable ecosystem present, since the repo has no package-manager manifest
(no `package.json`/lockfile, `requirements.txt`, `go.mod`, etc.). The schedule is weekly
and Actions bumps are grouped into a single PR to keep solo-maintainer review load low.
Add new ecosystems only when a real manifest is introduced. Security-update PRs come from
the repository setting above and do not require a manifest entry.

### CodeQL (code scanning)

CodeQL default setup is **enabled**. It detected **GitHub Actions** and
**JavaScript/TypeScript** and runs on pull requests, on pushes to `main`, on protected
branches, and weekly. It complements the existing tests, dependency alerts, and secret
scanning.

**Not yet a required check — by design.** A code-scanning result requirement is added to
`main-protection` only after (1) the first CodeQL scan completes successfully, (2) its
exact check name(s) are read back from GitHub and recorded here, and (3) designating it
required will not block rollout. Steps 1–2 are now satisfied; step 3 (the required-check
designation) remains a separately reviewed, human-owned settings change.

**Confirmed check names (first successful run, 2026-07-28, PR #122).** CodeQL default
setup reports three checks on pull requests:

- `Analyze (actions)`
- `Analyze (javascript-typescript)`
- `CodeQL` — the aggregate result check

Recommended requirement when activated: the aggregate **`CodeQL`** check (it rolls up the
per-language analyses, so it stays stable if the detected languages change). Add it to
`main-protection` in a reviewed follow-up; it passed cleanly on the initial rollout PR, so
it will not block.

| Check | Exact name | Required? |
|---|---|---|
| Repository validation | `repository-validation` | **Yes** (in `main-protection`) |
| CodeQL (aggregate) | `CodeQL` | Not yet — confirmed, activation deferred |
| CodeQL (per-language) | `Analyze (actions)`, `Analyze (javascript-typescript)` | No — covered by the aggregate |

## GitHub Actions posture

Existing account/repo defaults are **retained**:

- Default `GITHUB_TOKEN` permissions are **read-only**
  (`permissions: contents: read` is also set explicitly in `validation.yml`).
- Actions are **not** allowed to create or approve pull requests.
- First-time external-contributor workflow runs **require approval**.

### Action pinning

Third-party and GitHub-owned actions are **pinned to full commit SHAs** (with a version
comment) rather than moving tags, so a compromised or retargeted tag cannot silently
change what runs.

Current inventory (`.github/workflows/`):

| Workflow | Action | Pin |
|---|---|---|
| `validation.yml` | `actions/checkout` | `11d5960a326750d5838078e36cf38b85af677262` # v4.4.0 |

Sequence for the allowlist restriction (deferred until after pinning is verified green):

1. Pin every action to a full SHA (done for the current inventory above).
2. Confirm workflows still pass with the pinned SHAs.
3. Only then consider enabling the repository setting that **requires** SHA pinning, and
   restricting allowed actions to GitHub-owned actions plus an explicit allowlist.
4. Keep the read-only workflow-token default throughout.

## Code ownership

`.github/CODEOWNERS` stages ownership for these high-risk paths:

- `.github/workflows/**`
- `scripts/**`
- `.claude/hooks/**`
- `config/**`
- `schemas/**`

These are **informational / future-ready**. The ruleset's "Require review from Code
Owners" switch is **not** enabled while solo-maintained (it would block the sole
maintainer). Documentation, templates, and research remain lower-risk but are still
subject to the normal PR and `repository-validation` checks. Activate code-owner review
as part of the staged collaboration plan above once an independent reviewer exists.

## Emergency bypass policy

Admin bypass exists for **emergency recovery only** (e.g. restoring a broken `main` when
the normal PR path cannot). Any use should be rare, deliberate, and recorded. Routine
work — including the maintainer's own changes — always uses the PR + `repository-
validation` floor. This preserves the audit trail the workbench depends on.

## Change log

- 2026-07-28 — Initial canonical GitHub-governance record: documented the applied
  `main-protection` ruleset and staged solo-maintainer settings, security/supply-chain
  settings, CodeQL enablement (check name pending first run), Actions posture with
  `actions/checkout` pinned to a full SHA, informational CODEOWNERS for high-risk paths,
  and `SECURITY.md` / `.github/dependabot.yml`.
- 2026-07-28 — CodeQL first successful run on PR #122 confirmed the check names
  (`Analyze (actions)`, `Analyze (javascript-typescript)`, aggregate `CodeQL`); recorded
  here. Designating the aggregate `CodeQL` check required remains a deferred, human-owned
  settings follow-up.
