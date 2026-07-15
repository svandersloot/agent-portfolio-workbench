# Governed Backlog Execution Loop — Canonical Contract

Date: 2026-07-15
Status: Draft — canonical, platform-neutral contract for graduated backlog execution autonomy
Companion to: `docs/claude-code-adoption-plan.md` (accepted governance reference)

This document defines the target capability:

> **A governed backlog execution loop with graduated development autonomy and exception-based human review.**

**Authority precedence.** `AGENTS.md` remains the repository's authoritative operating contract. This document is canonical **only for backlog-loop behavior**. Where they conflict, resolve to `AGENTS.md` first, then to the **more restrictive** rule. This contract cannot grant authority that `AGENTS.md` prohibits.

This is a **platform-neutral** contract. Claude Code and Codex are **adapters** that implement it. Platform-specific permissions, hooks, and settings must implement this contract and must not define competing or wider policies. Where a platform cannot enforce a control, the missing enforcement is a gap to close before that platform operates the loop — not a license to widen the policy.

This contract does not by itself relax any approval posture. The graduated git/PR autonomy it describes activates only through issue **#51 (S8)** after the activation gates below pass.

---

## 1. Two-level runtime

The capability is two cooperating levels, not one open-ended goal over the whole backlog:

1. **Backlog controller (#53 / S9).** Selects the next eligible issue, skips ineligible/blocked/decision-gate items, claims exactly one, starts one per-issue loop, and advances within a human-authorized mandate.
2. **Per-issue engineering loop (#54 / S10).** Claim → inspect → plan → branch → implement → test → self-review → commit → draft PR → process bounded CI/review feedback → complete or hand off.

Unattended operation of the controller is a **separate controller mode** (§3), **not** an autonomy level. Durable state for both levels lives in GitHub (labels + project fields), never in chat history — see §8 and issue **#52 (S11)**.

---

## 2. Autonomy ladder

| Level | Label | The agent may |
|---|---|---|
| L0 | `agent:observe` | Inspect, diagnose, and report. No writes. |
| L1 | `agent:plan` | Prepare grooming proposals and implementation plans. **No GitHub or repo writes without separate approval.** |
| L2 | `agent:local` | Edit and validate in an isolated branch/worktree. **Never pushes.** Under the current posture, staging and local commits remain per-call approval-gated. |
| L3 | `agent:draft-pr` | Commit, push the named feature branch, open/update a **draft** PR, and address bounded CI/review feedback — only after S8 activation, for eligible issues. |
| Human gate | `decision-gate` / `blocked` | Merge, policy/contract, live-system, permission, destructive, ownership, approval, or material-scope decisions, and final approval. |

There is no L4 level. Unattended queue processing is a **controller mode** (§3), not a fifth rung; it does not raise any issue's autonomy.

### Label taxonomy and reconciliation

Autonomy: `agent:observe`, `agent:plan`, `agent:local`, `agent:draft-pr`.
Risk: `risk:low`, `risk:medium`, `risk:high`.
Reconciled with existing labels: `blocked` = "agent:blocked"; `decision-gate` = "human:decision-required". No duplicate labels are created.

---

## 3. Controller authorization (separate mode)

Unattended queue control is a **separate controller mode**, not an autonomy level. Running the controller never raises an issue's autonomy; each issue is executed only at its own labeled level (§2) and only if eligible (§4).

Every controller run must be started by a human with an explicit, bounded mandate:

- target **repository**
- **project/query** defining the candidate set
- the **eligible issue set** (enumerated or query-bounded)
- a **maximum issue count** for the run

The controller **may not**:

- expand its own queue scope beyond the mandate
- start another batch after the mandate is exhausted
- raise an issue's autonomy level or lower its risk classification

### Escalation handling

A **per-issue** escalation transitions that issue to `blocked` or `decision-gate`, records the evidence receipt, and lets the controller **continue with the next independent eligible issue inside the existing mandate**.

The **entire controller stops** only when the escalation affects shared policy, queue eligibility, a shared dependency or base, authorization, infrastructure, or the controller's bounded mandate — or when no eligible work remains.

At the end of a run, the controller returns a **consolidated list of issues needing human decisions**.

---

## 4. Conjunctive eligibility

An issue is eligible for autonomous draft-PR execution only if **every** clause holds:

1. label `agent:draft-pr`
2. label `risk:low`
3. no `blocked` and no `decision-gate` label
4. fully groomed acceptance criteria **and** explicit validation commands
5. permitted file/path scope is declared
6. a clean isolated branch or worktree
7. no policy, approval-authority, secret, permission, live-system, or protected-contract change (see Protected paths)
8. the agent may **not** raise its own autonomy level or lower its own risk classification

`.github/workflows/` changes are **excluded** from autonomous draft-PR eligibility and from the pilot; they remain `risk:medium`, `agent:local`, and human-reviewed before merge (see §10 and #50).

### Protected paths (machine-enforceable)

Clause 7 is enforced against an explicit protected-path set. Touching any of these makes an issue **ineligible** for autonomous execution:

- `AGENTS.md`
- `CLAUDE.md`
- `docs/governed-backlog-execution-loop.md` (this contract)
- `docs/claude-code-adoption-plan.md`
- `.claude/settings.json`
- `.claude/hooks/**`
- `.github/CODEOWNERS`
- `.github/workflows/**`

This is the initial set. S9/S10 may refine the implementation, but the set must remain defined and machine-enforceable, and it is **fail-closed**: an issue touching an undefined or unclassified path is ineligible. A protected-path change is human-owned and routed through normal review.

---

## 5. Permitted and human-only actions

### Permitted autonomous actions (exhaustive, eligible issue only)

- edit within the declared scope
- validate (run the repo checks)
- stage
- commit
- push the **named feature branch**
- create/update a **draft** PR
- read CI/review feedback
- apply bounded fixes
- update the configured GitHub loop state (§6)

### Human-only (never autonomous)

- direct push to `main`, merge, force-push, rebase
- branch-protection or permission changes
- secrets
- destructive operations
- live Jira / Confluence / Studio actions
- policy / contract changes (including any protected path, §4)
- material scope expansion
- final approval / merge

---

## 6. Pre-authorized claim/state writes (post-S8-activation only)

After S8 activation, and only then, the agent may perform these narrowly scoped GitHub writes without per-call approval:

**May:**
- set the configured Loop State field and its own claim/lease fields
- add an evidence/status receipt
- add `blocked` or `decision-gate` when escalation is required
- release **only its own** stale claim, after confirming there is no active branch, PR, or execution lease

**May not:**
- change issue title, body, acceptance criteria, priority, or scope
- add, remove, or alter `risk:*` or `agent:*` labels
- remove `blocked` or `decision-gate` (only a human may clear those)
- reclassify eligibility or approve its own scope

**Properties (all required):** field-allowlisted, idempotent, repository/project-scoped, and recorded in the evidence receipt.

---

## 7. Bounded recovery

- **one** retry for transient infrastructure failures
- at most **two** CI/review correction cycles, then transition to `blocked` with an evidence receipt
- do **not** restart already-successful work

---

## 8. Exception-based pause conditions

The loop runs autonomously within its authorized level and pauses only for:

- materially missing acceptance criteria that change the outcome
- policy, architecture, public-contract, ownership, or approval decisions
- live-system, permission, secret, or destructive actions
- high-risk changes outside the issue's authorized autonomy
- repeated validation failure after the bounded retry budget (§7)
- final merge, unless separately authorized later

Durable state is held in GitHub via a project Loop-State field plus labels, with defined transition ownership, concurrency protection, receipts, and stale-claim/return-to-queue recovery — specified in **#52 (S11)**.

---

## 9. S8 activation gates

The graduated git/PR autonomy in #51 (S8) is **approved in principle (2026-07-15)** but **inactive**. It activates only after all of the following pass and are verified:

1. **#47** — this canonical contract is merged.
2. **#45** — deny/secret hook is tested.
3. **#49** — human merge protection is verified on GitHub.
4. **#50** — minimum CI checks are running and required.
5. **#52** — loop-state and claim/concurrency rules are implemented.
6. **#44** — adapter permissions match S8 without widening it.

Merge remains human-owned throughout, at every level.

---

## 10. Staged rollout

Enablement is staged, and **each stage requires explicit human review and approval before the next begins. Successful validation of a stage does not authorize the next stage.**

1. Validate end-to-end on **one deliberately selected low-risk documentation issue** (produces a draft PR; a human merges).
2. — explicit human review and approval gate —
3. A **2–3 issue pilot**.
4. — explicit human review and approval gate —
5. Broader queue processing.

`.github/workflows/` changes are excluded from step 1's selection and from the pilot. Merge remains human-owned throughout.

---

## 11. Dependency order

1. #46 / #47 — vocabulary and contract
2. #51 (S8) — approved autonomy policy (decision-gated; inactive until §9 gates pass)
3. #52 (S11) — durable state machine
4. #50 — minimum CI enforcement (backlog `8.9`)
5. #53 (S9) — executable backlog controller
6. #54 (S10) — executable per-issue engineering loop

---

## 12. Adapters

- **Claude Code** — implements this contract via `.claude/settings.json` (permission mechanics, #44), `.claude/hooks/` (deny/secret enforcement, #45), and `CLAUDE.md` (thin adapter, #43). None of these may widen the contract.
- **Codex** — a future adapter must drive the same eligibility rules, permitted/human-only actions, state fields, and recovery bounds.

## Related files

- `AGENTS.md` — authoritative, platform-agnostic operating contract (takes precedence; see Authority precedence)
- `docs/claude-code-adoption-plan.md` — accepted permission/boundary posture (Claude Code adapter surface)
- `CLAUDE.md` — thin Claude Code adapter
- `.github/CODEOWNERS`, `.github/workflows/` — organizational control and CI enforcement
