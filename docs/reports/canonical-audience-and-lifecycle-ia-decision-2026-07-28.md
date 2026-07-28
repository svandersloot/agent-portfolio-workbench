# Decision: Canonical Audience and Lifecycle Information Architecture

| Field | Value |
|---|---|
| Decision date | 2026-07-28 |
| Status | Accepted |
| Scope | Documentation information architecture (audience taxonomy and lifecycle structure) |
| Supersedes | The two drifts previously flagged in [`docs/README.md`](../README.md) → "Known Inconsistencies" |
| Related research | [`docs/research/enterprise-agent-governance-operating-model-2026-07.md`](../research/enterprise-agent-governance-operating-model-2026-07.md) §3 (Agent Lifecycle), §4 (fields), §9 (Challenging Your Assumptions) |

## Decision Record

We adopt a six-role audience model and a five-gate lifecycle as the canonical
information architecture. Pilot users are a subset of end users; assurance partners
consolidate audit and security/legal/privacy/compliance roles. The existing 13 lifecycle
steps remain implementation guidance mapped to the five gates. Risk-tier requirements and
any changed gate criteria remain proposed until the completeness-contract/schema decision
is accepted.

## Why

The repo carried two coexisting taxonomies (a six-role model in the positioning doc, a
five-audience table in Stage 5) and two lifecycle descriptions (a 13-step / 8-stage model
across the operating docs and a newer five-gate / risk-tier model proposed in the research
report). A reader could not tell which was authoritative. This decision resolves the drift
with the least disruption: it keeps every current constituency and all the detail already
built, and it does not delay the pilot behind a larger governance redesign.

## Canonical Audience Model (six roles) — effective now

| Role | Notes |
|---|---|
| Governance builder | Shapes ideas, checks reuse, prepares durable artifacts and handoffs. Primary user of this repo. |
| Agent owner | Maintains sources, guardrails, readiness, measurement, and lifecycle evidence. |
| Reviewer / decision owner | Assesses evidence, risk, pilot scope, and promotion requests. |
| Assurance partner | Audit, security, privacy, legal, and compliance — consolidated into one role. Traces decisions to sources, evidence, owners, metrics, and change history; decides when a use case needs formal review or extra controls. |
| End user | Uses approved capabilities in the supported business workflow and provides feedback. **Pilot users are a temporary subset of end users during evaluation, not a separate role.** |
| Leader / executive | Sees portfolio shape, investment choices, risks, outcomes, and decisions needing attention. |

The Stage 5 five-audience table is retained as the **pilot-specific operating view**, not a
competing taxonomy. Roles describe who someone is; lifecycle gates describe when and how a
capability may be used.

## Canonical Lifecycle Structure (five gates) — effective now

The five gates are the canonical lifecycle structure. The existing 13 Stage 5 steps remain
the implementation checklist, nested beneath the gate they belong to.

| Gate | Nested Stage 5 steps (implementation checklist) |
|---|---|
| **G1 Fit** | 1. Pain point · 2. Intake · 3. Duplicate check |
| **G2 Design** | 4. Spec · 5. Context review |
| **G3 Build & verify** | 6. Prototype · 7. Dry run · 8. Human review |
| **G4 Pilot & measure** | 9. Pilot approval · 10. Team promotion · 11. Metrics and improvement |
| **G5 Operate & retire** | 12. Deprecation · 13. Retirement |

This gives lower cognitive load immediately without changing what the 13 steps require.

## Effective Now vs. Still Proposed

**Effective now (this decision):**

- The six-role audience model above is canonical.
- The five-gate lifecycle structure above is canonical, with the 13 steps nested as
  implementation guidance.

**Still proposed — NOT effective policy (do not treat as approval policy):**

- Risk-tier requirements (Tier 1 / 2 / 3) and tier-scaled process depth.
- Any changed gate-exit criteria or approval semantics relative to today's practice.
- Added record fields beyond the current twelve (e.g. risk tier, data classification,
  platform/runtime identity, write capability).

These remain proposed until decisions **9.1 and 9.2** — the completeness-contract and
schema changes — are accepted together. Until then, the
[completeness contract](../agent-governance-completeness-contract.md) v1 (seven statuses,
twelve required fields) stays effective unchanged, and gate exits carry today's approval
semantics. Adopting the five-gate *structure* does not adopt the proposed tier or approval
*rules*.

## Consequences

- The [positioning doc](../agent-portfolio-workbench-positioning.md) audience model is
  updated to the six roles and remains canonical for roles.
- [Stage 5 start-here](../stage-5-agent-factory-start-here.md) keeps its 13 steps and its
  five-audience table, now framed as implementation checklist and pilot operating view.
- The [operating model](../toolkit-operating-model.md) and
  [completeness contract](../agent-governance-completeness-contract.md) keep their statuses
  and fields; only the framing (gates as structure) is added.
- [`docs/README.md`](../README.md) records this as resolved and points here.
