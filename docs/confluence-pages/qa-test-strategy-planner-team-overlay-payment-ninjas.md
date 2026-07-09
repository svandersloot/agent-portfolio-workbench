# Team Overlay - Payment Ninjas (PN)

## Status And Source Scope

| Field | Value |
|---|---|
| Overlay status | Draft / Design-session evidence only |
| Source scope | Payment Ninjas (PN) test-plan design session for the DPT initiative, plus PN backlog epics used as working-session source material |
| Evidence type | Team design-session review of a generated project test plan; QA lead and workstream lead participation |
| Standard status | Design-session statements; not yet QA-lead-validated team standards. Promote fields to `Validated Team Standard` only after QA lead confirmation. |
| Related decision record | `docs/reports/qa-test-strategy-planner-payment-ninjas-overlay-integration-review-2026-07-09.md` |
| Last reviewed | 2026-07-09 |

## Studio Use

Use this overlay only when the user is working with Payment Ninjas, the PN workstream, the DPT initiative, or explicitly supplied PN source packets.

Apply the runtime contract's Team Overlay Contract: use validated overlay fields as team-specific authority in their sections; treat unvalidated fields as `Candidate Overlay Field` or `Observed Pattern` that sharpen intake questions rather than as settled policy. Do not infer owners, environments, test data, readiness, sign-off, or automation coverage from this overlay. Where the design session left an item tentative or proposed, apply it **and** flag it as pending confirmation rather than presenting it as approved.

Overlay-as-primary-filter note: the PN design session asked that overlay constraints take precedence over generic template defaults. Under the governed model this is satisfied by field validation state, not by overriding the reusable core: once a field is a `Validated Team Standard`, its "required use" in the runtime contract makes it authoritative for PN work. Hard-enforcing a still-tentative field as mandatory policy requires QA lead validation (below) — not a silent override.

## Recurring QA Planning Gaps

These gaps were identified in the design-session critique of the first generated PN plan ("partial incorporation" of the overlay).

| Gap | Session evidence | Runtime use |
|---|---|---|
| Governance assumed instead of flagged | Plan assumed approval structure and exit criteria though DoD and sign-off authority were unresolved. | Mark Exit Criteria and Sign-off Criteria `Data Incomplete`; list candidate sign-off roles as pending validation. |
| Environment roles not translated into strategy | QA1 and QA/SIT roles were identified but not mapped into the testing approach. | Map environments in Environment needs; flag any unmapped phase as a readiness gap. |
| LOB scope not enforced as coverage | In-scope/excluded LOBs were provided but not turned into mandatory coverage expectations. | Reflect LOB scope in Scope / Out of scope and the traceability approach. |
| No dependency testing framework | TPS, Paymentus, CAS, and APIHUB were named but not organized into dependency testing. | Add dependency touchpoints in Dependencies and assumptions and Test approach. |
| Automation model underused | RapidBotz, PN Xray, and hybrid manual/automation were named but not reflected in the automation section. | Use the PN automation model in Test approach and automation handoff. |
| Financial validation not streamed | GL, BlackLine, 1099, and EDD were noted as important but lacked dedicated validation. | Add financial validation to Test types / Test approach for payment-related epics. |
| Missing story intake questions | No Swagger/YAML/impact/data-model/UI intake checks. | Apply the intake checklist in Entry criteria and Data Incomplete flags. |
| Traceability stayed epic-only | Traceability did not extend to the fuller PN chain. | Apply the PN traceability model in the traceability approach. |

## Common Systems And Workstreams

| System / workstream | Observed role |
|---|---|
| TPS | Payment processing integration dependency. |
| Paymentus | Payment gateway integration dependency. |
| CAS | Integration dependency touchpoint. |
| APIHUB | Integration/API dependency touchpoint. |
| GL | General ledger financial validation area. |
| BlackLine | Financial reconciliation validation area. |
| 1099 | Tax reporting financial validation area. |
| EDD | Financial validation area referenced in plan discussion. |
| RapidBotz | Existing PN automation framework/suites. |
| PN Xray | PN automation/test repository. |

## Common Test Types

Observed / discussed test types for PN work:

- Functional validation (development-cycle).
- Integration validation (system-to-system touchpoints such as TPS, Paymentus, CAS, and APIHUB).
- End-to-end (E2E) validation (full business-flow validation across integrated systems).
- Financial reconciliation validation (GL, BlackLine, 1099, EDD) for payment-related epics.
- Regression.
- Automation via RapidBotz where applicable.

## Environment And Data Patterns

| Pattern | Status | Runtime use |
|---|---|---|
| QA1 for functional / development-cycle testing | `Candidate Overlay Field` (tentative; "likely" in session, not finalized) | Use in Environment needs; label "PN pending confirmation" until environment ownership confirms. |
| QA/SIT for integration and E2E testing | `Candidate Overlay Field` (tentative) | Use in Environment needs; flag unmapped phases as readiness gaps. |
| LOB test-data scope drives data setup | `Candidate Overlay Field` (team-stated) | Restrict test data to in-scope LOBs; exclude excluded LOBs; note PUP constraint below. |

## LOB Coverage Scope

| Scope | LOBs | Status |
|---|---|---|
| In scope | Personal Auto: Signature Series, Choice, California Signature Series, California Choice. Homeowners: HO3, HO4, HO6, DP3. | `Candidate Overlay Field` (team-stated in session; recommend QA lead ratify as `Validated Team Standard`). |
| Out of scope | Motorcycle. Commercial Auto (unless business confirms inclusion). | `Candidate Overlay Field`. |
| Constraint | PUP claims do not support manual-check testing. | `Observed Pattern`. |

Runtime use: present LOB scope inside Scope / Out of scope and the traceability approach, not as a new top-level section. Do not add or drop an LOB without source evidence or QA lead confirmation.

## Automation And Suite Ownership Patterns

| Item | Status | Runtime use |
|---|---|---|
| Framework: RapidBotz | `Candidate Overlay Field` (agreed as existing) | Use in automation handoff instead of generic automation language. |
| Repository: PN Xray | `Candidate Overlay Field` (agreed as existing) | Reference as the PN test/automation repository. |
| Hybrid manual/automation strategy | `Observed Pattern` | Ask which coverage is manual vs automated per epic. |
| Maintenance ownership (project-owned preferred) | `Data Incomplete` (explicitly pending in session) | Do not assert project-owned maintenance; flag as pending confirmation. |

## Release And Readiness Signals

| Signal | Status | Runtime use |
|---|---|---|
| Definition of Done | `Data Incomplete` (forthcoming; page not yet published) | Mark exit criteria dependent on DoD as Data Incomplete; link the DoD page once it exists. |
| Sign-off authority | `Data Incomplete` (not finalized) | List candidate sign-off roles as pending validation; do not assign an owner. |

## Story Intake Checklist

Apply as an entry-readiness aid (`Candidate Overlay Field`, proposed in session). Unanswered items become `Data Incomplete`:

- Swagger available?
- YAML available?
- TPS impact?
- Paymentus impact?
- Automation candidate?
- Data model change?
- UI change?

## Traceability Model

`Candidate Overlay Field` (proposed in session; ratify with QA lead before treating as standard):

```text
Epic -> Feature -> Story -> Acceptance Criteria -> Test Case -> Automation -> Defect
```

Runtime use: apply within the traceability approach section. Detailed test-case, RTM, coverage-map, and XRAY CSV generation still routes to QA Test Case Architect v2.

## Candidate Overlay Fields (mapped to runtime contract overlay fields)

| Runtime-contract overlay field | PN value | Validation status |
|---|---|---|
| Workstream/application | Payment Ninjas (PN) / DPT initiative | `Candidate Overlay Field` |
| Required test types | Functional, integration, end-to-end (E2E), financial reconciliation, regression | `Candidate Overlay Field` (financials `Observed Pattern`) |
| Environment map | QA1 functional; QA/SIT integration/E2E | `Candidate Overlay Field` (tentative) |
| Data strategy | In-scope LOB data; excluded LOBs; PUP manual-check constraint | `Candidate Overlay Field` |
| Automation-suite ownership | RapidBotz + PN Xray; maintenance ownership pending | `Candidate Overlay Field` / maintenance `Data Incomplete` |
| Risk rubric | Payment integrations (TPS/Paymentus/CAS/APIHUB) and financial areas (GL/BlackLine/1099/EDD) are high impact | `Candidate Overlay Field` |
| Deliverable expectations | PN traceability model; story intake checklist | `Candidate Overlay Field` (proposed) |

## QA Lead Validation Questions

- Are the in-scope LOB variants and exclusions (Motorcycle; Commercial Auto conditional) confirmed as a team standard?
- Are QA1 (functional) and QA/SIT (integration/E2E) the confirmed environment roles, and who owns them?
- Is automation maintenance project-owned during the initiative, or handed back to scrum teams?
- What is the agreed financial-validation approach and evidence expectation for GL, BlackLine, 1099, and EDD?
- Should the Story Intake Checklist be a required entry gate or an advisory aid?
- Is the Epic -> Feature -> Story -> AC -> Test Case -> Automation -> Defect chain the ratified PN traceability standard?
- Who is the confirmed QA sign-off authority once the DoD page is published?

## Guardrails And Non-Assumptions

- Do not treat design-session statements as validated team standards until the QA lead confirms them.
- Do not assume DoD content, exit criteria, or sign-off owners; mark them `Data Incomplete`.
- Do not add new top-level plan sections; inject PN intelligence into the standard structure.
- Do not carry individual names into reusable overlay content; use roles.
- Do not assert automation maintenance ownership, environment ownership, or financial-validation approach until confirmed.
- Do not use the PN overlay for another team, and do not let PN-specific values leak into the reusable core or other team overlays.
- If a current PN story or source packet conflicts with this overlay, prefer the current source and mark the conflict.
- Route detailed test cases, RTM, coverage maps, and XRAY CSV to QA Test Case Architect v2.
