# QA Test Adequacy Critic - Agent Design Record

## Design Metadata

| Field | Value |
|---|---|
| Agent name | QA Test Adequacy Critic |
| Status | Draft |
| Owner | Needs human confirmation; not formally assigned |
| Backup owner | TBD |
| Design version | v0.1 / 2026-08-25 |
| Related request | P1 item from the owner's QA Test Case Architect v2 enhancement priority list (2026-08-24): "Add ISTQB Coverage Critic Sub-Agent," supplied as a complete instruction file. |
| Related agents | QA Test Case Architect v2 (primary hand-off source), QA Test Strategy Planner |

## Problem Statement

QATCA v2 generates test artifacts from source evidence, but generation and adequacy review are different skills: a suite can look complete (every AC mapped, high test-case count, clean formatting) while still missing negative paths, boundary conditions, integration failure modes, or risk-weighted depth. The pilot survey of QATCA v2 usage (see `docs/reports/qa-test-case-architect-v2-pilot-survey-analysis-2026-08-20.md` once committed) found a coverage-shaped concern in all four responses. A second, deliberately skeptical reviewer — one that never generates and is rewarded for finding gaps, not for approving — closes that blind spot without compromising QATCA v2's own generation behavior.

## Target Users

| Role | How They Use The Agent |
|---|---|
| QA Engineer | Get an adversarial second opinion on a generated test suite before treating it as review-ready. |
| Test Lead | Use the Coverage Assessment, Top Missing Test Areas, and Human Review Checklist to decide what still needs work before signoff. |
| SDET | Use the Technique Coverage Matrix and Non-Functional Coverage Matrix to identify missing ISTQB techniques or non-functional dimensions. |
| Project Manager | Use the Executive Summary's Overall Confidence and Release Risk fields, and the Human Signoff Decision, to understand whether more QA work is needed before proceeding. |

## Workflow Supported

The primary input is a hand-off from QATCA v2: a generated ArtifactPack (or TestSuite) plus the source requirements/AC evidence it was generated from. The agent may also receive requirements, user stories, ACs, feature descriptions, RTMs, E2E scenarios, architecture diagrams, integration details, or existing automation suites directly. It runs all 12 reviews in `Runtime Contract - QA Test Adequacy Critic`, in order, and returns the full Required Output Format ending in a human-signoff recommendation (never an approval).

## Fit Decision

| Field | Value |
|---|---|
| Decision | NEW GOVERNED AGENT CANDIDATE |
| Reason | Adequacy review is a distinct skill from generation, explicitly adversarial by design, and directly addresses a gap the pilot survey surfaced across every response. |
| Why not fold into QATCA v2 itself? | QATCA v2's own generation guidance (product/state coverage, general coverage-completeness) raises its baseline, but a generator grading its own output has a structural conflict of interest that a separate skeptical reviewer avoids. |
| Why not prompt only? | The 12-review pipeline, fixed output format, and "never approve" guardrails need to be consistent and auditable across every use, not re-explained per prompt. |
| Why not existing-agent extension? | QA Test Strategy Planner covers test strategy/plan drafting and readiness-gap analysis at a different altitude (before test cases exist); this agent reviews already-generated test cases for adequacy. |

## Trigger

Primary trigger: a hand-off from QATCA v2 after it generates a complete production TestSuite/ArtifactPack (see `Subagent Settings - QA Test Adequacy Critic` for the exact condition). Secondary trigger: a user directly asks for an adequacy/coverage-confidence review of an existing test suite.

## Inputs And Context Sources

| Source | Type | Authority | Permissions | Freshness | Fallback |
|---|---|---|---|---|---|
| QATCA v2 generated ArtifactPack / TestSuite | Hand-off (pasted/attached) | Primary review subject | User-provided / read-only | Per hand-off | If no generated suite is supplied, ask for it before reviewing. |
| Business requirements / user stories / acceptance criteria | Supplied text or Jira evidence | Requirement evidence | Read-only or user-provided | Per request | Mark coverage against missing requirements as `Insufficient Evidence`. |
| Existing test cases / RTMs / E2E scenarios | Supplied text or file | Review subject / supporting evidence | Read-only | Per request | Review what's supplied; do not assume unsupplied artifacts exist. |
| Architecture diagrams / integration details | Image/file/text | Reference for integration and failure-mode analysis | Read-only | Per request | Use visible evidence only; mark unclear details `Insufficient Evidence`. |
| Existing automation suites | Supplied text or file | Reference for technique/negative/data coverage | Read-only | Per request | Note when automation evidence is absent rather than assuming coverage. |

## Source-Of-Truth Pages

| Page | Purpose | Space |
|---|---|---|
| QA Test Adequacy Critic Project Brain | Governed source of truth for purpose, scope, status, and launch gaps. | ROVO |
| Runtime Contract - QA Test Adequacy Critic | Behavior authority: 12-review pipeline, output format, critical rules. | ROVO |
| ROVO Studio Configuration - QA Test Adequacy Critic | Manual Studio copy blocks. | ROVO |
| Subagent Settings - QA Test Adequacy Critic | Hand-off contract with QATCA v2. | ROVO |

## Skills And Actions

| Skill | Assigned To | Risk Tier | Allowed Use | Approval Required? |
|---|---|---|---|---|
| Read pasted/attached QATCA v2 output and supporting evidence | Parent agent | Low / Medium | Perform the 12-review adequacy analysis. | No for read-only use. |
| Read URLs or uploaded files (diagrams, schemas, automation suite excerpts) | Parent agent | Medium | Support integration, technique, and data coverage reviews. | No for read-only use; user must ensure allowed data. |
| Generate the Required Output Format (Markdown report) | Parent agent | Low | Return the adequacy review to the user. | Human review before acting on the recommendation. |
| Jira, XRAY, or Confluence write actions | None in current design | High | Not allowed. | Future governed workflow required. |
| Agent-to-agent invocation (receiving a QATCA v2 hand-off) | None confirmed in current Studio setup | Medium | Human-mediated hand-off only until Studio's capability is confirmed and governed. | Governed decision required before automating. |

## Human Approval Points

| Trigger | Approver | Agent Behavior |
|---|---|---|
| Final adequacy / signoff decision | QA lead or accountable test owner | Return a recommendation (Ready / Conditionally ready / Not ready / Insufficient evidence) only; never approve. |
| Release risk assessment | QA lead, release owner, or project owner | Report Release Risk (Low/Moderate/High/Unable to Determine) as input to their decision, not as a go/no-go call. |
| Ambiguous or ISTQB-technique-related judgment calls | QA lead or Test Architect | Flag as a Human Investigation Candidate rather than resolving. |

## Expected Outputs

| Output | Format | Destination |
|---|---|---|
| Executive Summary (Overall Confidence, Release Risk, Major Gaps) | Markdown | Returned to user for review. |
| Coverage Assessment (per-dimension ratings with evidence/reason/gap/follow-up) | Markdown table | Returned to user for review. |
| Technique Coverage Matrix | Markdown table | Returned to user for review. |
| Non-Functional Coverage Matrix | Markdown table | Returned to user for review. |
| Top Missing Test Areas (ranked by production risk) | Markdown list | Returned to user for review. |
| Critical Assumptions (explicit vs. inferred) | Markdown list | Returned to user for review. |
| Human Review Checklist | Markdown checklist | Returned to user for action. |
| Human Signoff Decision | One of four fixed recommendations | Returned to user; final decision remains theirs. |

## Example Prompts

1. Review this generated TestSuite against these acceptance criteria for adequacy — what's missing?
2. QATCA v2 just generated this ArtifactPack for story BB26-1197 — is it ready for QA signoff?
3. Check this test suite for negative-path and boundary-condition coverage.
4. What ISTQB techniques are missing from this set of test cases?
5. Given these integration points, does this suite validate failure and retry scenarios?

## Failure Modes

| Failure Mode | Likelihood | Impact | Mitigation |
|---|---|---|---|
| No generated suite supplied (direct-ask trigger without a hand-off) | Medium | Nothing concrete to review. | Ask for the test suite and its source requirements before reviewing. |
| Reviewer treats a high test count or clean formatting as sufficient | Medium | False confidence in an inadequate suite. | Critical Rule: never treat test-case count or polished formatting as proof of adequacy (already in source instructions). |
| Reviewer invents a requirement or integration not in evidence to justify a gap finding | Low | Fabricated gap, wastes reviewer time. | Critical Rule: do not invent requirements, integrations, risks, or expected results. |
| Hand-off never happens because it's human-mediated and the reviewer forgets | Medium | The adequacy check is silently skipped. | Confirmed handoff-trigger condition (§ Runtime Contract) plus QATCA v2 surfacing a recommendation message; revisit if Studio subagent chaining becomes available. |
| Agent approves a suite or makes a go/no-go call | Low | Violates human-owned-decision boundary. | Critical Rule + Required Output Format always end in a recommendation, never an approval. |

## Owner And Governance

| Field | Value |
|---|---|
| Primary owner | Needs human confirmation |
| Backup owner | TBD |
| Purpose | Adversarial adequacy review of generated QA test suites. |
| Audience | QA Engineers, Test Leads, SDETs, and Project Managers working with QATCA v2 output. |
| Readiness status | Needs Cleanup |
| Project Brain link | QA Test Adequacy Critic Project Brain |
| Last-reviewed date | 2026-08-25 |
| Review cadence | After pilot runs, then quarterly if promoted. |
| Next review date | TBD after owner assignment. |
| Retirement criteria | Deprecate or fold into QATCA v2's own validation step if a separate reviewer proves unnecessary in practice. |

## Version History

| Version | Date | Change Summary | Updated By |
|---|---|---|---|
| v0.1 | 2026-08-25 | Initial governed documentation scaffold from the owner-supplied instruction file and the 2026-08-24/25 priority-list decisions. | Claude Code (governance workbench) |
