# Team Overlay - Breaking Backlogs (BB26) - QA Test Case Architect v2

## Status And Ownership

| Field | Value |
|---|---|
| Team | Breaking Backlogs (BB26) |
| Overlay status | Draft overlay |
| Parent agent | QA Test Case Architect v2 |
| Primary owner | Needs human confirmation; not formally assigned |
| Backup owner | Needs human confirmation; not formally assigned |
| Source pages | `Breaking Backlogs` team overview (Confluence space BB1, `/spaces/BB1/overview`, page ID 3891920960); `Team Standards: Breaking Backlogs (BB26)` (Confluence page ID 5271290013, space MO) |
| Last reviewed | 2026-08-27 |

## Purpose

This overlay configures QA Test Case Architect v2 for Breaking Backlogs (BB26) work. It covers BB26's ticket naming and structure convention, acceptance-criteria density expectations, board and Definition of Ready/Done signals worth citing in generated artifacts, and the base-default deterministic TC-ID pattern (BB26 does not need its own custom pattern — see below). It does not restate the shared XRAY column contract, which is defined in `ROVO Studio Configuration - QA Test Case Architect v2` and is shared across teams.

Use this overlay only when the user is working with Breaking Backlogs, the BB26 workstream, or an explicitly supplied BB26 source packet (for example, a story carrying the `CAS`, `SmartComm`, or `NextGen` label, or linked to a `CLM26`/`CLME` epic). Apply the clarification/intake gate defined in `ROVO Studio Configuration - QA Test Case Architect v2` and `Studio Setup - QA Test Case Architect v2` before assuming this overlay applies on a ticket-attach run with ambiguous scope.

This overlay was authored directly from the two source pages above via the Atlassian MCP connector (read-only), resolving the sourcing blocker recorded in the enhancement plan (§7.3): the connector was previously unavailable in-session, and the `BB1` space/page IDs were not yet confirmed.

## Deterministic TC-ID Pattern

| Field | Value |
|---|---|
| Overlay-specific pattern | None. Breaking Backlogs uses the base default pattern; this overlay does not define its own. |
| Base default (applies here) | `{StoryID}-{Seq}` (example: `BB26-1197-1`) |

Breaking Backlogs does not need a custom TC-ID pattern. The base default introduced in §10 (`{StoryID}-{Seq}`) already produces the right shape from a BB26 project-prefixed story key (for example, `BB26-1197` yields `BB26-1197-1`, `BB26-1197-2`, and so on) without any overlay-specific configuration. If a future BB26-specific pattern is requested (for example, one that differs from the base default), that requires its own governance decision — this overlay does not assume one.

## XRAY Column Contract

Breaking Backlogs uses the shared 15-column XRAY CSV contract documented in `ROVO Studio Configuration - QA Test Case Architect v2` (Story ID, TC ID, Summary, Description, Test Type, Application list, Test Type, Regression, Automated, Assignee, Functionality, Priority, Data, Action, Expected Result; `Priority` is part of the contract, re-added 2026-08-27, and must always be populated — defaulting to `Low` unless the source evidence indicates otherwise — because it is required to close the underlying Jira ticket). This overlay does not redefine or vary that contract; the column names, order, and count are shared across teams.

**BB26's Jira issue-level `Priority` field and the CSV `Priority` column are two separate fields, even though they share a name.** BB26's own Team Standards require a Jira `Priority` value (Critical / High / Medium / Low) to be set before a story is ready for a sprint (see Definition of Ready below); that is a normal, expected part of a BB26 Jira issue and is independent of the CSV output. Do not automatically copy a BB26 story's Jira `Priority` value into the generated CSV `Priority` column — apply the shared default (`Low`, per `ROVO Studio Configuration - QA Test Case Architect v2`) unless a future overlay decision explicitly defines a mapping between the two.

## Ticket Naming And Structure Convention (source: Team Standards: Breaking Backlogs (BB26))

- Functional story summaries follow the pattern `[Project/Component] | [Action/Outcome]` (example from the team standard: `ERAC Frictionless | Create DL Field`). Use this pattern when citing or restating a BB26 story's identity in generated artifacts.
- Story descriptions are organized under `Summary` (high-level overview), `Business Value` (why the work matters, e.g., "frictionless rental experience," "vendor compliance"), and `Technical Context` (specific systems or versions, e.g., "Guidewire Palisades," "CCC Outbound Events") headers. Cite which of these sections fed which part of a generated artifact when possible.
- Functional stories use the **AS A / I WANT / SO THAT** user-story structure.

## Acceptance Criteria Density And Coverage (source: Team Standards: Breaking Backlogs (BB26))

- **Functional stories**: minimum 5 acceptance criteria, written **GIVEN/WHEN/THEN**, expected to cover UI visibility and field editability, data persistence (saving without errors), and cross-LOB consistency (Auto, Home, PUP, etc.). Cross-LOB consistency is itself a signal for this agent's general product/state coverage rule (see `Runtime Contract - QA Test Case Architect v2`, AC And Test Generation Rules) — treat each named LOB as its own combination rather than a single generalized test, consistent with that rule's default.
- **Technical stories / spikes**: minimum 3 acceptance criteria, focused on payload/schema validation, connectivity/integration verification, and deliverables (for example, "mapping document created," "feasibility analysis complete").
- These are BB26's stated density expectations, not a target to fabricate toward: if a BB26 story's actual source evidence falls short of these minimums, log the shortfall in TBDLog as a coverage gap rather than inventing additional acceptance criteria to reach the expected count.

## Board, Definition Of Ready, And Definition Of Done Signals (source: Breaking Backlogs team overview)

- **Board**: BB26 backlog board (internal Jira board; URL intentionally not recorded here per this repo's private-URL handling — see `AGENTS.md`). Confirm the current board link directly in Jira when needed rather than relying on a copied link in this page.
- **Definition of Ready** signals worth citing in a source summary when present: dependencies called out and any dependent-team work completed; description and scope clearly defined; acceptance criteria clear; for SmartComm stories, a proper requirements document from the stakeholder; Jira `Priority` set; linked to a parent epic; `FixVersion` populated when applicable.
- **Definition of Done** expects: acceptance criteria met; no open story bugs; a completed and signed-off **Shoulder Check**; all test cases passed; automation completed, with `Rapidbotz` automation results linked or attached and test execution summaries provided in comments; evidence such as screenshots of UI changes or API responses (for example, Postman) attached.
- Treat "automation completed" and linked `Rapidbotz` results as a signal that a BB26 story likely already has an existing automated-test surface. Do not assume the agent's generated manual TestSuite replaces or duplicates that automation; when source evidence mentions existing `Rapidbotz` coverage, note it in validation notes rather than silently ignoring it or treating the manual suite as the only coverage.
- Missing setup or prerequisite information: as with other teams, log it in TBDLog naming the missing prerequisite rather than inventing concrete steps.

## Test Type Source (S7)

The functional Test Type for a BB26 test is taken from the Jira story's test-type field — the story is the source of truth. The agent does not infer or invent the functional test type from prose. The approved functional test-type list in `Knowledge Source Plan - QA Test Case Architect v2` (Controlled Vocabularies) is canonical validation data: the story's value must be one of those values; if it is missing or not on the list, the agent flags the field for human review rather than guessing. The first `Test Type` (execution mode) is `Manual` — the default and only currently approved value; no other value is emitted unless a future approved source changes the shared contract.

## Guardrails And Non-Assumptions

- Do not assert a primary or backup owner for this overlay; owner assignment is human-owned.
- Do not treat this overlay as `Active`, `Ready`, or approved for broad pilot use.
- Do not invent a BB26-specific TC-ID pattern; use the base default (`{StoryID}-{Seq}`) unless a future governance decision defines one.
- Do not modify the shared XRAY column contract from this page; any contract change routes through `ROVO Studio Configuration - QA Test Case Architect v2` and `Studio Setup - QA Test Case Architect v2`.
- Do not copy a BB26 story's Jira `Priority` field value into the generated CSV `Priority` column; apply the shared default (`Low`) unless a future overlay decision explicitly defines a mapping between the two.
- If a current BB26 story or source packet conflicts with this overlay, prefer the current source and log the conflict for human review.
- This overlay does not perform, and must not be read as authorizing, any ROVO Studio, Jira, XRAY, or Confluence write action.
