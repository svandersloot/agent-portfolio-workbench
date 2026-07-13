# Measurement Plan - QA Test Case Architect v2

## Measurement Status

| Field | Value |
|---|---|
| Agent | QA Test Case Architect v2 |
| Lifecycle status | Draft |
| Readiness status | Needs Cleanup |
| Measurement maturity | Draft |
| Review cadence | After each pilot artifact package, then quarterly if promoted |

## Value Hypothesis

QA Test Case Architect v2 should reduce the time required to draft QA test artifacts while improving acceptance-criteria coverage, traceability, standard formatting, and visibility of unresolved requirement gaps.

### Time-Savings Hypothesis (Session 1 follow-up, not an ROI claim)

Recorded from the 2026-07-10 working session (see `qa-test-case-architect-v2-session-review-2026-07-10.md`, evidence E20).

| Field | Value |
|---|---|
| Hypothesis | Agent-assisted drafting reduces the time a QA engineer spends producing the first review-ready draft of a test-suite package (summary, description, and CSV formatting), versus fully manual authoring. |
| What prompted it | One QA SME stated in-session that the agent "would save a lot of time," especially on formatting, summary, and description drafting. |
| Evidence strength | **Anecdotal.** One SME opinion, one story, one unrepeated session. This is a hypothesis to test, **not** measured time savings, **not** an ROI claim, and **not** a readiness or approval signal. |
| Proposed metric | Test artifact draft time (manual baseline vs agent-assisted), already tracked in the Metrics table below. |
| Baseline capture | **Owner-owned gate.** The measurement owner must define how the manual baseline is captured (e.g., timed manual authoring of a comparable package) before any reduction figure is stated. Until then, no percentage or time-saved number is claimed. |
| Confounders to control | Post-generation rework (steps were judged "barely functional" in Session 1), story complexity, and reviewer familiarity. Draft-time savings must not be reported net of the rework the SME still expects to do on steps. |
| Explicitly out of scope | ROI, cost savings, headcount impact, and "production-ready" claims. This hypothesis measures draft-time only, once a baseline exists. |

## Metrics

| Metric | Baseline | Target | Measurement Method | Cadence |
|---|---|---|---|---|
| Test artifact draft time | TBD during first pilot ticket pack | 25 percent reduction after two pilot ticket packs | QA owner estimates manual vs agent-assisted time | Per package |
| AC coverage completeness | TBD | 100 percent of provided AC mapped to tests or explicit gaps | Review coverage map | Per package |
| Validation gate completeness | TBD | 100 percent of outputs include coverage, XRAY/CSV, traceability, and missing-data feedback when applicable | Review generated validation section | Per package |
| Human correction rate | TBD | Reduce repeated formatting and traceability corrections after first two packages | Count owner edits or review comments | Per package |
| Conflict/TBD visibility | TBD | All known missing or conflicting inputs appear in `ConflictLog` or `TBDLog` | Owner review checklist | Per package |
| Unsafe action refusal | Not measured | 100 percent refusal for test execution, go/no-go, and write requests | Evaluation prompts | Monthly during pilot |
| Production ticket-pack gate | Not measured | 100 percent of production runs require `TICKET_PACK_COMBINED.xml` | Evaluation and manual prompt review | Monthly during pilot |

## Quality And Risk Signals

| Signal | Good | Warning | Action |
|---|---|---|---|
| Source completeness | Jira story, AC, QA template, and required schemas are available. | Missing AC, template, schema, or export metadata. | Mark Data Incomplete and ask for source evidence. |
| Production input package | `TICKET_PACK_COMBINED.xml` is available for production run. | User asks for production artifact generation from incomplete ad hoc context. | Stop and request ticket pack; allow prompt source packet only for evaluation/prototype. |
| Traceability | Every AC maps to tests or a documented gap. | Unmapped AC or tests without source requirement. | Revise output and rerun coverage check. |
| Golden-copy fit | Requested artifact matches an approved template or example. | No example exists or format differs by team. | Mark validation limited and request approved example. |
| Deterministic IDs | ID rule is confirmed by QA/XRAY owner. | Draft IDs used without approved legacy mapping. | Keep IDs caveated and block pilot promotion. |
| Human approval | QA owner reviews before upload/use. | User asks agent to approve or upload directly. | Refuse write/approval and return review packet. |
| Privacy | Source packet contains only permitted QA data. | PII/PHI or restricted data appears in pasted/exported content. | Stop and ask user to sanitize or confirm permitted use. |

## Reporting Table

| Package | Date | Artifact type | Draft time estimate | AC count | Tests generated | ConflictLog count | TBDLog count | Review corrections | Owner rating | Notes |
|---|---|---|---|---|---|---|---|---|---|---|
| TBD | TBD | CSV / Coverage Map / RTM | TBD | TBD | TBD | TBD | TBD | TBD | TBD | Start after pilot owner is assigned. |

## Review Cadence

- Pilot: review after each generated artifact package.
- First lifecycle review: after two pilot packages or 30 days, whichever comes first.
- Steady state: quarterly review if promoted beyond pilot.

## Promotion Evidence Needed

- Named primary and backup owner.
- Confirmed QA standard template source.
- Confirmed Ticket Pack Builder handoff and `TICKET_PACK_COMBINED.xml` structure.
- Confirmed manual Copilot/XRAY CSV generation and import model.
- Approved golden-copy examples or templates for advertised artifacts.
- Defined coverage, XRAY format, CSV structure, and traceability validation thresholds.
- At least two evaluated artifact packages.
- Measurement table started with real pilot data.
- No write-capable Jira, XRAY, or Confluence tools enabled unless separately approved.
