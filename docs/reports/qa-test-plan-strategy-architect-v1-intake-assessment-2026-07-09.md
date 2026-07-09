# QA Test Plan & Strategy Architect v1 — Agent Candidate Intake Assessment

Report date: 2026-07-09

Status: Repo-only intake / fit assessment. No ROVO Studio, Jira, Confluence, or XRAY
writes were performed. This packet does not approve, promote, assign owners, merge,
retire, or broaden visibility for any agent. Lifecycle status, ownership, consolidation,
and retirement remain human-owned decisions.

## Objective

Run the candidate **QA Test Plan & Strategy Architect v1** through the Agent Fit Intake /
ROVO Design Agent intake flow (`docs/confluence-pages/agent-fit-intake.md`), the inventory
reuse/overlap check, and the governance completeness contract
(`docs/agent-governance-completeness-contract.md`), then recommend the lightest governed
route. The candidate is a detailed instruction set intended for the ROVO Studio
*Instructions* field; it produces two artifact types:

- **Project Test Plan** — the master, cross-cutting plan (one per project/program).
- **Epic Test Strategy** — an epic-scoped plan that references and inherits from its parent
  Project Test Plan.

## Evidence Basis

All claims are labeled by evidence type. No claim is stronger than its evidence.

| Evidence type | Meaning in this packet |
|---|---|
| Candidate-instruction | Behavior stated in the user-provided instruction set (`QA_Test_Plan_Strategy_Architect_Instructions.md`, provided 2026-07-09). Design intent, not proven Studio configuration, ownership, visibility, or approval. |
| Repo-backed | Governance docs, inventory, prior reports, and operating contract in this repo. |
| User-provided owner | Owner evidence supplied previously for adjacent agents; backup owners remain Unknown. |
| Unknown | Not provided or not proven in repo-local evidence. |

Primary sources:

- User-provided instruction set: `QA_Test_Plan_Strategy_Architect_Instructions.md` (2026-07-09).
- `docs/confluence-pages/agent-inventory.md`
- `docs/agent-governance-completeness-contract.md`
- `docs/confluence-pages/agent-fit-intake.md`
- `docs/reports/testing-services-top-three-test-generation-agent-comparison-2026-07-08.md`
- `docs/reports/testing-services-ai-agent-inventory-readiness-report-2026-07-08.md`
- `docs/confluence-pages/qa-test-case-architect-v2-project-brain.md`

Honesty constraint carried from the instruction set itself: the candidate's stated
"source of truth," a Confluence page named *QA Standard Test Plan Template for Rovo Agents*,
**could not be retrieved** by the author (automated retrieval is blocked). The required
section lists in the instruction set are therefore reconstructed / interim, not verified
against the live standard. This is a material context-readiness gap, not a detail.

## Intake Flow Result (Design Agent 8-Step Sequence)

| Step | Action | Result |
|---|---|---|
| 1 | Restate as a workflow problem | Turn Jira/Confluence/diagram/email/chat evidence into review-ready QA **test planning** artifacts (project-level test plan and epic-level test strategy), with traceability, risk/impact classification, and gap logging. |
| 2 | Better prompt / default behavior enough? | No. Ongoing ownership, scoped sources, auditability, versioned living documents, and template governance are required. Not a one-off prompt. |
| 3 | Automation / deterministic rule enough? | No. Requires exploratory reasoning over heterogeneous evidence, conflict logging, and interactive clarification. |
| 4 | Inventory reuse / extension check | **Primary finding — see Overlap Analysis.** A governed agent (`QA Test Strategy Planner`) already occupies the QA planning/strategy lane, and an external agent (`QA Test Plan Architect`) already produces insurance-platform test plans from a strict template. This is a duplicate/consolidation situation, not a greenfield build. |
| 5 | Confluence template / source cleanup? | Partly relevant. The strict multi-section Project Test Plan and Epic Test Strategy structures are strong **team-template** candidates regardless of the agent decision, and the unverified standard-template page must be reconciled either way. |
| 6 | Agent candidate needing discovery? | Yes, at minimum. Scope is agent-shaped but the boundary against `QA Test Strategy Planner` and the fate of `QA Test Plan Architect` are unresolved. |
| 7 | Collect completeness fields if a new governed agent still looks justified | Partial — see Completeness Pass. Ownership, measurement, Project Brain, and verified template source are missing. |
| 8 | If fields / source readiness missing, keep in `Idea` and route to discovery/remediation | **Applies.** Keep at `Idea` (candidate). Do not scaffold a full new governed page family or imply a build decision until the overlap and template-source gaps are resolved by a human. |

## Overlap Analysis (the crux)

The candidate sits in the **QA planning / test-strategy** layer — distinct from test-case
generation, but heavily overlapping two existing assets.

| Existing asset | Type / status (repo-backed) | Overlap with candidate | Interpretation |
|---|---|---|---|
| **QA Test Strategy Planner** | Governed agent; `Pilot Approved` / `Needs Cleanup`; owner Shayne Vandersloot; Lisa Porter pilot; Project Brain `5403017262` (Confluence-only, no repo page family) | **High / direct.** Purpose is "QA strategy, test planning, automation handoff, and QA deliverable readiness" — the same planning lane the candidate targets. | The candidate reads as a more fully specified version of this agent's job. Most likely a **maturation / reconciliation** of QA Test Strategy Planner rather than a second, parallel planning agent. |
| **QA Test Plan Architect** | External agent; not repo-proven; owner Raghavender Reddy Vedire; insurance/Guidewire domain; strict multi-section test-plan template | **High / direct.** Generates structured QA test plans for insurance-platform epics from a strict section template — the same output shape and domain (regression Category A/B/C, FNOL/claim, Guidewire) as the candidate. Prior comparison recommended: team template first, possible reuse by QA Test Strategy Planner — **not** a separate governed agent. | The candidate looks like a governed **successor/consolidation** of QA Test Plan Architect. Standing up the candidate as brand-new, while QA Test Plan Architect keeps running, would create exactly the duplicate sprawl the prior comparison warned against. |
| **QA Test Case Architect v2** | Governed candidate; `Draft` / `Needs Cleanup` | **Adjacent, not duplicate.** QATCA v2 produces test *cases*, RTM, coverage maps, XRAY CSV — the downstream layer. The candidate produces the *plans/strategies* those cases roll under. | Complementary. The candidate's Traceability Matrix and Epic Test Strategy should hand off to, not re-implement, QATCA v2's test-case package. Define the boundary explicitly. |
| **Jira Work Item Assistant** | Governed; `In Review` | Low. Shares Jira/AC source reading only. | Keep story/AC refinement in Jira Work Item Assistant; the candidate consumes confirmed AC, it does not groom them. |

Governance implication: under the intake Routing Rules, "New governed agent" is explicitly
*not* the right route "when a duplicate exists." A governed agent (`QA Test Strategy
Planner`) already serves the same audience, domain, and workflow family, so the intake
routes this to **Existing-agent extension / reconciliation**, gated on a human
consolidation decision.

## Completeness Contract Pass

Field-level, present/total (never a percentage). `Present` means proven by the instruction
set or repo evidence for this intake. `Unproven` means not proven in repo-local evidence,
not necessarily absent from a future Studio configuration.

| Field | State | Evidence / note |
|---|---|---|
| `agentName` | Present | QA Test Plan & Strategy Architect v1 (candidate-instruction). |
| `owner` | Unproven | Not stated. Adjacent QA planning agent is owned by Shayne Vandersloot (user-provided); assignment is a human decision. |
| `backupOwner` | Unproven | Not stated. |
| `status` | Present (intake) | Treated as `Idea` / candidate for this assessment; no governed lifecycle status assigned. |
| `purpose` | Present | Clear: generate review-ready Project Test Plans and Epic Test Strategies from explicit source evidence. |
| `audience` | Present | QA Engineers, Test Leads, Scrum Masters, Project/Program Managers (candidate-instruction). |
| `knowledgeSources` | Needs Cleanup | Names Jira epics/stories/AC, Confluence, diagrams, emails, chat transcripts, and the *QA Standard Test Plan Template for Rovo Agents* — **but that template page is unverified/unreachable**, so the section-order "source of truth" is not proven. |
| `toolsOrSkills` | Unproven | Instruction set implies read-only Jira/Confluence retrieval + image/PDF ingestion, no writes; not proven against a Studio configuration. |
| `measurementPlan` | Missing | No value signal, baseline, quality signal, or cadence defined in the instruction set. |
| `readinessStatus` | Not Ready / Needs Cleanup | Unverified template source, unassigned owner, unresolved overlap, no evaluation evidence, no Project Brain. |
| `projectBrainLink` | Missing | No Project Brain exists for this candidate. |
| `lastReviewedDate` | Present | 2026-07-09 (this intake). |

Proven-enough for intake: ~5/12 (`agentName`, `status`, `purpose`, `audience`,
`lastReviewedDate`), with `knowledgeSources` and `toolsOrSkills` partial/unproven. Readiness
is **Not Ready** for build until the blocking gaps below are closed. This is comparable to
the other Testing Services QA candidates at intake.

## Strengths Worth Preserving (regardless of the route)

These are well-designed and should carry forward into whichever asset owns the workflow:

- Clear artifact-type disambiguation (ProjectTestPlan vs EpicTestStrategy) with a
  confirm-before-drafting rule when the level is ambiguous — avoids drafting the wrong scope.
- Living-document discipline: one current plan per project / strategy per epic, dated
  revisions with change history, deterministic IDs (`TP-{ProjectKey}-{YYYYMMDD}-v{N}`,
  `TS-{EpicKey}-{YYYYMMDD}-v{N}`).
- Retrieval → Generation → Validation pipeline with an explicit self-check gate.
- Strong safety posture that already matches repo boundaries: no fabricated scope/AC/dates,
  `TBD → Gap Analysis` instead of hidden gaps, ConflictLog for conflicting sources, PII/PHI
  masking, no execution / no go-no-go / no approval, no direct Jira/Confluence writes
  (Markdown for human publish), explicit instruction-conflict refusal rule.
- Fixed, non-reorderable Traceability Matrix CSV header — a governable output contract,
  the same discipline QATCA v2 uses for its XRAY CSV.
- Regression Category A/B/C model with Category C (modified existing) getting the deepest
  coverage — reusable risk logic.

## Risks and Gaps To Resolve Before Build

| Risk / gap | Why it matters | Suggested resolution (human-owned) |
|---|---|---|
| Duplicate/overlap with QA Test Strategy Planner | Two governed agents in one QA planning lane = sprawl, unclear ownership, inconsistent output. | Decide: does this candidate **become** the governed QA Test Strategy Planner (v-next), extend it, or stay separate with a hard boundary? |
| Fate of external QA Test Plan Architect | Prior comparison routed it to template/reuse, not a separate agent. Leaving it running alongside this candidate re-creates the duplicate. | Consolidation + retirement/reuse decision with its owner (Raghavender Reddy Vedire). |
| Unverified standard-template source | The agent's "source of truth" for required sections cannot be verified; the enforced section lists are interim. | Confirm the live *QA Standard Test Plan Template for Rovo Agents* content, or adopt the interim lists as the governed standard and update the Confluence page to match. |
| No owner / backup owner | Cannot promote beyond Draft. | Assign primary + backup owner. |
| No measurement plan | Value/quality unprovable; ROI claims unsupported. | Define time-saved, output accepted/edited/rejected, traceability completeness, and cadence (reuse the Testing Services ROI model). |
| No evaluation evidence | Behavior/safety unproven. | Build an evaluation prompt pack (artifact-selection, missing-source, conflict-logging, PII/PHI masking, unsafe-write trap, template-unverified fallback) before any pilot. |
| Boundary vs QA Test Case Architect v2 | Users may ask the planning agent to generate full test-case packages, or vice versa. | Document the handoff: this agent plans and traces; QATCA v2 generates the case package. |
| Domain hard-coding risk | Insurance/Guidewire framing must not bake in private project keys, names, or claim/policy identifiers. | Keep domain context configurable/source-derived; private-data scan before any commit. |

## Recommendation

**Route: Existing-agent extension / reconciliation, held at `Idea` (candidate), Not Ready
for build.** Do not stand up a new parallel governed agent.

Rationale: a governed agent (`QA Test Strategy Planner`) already owns the QA planning/strategy
lane, and an external agent (`QA Test Plan Architect`) already produces the same
insurance-platform test-plan output. The candidate is best understood as the mature,
well-specified expression of that same workflow — the right governed move is to reconcile
it with `QA Test Strategy Planner` (as a v-next / extension) and fold in `QA Test Plan
Architect` as template + reuse, not to create a third planning agent.

In parallel, the two strict artifact structures (Project Test Plan, Epic Test Strategy) are
strong **team-template** candidates that deliver value even before the agent-consolidation
decision lands.

This recommendation makes no lifecycle, ownership, consolidation, retirement, visibility, or
approval decision. Those remain human-owned.

## Recommended Next Steps (smallest reviewable slices)

1. **Human consolidation decision (blocking):** confirm whether this candidate is the
   v-next of `QA Test Strategy Planner`, an extension of it, or separate — and the fate of
   external `QA Test Plan Architect`. Record the reuse/improve/merge/reject/new decision in
   the Duplicate Prevention Workflow.
2. **Resolve the template source:** verify the live standard page or ratify the interim
   section lists as the governed standard.
3. **Capture QA Test Strategy Planner into a repo page family** (Project Brain, knowledge
   source plan, evaluation, measurement plan) so the reconciliation has a governed target;
   today it is Confluence-only.
4. **Only after 1–3:** scaffold the chosen artifact set (extend the existing Project Brain,
   or a new one if the human decision is "separate"), assign owner/backup, add a measurement
   plan, and draft an evaluation prompt pack.
5. Keep the Project Test Plan / Epic Test Strategy structures as reusable team templates
   regardless of the agent decision.

## Boundaries Respected

- No ROVO Studio, Jira, Confluence, or XRAY writes.
- No agent-inventory, owner, readiness, lifecycle, approval, or retirement changes.
- No promotion to Active, Ready, Team Approved, or Pilot Approved.
- No full new governed page family scaffolded — that would imply a build decision not yet
  made and risk the exact duplicate sprawl this assessment flags.
- User-provided instruction set treated as design-intent evidence; no private project keys,
  epic/claim identifiers, names, or raw exports carried into this repo.
- Existing QA Test Strategy Planner and QA Test Case Architect v2 governance docs remain the
  source path for any future reconciliation.
