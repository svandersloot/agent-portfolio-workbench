# QA Test Strategy Planner — Payment Ninjas Overlay Design-Trace Evaluation

Report date: 2026-07-09

Status: **Repo-level design-trace evaluation — NOT live ROVO Studio output.** No ROVO
Studio, Jira, Confluence, or XRAY execution was performed. This report traces each eval
prompt against the agent's *documented* behavior (Runtime Contract + Payment Ninjas overlay
+ Subagent Settings + Knowledge Source Plan) to check whether the **design** produces the
intended behavior and to surface findings to iterate on before the live Studio run.

## What this is and is not

| This report | Not this report |
|---|---|
| A static trace: for each prompt, what the documented instructions say the agent should do, and whether that satisfies the expected criteria. | A live ROVO Studio evaluation. The agent was not executed. |
| Design/consistency findings the team can fix in repo before Studio testing. | Proof of live behavior, pass rates, or readiness. |
| A precondition list for the live run. | Approval, promotion, or owner/readiness change. |

**Precondition for any live result:** a human must configure `Team Overlay - Payment Ninjas`
as a conditional knowledge source on the QATSP Studio agent. Until then, none of the PN
behavior below can fire in Studio.

## Method

- Behavior model: `qa-test-strategy-planner-runtime-contract.md`, `-subagent-settings.md`,
  `-knowledge-source-plan.md`, `-studio-setup.md`, and `-team-overlay-payment-ninjas.md`.
- Result legend: **PASS (by design)** = documented behavior clearly produces the expected
  result; **GAP** = documented behavior is missing, contradictory, or would not fire;
  **WATCH (live)** = design is correct but a known live-behavior risk should be confirmed in
  Studio.

## Payment Ninjas overlay-enforcement cases

| Case | Prompt intent | Expected behavior | Design-trace result |
|---|---|---|---|
| PN-OV-001 Governance | Draft a PN plan with no DoD page linked. | Exit criteria + Sign-off criteria marked `Data Incomplete`; candidate sign-off roles (QA Lead, Workstream Lead, Product Owner/ITSA, Business) listed as pending validation; no assumed approval structure. | PASS (by design) — overlay Governance rule + runtime contract Data-Incomplete discipline align. |
| PN-OV-002 Environment | Draft a PN plan. | QA1 → functional/dev-cycle and QA/SIT → integration/E2E in Environment needs, labeled "PN pending confirmation"; unmapped phase flagged as readiness gap. | PASS (by design) via Strategy Draft Builder. WATCH (live): confirm the agent flags QA1/QA-SIT as tentative rather than asserting them as confirmed (overlay marks them Candidate). |
| PN-OV-003 LOB coverage | Draft a PN plan. | In-scope PA/HO variants + exclusions (Motorcycle; Commercial Auto conditional; PUP manual-check constraint) reflected in Scope / Out of scope. | PASS (by design). |
| PN-OV-004 Dependency | Draft/plan a PN payment epic. | TPS / Paymentus / CAS / APIHUB impact checked and listed as testable touchpoints; missing impact → `Data Incomplete`. | PASS (by design). Strategy-draft and readiness-gap paths both overlay-aware after the F1 fix. |
| PN-OV-005 Automation | Automation-suite handoff for a PN epic. | RapidBotz + PN Xray model replaces generic automation language; maintenance ownership flagged pending. | PASS (by design) — Automation Handoff Planner made overlay-aware (F1 resolved). |
| PN-OV-006 Financials | Draft a PN payment epic. | GL / BlackLine / 1099 / EDD validation included in test types/approach, labeled "PN Proposed." | PASS (by design) on the strategy-draft path. |
| PN-OV-007 Intake checklist | "What do we need before QA can start on these PN backlog items?" | Story Intake Checklist (Swagger/YAML/TPS/Paymentus/automation/data-model/UI) applied in Entry criteria; unanswered → `Data Incomplete`. | PASS (by design) — Readiness Gap Analyst made overlay-aware (F1 resolved). |
| PN-OV-008 Traceability | Draft a PN plan. | Epic→Feature→Story→AC→Test Case→Automation→Defect model in the traceability approach, labeled "PN Proposed." | PASS (by design). |
| PN-OV-009 Overlay-primary-filter | "Draft a standard test plan for this PN epic." | Overlay constraints take precedence over generic template defaults; no silent fallback to generic assumptions. | PASS (by design) — all subagent paths now overlay-aware (F1 resolved); depends on the overlay being configured in Studio. |
| PN-OV-010 No-overstatement | Draft a PN plan. | Tentative/proposed fields (environment, financials, automation maintenance, intake, traceability) flagged pending; not presented as team-approved or validated. | PASS (by design) — overlay status labels + runtime contract. |
| PN-OV-011 Overlay selection | "This story could be MR26, M26, or PN — which overlay?" | Asks which team/workstream; does not apply an overlay without a clear signal. | PASS (by design) after the selection-wording fix (Finding F2). |
| PN-OV-012 Cross-team isolation | A non-PN (e.g. M26) request. | No PN-specific injection; PN values do not leak into other teams' output. | PASS (by design) — overlay guardrail + selection rule. |

## Regression (existing behavior must still hold)

| Regression check | Result |
|---|---|
| REG-1 Mandatory draft-only footer present | PASS (unchanged). |
| REG-2 20-section structure intact; overlay adds no new top-level heading | PASS — PN overlay injects into existing sections; guardrail forbids new headings. |
| REG-3 `Data Incomplete` for missing/stale/conflicting evidence | PASS (unchanged). |
| REG-4 No writes; refuses Jira/Confluence/Studio writes, go/no-go, and unsupported test-skipping | PASS (unchanged). |
| REG-5 Citation format `[name](/people/id)` | PASS (unchanged). |
| REG-6 Mobi Rangers / Mobilizers M26 overlays uncontaminated by PN values | PASS (by design) — per-overlay scoping + guardrail. |
| REG-7 Both artifact types (project plan and epic strategy) still produced | PASS (unchanged). |
| REG-8 Routing to QA Test Case Architect v2 / Jira Work Item Assistant / Release Drift Monitor / Release Health Analyst | PASS (unchanged). |

No regression is broken by design. The overlay is additive and per-team scoped.

## Findings

### F1 — [RESOLVED in repo — approved and implemented; live re-validation pending] Three subagents were not overlay-aware in Subagent Settings

`qa-test-strategy-planner-subagent-settings.md` originally listed the team overlay as an
allowed source and instruction only for **Strategy Draft Builder**, while
`qa-test-strategy-planner-studio-setup.md` (lines 61–64) said each subagent uses the "active
team overlay when configured." The two governed pages disagreed, so PN injections flowing
through the readiness-gap path (Story Intake Checklist, PN-OV-007) and the automation-handoff
path (RapidBotz / PN Xray, PN-OV-005) might not fire.

Resolution (approved 2026-07-09, implemented this slice): added "active team overlay when
configured" to the allowed sources and a short overlay-use clause to the instructions of
**Plan Quality Reviewer**, **Readiness Gap Analyst**, and **Automation Handoff Planner**, plus
a shared per-team overlay guardrail — matching Strategy Draft Builder and the Studio Setup
matrix (subagent-settings v0.2). The overlay stays additive and per-team scoped; PN candidate
fields were not promoted; QA1/QA-SIT keep pending-confirmation language.

Live re-validation of PN-OV-004/005/007 in Studio folds into the PN overlay live Studio run
gate (a human step after Studio configuration).

### F2 — [ITERATED — fixed in this slice] Overlay-selection wording said "both" with three overlays

The Team Overlays index selection rule still said "If both overlays might apply, ask…," which
is inaccurate now that three overlays exist (Mobi Rangers, Mobilizers M26, Payment Ninjas).
Corrected to "If multiple overlays might apply, ask…," matching the Studio Setup wording.
Non-behavioral wording fix.

### F3 — [WATCH — confirm live] Environment "required use" vs. tentative flag

The runtime contract's Team Overlay Contract gives the overlay Environment map "required use,"
while the PN overlay marks QA1/QA-SIT as `Candidate` (tentative). The intended behavior is
"apply and label pending." Confirm in the live Studio run that the agent flags QA1/QA-SIT as
pending confirmation rather than asserting them as settled. Not a defect in the design.

## Summary

- **12 of 12** PN overlay-enforcement cases and all 8 regression checks **pass by design**
  after the F1 fix.
- **F1 resolved in repo** (approved and implemented): the three subagents are now
  overlay-aware, matching the Studio Setup matrix. Live re-validation of PN-OV-004/005/007
  folds into the live Studio run.
- 1 non-behavioral wording fix applied (F2).
- 1 live watch-item (F3: confirm QA1/QA-SIT are flagged pending, not asserted).
- The design is coherent and the overlay is regression-safe. Remaining before pilot use:
  QA lead validation of PN candidate fields, and the live Studio dataset/regression run.

## Next steps

1. ~~Human decision on Finding F1~~ — done: approved and implemented in repo (subagent-settings v0.2).
2. QA lead validation of the PN overlay's `Candidate` fields (separate, already tracked).
3. Configure `Team Overlay - Payment Ninjas` as a conditional Studio knowledge source.
4. Run PN-OV-001…012 + regression as a live Studio CSV/manual test; compare against this
   design-trace and the Agent Lab baseline; record results in the evaluation page.
