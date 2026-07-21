# GitHub Branch Protection Decision Brief — 2026-07-21

Status: Decisions recorded — enforcement pending manual account upgrade and separately approved settings action
Decision owner: repository admin/account owner (human)
Companion to: `docs/governed-backlog-execution-loop.md` (§9 activation gates), issue #49, issue #51 (S8 gate ledger)

This brief records the human decisions for S8 activation gate #3 ("human merge protection verified on GitHub"). It changes no settings. Branch protection, billing, and ownership remain human/admin decisions; no agent may perform them.

## Current state (verified read-only, 2026-07-21)

- `main` is **unprotected** (`protected: false`).
- Classic branch protection and rulesets both return HTTP 403: *"Upgrade to GitHub Pro or make this repository public to enable this feature."* The repository is **private** on a free personal plan, so **no protection mechanism is currently available at all**.
- `CODEOWNERS` is `* @svandersloot` with a note to formalize ownership later.
- The only existing CI check is `repository-validation` (`.github/workflows/validation.yml`), running on pull requests and pushes to `main`.

## Decision 1 — Enforcement capability (DECIDED 2026-07-21)

**Chosen: Option A — upgrade the personal account to GitHub Pro**, keeping the repository private. The account owner performs the upgrade manually. No billing or repository-setting change is automated; the settings action after upgrade requires its own explicit approval.

Rejected alternatives: making the repo public (work-content exposure decision far larger than this gate); moving to an organization (private-repo protection still requires a paid org plan); accepting no platform enforcement (would have required redefining gate #3 entirely).

## Decision 2 — Protection policy for `main` (CONFIRMED 2026-07-21, apply via ruleset after upgrade)

| Rule | Setting |
|---|---|
| Require a pull request before merging | **Yes** |
| Required approving reviews | **0 while solo-maintained** (GitHub forbids self-approval; ≥1 would block the sole maintainer's own PRs; raise only when a second acknowledged owner exists) |
| Required status checks | **`repository-validation`** now; add the stable #50 check names once they exist |
| Require branches to be up to date before merging | **Yes** |
| Direct pushes to `main` | **Blocked** |
| Force pushes to `main` | **Blocked** |
| Deletion of `main` | **Blocked** |
| Apply to admins | **Yes — no standing bypass** |
| CODEOWNERS-required review | **No** — CODEOWNERS stays informational until a second acknowledged owner exists (ownership assignment is a Human-Owned Decision under `AGENTS.md`) |

### Emergency override procedure

Any emergency override requires, in order: explicit human approval; a temporary ruleset change; restoration of the ruleset; verification by GitHub read-back; and a receipt recording all of the above. No standing bypass exists for any actor, including admins.

## Accepted gate #3 interpretation (S8 pilot)

GitHub enforces the **PR/check process floor** (PR-only merges into `main`, required checks green, up-to-date branches, no direct/force pushes, no deletion). **Merge remains human-only under the operating contract** (`docs/governed-backlog-execution-loop.md` §4/§5), not through platform actor separation.

### Accepted pilot residual risk — shared credential

The agent currently operates with the maintainer's own credential, so platform rules cannot distinguish agent from human: nothing technical prevents that credential from merging. Actor-level enforcement ("agent can open but can never merge") would require a separate machine identity (bot account or GitHub App) restricted by the ruleset. This is **accepted as a pilot residual risk** and recorded as a **future machine-identity hardening item** for the S9/S10 executable controller/loop work (#53, #54).

## Enforcement and verification plan (after upgrade; each step separately approved)

1. #50 lands the minimum CI checks with stable check names (separate slice; the workflow itself does not need protection capability).
2. Human approves the exact ruleset creation action; the ruleset above is applied.
3. **Gate #3 read-back:** the live ruleset configuration is read back via the GitHub API and receipted on #49 and the #51 ledger — PR requirement, required-check list including the #50 names, up-to-date requirement, push/force-push/deletion blocks, admin enforcement.
4. Gate #4 (#50 "running **and required**") completes only after the required-check designation in step 2–3 is verified.

## Boundaries

- This brief is a record, not an action. No repository settings, billing, labels, schema, or live-system state were changed in producing it.
- S8 remains inactive. Satisfied gates at time of writing: #1 (contract), #2 (deny/secret hook), #5 (loop-state). Remaining: #49/gate #3, #50/gate #4, #44/gate #6.
