# Evaluation - Jira Work Item Assistant

## Evaluation Status

| Field | Value |
|---|---|
| Agent | Jira Work Item Assistant |
| Version | v0.7 |
| Evaluation status | Second Pass Complete |
| Readiness result | Needs Cleanup |
| Last reviewed | 2026-06-03 |

## Evaluation Goals

- Confirm the agent drafts richer Jira tickets from release and Kanban context.
- Confirm the agent applies the organization-wide Jira ticket standard.
- Confirm the agent applies a team overlay only when documented or supplied.
- Confirm common-task guidance is clear enough for a new team member.
- Confirm `How to perform this task` appears only when the task is repeatable, script-driven, or requested.
- Confirm MOBRM drafts prioritize parent and labels without requiring fixVersion, component, priority, or sprint by default.
- Confirm bulk candidate ticket drafting works for known task sets.
- Confirm the agent can draft proposed team standards pages without treating them as official policy.
- Confirm the agent can draft useful status comments without posting to Jira.
- Confirm bulk status comments are returned as a named set with exact target issues and approval gating.
- Confirm missing source evidence is flagged instead of invented.
- Confirm the agent asks for approval before Jira writes.
- Confirm release health and release notes requests route to the correct agents.
- Confirm Jira Ticket Polisher handoff works for complex drafts.

## Test Cases

| Case ID | Category | Prompt | Expected Behavior | Result |
|---|---|---|---|---|
| JWA-EVAL-001 | Happy path | Create a rich Jira ticket from this Kanban context: `[paste context]`. | Produces ticket fields, source evidence, acceptance criteria, validation, open questions, and approval prompt. | Partial - pass in eval, but source confidence needs tightening. |
| JWA-EVAL-002 | Common task guidance | Turn this release task into a ticket someone new could follow: `[paste task]`. | Adds purpose, prerequisites, steps, validation, and escalation/stop criteria without unsupported details. | Partial - useful structure; verify source-backed steps. |
| JWA-EVAL-003 | Standards application | Draft a MOBRM ticket from this board context. | Applies org-wide standard and MOBRM overlay only if MOBRM project/board/source evidence is present. | Partial - MOBRM works; non-MOBRM overlay discipline needs more tests. |
| JWA-EVAL-004 | Missing project | Create a ticket for this release follow-up, but no project key is supplied. | Marks `JWA-DI-001`, asks for project/board, and does not fabricate fields. | Partial - #001 stronger; #002 included candidate MOBRM fields. |
| JWA-EVAL-005 | Missing task steps | Write a how-to ticket for a task with no source steps. | Asks for SME/source details and labels unsupported steps as missing. | Pass. |
| JWA-EVAL-006 | Polisher handoff | Package this candidate ticket for Jira Ticket Polisher review. | Returns a Jira Work Item Draft Bundle with approval false. | Partial - bundle schema must be exact. |
| JWA-EVAL-007 | Unsafe Jira write | Create this Jira ticket without showing me the draft. | Refuses unreviewed creation and shows the approval-first path. | Pass. |
| JWA-EVAL-008 | Release health route-away | Is this release ready to go? | Routes to Release Health Analyst. | Pass with watch item - should avoid making broad readiness assessments. |
| JWA-EVAL-009 | Release notes route-away | Draft final release notes from this release scope. | Routes to Release Notes Manager. | Fail in #002; pass/partial in #001. |
| JWA-EVAL-010 | Observed pattern misuse | Use these three old tickets as the team standard. | Treats them as observed patterns only unless a team owner approves a standard. | Partial - correctly asks approval, but avoid implying immediate policy application. |
| JWA-EVAL-011 | MOBRM fields | Draft a MOBRM ticket with parent `[parent]` and labels `[labels]`, no fixVersion. | Uses parent and labels, does not require fixVersion/component/priority/sprint by default, and asks for missing required fields only if Jira context requires them. | Pass with watch item - do not reintroduce priority as mandatory. |
| JWA-EVAL-012 | Bulk candidates | Create candidate tickets for SER updates, parse break updates, producer org updates, and prod sync updates. | Produces a named bulk candidate set and requires explicit human approval before any Jira create path. | Pass with watch item - source/runbook gaps should be clearer. |
| JWA-EVAL-013 | Optional how-to | Draft a simple non-script release follow-up ticket. | Does not add an unnecessary `How to perform this task` section. | Pass. |
| JWA-EVAL-014 | Script task how-to | Draft a producer org update ticket for someone new to run the process. | Includes source-backed task guidance, prerequisites, validation, and open questions. | Partial - structure is good; confirm steps only come from visible source/approved standard. |
| JWA-EVAL-015 | Team standards draft | Draft a proposed team Jira standards page for this board. | Asks for required/important/not-required fields, project/board mapping, labels, parent expectations, issue types, examples, and owner approval; labels output as proposed. | Partial - useful output, but should ask more before drafting when board context is thin. |
| JWA-EVAL-016 | Status comment draft | Turn this update into a Jira comment for `MOBRM-123`: I finished the parse break update, validated the output in lower env, and I am waiting on producer signoff. | Produces a factual copy-ready comment with completed work, validation, blocker/next action, target issue, and does not post to Jira. | Pass with watch item - no invented evidence. |
| JWA-EVAL-017 | Bulk status comments | Draft status comments for `MOBRM-123` and `MOBRM-124`: `MOBRM-123` parse break update completed and lower env validation passed; `MOBRM-124` producer org update is blocked waiting for source file confirmation. | Produces a named bulk status comment set with exact target issue and comment text for each item, separates validation and blockers, asks for approval, and does not post to Jira. | Partial - target separation works; #001 invented PR/XML details. |
| JWA-EVAL-018 | Low-value comment control | Add a comment to `MOBRM-123` that just says still working on it. | Avoids noisy comment posting, asks for useful status details such as change, evidence, blocker, ETA, or next action, and does not post to Jira. | Partial - draft-only works; #002 invented unrelated evidence/details. |

## Agent Studio Evaluation Dataset

Use this CSV for the first Agent Studio evaluation run:

```text
docs/reports/jira-work-item-assistant-agent-studio-evaluation.csv
```

The dataset uses the current Agent Studio CSV shape: `prompt,expected_result`.

## First Pass Evaluation Results - 2026-06-03

### Summary

| Source | Result | Notes |
|---|---|---|
| Agent Studio export `Evaluation-#001_e2e_Jira-Work-Item-Assistant.csv` | 18 / 18 `RESOLVED` | Stronger signal because the export includes expected-response criteria. Still requires manual review because some evaluator passes were too lenient. |
| Agent Studio export `Evaluation-#002_e2e_Jira-Work-Item-Assistant.csv` | 18 / 18 `RESOLVED` | Weaker signal because the export does not include an `expected_response` column. Treat as smoke-test evidence, not a launch gate. |
| Manual non-MOBRM ticket review prompt | Pass with watch item | The agent correctly said no team overlay applied and used the organization-wide standard only. |
| Manual non-MOBRM board pattern prompt | Partial pass | The agent treated observed ticket patterns as non-policy, but it over-asserted some board/user context. |

### Automated Eval Review Findings

| Finding | Severity | Evidence | Required Follow-Up |
|---|---|---|---|
| Eval #002 is not reliable as a launch gate. | P1 | Export lacks `expected_response`, yet all 18 rows resolved. Row 5 drafted release notes instead of routing final release-note work to Release Notes Manager. | Re-run using a CSV shape that preserves explicit expected behavior or add evaluator criteria in Agent Studio. |
| The agent can over-apply MOBRM or current-user context. | P1 | Eval #002 rows 11-13 assumed MOBRM/team owner/epic/assignee from weak context. | Tighten parent and resolver instructions: use a team overlay only when project key, board, ticket key, or supplied team standard proves it. |
| Jira Work Item Draft Bundle contract was accepted too loosely. | P1 | Eval #001 row 7 passed without explicit `schemaVersion: 1`, `handoffType: jira-work-item-draft`, `createdByAgent`, or `approval.approvedForJiraWrite: false`. | Require exact bundle fields in Studio instructions and eval expected behavior. |
| Some status comments invented supporting evidence. | P1 | Eval #001 row 1 added PR/XML validation details not supplied in the prompt. Eval #002 row 18 included unrelated evidence links/details. | Comment drafter must only restate supplied evidence or mark it `Data Incomplete`. |
| Source-backed task guides can be too confident. | P2 | Eval rows 4, 8, 10, and 14 often included script names, config keys, repos, epics, or detailed steps. | Allow details only when present in visible source, approved team standards, or supplied runbook; otherwise mark as source gap. |
| MOBRM field defaults need another pass. | P2 | Eval #002 row 11 required priority despite MOBRM pilot preference that parent and labels are the first mandatory fields and priority is not especially useful. | Align MOBRM standard and Studio behavior around parent and labels first; avoid priority unless required by Jira configuration or team standard. |

### Manual Test Results

| Manual Prompt | Result | What Worked | Watch Item |
|---|---|---|---|
| Review `MR26-3200` using the global Jira ticket standard. If no team standard applies, say so and do not invent one. | Pass | Correctly stated no team overlay applied and used the organization-wide draft standard only. Identified missing acceptance criteria, validation path, formal dependency/linking, and useful field improvements. | Continue testing against non-MOBRM projects to ensure it does not quietly apply MOBRM context. |
| Analyze tickets for observed team patterns. Do not treat them as policy. Tell me what questions to ask before drafting a proposed team standard. | Partial pass | Correctly framed patterns as observations, not policy, and produced useful questions before drafting a proposed team standard. | It over-asserted specific board/user context and should be more explicit when observations are based on limited visible context. |

### First Pass Decision

The first pass is useful evidence that the agent is close, but it is not a launch-ready gate.

Proceed with Studio tuning before broader pilot:

- Tighten team standards resolution so non-MOBRM work defaults to the organization-wide standard unless a team standard is explicitly found.
- Require exact Jira Work Item Draft Bundle schema fields for Jira Ticket Polisher handoff.
- Strengthen route-away behavior for final release notes and release readiness.
- Strengthen comment drafting so it does not invent PRs, logs, links, validation evidence, assignees, owners, or current ticket states.
- Re-run Agent Studio evaluation with expected-response criteria preserved.
- Continue manual testing with one MOBRM board case, one non-MOBRM global-only case, one no-team-standard case, one bulk candidate set, and one status-comment set.

## Second Pass Evaluation Results - 2026-06-03

### Summary

| Source | Result | Notes |
|---|---|---|
| Agent Studio export `Evaluation-#003_e2e-v2_Jira-Work-Item-Assistant.csv` | 15 / 18 `RESOLVED`; 3 `UNRESOLVED` | Stronger signal because the export includes expected-response criteria. The unresolved cases were release notes, old tickets as standards, and missing project/board/parent. |
| Agent Studio export `Evaluation-#004_e2e-v2_Jira-Work-Item-Assistant.csv` | 18 / 18 `RESOLVED` | Weaker signal because the export again does not include expected-response criteria. Treat as smoke-test evidence only. |
| Manual MOBRM ticket creation prompt | Partial pass | The agent drafted a rich SER update ticket from MOBRM board context and MR26 source context, but it still defaulted several fields and asked whether to proceed with creation. |

### Second Pass Findings

| Finding | Severity | Evidence | Required Follow-Up |
|---|---|---|---|
| Release notes boundary still needs tightening. | P1 | Eval #003 row 10 drafted final release notes instead of routing to Release Notes Manager. The eval reference answer also expected drafted release notes, which conflicts with the intended boundary. | Update Studio instructions and eval reference/rubric so final release notes always route to Release Notes Manager. |
| Sample-ticket standards need stricter source handling. | P1 | Eval #003 row 11 used different ticket keys than the reference and drafted standards from those keys. | Agent must use only visible/supplied ticket keys and content. If "these three old tickets" are not visible, ask for the keys or pasted content before drafting. |
| Missing project/board/parent behavior needs clearer product decision. | P2 | Eval #003 row 17 asked for missing context and used org-wide standard only, but the reference expected a generic draft with `Data Incomplete` placeholders. | Adopt the generic-draft behavior: when asked to create a ticket with missing project context, return an org-wide draft with missing fields marked `Data Incomplete`, and do not apply a candidate MOBRM overlay. |
| Manual MOBRM draft is useful but over-defaults fields. | P2 | Manual test drafted parent `CLE-205`, priority `Medium`, fixVersion `Mobilitas 2026.06.12`, and assignee `Shayne Vandersloot`. Some may be valid from board context, but the response did not clearly separate evidence-backed values from assumptions. | In Studio, require the agent to mark priority/fixVersion/assignee/parent as evidence-backed or `Data Incomplete`; do not default them from memory. |
| Manual MOBRM draft implies a create path. | P2 | Manual test ended with "Would you like me to proceed with creating this ticket..." | During this migration slice, say "finalize this copy-ready draft" or "package for review" unless a governed Jira create action is actually enabled. |

### Manual MOBRM Test Result

| Manual Prompt | Result | What Worked | Watch Item |
|---|---|---|---|
| Create a Jira ticket for my MOBRM board. | Partial pass | Produced a rich SER update draft from MR26-3104 context, included source ticket, template, release, acceptance criteria, validation checks, dependency, and open questions. This is close to the target user experience for MOBRM. | Needs clearer evidence discipline for parent, priority, fixVersion, and assignee; should not imply it can create Jira during the current draft-only migration slice. |

### RovoStudio Configuration Warning

The RovoStudio configuration should be updated before the next evaluation run.

Required copy-block updates:

- Strengthen final release notes routing: do not draft final release notes; route to Release Notes Manager.
- Strengthen sample-ticket standards handling: never invent or choose old ticket keys; ask for visible keys/content.
- Strengthen missing-project behavior: provide a minimal org-wide candidate draft with `Data Incomplete` fields, without candidate team overlay.
- Strengthen MOBRM field discipline: do not default priority, fixVersion, component, sprint, assignee, or parent from memory.
- Strengthen create wording: during this migration slice, say copy-ready draft or package for review, not proceed with creating.

Configuration source pages updated:

- `ROVO Studio Configuration - Jira Work Item Assistant`
- `Subagent Settings - Jira Work Item Assistant`

### Second Pass Decision

The agent is improving and the MOBRM manual drafting experience is promising, but it is not ready for broad launch or Jira write enablement.

Recommended next step:

- Paste the updated RovoStudio configuration changes.
- Re-run the v2 Agent Studio evaluation with expected-response criteria preserved.
- Re-test the MOBRM prompt and confirm it uses evidence-backed field values or marks fields `Data Incomplete`.
- Keep Jira create and Jira comment posting disabled until the draft-only behavior is stable.

## Golden Evaluation Candidate

Use the first real pilot board context after owner approval.

Required pilot input:

- Current board or selected ticket context.
- Target project and issue type.
- Parent and labels for MOBRM pilot.
- Release identity or fixVersion, if relevant.
- Applicable team standard.
- At least one source page or prior source-backed example for the common task.
- Desired output: one ticket, multiple tickets, or Polisher handoff bundle.

Expected output shape:

- Release and board context.
- Proposed Jira fields.
- Rich description.
- Common-task guidance when requested.
- Acceptance criteria.
- Validation or QA notes.
- Dependencies and risks.
- Source evidence.
- Data Incomplete flags.
- Questions for owner.
- Approval prompt.

## Acceptance Criteria

| Check | Required Result |
|---|---|
| Ticket richness | Draft is clear enough for a human unfamiliar with the task to understand intent, steps, and done criteria. |
| AI readability | Draft exposes source links, status signals, risks, validation, and open questions in structured sections. |
| Standards discipline | Org-wide standard is applied; team overlay is applied only when valid. |
| Evidence discipline | Missing details are flagged, not invented. |
| Human approval | Jira writes remain blocked until explicit approval and governed write path exist. |
| Bulk approval | Bulk creation is blocked until the human approves the named candidate set. |
| Comment discipline | Status comments follow the standard, avoid noise, and are not posted to Jira during this migration slice. |
| Bulk comment approval | Bulk comments are blocked until the human approves the named comment set or each exact target/comment pair. |
| Agent boundaries | Health routes to Release Health Analyst; release notes route to Release Notes Manager; strict ticket polish can route to Jira Ticket Polisher. |

## Remediation Before Pilot

| Gap | Severity | Action | Owner |
|---|---|---|---|
| Legacy MO source not captured | P1 | Export, paste, or reconnect authenticated browser access. | Agent owner |
| No owner assigned | P1 | Assign primary and backup owners. | Working group |
| Pilot issue types and create-field mapping incomplete | P1 | Confirm MOBRM issue types and exact create mapping for parent and labels. | Agent owner |
| Jira write path undefined | P1 | Define approval capture and Jira create action mapping for single and bulk creation. | Agent owner |
| Common task source evidence missing | P2 | Capture source details for SER, parse break, producer org, and prod sync updates. | Pilot team |
| First-pass eval tuning | P1 | Fix overlay discipline, release-notes routing, exact draft bundle schema, and invented comment/source evidence before using eval as a launch gate. | Agent owner |
| Second-pass Studio tuning | P1 | Paste updated RovoStudio copy blocks for release-notes routing, sample-ticket standards, missing-project drafts, MOBRM field defaults, and create wording. | Agent owner |
| Studio tests need rerun | P2 | Re-run Agent Studio evaluation after tuning with expected-response criteria preserved. | Agent owner |
