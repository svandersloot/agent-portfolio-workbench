# Knowledge Source Plan - QA Test Case Architect v2

## Source Strategy

QA Test Case Architect v2 should work from explicit, current QA source evidence. In production, the required input is `TICKET_PACK_COMBINED.xml` from the upstream Ticket Pack Builder workflow because the agent needs normalized context to build tests safely. In Studio evaluation or AgentLab testing, a complete prompt-provided source packet may be treated as a temporary input package. Missing details must become `TBD`, `ConflictLog`, or `TBDLog` entries rather than invented content.

## Authority Labels

| Label | Meaning |
|---|---|
| Process Authority | Approved standard or template that defines expected QA artifact structure. |
| Production Input Package | Required normalized input file for production artifact generation. |
| System of Record | Jira story, requirement, or approved source that defines the work being tested. |
| Technical Source | API schema, architecture diagram, or implementation reference that informs test design. |
| User-Supplied Evidence | Pasted or attached source material provided for the current run. |
| Reference | Helpful context that cannot override the process authority or system of record. |

## Approved Source Map

| Source | Type | Authority | Allowed Use | Freshness | Fallback |
|---|---|---|---|---|---|
| QA Standard - Test Case Template For Rovo Agents | Confluence / QA standard | Process Authority | Define test case CSV fields, naming, and artifact structure. | Review after template changes | Ask user to paste current template if inaccessible. |
| TICKET_PACK_COMBINED.xml | XML input package | Production Input Package | Required production context bundle containing normalized Jira stories, ACs, source manifest, and supporting evidence. | Per request | Stop production workflow and ask for the ticket pack. For evaluation only, use a complete prompt source packet with caveat. |
| Jira story exports or pasted Jira story content | Jira / supplied text | System of Record | Identify story scope, acceptance criteria, labels, and traceability anchors. | Per request | Mark missing fields as `TBD`. |
| Acceptance criteria | Jira / supplied text | System of Record | Create 1:1 AC-to-test mappings. | Per story | Do not generate unsupported AC; log missing AC. |
| SharePoint-hosted Confluence exports | Supplied export | User-Supplied Evidence / Reference | Use when user confirms source origin and export date. | Per export | Ask for source metadata or mark confidence low. |
| Attachments and supporting documentation | File / supplied text | User-Supplied Evidence / Reference | Use as supporting context for feature briefs, test suites, coverage maps, and RTMs. | Per request | Ask user to identify source authority and freshness. |
| Architecture diagrams | Image/file | Technical Source / Reference | Extract visible flows, systems, and integration points for test coverage ideas. | Per diagram version | Use `TBD` for unclear OCR or ambiguous relationships. |
| API schemas | File or URL | Technical Source | Identify endpoints, fields, validations, and negative cases. | Per schema version | Ask for current schema or mark API coverage incomplete. |
| Golden-copy XRAY CSV example | Confluence / supplied example | Process Authority when approved | Validate TestSuite/XRAY CSV field names, row grouping, action/expected-result pattern, and manual/automated fields. Also the SME-approved (2026-07-14, Session 2) step-style/precondition example source for `Action`/`Expected Result` voice and structure — use for style/patterns only, not verbatim copying. | Review after template changes | Use sanitized repo fixture until approved Confluence copy is attached. |
| Golden-copy artifact examples for XML/CSV/TXT outputs | Confluence / supplied examples | Process Authority when approved | Validate FeatureBrief, CoverageMap, RTM, E2E_Scenarios, MiniTestPlan, TestSummary, ConflictLog, and TBDLog shape. | Review after template changes | Mark format validation limited. |

## Required Input Check

Before generating final-seeming artifacts, the agent must confirm:

- Target story, epic, feature, or requirement set.
- Production run: `TICKET_PACK_COMBINED.xml` is provided.
- Evaluation or AgentLab run: complete prompt source packet is provided and clearly marked as temporary evaluation input.
- Source material includes acceptance criteria or explicit requirements.
- Desired artifact package or specific artifact from the required catalog.
- QA standard template is available or the user accepts a `Data Incomplete` caveat.
- Any required ID prefix, numbering convention, or XRAY project context.
- Whether diagrams or API schemas are authoritative or reference-only.
- Whether any source contains privacy-sensitive data that should be excluded from copied output.

## Data Incomplete Flags

| Flag ID | Missing or incomplete data | Impact | How to clear |
|---|---|---|---|
| QATCA-DI-001 | Acceptance criteria are missing. | 1:1 traceability cannot be proven. | Provide AC or source requirement page. |
| QATCA-DI-002 | QA template is inaccessible. | CSV may not match the current standard. | Provide template link or pasted template. |
| QATCA-DI-003 | Production ticket pack is missing. | Production workflow cannot safely generate tests. | Provide `TICKET_PACK_COMBINED.xml`; evaluation runs may use a complete prompt source packet. |
| QATCA-DI-004 | API schema or diagram is referenced but not provided. | Technical coverage may be incomplete. | Provide schema, diagram, or exclude that coverage area. |
| QATCA-DI-005 | Requirements conflict across sources. | Test design may validate the wrong behavior. | Human owner resolves conflict. |
| QATCA-DI-006 | Source export origin or date is unknown. | Source freshness cannot be trusted. | Provide export metadata or current source link. |
| QATCA-DI-007 | Golden-copy example is missing for the requested artifact. | Format validation is limited. | Provide an approved example or template. |
| QATCA-DI-008 | Golden-copy example is missing for a non-TestSuite artifact. | Format validation is limited. | Provide approved example or template. |

## Controlled Vocabularies (XRAY field values)

The two `Test Type` columns and `Application List` in the TestSuite/XRAY CSV are constrained to approved values. The agent must infer the value from the story and supporting context, present the inferred value(s) to the user, and proceed only after confirmation. The agent must not invent a value that is not on the approved list; when it cannot confidently determine a value, it must flag the field for human review instead of guessing. The functional Test Type for a given test is SOURCED from the Jira story's test-type field; the list below is canonical validation data (the allowed set), not a value the agent infers from prose. Application List is inferred from story/project context, constrained to its approved picklist.

- **Execution-mode Test Type** (first `Test Type` column): approved values are `Manual`, `Generic`, `Cucumber`. This team uses `Manual`. Source: Jira/XRAY configuration.
- **Functional Test Type** (second `Test Type` column): approved values are `Batch`, `Certification`, `Container - Security Test`, `DAST - Security Test`, `Database`, `E2E`, `ETL`, `Functional`, `IaC - Security Test`, `IAST - Security Test`, `Integration`, `Performance`, `Production`, `RASP - Security Test`, `Regression`, `SAST - Security Test`, `SCA - Security Test`, `Security`, `Security Test – Container`, `Security Test – DAST`, `Security Test – IaC`, `Security Test – IAST`, `Security Test – RASP`, `Security Test – SAST`, `Security Test – SCA`, `User Acceptance`. Source of the per-test value: the Jira story's test-type field. The values below are the canonical allowed set used to validate that field. Source of the list: Jira/XRAY custom field configuration. Last confirmed: 2026-07-14 (Session 2).
- **Application List**: an authoritative controlled picklist maintained in the Jira/XRAY configuration; configure it as a Studio knowledge source. The full list is intentionally not enumerated in this repo (internal application inventory); only `CAS` appears in existing fixtures. The agent must select from the approved list and flag for review when it cannot confidently determine the value.

| Open item | Status |
|---|---|
| Cross-team scope of the Test Type / Application List values | Shared org-wide (confirmed 2026-07-14) — sourced from global Jira/XRAY custom fields |
| Multi-value Application List / delimiter | Single-value (confirmed 2026-07-14); one Application List per test; multi-value not used |
| Governance owner of the lists | Jira/XRAY administrators own the picklists; QA is the consumer (confirmed 2026-07-14) |
| Application List field hygiene | Live field contains near-duplicate/variant entries (differing casing and spacing, plus two dash conventions in the security-test labels); the field owner should reconcile them. The agent matches the field as-is meanwhile. |
| Full sanitized Application List | Held out pending sanitization/approval |

## Source Handling Rules

- Do not invent acceptance criteria, test data, expected results, APIs, or system behavior.
- Require `TICKET_PACK_COMBINED.xml` for production artifact generation.
- Allow complete prompt source packets only for Studio evaluation, AgentLab testing, or explicitly approved prototype runs.
- Preserve source traceability for each generated test case.
- Require specific pages, spaces, filters, files, or pasted source packets; do not use broad `all Jira` or `all Confluence` scopes.
- Use `TBD` for missing test preconditions, data, expected results, or requirement mappings.
- Add conflicting source statements to `ConflictLog`; do not resolve them silently.
- Add missing inputs to `TBDLog` with the needed owner or source when known.
- Treat diagrams and OCR as lower-confidence evidence unless the user confirms them as authoritative.
- Keep user-supplied exports local to the current run unless a human creates a sanitized Confluence record.
- Avoid copying PII/PHI into generated artifacts unless the user confirms it is permitted and necessary.

## Knowledge Source Review

| Review item | Status | Notes |
|---|---|---|
| QA standard template confirmed | Partial | Name is known; page location and current version need confirmation. |
| Jira source pattern confirmed | Partial | Pasted or attached story exports are expected; project/filter scope needs confirmation. |
| SharePoint/Confluence export handling confirmed | Open | Need source authority and privacy handling review. |
| Diagram and OCR handling confirmed | Draft | Use only visible evidence and mark uncertainty. |
| API schema handling confirmed | Draft | Use supplied schemas only; do not infer missing fields. |
| Golden-copy XRAY CSV example confirmed | Partial | Sanitized repo fixture created from supplied example; live Confluence attachment still needs owner confirmation. |
| Golden-copy examples for remaining artifacts confirmed | Open | Needed for FeatureBrief, CoverageMap, RTM, E2E_Scenarios, MiniTestPlan, TestSummary, ConflictLog, and TBDLog. |
| Full artifact catalog confirmed | Done | Nine required artifacts are documented. |
| XRAY ID and upload model confirmed | Partial | XRAY numbering occurs on import after ROVO provides CSV text and a human uses Copilot/manual flow to produce/import the actual CSV. |
| XRAY column contract scope (shared vs team-specific) | Decided (2026-07-13; updated 2026-07-14) | S2 ruling relayed by owner: the XRAY CSV column contract is **shared across teams**; team-specific *values* stay overlay-scoped. The shared base contract was first captured as the 14-column golden ([contract-diff note](../reports/qa-test-case-architect-v2-csv-contract-diff-2026-07.md)) and applied in source by S3; `Priority` (default `Low`) was re-added 2026-07-14, so the enforced contract is now **15 columns**. |
| Permission model reviewed | Open | No write tools should be enabled in current design. |
| Controlled vocabularies (Test Type / Application List) | Confirmed (2026-07-14) | Test Type values captured; Application List referenced as a knowledge source (shared org-wide, single-value, owned by Jira/XRAY admins; full list held out); field-hygiene cleanup flagged to the owner. |
