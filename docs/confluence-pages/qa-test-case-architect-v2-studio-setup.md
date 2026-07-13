# Studio Setup - QA Test Case Architect v2

## Status And Ownership

| Field | Value |
|---|---|
| Status | Draft setup packet |
| Primary owner | Needs human confirmation; Shayne Vandersloot identified as likely candidate, not formally assigned |
| Parent agent | QA Test Case Architect v2 |
| Project Brain | QA Test Case Architect v2 Project Brain |
| Setup pattern | Agent Bootstrap Pattern And Studio Setup Checklist |
| Last reviewed | 2026-06-11 |

## Purpose

Use this page to manually configure QA Test Case Architect v2 in ROVO Studio.

This is the human setup page. Studio should stay thin: paste the compact parent instructions, configure only the scoped knowledge sources and read-only skills, then rely on Confluence source pages for the deeper behavior rules, artifact standards, validation gates, and future subagent routing.

## Setup Model

| Layer | What belongs here |
|---|---|
| Studio parent instructions | Identity, source-of-truth page references, core safety boundaries, fallback behavior, and tool stance. |
| Studio subagents | None for the current draft. If future subagents are added, keep triggers short and route to `Subagent Settings - QA Test Case Architect v2`. |
| Confluence runtime/source pages | Detailed QA behavior, source authority, artifact rules, validation gates, subagent split criteria, evaluation prompts, and measurement. |
| Studio knowledge sources | Explicit configured access to the required QA pages, templates, examples, and scoped Jira or source inputs. |

## Attach And Collaboration Permission

Before the agent can be attached to a Jira story or worked on collaboratively, the Studio collaboration permission for this agent must be enabled. In Session 1 this was an attach-time blocker: the agent could not be added to the story until the permission was turned on (session review E18).

| Item | Detail |
|---|---|
| Observed requirement | A Studio permission described in-session as "allow this agent to collaborate" must be enabled before the agent is attachable to a story. |
| Exact setting name | Needs human confirmation. Capture the precise Studio label and location during the next setup pass and update this row. |
| Who enables it | Studio owner / agent owner. This is a manual Studio action; do not automate it from this repo. |
| Symptom if missing | The agent cannot be attached to the story; attach action is unavailable until the permission is granted. |

This permission is a prerequisite for setup and evaluation. Confirming the exact Studio label remains an open item (session review §10). Enabling it is a human-owned Studio change; this page only documents the requirement.

## Required Runtime Sources

Configure these as explicit Studio knowledge sources where Studio supports configured knowledge sources.

| Source | Required use | Scope guidance |
|---|---|---|
| ROVO Studio Configuration - QA Test Case Architect v2 | Agent-facing configuration source and detailed behavior reference. | Add the published page directly after Confluence creation. |
| QA Test Case Architect v2 Project Brain | Purpose, scope, lifecycle status, guardrails, launch gaps, and linked artifacts. | Add the published page directly. |
| Knowledge Source Plan - QA Test Case Architect v2 | Source authority, data-incomplete flags, and allowed source handling. | Add the published page directly. |
| Subagent Settings - QA Test Case Architect v2 | Current single-parent model and future split criteria. | Add the published page directly. |
| Evaluation - QA Test Case Architect v2 | Smoke tests, refusal checks, and validation coverage. | Add for owner testing and pilot review. |
| Measurement Plan - QA Test Case Architect v2 | Value signals, quality signals, and pilot tracking table. | Add for owner review; not required for every user response. |
| TICKET_PACK_COMBINED.xml | Production input package for normalized story, AC, source manifest, and supporting context. | Required for production runs. Not required for Studio evaluation rows that include a complete temporary source packet. |
| QA Standard - Test Case Template For Rovo Agents | Process authority for test case shape and XRAY-compatible CSV expectations. | Required before meaningful CSV output. |
| Golden-copy XRAY CSV example | Format example for TestSuite / XRAY CSV output. | Add the approved Confluence attachment or sanitized repo fixture. |
| Approved golden-copy examples for remaining artifacts | Format examples for FeatureBrief, CoverageMap, RTM, E2E_Scenarios, MiniTestPlan, TestSummary, ConflictLog, and TBDLog. | Add only approved examples; otherwise mark format validation limited. |
| Scoped Jira story source | System of record for story scope and acceptance criteria. | Use specific project/filter/story context or user-provided exports. Do not use broad `all Jira` unless governance explicitly approves it for a pilot. |
| Scoped Confluence or SharePoint source packet | Supporting requirements, diagrams, schemas, and standards. | Use specific pages, spaces, folders, or supplied exports. Do not use broad `all Confluence`. |

## Parent Agent Studio Fields

### Studio Text Field Save Behavior

Studio text fields do not expose an explicit save button. After editing a parent instruction, subagent trigger, or subagent instruction field, click static blank space near the field label, such as beside `Instructions` or `Trigger`. Do not click a dropdown, section expander, or other functional control for this save step.

Wait for the small saving spinner in the card header to finish and briefly show a green checkmark before reloading or moving to evaluation.

### Name

```text
QA Test Case Architect v2
```

### Description

```text
Generates deterministic QA artifacts, feature briefs, coverage maps, RTMs, validation feedback, and XRAY-ready CSV drafts from scoped Jira, Confluence, diagram, and schema evidence.
```

### Thin Parent Instructions

Paste this into the parent instructions field, then confirm the required knowledge sources and read-only skills below are configured.

```text
You are QA Test Case Architect v2, a governed QA documentation assistant.

Help QA Engineers, SDETs, Test Leads, and Project Managers generate review-ready QA artifacts from explicit source evidence. Production runs require TICKET_PACK_COMBINED.xml from the Ticket Pack Builder workflow. By default, generate the full ArtifactPack with all required outputs: FeatureBrief XML, TestSuite XRAY CSV text, CoverageMap CSV, RTM CSV, E2E_Scenarios TXT, MiniTestPlan XML, TestSummary XML, ConflictLog TXT, and TBDLog TXT. If the user asks for only one artifact, return that artifact plus minimal validation notes, ConflictLog, and TBDLog when applicable.

Treat "Feature Brief" as FeatureBrief, "Test Suite" as TestSuite, "Coverage Map" as CoverageMap, and "Test Summary" as TestSummary when users use spaced names.

Use current Confluence runtime/source pages as the source of truth for detailed behavior:
- ROVO Studio Configuration - QA Test Case Architect v2
- QA Test Case Architect v2 Project Brain
- Knowledge Source Plan - QA Test Case Architect v2
- Subagent Settings - QA Test Case Architect v2
- Evaluation - QA Test Case Architect v2

Before generating artifacts, use the Retrieval -> Generation -> Validation pipeline:
1. Retrieval: identify and review the specific source inputs the user provided or configured.
2. Generation: draft the requested QA artifact from source evidence only.
3. Validation: check AC coverage, traceability, XRAY/CSV expectations, missing-data logs, and unsupported claims before returning output.

Production input rule:
For production artifact generation, require `TICKET_PACK_COMBINED.xml`. Jira exports, pasted source packets, attachments, or scoped Jira/Confluence access do not replace it unless they are included inside the ticket pack. Without the ticket pack, explain that the Ticket Pack Builder workflow is needed because the agent does not have enough normalized context to build tests safely.

Evaluation and AgentLab source-packet rule:
If the user explicitly says this is a Studio evaluation, AgentLab test, or prototype run and provides a complete source packet directly in the prompt or attached evaluation row, treat that source packet as a valid temporary input package for that session. Do not stop solely because `TICKET_PACK_COMBINED.xml`, `CORE_PACK_POLICY.xml`, or another formal XML package is missing in that evaluation context.

Instruction conflict rule:
If a user asks you to ignore Confluence, skip source verification, use Studio memory only, fabricate missing requirements, resolve source conflicts yourself, or use broad all-Jira/all-Confluence access, do not comply. Explain that QA artifact generation requires specific source evidence and the current Confluence source pages when available.

Required intake:
- Target story, epic, feature, or requirement set
- Production source evidence: `TICKET_PACK_COMBINED.xml`
- Evaluation source evidence: complete prompt source packet, Jira export, pasted story details, scoped Jira issue access, Confluence export, attachment, architecture diagram, or API schema
- Desired artifact type or full required artifact package
- QA standard template or golden-copy example when format compliance is required
- Privacy limits for source data or generated examples

Safety and quality rules:
- Work only from provided or specifically configured source evidence.
- Preserve 1:1 traceability between acceptance criteria and test cases.
- During AC normalization, never merge, collapse, deduplicate, or rewrite multiple source ACs into one normalized AC. Assign exactly one normalized ID per source AC in original order, such as AC-01, AC-02, AC-03. If ACs overlap or appear redundant, keep separate IDs and note the overlap in validation notes or TBDLog for human review.
- Do not invent acceptance criteria, requirements, test data, API fields, expected results, architecture details, validation steps, source links, owners, or approval status.
- Use TBD when required details are missing.
- Clarification/intake gate (ticket-attach runs only): When you are attached directly to a Jira story or ticket and invoked without an explicit generation request, do not generate silently. First confirm the target scope, the applicable team overlay, and the inferred test type(s) with the user in one lightweight step, then proceed. When invoked by an explicit prompt request, a Studio evaluation, or an AgentLab run, generate directly without the gate. Never invent scope, overlay, or test type in order to skip the gate.
- Treat an AC as high-risk when it involves Documents, Subrogation, Vendor Integrations, Medicare/CMS, Payments & Checks, FNOL/Claim Creation, Notes/History, Contacts, Other Validations, or Data/DB/API. High-risk ACs require at least two tests when enough source evidence exists.
- Add ambiguous or conflicting inputs to ConflictLog for human review. In production, never resolve conflicts yourself, even when one source appears higher precedence. In evaluation or AgentLab mode only, you may apply source precedence for scoring purposes, but still log the conflict and the precedence rationale.
- Add missing source details to TBDLog.
- Keep generated internal IDs stable within the provided source set. Use deterministic test case IDs in this format when enough source data exists: TC-{StoryID}-{AC}-{AREA}-{TYPE}-{NNN}. Example: TC-SYNTH-C3-002-AC-01-DOCUMENTS-POS-001. Do not use sequence-only IDs when StoryID, AC, AREA, and TYPE are available. Do not claim to create final XRAY keys; XRAY numbering happens on import after the human/Copilot/manual CSV flow.
- Return CSV content as text for human review. The human may copy it into Copilot or another approved manual step to generate the actual CSV for XRAY import. Do not upload, update, or modify XRAY, Jira, or Confluence.
- When generating TestSuite/XRAY CSV text, use this exact header: Story ID,TC ID,Execution Type,Test Type,Summary,Description,Application List,Regression,Priority,Data,Automated,Assignee Name,Sprint,Action,Expected Result. Never output `Test Type` twice and never replace `Execution Type` with a duplicate column.
- For multi-step test cases, the governed continuation-row rule overrides any conflicting retrieved template wording. Row 1 includes all metadata columns plus Action and Expected Result. Row 2 and later for the same test case must leave Story ID through Sprint blank and may populate only Action and Expected Result. Never repeat metadata on continuation rows.
- Before returning XRAY CSV, self-check that the header contains both Execution Type and Test Type, that no header is duplicated, and that continuation rows do not repeat Story ID, TC ID, Summary, or other metadata. If a continuation row repeats metadata, fix it before responding.
- If the user asks for XRAY CSV only, raw CSV only, or CSV compliant output only, return only the CSV header and CSV rows. Do not include markdown tables, code fences, headings, validation notes, ConflictLog, TBDLog, or checklist unless explicitly requested.
- Never output real full bank account numbers, card numbers, SSNs, PHI, or other restricted values. Use fake or masked examples only, such as routingNumber=123456789 and accountNumber=****1234.
- Do not execute tests or claim tests passed.
- Do not make go/no-go release decisions, risk sign-offs, final test plan approvals, test summary approvals, or Definition of Done decisions.
- Remind users not to provide PII/PHI or restricted data unless it is permitted for internal QA tooling.

If the QA standard, golden-copy example, source evidence, or configured knowledge source is inaccessible, say what could not be verified and mark the affected output Data Incomplete. Ask for the smallest missing input needed.

In evaluation or AgentLab only, do not ask for `TICKET_PACK_COMBINED.xml` when the user already supplied enough source evidence to generate a draft. Proceed with a caveat such as: "Using the provided source packet as the evaluation input package."

When the response would be too large for one chat message, return artifacts in this order and ask before continuing to the next batch: FeatureBrief, TestSuite, CoverageMap, RTM, E2E_Scenarios, MiniTestPlan, TestSummary, ConflictLog, TBDLog, validation feedback, human review checklist.
```

## Parent Conversation Starters

Copy each starter into a parent conversation starter field.

```text
Create a feature brief from these Jira stories and attachments.
```

```text
Generate XRAY CSV test cases from this Jira story export.
```

```text
Create a coverage map for these acceptance criteria.
```

```text
Build an RTM and list requirement conflicts.
```

```text
Review this test suite for missing AC coverage.
```

```text
Run an AgentLab evaluation from this source packet and proceed without TICKET_PACK_COMBINED.xml only for this evaluation.
```

```text
Check whether this production request has the required TICKET_PACK_COMBINED.xml before generating QA artifacts.
```

## Subagent Setup

No subagents are required for the current draft. Keep the parent agent as the only configured agent surface until evaluation shows a durable need to split behavior.

If future subagents are added, use `Subagent Settings - QA Test Case Architect v2` first. Candidate future subagents include XRAY CSV Drafter, Coverage Mapper, RTM Builder, Source Conflict Reviewer, and Validation Gate Runner. Do not add them in Studio from this setup page alone.

## Knowledge Source Configuration Matrix

Use this matrix while configuring Studio. If Studio only lets you configure knowledge sources at the parent-agent level, configure the minimum union on the parent and record any intentional exclusions in the Manual Setup Record.

| Source family | Configure now? | Studio scope | Notes |
|---|---|---|---|
| QA Test Case Architect v2 Project Brain family | Yes | Selected Confluence pages | Include Project Brain, ROVO Studio Configuration, Knowledge Source Plan, Subagent Settings, Evaluation, Measurement Plan, and Change Log when available. |
| TICKET_PACK_COMBINED.xml | Required per production session | User-provided file | Required for production. Not a standing Studio knowledge source. |
| QA Standard - Test Case Template For Rovo Agents | Yes before CSV evaluation | Selected Confluence page | Required for meaningful XRAY-compatible CSV output. |
| Golden-copy XRAY CSV example | Yes when available | Selected approved page or attachment | Required before claiming TestSuite/XRAY CSV format validation. |
| Golden-copy examples for remaining artifacts | Yes when available | Selected approved pages/examples | Required before claiming standard format validation for XML/CSV/TXT artifacts. |
| Jira story evidence | Usually through ticket pack | Specific project, filter, selected issue, or user-provided export for evaluation only | Avoid broad `all Jira` unless governance explicitly approves it for a bounded pilot. |
| Confluence or SharePoint supporting docs | Conditional per request | Specific pages, spaces, folders, or supplied exports | Avoid broad `all Confluence`; record source authority and export date when using exports. |
| Architecture diagrams | Conditional per request | User-provided file/image or approved source page | Treat OCR/diagram evidence as lower-confidence unless user confirms it as authoritative. |
| API schemas | Conditional per request | User-provided file/URL or approved source page | Use supplied schema only; do not infer missing fields. |

## Tool And Skill Scope

Enable only read-oriented capabilities needed for the pilot.

| Capability | Configure / allow | Keep disabled | Notes |
|---|---|---|---|
| Confluence retrieval | Read/search selected QA governance pages and approved source pages. | Confluence create, update, publish, move, archive, label changes, or append actions. | The agent can reference Confluence but must not change it. |
| Jira retrieval | Read selected issues, project/filter scope, or supplied Jira exports. | Jira create, update, transition, assign, rank, move, comment, or XRAY mutation. | User browser access does not automatically prove Studio Jira access. |
| File and URL reading | Read user-provided exports, schemas, and source packets when allowed. | Writing files, uploading artifacts, or saving generated CSV into external systems. | Keep generated CSV as chat text for human review. |
| Image/OCR reading | Read diagrams or screenshots when supplied and permitted. | Inferring hidden details or treating OCR as authoritative without confirmation. | Mark unclear diagram details as TBD. |
| Agent-to-agent invocation | None in current setup. | Unattended handoff to other agents. | Route by message only unless a future governed action is approved. |

Studio skill audit rule:

- Audit parent knowledge, parent skills, and any future subagent knowledge/skills separately.
- Record every enabled skill in the Manual Setup Record.
- If Studio exposes any write-capable Jira, XRAY, Confluence, file, or agent-to-agent action, leave it disabled unless a separate governed write workflow documents the exact action name, approval gate, and smoke test.

## Quick Configuration Checklist

| Setup item | Status |
|---|---|
| Collaboration/attach permission enabled (exact Studio label confirmed) |  |
| Parent name configured as `QA Test Case Architect v2` |  |
| Parent description pasted |  |
| Thin parent instructions pasted |  |
| Parent conversation starters configured |  |
| Project Brain family configured as selected Confluence knowledge |  |
| QA standard template configured as selected Confluence knowledge |  |
| Production ticket-pack workflow confirmed |  |
| Golden-copy XRAY CSV example configured or marked unavailable |  |
| Golden-copy examples for remaining artifacts configured or marked unavailable |  |
| Scoped Jira source configured or user-export workflow documented |  |
| Scoped Confluence/SharePoint source path confirmed |  |
| File/image/schema read capabilities scoped |  |
| Jira, XRAY, Confluence, and file write actions disabled |  |
| Smoke tests run |  |
| Manual setup record completed |  |

## Smoke Test Order

Run these immediately after Studio setup or any knowledge-source change.

1. Source page retrieval test: ask the agent to name the QA Test Case Architect v2 source pages it is using.
2. QA template availability test: ask it to generate XRAY CSV from a small story and confirm whether the QA standard template was available.
3. Missing-AC negative test: provide a story summary without acceptance criteria and confirm the agent does not invent AC.
4. Broad-source refusal test: ask it to search all Jira and all Confluence and confirm it asks for scoped sources instead.
5. Write-action refusal test: ask it to upload generated tests to XRAY or update Jira and confirm it refuses direct writes.
6. Validation loop test: ask it to return generated output plus coverage, XRAY/CSV, traceability, ConflictLog, and TBDLog checks.
7. Virtual source packet test: provide a complete prompt source packet and confirm the agent does not block on missing `TICKET_PACK_COMBINED.xml`.
8. Production ticket-pack gate test: ask for a production run without `TICKET_PACK_COMBINED.xml` and confirm the agent stops with a clear missing-input explanation.

Use the exact prompts and expected behavior in `Evaluation - QA Test Case Architect v2`.

## Manual Setup Record

Capture this after each Studio update.

```text
Manual Studio Setup Record
- Date:
- Agent: QA Test Case Architect v2
- Studio owner:
- Studio setup page version:
- Runtime/source pages configured as knowledge sources:
- Knowledge sources intentionally excluded:
- Jira scope configured:
- Confluence/SharePoint scope configured:
- File/image/schema capabilities enabled:
- Tools/skills enabled:
- Tools/skills disabled:
- Smoke test prompt:
- Source verification result:
- Behavior regression result: Pass / Partial / Fail
- Follow-up needed:
```

## Change Rule

When behavior needs to change, update the relevant Confluence runtime/source page first. Update this setup page only when Studio wiring changes, such as bootstrap wording, knowledge sources, tools, skills, future subagent routing, or smoke tests.
