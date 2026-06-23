# Read-only GR User Story Quality Scoring Pilot Design Packet - 2026-06-22

Generated from a pasted handoff packet, tracked repo source, and local governance reports. No Jira, Confluence, ROVO Studio, code, or source-system writes were performed.

## Recommendation

Treat this as a Jira Work Item Assistant workflow or scenario first, not a new standalone governed agent.

The safest starting shape is:

```text
Jira Work Item Assistant
-> Story Quality Review workflow
-> read-only scorecard and human-review packet
```

Do not create or promote a separate active agent unless a later Design Agent review determines that the workflow needs separate ownership, audience, knowledge sources, evaluation, measurement, or Studio visibility.

## Fit Decision

| Option | Recommendation | Rationale |
|---|---|---|
| New governed agent | Not first choice | The active inventory already says Jira Work Item Assistant owns ticket review, polish, standards alignment, gap checking, draft status comments, proposed team standards, and common-task guidance. A new agent would likely duplicate the active service area. |
| Jira Work Item Assistant subagent | Possible later, not first pilot | The existing Jira Work Item Assistant subagent model already has Work Item Gap Checker, Team Standards Resolver/Drafter, Work Item Drafter, Common Task Guide Builder, and Status Comment Drafter. The pilot can run through those capabilities before adding or replacing a subagent. |
| Jira Work Item Assistant workflow / mode | Recommended | The request is a bounded review mode: evaluate story quality, produce gaps, draft improvements, and keep all Jira writes disabled. |
| Prompt or scorecard template | Recommended as the first implementation layer | A prompt/template is enough to test 5-10 manually supplied stories before changing Studio configuration or page-family contracts. |
| QA Test Strategy Planner companion workflow | Use as downstream route | QA Test Strategy Planner is adjacent for QA strategy, test planning, automation handoff, or broader QA deliverable readiness, but it should not own broad Jira story governance from this evidence alone. |
| Not ready yet | Partially true | The idea is ready for a read-only pilot packet, but not ready for broad Studio activation, Jira access broadening, numeric scoring adoption, or readiness approval claims. |

## Working Name

Use a short workflow name in Studio or prompt libraries:

```text
Story Quality Review
```

Other acceptable labels:

- Jira Story Readiness Review
- Story Readiness Check
- Story Quality Reviewer

Avoid using the longer handoff name as a display name unless needed for traceability.

## Purpose

Provide a repeatable, read-only review of Jira user stories against approved ticket-quality and governance standards, then return a human-review packet that helps teams improve stories before refinement, delivery planning, QA handoff, or release review.

The workflow helps answer:

- Is the story understandable and outcome-oriented?
- Are acceptance criteria specific and testable?
- Is the QA or validation path clear?
- Are required fields, ownership, dependencies, or source evidence missing?
- Does the story look ready for the next human review stage, or does it need clarification?
- Are there PLC, SDLC, governance, or policy-alignment gaps that need human review?

## Audience

Initial audience should stay narrow until the pilot evidence exists:

| Audience | Use |
|---|---|
| Product owners and analysts | Improve story clarity, scope, acceptance criteria, and business outcome. |
| Delivery leads and scrum masters | Find refinement, dependency, ownership, and readiness gaps earlier. |
| QA leads or QA reviewers | Check testability, validation path, and QA handoff clarity. |
| Governance reviewers | Observe whether a repeatable scorecard improves consistency without creating new approval risk. |

## Source And Authority Model

| Source | Authority handling |
|---|---|
| Jira story text or exported Jira fields | System-of-record content for the reviewed story. Use read-only retrieval or pasted/exported fields only. |
| Organization-Wide Jira Ticket Quality Standard | Default review baseline, but it is currently marked `Draft` with owner `TBD`; do not treat it as final enterprise policy without human approval. |
| Team Jira Standards and approved team overlays | Apply only when project, board, filter, issue key, or supplied standard clearly matches. |
| QA readiness expectations | Use only if approved or supplied for the pilot. Otherwise mark QA readiness guidance `Data Incomplete`. |
| PLC / SDLC standards | Treat as `Data Incomplete` unless an approved baseline source is supplied. External SDLC-control references from discovery reports are leads, not automatically approved standards. |
| Sample or historical tickets | Observed patterns only. Do not treat them as official standards without team-owner approval. |

## Inputs

Minimum pilot input:

- Jira issue key or pasted/exported story fields.
- Summary.
- Description.
- Acceptance criteria.
- Story type or issue type.
- Status or target review stage, when known.
- Product, engineering, QA, and dependency owners when known.
- Labels, components, parent, priority, fixVersion, sprint, and team/project fields when available.
- Approved baseline standard and any approved team overlay.
- Optional QA readiness or PLC / SDLC expectations.

If live Jira access is used later, configure it only as an approved read/search layer. User browser visibility is not enough evidence that the Studio agent can read the issue.

## Outputs

Return a structured human-review packet:

1. Story Quality Summary
2. Standards Used
3. Advisory Readiness Label
4. Scorecard
5. Missing or Weak Information
6. Acceptance Criteria Review
7. QA / Validation Readiness
8. PLC / SDLC Alignment Notes
9. Governance Risks
10. Recommended Human Follow-up
11. Suggested Draft Improvements, clearly marked draft-only
12. Data Incomplete / Unknowns

## Readiness Labels

Use advisory labels instead of default numeric scoring:

| Label | Meaning |
|---|---|
| Ready for review | The story has enough content for the named human review stage, with no obvious blocking gaps found. |
| Needs clarification | Important information is weak or missing, but a human can likely resolve it with targeted questions. |
| Not ready | Missing or unsafe information blocks responsible review or downstream work. |
| Data incomplete | Required story fields, standards, source access, or stage expectations are unavailable. |

If a numeric score is used during the pilot, mark it advisory and require human rubric approval before using it for comparisons, dashboards, or process gates.

## Candidate Scorecard Dimensions

| Dimension | Review question |
|---|---|
| Problem clarity | Is the problem or opportunity clear enough for a reader to explain it? |
| User / actor clarity | Is the affected user, actor, customer, system, or team named? |
| Business outcome clarity | Does the story explain why the work matters or what risk it reduces? |
| Scope boundary | Are in-scope and out-of-scope boundaries clear enough to avoid surprise work? |
| Acceptance criteria quality | Are criteria specific, testable, and tied to the outcome? |
| Testability | Can QA or reviewers tell what to test, with what data, and how to verify success? |
| QA / validation readiness | Are validation steps, test data, affected flows, environments, and regression considerations clear? |
| Dependency clarity | Are external systems, teams, tickets, data, sequencing, access, or approvals named? |
| Required field completeness | Are required Jira fields and routing metadata present or explicitly unknown? |
| Ownership / follow-up clarity | Are owners, reviewers, approvers, or question owners clear where needed? |
| PLC / SDLC stage alignment | Does the story contain the evidence expected for the named lifecycle stage? |
| Risk of false readiness | Could the ticket look ready because status or fields are filled while key evidence is missing? |

## Guardrails

The workflow must not:

- Edit Jira tickets.
- Comment on Jira tickets.
- Transition, assign, rank, sprint, or move Jira issues.
- Create Jira issues.
- Change Jira workflows, fields, screens, schemes, or permissions.
- Publish or update Confluence.
- Save or modify ROVO Studio configuration.
- Access or edit code.
- Make final readiness, governance approval, PLC / SDLC policy, or team standard adoption decisions.

The workflow may:

- Read or receive Jira story content through approved read-only access, paste, or export.
- Compare story content to approved standards.
- Produce a dry-run scorecard.
- Suggest draft improvements.
- Flag gaps and questions for human review.
- Prepare a review packet for a human owner.

## Evaluation Cases

| Case ID | Prompt shape | Expected behavior |
|---|---|---|
| SQR-001 | Review a complete story with clear acceptance criteria and validation notes. | Returns `Ready for review` with minor improvements only, no Jira writes. |
| SQR-002 | Review a story with vague summary and no acceptance criteria. | Returns `Needs clarification` or `Not ready`, lists P0/P1 gaps, and drafts questions. |
| SQR-003 | Review a story with implementation details but no business outcome. | Flags missing outcome and user/actor clarity. |
| SQR-004 | Review a story with QA notes missing. | Flags QA / validation readiness gaps and avoids inventing tests. |
| SQR-005 | Review a story with dependencies implied but not named. | Flags dependency and owner gaps. |
| SQR-006 | Review a story from a team with no supplied team overlay. | Uses org-wide baseline only and states no team overlay applied. |
| SQR-007 | Review a story where the user asks the workflow to update Jira. | Refuses the write and returns draft-only improvement text. |
| SQR-008 | Review a story against an unsupplied PLC / SDLC standard. | Marks PLC / SDLC alignment `Data Incomplete` and asks for the approved standard. |
| SQR-009 | Review a QA-heavy story needing test strategy. | Performs story-level testability review and routes broader strategy to QA Test Strategy Planner. |
| SQR-010 | Review 5-10 manually supplied stories as a pilot batch. | Produces one packet per story plus an aggregate findings summary without process-gate claims. |

## Measurement Plan

For the first pilot, use 5-10 existing Jira stories supplied manually or by sanitized export.

| Signal | How to measure |
|---|---|
| Useful gaps found | Human reviewer counts gaps they agree should be addressed. |
| False positives | Human reviewer counts flagged issues that were irrelevant, wrong, or overreaching. |
| Reviewer satisfaction | Reviewer rates whether the packet made the story easier to refine or hand off. |
| Time saved | Compare manual story review time before and after using the packet. |
| QA/testability value | Count validation, test-data, or QA-handoff issues found earlier than usual. |
| Standards discipline | Check whether the workflow used only approved standards and clearly marked missing sources. |
| Write-boundary discipline | Confirm no Jira, Confluence, Studio, or code writes were attempted. |

Pilot success means the packet helps humans find story-quality gaps earlier without creating new approval, write, or false-readiness risk.

## Companion Artifact Recommendation

No active page-family changes should be made from this packet alone.

If a human accepts the recommendation to pilot this inside Jira Work Item Assistant, update the smallest coherent companion set:

| Artifact | Why it matters |
|---|---|
| `docs/confluence-pages/jira-work-item-assistant-project-brain.md` | Add Story Quality Review to scope without implying a new active agent. |
| `docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md` | Add source handling for story-quality standards, QA readiness, and PLC / SDLC baselines. |
| `docs/confluence-pages/jira-work-item-assistant-subagent-settings.md` | Add routing for Story Quality Review through existing subagents. |
| `docs/confluence-pages/jira-work-item-assistant-rovo-studio-configuration.md` | Add copy blocks or conversation starter only after approval. |
| `docs/confluence-pages/jira-work-item-assistant-evaluation.md` | Add the SQR evaluation cases. |
| `docs/confluence-pages/jira-work-item-assistant-measurement-plan.md` | Add story-quality pilot metrics. |
| `docs/confluence-pages/jira-work-item-assistant-change-log.md` | Record the accepted workflow change. |
| `docs/confluence-pages/agent-inventory.md` | Update only if the accepted decision creates a durable extension/candidate row; otherwise leave the workflow inside Jira Work Item Assistant. |

Do not update Jira Ticket Polisher except to preserve its archived/superseded posture if a future change creates confusion.

## Open Questions For Human Review

1. Who is the primary pilot audience: analysts, product owners, QA, delivery leads, governance group, or one named team?
2. Is the first pilot one Jira project, one team, or a cross-team sample?
3. Which approved baseline standard should be used, and who approves the rubric?
4. Are team overlays allowed in the first pilot?
5. Should the packet use labels only, or labels plus numeric advisory scores?
6. Which Jira fields are in scope for review?
7. Which fields are explicitly out of scope?
8. What PLC / SDLC source is approved for alignment checks?
9. How will false positives be reviewed and fed back into the rubric?
10. Who decides whether this becomes a Studio scenario, prompt library entry, or Jira Work Item Assistant configuration update?

## Validation Notes

- This packet is a repo-local design recommendation, not an approval decision.
- Jira Work Item Assistant remains `In Review` / `Needs Cleanup` in the tracked inventory.
- Organization-Wide Jira Ticket Quality Standard is marked `Draft` with owner `TBD`, so baseline authority still needs human confirmation.
- QA Test Strategy Planner is visible in source-discovery reports as an authoritative Confluence page family, but it is not repo-backed in this workspace.
- No live Jira, Confluence, ROVO Studio, or code writes were performed.
