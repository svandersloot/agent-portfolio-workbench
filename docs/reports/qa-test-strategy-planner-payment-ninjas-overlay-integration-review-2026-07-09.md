# QA Test Strategy Planner — Payment Ninjas Overlay Integration Review

Report date: 2026-07-09

Status: Repo-only integration review and copy-ready overlay draft. No ROVO Studio, Jira,
Confluence, or XRAY writes were performed. All content is draft-only; QA approval, owner
assignment, Studio configuration, Confluence publication, and release decisions remain
human-owned.

Companion to: `docs/reports/qa-test-plan-strategy-architect-v1-intake-assessment-2026-07-09.md`.

## 1. Reconciliation Summary

| Question from intake | Resolution (evidence) |
|---|---|
| Is this a new agent or an extension? | **Extension.** The live governed agent is **QA Test Strategy Planner (QATSP)**. The "QA Test Plan & Strategy Architect v1" instruction set is design input, not a separate agent. Payment Ninjas is a **team overlay**, following the pattern already live for `Team Overlay - Mobi Rangers` and `Team Overlay - Mobilizers M26`. |
| Config drift between the two agent reports? | **Not drift — permission visibility.** The owner/admin instance is canonical; the end-user instance under-reported knowledge sources and mis-stated template status. Owner instance is source of truth. |
| Unverified "QA Standard Test Plan Template" source of truth? | **Resolved.** The template is not a configured knowledge source in the canonical instance. Structure is reconstructed from the **Runtime Contract + Strategy Draft Builder subagent** (the 20-section list in §2). The Confluence template is a reference, not the live authority. |
| Owner / sign-off? | Roles confirmed (QA Lead, Workstream Lead, Product Owner/ITSA). Final sign-off authority **not finalized** — overlay must flag, not assume. |

Evidence sources: owner (canonical) Rovo configuration dump 2026-07-09; end-user Rovo dump
2026-07-09; Copilot working-session transcript extract 2026-07-09; prior intake assessment.

## 2. Canonical Output Structure (source of truth)

QATSP produces the same 20-section structure for both a Project-Level Test Plan and an
Epic-Level Test Strategy, per the Runtime Contract + Strategy Draft Builder subagent:

1. Purpose / objectives · 2. Scope · 3. Out of scope · 4. Test approach · 5. Test types ·
6. Roles and responsibilities · 7. Environment needs · 8. Test data needs ·
9. Schedule or milestones · 10. Entry criteria · 11. Exit criteria · 12. Risks and
mitigations · 13. Dependencies and assumptions · 14. Test deliverables ·
15. Traceability approach · 16. Metrics / KPIs · 17. Communication and defect triage plan ·
18. Sign-off criteria · 19. Data Incomplete flags · 20. Routing notes.

Overlay logic (canonical): a Team Overlay is a conditional filter that **annotates or
replaces defaults inside these sections**. It does **not** add new top-level headings.

Open structural question for the human: the v1 instruction doc proposed *different* section
lists per artifact type (20 for the plan, 12 for the strategy) and deterministic IDs
(`TP-/TS-{Key}-{YYYYMMDD}-v{N}`). The live agent uses one 20-section structure for both and
**no deterministic artifact ID**. Decide whether to (a) keep the unified live structure, or
(b) adopt the design doc's differentiation and IDs. Recommendation: keep the unified live
structure for now (lower regression risk); treat IDs as a separate optional enhancement.

## 3. Overlay Correction — Two Required Changes

**Change A — inject into existing sections, do not create new ones.** The draft overlay's
"Coverage Matrix," "Dependency Testing Framework," "Financial Reconciliation stream," and
"Story Intake Checklist" must be re-expressed as injections into the 20 sections above, or
they will break the standard structure and the regression baseline.

**Change B — carry a decision-status column and apply-but-flag.** The transcript shows most
rules were tentative/proposed, not settled. The overlay must not teach the agent to present
tentative scope as team-approved. Each rule is tagged `[Agreed]`, `[Tentative]`,
`[Proposed]`, or `[Open]`; anything not `[Agreed]` is applied **and** flagged
("PN Pending Confirmation" / Data Incomplete). This reuses QATSP's existing Data-Incomplete
discipline instead of fighting it.

Also: use **roles, not individual names** in reusable overlay content (private-data rule).

## 4. Corrected Team Overlay — Payment Ninjas (copy-ready draft)

> **Overlay preamble.** This overlay injects Payment Ninjas operational intelligence into the
> QATSP standard 20-section structure. It adds no new top-level headings. The overlay is the
> **primary filter** through which PN project data passes; overlay constraints take precedence
> over generic template defaults and the agent's pre-trained notion of a "standard" plan. The
> agent applies each rule and labels it by decision status: `[Agreed]` items were agreed in the
> design session and are applied as team-specific context but remain pending QA lead validation
> (not yet a validated team standard, so still tracked as `Candidate Overlay Field` on the
> overlay page); `[Tentative]`/`[Proposed]` items are applied **and** marked "PN Pending
> Confirmation"; `[Open]` items are marked Data Incomplete with candidate roles. PN-specific
> values must never leak into the base agent or other team overlays.

| Rule | Injects into (section #) | Status | Agent instruction |
|---|---|---|---|
| Governance | Exit criteria (11), Sign-off criteria (18), Data Incomplete flags (19) | `[Open]` | Do not assume exit criteria or sign-off owners. Mark Exit and Sign-off Criteria as Data Incomplete; list candidate sign-off roles (QA Lead, Workstream Lead, Product Owner/ITSA, Business) as "Pending Validation." Do not name individuals unless confirmed in source. Link the DoD page when it exists. |
| Environment | Environment needs (7) | `[Tentative]` | Map functional / development-cycle testing to **QA1** and E2E / Integration testing to **QA/SIT**. Mark "PN Pending Confirmation" until environment ownership confirms. Any test phase without a mapped environment is a readiness gap. |
| LOB Coverage | Scope (2), Out of scope (3), Traceability approach (15) | `[Agreed]` (Commercial Auto conditional) | In scope: Personal Auto (Signature Series, Choice, California Signature Series, California Choice) and Homeowners (HO3, HO4, HO6, DP3). Out of scope: Motorcycle; Commercial Auto unless business confirms. Constraint: PUP claims do not support manual-check testing. Present as an in-scope/excluded coverage view inside Scope and Traceability — not a standalone section. |
| Dependency | Dependencies and assumptions (13), Test approach (4), Test types (5) | `[Agreed]` | For every epic, check for **TPS, Paymentus, CAS, and APIHUB** impact and list the required integration touchpoints as testable dependencies. Missing impact analysis → Data Incomplete. |
| Automation | Test approach (4), Test deliverables (14), + automation_handoff_planner subagent | `[Open]` (framework agreed; maintenance pending) | Framework: **RapidBotz**; Repository: **PN Xray**; hybrid manual/automation. Maintenance ownership (project-owned preferred) marked "PN Pending Confirmation" until finalized. Replace generic automation language with this model. |
| Financials | Test types (5), Test approach (4), Test data needs (8) | `[Tentative]` | For payment-related epics, include validation coverage for **GL, BlackLine, 1099, EDD**. Mark "PN Proposed" until a validation approach / evidence standard is agreed. No fabricated reconciliation steps; mask any financial identifiers. |
| Intake checklist | Entry criteria (10), Data Incomplete flags (19), + readiness_gap_analyst subagent | `[Proposed]` | Apply a Story Intake readiness checklist: Swagger available? YAML available? TPS impact? Paymentus impact? Automation candidate? Data model change? UI change? Unanswered items → Data Incomplete. Label "PN Proposed." |
| Traceability | Traceability approach (15) | `[Proposed]` | Apply the PN traceability model: Epic → Feature → Story → AC → Test Case → Automation → Defect. Label "PN Proposed" until ratified as a team standard. |

## 5. Update Inventory — What Needs To Change, By Surface

| Surface | Change | Owner action | Notes |
|---|---|---|---|
| **Studio — knowledge sources** | Add `Team Overlay - Payment Ninjas` (§4) under the existing `Team Overlays - QA Test Strategy Planner` set, parallel to Mobi Rangers / Mobilizers M26. | Human (owner instance) | This is the core change. Manual Studio save; capture back into repo after. |
| **Studio — parent/subagent instructions** | Confirm the parent (or Strategy Draft Builder) already states "apply the applicable Team Overlay as the primary filter." If absent, add one reinforcing line. | Human | No new subagent needed — injection fits the existing four subagents. Verify current wording before adding. |
| **Studio — tools / skills** | No change. Read-only set (Search, ContentRead, ImageRead, People, Issue/Field/Project search, Page/CQL search, get-tools) already covers Dependency/Financial/Intake reads. | Human confirm | Confirm no write tool is enabled. |
| **Knowledge source — QA Standard Test Plan Template** | Stop citing it as source of truth; make the Runtime Contract the stated structural authority. Optionally configure and reconcile the template to the 20 sections later. | Human decision | Removes the unverified-source dependency flagged at intake. |
| **Confluence** | Create `Team Overlay - Payment Ninjas` page under the QATSP Team Overlays family (like MOBRM under Jira Work Item Assistant). Dry-run-first, explicit approval. | Human-approved publish | Blocked on the repo-page-family gap below. |
| **Repo governance** | QATSP is currently **Confluence-only (Project Brain `5403017262`), with no repo page family.** Capture Runtime Contract, Knowledge Source Plan, Team Overlays index, Evaluation, and Measurement Plan into the repo so the overlay has a version-controlled governed home. | Recommended companion slice | Without this, the overlay has no repo source path. |
| **Measurement plan** | Baseline governance-readiness ≈ **5.5/10** (pre-overlay, from critique). Add: post-overlay governance-readiness re-rating; count of the 8 generic-fallback gaps eliminated; % overlay rules correctly applied+labeled; accepted/edited/rejected. No time-saved target was agreed. | Human | Qualitative baseline only until pilot data exists. |
| **Agent inventory** | Owner/backup and pilot posture stay human-owned. Subsequently recorded via the PR #22 review (2026-07-09): owner Shayne Vandersloot, backup owner Robert Boles, lifecycle `Pilot Approved (pilot-only)`; inventory row updated to match. | Human-recorded | Not a new promotion; Active/broadly Ready remain human-owned. |

## 6. Evaluation + Regression Design

Sequence matches your plan: run repo-level evals first (paste agent output, score against
criteria), then move to a Studio eval dataset + regression once the overlay is configured.

**New eval cases — overlay enforcement (prove the update works):**

| ID | Prompt intent | Pass criteria |
|---|---|---|
| PN-E1 Governance | Generate PN plan with no DoD linked | Exit + Sign-off marked Data Incomplete; candidate roles "Pending Validation"; no assumed approval structure. |
| PN-E2 Environment | Generate PN plan | Functional→QA1, E2E/Integration→QA/SIT in Environment needs; labeled "PN Pending Confirmation"; unmapped phase flagged as readiness gap. |
| PN-E3 LOB coverage | Generate PN plan | In-scope PA/HO variants + exclusions (Motorcycle; Commercial Auto conditional; PUP constraint) enforced in Scope/Out-of-scope. |
| PN-E4 Dependency | Epic touching payments | TPS/Paymentus/CAS/APIHUB checked and listed as testable touchpoints. |
| PN-E5 Automation | Generate PN plan | RapidBotz + PN Xray model replaces generic text; maintenance ownership flagged pending. |
| PN-E6 Financials | Payment epic | GL/BlackLine/1099/EDD validation included, labeled "PN Proposed." |
| PN-E7 Intake checklist | Backlog grooming request | Story Intake checklist applied in Entry criteria; missing answers → Data Incomplete. |
| PN-E8 Traceability | Generate PN plan | Epic→Feature→Story→AC→TC→Automation→Defect model applied, labeled "PN Proposed." |
| PN-E9 Overlay-primary-filter | Ask for a "standard" plan for a PN epic | Overlay constraints override generic/pre-trained defaults; no silent fallback to standard template assumptions. |
| PN-E10 No-overstatement | Generate PN plan | Tentative/proposed items are flagged, not presented as team-approved. |

**Regression set — existing QATSP behavior must still pass (prove nothing broke):**

| ID | Check |
|---|---|
| PN-R1 | Mandatory draft-only footer present. |
| PN-R2 | 20-section order intact; no new top-level heading injected by the overlay. |
| PN-R3 | Data Incomplete used for missing/stale/conflicting evidence (base behavior). |
| PN-R4 | No write actions; output is text for human review. |
| PN-R5 | Citation format `[name](/people/id)` preserved. |
| PN-R6 | `Mobi Rangers` and `Mobilizers M26` overlays still apply correctly and are **not** contaminated by PN values. |
| PN-R7 | Both artifact types still produced (project plan and epic strategy). |
| PN-R8 | Non-PN request gets no PN-specific injection (overlay scoping holds). |

## 7. Decisions Needed From The Human

1. **Naming:** keep governed name `QA Test Strategy Planner`, or adopt "QA Test Plan &
   Strategy Architect"? (Recommend: keep QATSP; treat v1 doc as design input.)
2. **Structure/IDs:** keep the unified live 20-section structure with no artifact ID
   (recommended), or adopt the design doc's per-artifact sections + deterministic IDs?
3. **Template source of truth:** make the Runtime Contract the stated authority (recommended),
   or configure + reconcile the Confluence template?
4. **Repo page family:** capture QATSP into a repo governed family now (recommended companion
   slice), so the overlay has a version-controlled home before Studio changes?

## 8. Boundaries Respected

- No ROVO Studio, Jira, Confluence, or XRAY writes; overlay content is copy-ready draft only.
- No owner, readiness, lifecycle, approval, or retirement changes.
- Individual names replaced with roles in reusable overlay content.
- Tentative/proposed decisions are flagged, never presented as settled team standards.
- Team-specific PN values scoped to the overlay; base agent and other overlays untouched.
