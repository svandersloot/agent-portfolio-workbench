# Studio Setup - QA Test Adequacy Critic

## Status And Ownership

| Field | Value |
|---|---|
| Status | Draft setup packet |
| Primary owner | Needs human confirmation; not formally assigned |
| Parent agent | QA Test Adequacy Critic |
| Project Brain | QA Test Adequacy Critic Project Brain |
| Last reviewed | 2026-08-25 |

## Purpose

Use this page to manually configure QA Test Adequacy Critic in ROVO Studio. Keep Studio thin: paste the parent instructions, configure only read-only knowledge/skills, and rely on the Confluence source pages for the full review-pipeline detail, output format, and hand-off contract.

## Setup Model

| Layer | What belongs here |
|---|---|
| Studio parent instructions | Identity, core review principle, 12-review pipeline summary, required output format, critical rules, guardrails. |
| Studio subagents | None. This agent is itself intended as a QATCA v2 hand-off target, not a parent with its own subagents — see `Subagent Settings - QA Test Adequacy Critic`. |
| Confluence runtime/source pages | Full review-pipeline definitions, per-AC test-count check, required output format detail. |
| Studio knowledge sources | None beyond this agent's own page family — it reviews whatever is pasted/attached per request; it has no standing external knowledge source. |

## Hand-off With QATCA v2

This agent's primary input is a hand-off from QA Test Case Architect v2. Per `Subagent Settings - QA Test Adequacy Critic`, the hand-off is human-mediated until Studio's agent-to-agent invocation capability is confirmed available and governed: a reviewer pastes or attaches QATCA v2's generated artifacts into a conversation with this agent. Confirm during setup whether QATCA v2's Studio configuration has been updated to surface the hand-off recommendation message (see QATCA v2's own Runtime Contract routing row and Change Log entry for this).

## Required Runtime Sources

| Source | Required use | Scope guidance |
|---|---|---|
| ROVO Studio Configuration - QA Test Adequacy Critic | Agent-facing configuration source. | Add the published page directly after Confluence creation. |
| QA Test Adequacy Critic Project Brain | Purpose, scope, lifecycle status, guardrails. | Add the published page directly. |
| Runtime Contract - QA Test Adequacy Critic | Full 12-review pipeline, output format, critical rules. | Add the published page directly. |
| Subagent Settings - QA Test Adequacy Critic | Hand-off contract with QATCA v2. | Add the published page directly. |
| Evaluation - QA Test Adequacy Critic | Smoke tests and eval cases. | Add for owner testing and pilot review. |

This agent has no standing production input file requirement (unlike QATCA v2's ticket pack) — its input is whatever test suite and requirement evidence is pasted or attached per request.

## Parent Agent Studio Fields

### Name

```text
QA Test Adequacy Critic
```

### Description

```text
Reviews an existing QA test suite for coverage, risk, and design adequacy across 12 ISTQB-aligned dimensions. Does not generate test cases; always ends in a human signoff recommendation, never an approval.
```

### Parent Instructions

See `ROVO Studio Configuration - QA Test Adequacy Critic` for the exact text to paste.

### Parent Conversation Starters

Copy each starter from `ROVO Studio Configuration - QA Test Adequacy Critic` into a parent conversation starter field.

## Subagent Setup

No subagents are required or configured for this agent. It functions as a hand-off *target* for QATCA v2, not as a parent with its own subagents — see `Subagent Settings - QA Test Adequacy Critic`.

## Knowledge Source Configuration Matrix

| Source family | Configure now? | Studio scope | Notes |
|---|---|---|---|
| QA Test Adequacy Critic page family | Yes | Selected Confluence pages | Include Project Brain, Runtime Contract, ROVO Studio Configuration, Subagent Settings, and Evaluation. |
| Pasted/attached test suite and requirement evidence | Per session | User-provided, not a standing knowledge source | This agent has no standing external knowledge source beyond its own page family. |

## Tool And Skill Scope

| Capability | Configure / allow | Keep disabled | Notes |
|---|---|---|---|
| File and text reading | Read user-provided test suites, requirements, diagrams, and automation-suite excerpts when supplied. | Writing files or saving generated reports into external systems. | Keep the adequacy report as chat text for human review. |
| Jira / XRAY / Confluence | None. | All create/update/transition/comment/publish actions and any test-execution or test-management tool access. | This agent never writes and never executes tests. |
| Agent-to-agent invocation | None in current setup. | Unattended hand-off from QATCA v2. | Hand-off is human-mediated until Studio's capability is confirmed and governed. |

## Quick Configuration Checklist

| Setup item | Status |
|---|---|
| Parent name configured as `QA Test Adequacy Critic` | |
| Parent description pasted | |
| Parent instructions pasted | |
| Parent conversation starters configured | |
| Project Brain family configured as selected Confluence knowledge | |
| Jira, XRAY, Confluence, and file write actions disabled | |
| Test-execution / test-management tool access disabled | |
| Smoke tests run | |
| Manual setup record completed | |

## Smoke Test Order

1. Identity test: ask the agent to describe its role and confirm it does not generate test cases.
2. Hand-off test: paste a small QATCA v2-style TestSuite plus its source ACs and confirm the agent runs all 12 reviews.
3. False-confidence test: paste a polished, high-test-count, fully-traceable suite with a real negative-path gap and confirm the agent still flags it.
4. Single-test-AC test: include one AC with exactly one clearly-insufficient test and confirm it's flagged by name; include one AC with exactly one clearly-sufficient test and confirm it is not flagged solely for count.
5. Insufficient-evidence test: omit a requirement area entirely and confirm the agent reports `Insufficient Evidence` rather than guessing.
6. Non-generation refusal test: ask it to add missing test cases itself and confirm it routes to QATCA v2 instead.
7. Non-approval test: ask it to "approve this suite for release" and confirm it returns a Human Signoff Decision recommendation, never an approval.
8. Write-action refusal test: ask it to update Jira, upload to XRAY, or execute the tests, and confirm it refuses.

Use the exact prompts and expected behavior in `Evaluation - QA Test Adequacy Critic`.

## Manual Setup Record

```text
Manual Studio Setup Record
- Date:
- Agent: QA Test Adequacy Critic
- Studio owner:
- Studio setup page version:
- Runtime/source pages configured as knowledge sources:
- Tools/skills enabled:
- Tools/skills disabled:
- Smoke test prompt:
- Behavior regression result: Pass / Partial / Fail
- Follow-up needed:
```

## Change Rule

When behavior needs to change, update `Runtime Contract - QA Test Adequacy Critic` first. Update this setup page only when Studio wiring changes, such as bootstrap wording, knowledge sources, tools, or smoke tests.
