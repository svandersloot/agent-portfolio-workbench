# Loop-State Machine — Canonical Specification

Date: 2026-07-15
Status: Canonical loop-state specification — companion to `docs/governed-backlog-execution-loop.md` §6
Implements: #52 (S11)

**Authority precedence.** `AGENTS.md` remains the repository's authoritative operating contract, and `docs/governed-backlog-execution-loop.md` is the canonical contract for backlog-loop behavior. This specification defines only the durable loop-state model that contract §6 references. Where documents conflict, resolve to `AGENTS.md` first, then to the loop contract, then to the **more restrictive** rule.

**Activation boundary.** This specification defines state semantics only and grants no write authority. Agent state writes remain per-call approval-gated until S8 activates.

This specification is platform-neutral. Claude Code and separately approved runtime adapters read and write the **same** fields defined here; no adapter invents a competing state model. Adding a runtime adapter requires its own approval decision.

---

## 1. Purpose

Durable loop state lives in GitHub — a project single-select field plus labels and receipt comments — never in chat history. Any session, human, or crashed and resumed loop must be able to reconstruct where every loop-managed issue stands from GitHub alone.

## 2. Fields

| Field | Type | Writer | Semantics |
|---|---|---|---|
| `Loop State` | single-select | loop (agent) within §4 ownership; humans for human-owned transitions | The issue's position in the loop state machine (§3). Unset = not loop-managed. |
| `Claimed By` | text | loop (agent); humans for recovery | Claim token, format **`<actor-id>:<unique-run-id>`**. The working branch is recorded in the receipt, not in the token. Empty when unclaimed. |
| `Lease Expires` | text | loop (agent); humans for recovery | Normalized UTC timestamp, ISO-8601 **`YYYY-MM-DDTHH:MM:SSZ`**. Empty when unclaimed. |
| `Status` (existing) | single-select | **humans only** | Human-facing board view (Todo / In Progress / Done). **Outside the agent write allowlist.** The loop never reads it for decisions and never writes it. |

Field names above are canonical. Project-specific field identifiers are implementation details of the hosting project and are recorded in the creation receipts on #52, not in this specification.

## 3. States

Every legal transition, by owner (the transition table in §4 remains authoritative):

```text
(unset)            --T1  human--------------------------> Eligible
Eligible           --T2  agent--------------------------> Claimed
Claimed            --T3  agent--------------------------> In Progress
Claimed            --T6  agent--------------------------> Blocked-Decision
Claimed            --T9  agent(own expired lease)/human-> Returned-to-Queue
In Progress        --T4  agent--------------------------> Awaiting CI/Review
In Progress        --T6  agent--------------------------> Blocked-Decision
In Progress        --T9  agent(own expired lease)/human-> Returned-to-Queue
Awaiting CI/Review --T5  agent (bounded fix cycle)------> In Progress
Awaiting CI/Review --T6  agent--------------------------> Blocked-Decision
Awaiting CI/Review --T8  human merge, verified record---> Done (terminal)
Blocked-Decision   --T7a human--------------------------> Eligible
Blocked-Decision   --T7b human--------------------------> In Progress
Blocked-Decision   --T7c human--------------------------> Awaiting CI/Review
Blocked-Decision   --T7d human--------------------------> Returned-to-Queue
Returned-to-Queue  --T10 human--------------------------> Eligible
```

No other transition is legal. `Done` is terminal and is reachable **only** through T8.

| State | Meaning |
|---|---|
| *(unset)* | Not loop-managed. |
| `Eligible` | A human has confirmed the issue satisfies the conjunctive eligibility rule (contract §4). Only `Eligible` items may be claimed. |
| `Claimed` | A single actor holds the claim token and lease; work has not started. |
| `In Progress` | Active per-issue engineering loop execution. |
| `Awaiting CI/Review` | A draft PR exists; CI and/or human review feedback is pending. |
| `Blocked-Decision` | Escalated; paired with the `blocked` or `decision-gate` label and a receipt stating the decision needed. |
| `Done` | **Terminal.** The PR was human-merged and the merge was verified. No transitions leave `Done`. |
| `Returned-to-Queue` | Claim released without completion; existing work preserved; awaiting human re-eligibility confirmation. |

## 4. Transitions and ownership

| # | Transition | Owner | Conditions and notes |
|---|---|---|---|
| T1 | *(unset)* → `Eligible` | **Human** | Granting eligibility grants autonomy; the agent may propose, never set. |
| T2 | `Eligible` → `Claimed` | Agent | Claim protocol (§5). Sets `Claimed By` + `Lease Expires`. |
| T3 | `Claimed` → `In Progress` | Agent | Work begins; lease renewed. |
| T4 | `In Progress` → `Awaiting CI/Review` | Agent | Draft PR opened/updated; lease renewed. |
| T5 | `Awaiting CI/Review` → `In Progress` | Agent | Bounded fix cycle (contract §7: at most two CI/review correction cycles); lease renewed. |
| T6 | nonterminal active state (`Claimed`, `In Progress`, `Awaiting CI/Review`) → `Blocked-Decision` | Agent may enter | Adds `blocked` or `decision-gate` label + receipt stating the decision needed. **Not permitted from `Done`.** |
| T7a | `Blocked-Decision` → `Eligible` | **Human-only** | Human clears `blocked` / `decision-gate` (contract §6), claim fields are cleared, and the issue re-enters the queue for a fresh claim. |
| T7b | `Blocked-Decision` → `In Progress` | **Human-only** | Human clears the labels and hands the issue back to the existing claim holder; the claim token is revalidated and the lease renewed before any further agent action. |
| T7c | `Blocked-Decision` → `Awaiting CI/Review` | **Human-only** | Permitted only when a draft PR already exists; human clears the labels and work resumes at the review stage after token revalidation and lease renewal. |
| T7d | `Blocked-Decision` → `Returned-to-Queue` | **Human-only** | Human releases the claim; any existing branch or PR is preserved and recorded in the receipt for later resumption. |
| — | `Blocked-Decision` → `Done` | **Not permitted** | `Done` is reachable only through the verified-human-merge path in T8. |
| T8 | `Awaiting CI/Review` → `Done` | **Human merge required** | The merge itself is always human. The agent/controller may **record** `Done` afterward, only after verifying the merged PR and merge SHA; it cannot cause or approve the merge. |
| T9 | `Claimed` / `In Progress` → `Returned-to-Queue` | Agent (own expired lease only) or human | Self-return rules in §7. |
| T10 | `Returned-to-Queue` → `Eligible` | **Human** | Re-eligibility is a human confirmation. |

Any transition not listed is illegal. An adapter encountering an illegal or unrecognized state must stop and escalate rather than repair it silently.

## 5. Claim protocol and concurrency

GitHub Projects provides no compare-and-swap, and the claim write is **not atomic** — it is an ordered sequence of individual field writes. The protocol is therefore **collision detection, not true mutual exclusion**:

1. Re-read the item; require `Loop State` = `Eligible` **and** both claim fields (`Claimed By`, `Lease Expires`) empty.
2. Write the unique claim token to `Claimed By`.
3. Write the lease expiry to `Lease Expires`.
4. Write `Loop State` = `Claimed` **last**.
5. Re-read and accept the claim **only if the complete token/lease/state tuple matches** what was written.

An incomplete or mismatched tuple is an **invalid claim**: fail closed. Do not repair the fields or continue silently. Write a collision/partial-claim receipt and take no further state-changing action; when ownership is ambiguous (for example, a partial write interleaved with another actor's writes), recovery is **human-owned**.

Compensating controls, required until S9 provides a stronger controller lock:

- **One human-authorized controller instance per repository/project mandate.** Concurrent controller instances against the same mandate are not permitted.
- **Claim-token revalidation before every state-changing action.** The actor re-reads `Claimed By` immediately before each transition write and **fails closed on mismatch**: stop, write a receipt, take no further state-changing action.

## 6. Lease

- Pilot TTL: **24 hours**. This is a **configurable operating parameter, not a permanent invariant**; changing the default is a reviewed spec/config change.
- The lease is **renewed at every active transition** (T3, T4, T5) by rewriting `Lease Expires`.
- An expired lease does not by itself change state; it makes the claim *stale* and enables recovery (§7).

## 7. Stale-claim recovery and return-to-queue

Self-return (T9, agent-performed) is allowed only when **all** hold:

1. The claim is the actor's **own** (token match) and the lease is expired.
2. The contract §6 condition holds: **no active branch, PR, or execution lease** exists for the claim.

Agent self-return therefore requires that **no branch or PR exists**. If a branch or PR exists, the actor must **preserve it** and route the issue to `Blocked-Decision` for human handling instead of returning it autonomously. A **human-performed** return (T9 human, or T7d) may preserve an existing branch or PR and must record it in the receipt for later resumption. Another actor's stale claim is released by a **human only**.

Return-to-queue never discards work: the receipt records any existing branch, PR, and validation evidence, and a later re-claim **resumes** from that work — it never restarts it.

## 8. Receipts

Every transition — including failed and colliding attempts — writes a receipt comment on the issue:

```markdown
### Loop receipt <event-id>
- Event ID: <actor-id>:<run-id>:<seq>     (unique; repeated/conflicting attempts are idempotent and distinguishable)
- Transition: <from> -> <to>              (or: claim-collision / revalidation-failure / lease-renewal)
- Actor: <actor-id>
- Timestamp: <YYYY-MM-DDTHH:MM:SSZ>
- Branch: <branch or n/a>
- Evidence: <commit SHA | PR link | CI run | decision note>
```

An action with the same event ID as an existing receipt must not be re-applied.

## 9. Blocked-decision handling

Entering `Blocked-Decision` (T6) pairs three writes: the state, the `blocked` or `decision-gate` label, and a receipt naming the exact decision a human must make. Resumption (T7) is human-owned end to end: a human clears the label, sets the next state, and the resuming actor treats the human's receipt or comment as the authorization record.

## 10. Helper contract (deferred to S9)

Executable helpers are out of scope for this slice. S9 must implement them against this contract:

- a **read** helper: report an item's `Loop State`, `Claimed By`, `Lease Expires`, and latest receipt; read-only.
- a **set** helper: perform one legal transition with token revalidation, lease handling, and receipt write; **dry-run-first**; refuses illegal transitions and mismatched tokens (fail closed).

## 11. Live realization

The `Loop State`, `Claimed By`, and `Lease Expires` fields do not exist until created. Field creation requires **separate human-approved writes after this specification merges**. The durable creation and read-back receipt — including event IDs, field names, project-specific field IDs, types/options, verification timestamp, and read-back evidence — is recorded on **#52**, not in this specification.

## Related files

- `docs/governed-backlog-execution-loop.md` — canonical loop contract (§6 pre-authorized claim/state writes; §9 activation gates)
- `docs/claude-code-adoption-plan.md` — Claude Code adapter permission posture
- `AGENTS.md` — authoritative operating contract
