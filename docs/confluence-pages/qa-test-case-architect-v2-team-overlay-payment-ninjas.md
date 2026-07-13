# Team Overlay - Payment Ninjas (PN) - QA Test Case Architect v2

## Status And Ownership

| Field | Value |
|---|---|
| Team | Payment Ninjas (PN) |
| Overlay status | Draft overlay |
| Parent agent | QA Test Case Architect v2 |
| Primary owner | Needs human confirmation; not formally assigned |
| Backup owner | Needs human confirmation; not formally assigned |
| Last reviewed | 2026-07-13 |

## Purpose

This overlay configures QA Test Case Architect v2 for Payment Ninjas (PN) work. It is scoped to Slice S4: the configurable deterministic test-case ID (TC-ID) pattern, plus the minimal team identity needed to select this overlay. It does not restate the shared XRAY column contract, and it does not define step-voice/prerequisite enrichment or the test-type allow-list, both of which remain open items owned by other slices (see `Not yet defined in this overlay` below).

Use this overlay only when the user is working with Payment Ninjas, the PN workstream, or an explicitly supplied PN source packet. Apply the clarification/intake gate defined in `ROVO Studio Configuration - QA Test Case Architect v2` and `Studio Setup - QA Test Case Architect v2` before assuming this overlay applies on a ticket-attach run with ambiguous scope.

## Deterministic TC-ID Pattern

| Field | Value |
|---|---|
| Pattern | `{ProjectPrefix}-{StoryNumber}-{Seq}` |
| Example | `BB26-2620-1` |
| Base/default fallback (no overlay) | `TC-{StoryID}-{AC}-{AREA}-{TYPE}-{NNN}` (see `ROVO Studio Configuration - QA Test Case Architect v2`) |

Pattern components:

- `{ProjectPrefix}` and `{StoryNumber}` come directly from the source Jira story key (for example, a story key of `BB26-2620` supplies `ProjectPrefix = BB26` and `StoryNumber = 2620`).
- `{Seq}` increments per test case within the story, starting at 1 (`BB26-2620-1`, `BB26-2620-2`, `BB26-2620-3`, and so on).
- IDs must be deterministic and stable across reruns: the same source story and test-case set must produce the same IDs every time the agent regenerates output. Do not vary sequence assignment based on run order, wall-clock time, or random tie-breaking.
- ROVO draft IDs generated under this pattern are internal draft identifiers only. They are not final XRAY keys. XRAY numbering happens on import, after the human/Copilot/manual CSV flow described in `ROVO Studio Configuration - QA Test Case Architect v2`.
- When no team overlay is configured, or when this overlay does not apply, the agent falls back to the base default pattern `TC-{StoryID}-{AC}-{AREA}-{TYPE}-{NNN}`, not this pattern.

## XRAY Column Contract

Payment Ninjas uses the shared 14-column XRAY CSV contract documented in `ROVO Studio Configuration - QA Test Case Architect v2` (Story ID, TC ID, Summary, Description, Test Type, Application list, Test Type, Regression, Automated, Assignee, Functionality, Data, Action, Expected Result). This overlay does not redefine or vary that contract; the column names, order, and count are shared across teams.

Team-specific column *values* (for example, the `Application list` entries relevant to PN) come from the sanitized golden fixture `qa-test-case-architect-v2-team-golden-import-payment-ninjas.csv`, not from this page. Use the golden as the source of truth for PN-specific value examples.

## Not Yet Defined In This Overlay

The following items are explicitly out of scope for this overlay and this slice (S4). They are deferred to other slices and are blocked on inputs this overlay does not yet have. Do not infer or fabricate their content from this page.

| Item | Status | Deferred to |
|---|---|---|
| Step-voice / prerequisite enrichment for PN test steps | Not yet supplied; blocked on SME historical examples | Slice S5 |
| Test-type allow-list for PN work | Not yet supplied; blocked on QA owner source | Slice S7 |

## Guardrails And Non-Assumptions

- Do not assert a primary or backup owner for this overlay; owner assignment is human-owned.
- Do not treat this overlay as `Active`, `Ready`, or approved for broad pilot use.
- Do not use the PN TC-ID pattern for another team, and do not let PN-specific values leak into the base default pattern or other team overlays.
- Do not modify the shared XRAY column contract from this page; any contract change routes through `ROVO Studio Configuration - QA Test Case Architect v2` and `Studio Setup - QA Test Case Architect v2`.
- If a current PN story or source packet conflicts with this overlay, prefer the current source and log the conflict for human review.
- This overlay does not perform, and must not be read as authorizing, any ROVO Studio, Jira, XRAY, or Confluence write action.
