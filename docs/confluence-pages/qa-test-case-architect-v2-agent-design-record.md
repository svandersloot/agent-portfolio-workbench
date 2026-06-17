# QA Test Case Architect v2 - Agent Design Record

## Design Metadata

| Field | Value |
|---|---|
| Agent name | QA Test Case Architect v2 |
| Status | Draft |
| Owner | Needs human confirmation; Shayne Vandersloot identified as likely candidate, not formally assigned |
| Backup owner | TBD |
| Design version | v0.1 / 2026-06-11 |
| Related request | Scaffold documentation from the agent self-description report. |
| Related agents | Jira Work Item Assistant, Agent Doc Steward, ROVO Design Agent |

## Problem Statement

QA teams need repeatable, source-backed test artifacts that preserve traceability from requirements and acceptance criteria to XRAY-ready test cases. Without a governed assistant, test suites, coverage maps, and RTMs can drift across teams, omit acceptance criteria, or include undocumented assumptions.

## Target Users

| Role | How They Use The Agent |
|---|---|
| QA Engineer | Generate draft test cases and coverage maps from Jira story evidence. |
| SDET | Prepare deterministic CSV output and identify automation-ready scenarios. |
| Test Lead | Review traceability, gaps, and conflicts before test-plan approval. |
| Project Manager | Understand coverage status, TBDs, and unresolved requirement conflicts. |

## Workflow Supported

For production, the user provides `TICKET_PACK_COMBINED.xml` from the Ticket Pack Builder workflow. The ticket pack contains normalized source evidence such as Jira stories, acceptance criteria, attachments, supporting documentation, Confluence or SharePoint exports, architecture diagrams, or API schemas. For Studio evaluation or AgentLab testing, a complete prompt-provided source packet may stand in as a temporary input package. The agent runs a retrieval, generation, and validation loop: it normalizes requirements, drafts QA artifacts, maps acceptance criteria to tests, checks coverage and format, and reports conflicts or missing data for human review.

## Fit Decision

| Field | Value |
|---|---|
| Decision | NEW GOVERNED AGENT CANDIDATE |
| Reason | The workflow is repeatable, shared across QA roles, source-backed, and produces auditable QA artifacts. |
| Why not prompt only? | A one-off prompt may help evaluation or prototype users, but production needs a normalized ticket pack to preserve context, source manifest, standard CSV formatting, traceability rules, and conflict logging across teams. |
| Why not automation only? | The workflow needs interpretation of requirements, ambiguity handling, and human-facing documentation judgment. |
| Why not existing-agent extension? | Jira Work Item Assistant supports work-item drafting and review; this agent focuses on QA artifact generation and XRAY-ready test documentation. |

## Trigger

The primary trigger is a QA or project user asking to generate test cases, coverage maps, or RTMs from Jira, Confluence, or provided source evidence.

## Inputs And Context Sources

| Source | Type | Authority | Permissions | Freshness | Fallback |
|---|---|---|---|---|---|
| QA Standard - Test Case Template For Rovo Agents | Confluence / QA standard | Process Authority | Read-only | Review after template changes | Ask user to provide current template content if inaccessible. |
| TICKET_PACK_COMBINED.xml | XML file | Production input package | User-provided / read-only | Per request | Stop production workflow if missing; use prompt packet only for evaluation/prototype runs. |
| Jira story export or pasted story details | Jira / supplied text | System of Record for story scope | Read-only or user-provided | Per request | Mark missing fields as `TBD`. |
| Attachments and supporting documentation | File / supplied text | User-supplied evidence | Read-only | Per request | Ask user to clarify source authority. |
| Acceptance criteria | Jira / supplied text | Requirement evidence | Read-only or user-provided | Per story | Do not invent missing AC; log gaps. |
| SharePoint-hosted Confluence exports | Supplied file/export | Reference or process evidence depending on source | Read-only | Per export | Ask user to identify source authority and export date. |
| Architecture diagrams | Image/file | Reference | Read-only OCR/diagram analysis | Per request | Use only visible or described diagram details; mark uncertainty. |
| API schemas | File or URL | Technical source | Read-only | Per schema version | Ask for current schema or mark API fields `TBD`. |

## Source-Of-Truth Pages

| Page | Purpose | Space |
|---|---|---|
| QA Test Case Architect v2 Project Brain | Governed source of truth for purpose, scope, status, and launch gaps. | ROVO |
| Knowledge Source Plan - QA Test Case Architect v2 | Approved source and authority model. | ROVO |
| ROVO Studio Configuration - QA Test Case Architect v2 | Manual Studio copy blocks. | ROVO |
| QA Standard - Test Case Template For Rovo Agents | Test case template and formatting standard. | To confirm |

## Skills And Actions

| Skill | Assigned To | Risk Tier | Allowed Use | Approval Required? |
|---|---|---|---|---|
| Search Confluence or supplied exports | Parent agent | Medium | Retrieve QA template and source context. | No for read-only use. |
| Search Jira or supplied Jira exports | Parent agent | Medium | Read story scope, AC, labels, and metadata. | No for read-only use. |
| Read URLs or uploaded files | Parent agent | Medium | Read source docs, schemas, diagrams, and exports. | No for read-only use; user must ensure allowed data. |
| Image/OCR reading | Parent agent | Medium | Extract visible diagram labels or flows. | No for read-only use. |
| Generate CSV text | Parent agent | Low / Medium | Return review-ready XRAY CSV content to user for Copilot/manual CSV generation and XRAY import. | Human review before upload. |
| Jira, XRAY, or Confluence write actions | None in current design | High | Not allowed in current design. | Future governed workflow required. |

## Human Approval Points

| Trigger | Approver | Agent Behavior |
|---|---|---|
| Final test plan or test summary approval | QA lead or test owner | Return draft artifacts and review notes only. |
| Risk sign-off | QA lead, release owner, or project owner | List risks and gaps; do not sign off. |
| Conflicting requirements | Product owner, BA, QA lead, or source owner | Add to `ConflictLog` and request resolution. |
| Definition of Done | Team owner or delivery lead | Do not determine DoD; reference supplied standard only. |
| Test case ID policy | QA lead or XRAY owner | Use draft deterministic IDs only until numbering is confirmed. |

## Expected Outputs

| Output | Format | Destination |
|---|---|---|
| FeatureBrief | XML | Returned to user for review. |
| TestSuite | XRAY CSV text | Returned to user for Copilot/manual CSV generation and XRAY import. |
| CoverageMap | CSV text | Returned to user for review. |
| RTM | CSV text | Returned to user for review. |
| E2E_Scenarios | TXT | Returned to user for review. |
| MiniTestPlan | XML | Returned to user for review. |
| TestSummary | XML | Returned to user for review. |
| ConflictLog | TXT | Returned with artifact package for human resolution. |
| TBDLog | TXT | Returned with missing details and source questions. |

## Example Prompts

1. Generate XRAY CSV test cases from this Jira story export using the QA standard template.
2. Create a coverage map that shows each acceptance criterion and its linked test cases.
3. Build an RTM from these stories and list any missing or conflicting requirements.
4. Review this generated test suite for gaps against the supplied acceptance criteria.
5. Create a feature brief and linked test suite from these story attachments and supporting docs.

## Failure Modes

| Failure Mode | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Missing acceptance criteria | Medium | Test cases may not trace to requirements. | Mark `TBD`; ask for AC or source story update. |
| Ambiguous requirement wording | Medium | Wrong or weak tests may be generated. | Add to `ConflictLog` or `TBDLog`. |
| Template source inaccessible | Medium | CSV may drift from QA standard. | Ask user to provide current template. |
| Missing golden-copy examples | Medium | Artifact format may drift between teams. | Keep output draft and flag the missing example. |
| Broad source scope requested | Medium | Agent may retrieve unrelated or private context. | Require specific pages, spaces, filters, or supplied files. |
| Ticket pack missing in production | High | Agent lacks required normalized context. | Stop and ask for `TICKET_PACK_COMBINED.xml`. |
| XRAY import numbering misunderstood | Medium | Users may expect final XRAY IDs before import. | State that XRAY numbering happens on import after manual/Copilot CSV flow. |
| Sensitive source data supplied | Medium | Privacy risk. | Remind user to use only permitted internal QA data. |

## Owner And Governance

| Field | Value |
|---|---|
| Primary owner | Needs human confirmation |
| Backup owner | TBD |
| Purpose | Generate deterministic QA artifacts from explicit source evidence. |
| Audience | QA Engineers, SDETs, Test Leads, and Project Managers in CSAA IG NextGen and QA AI Ops. |
| Readiness status | Needs Cleanup |
| Project Brain link | QA Test Case Architect v2 Project Brain |
| Last-reviewed date | 2026-06-11 |
| Review cadence | After pilot runs, then quarterly if promoted. |
| Next review date | TBD after owner assignment. |
| Retirement criteria | Deprecate or fold into another QA agent if ownership, source standards, or XRAY integration cannot be sustained. |

## Version History

| Version | Date | Change Summary | Updated By |
|---|---|---|---|
| v0.1 | 2026-06-11 | Initial governed documentation scaffold from self-description report. | Codex documentation scaffold |
