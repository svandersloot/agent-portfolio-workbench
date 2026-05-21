# ROVO Space Improvement Plan

Source: ROVO space audit report provided on 2026-05-21.

## Executive Summary

The ROVO space already has a strong agent governance operating model:

- Fit triage front gate with seven valid outcomes: Prompt Only, Default Rovo, Automation Flow, Extend Existing, Create New, App/Forge Candidate, Not Ready.
- Project Brain pattern: one root page per durable agent linking Blueprint, Knowledge Source Plan, Subagent Settings, Change Log, Evaluation, and Studio Configuration.
- Meta-agent collaboration model between the Rovo Design Agent and Agent Doc Steward.
- Pattern Library with promotion rules.
- Working examples: Release Health Analyst and Performance Test Report Agent Extension.
- Formatting standards that make pages easier for people and agents to retrieve.

The largest current gaps are:

- No measurement framework for adoption, value, quality, rework, or satisfaction.
- No centralized decision log for agent design decisions.
- No context readiness assessment before agent design.
- No user-facing builder onboarding path.
- No centralized known risks and limitations page.
- No backlog or improvement roadmap page in Confluence.
- Competing inventory pages: `Agent Inventory` and `Rovo Agent Inventory Home`.

## First Five Actions

1. Merge the two inventory pages.
   - Keep `Agent Inventory` as the canonical page.
   - Harvest compliance tier, environment, runbook, SLO, and data/privacy concepts from `Rovo Agent Inventory Home`.
   - Archive the duplicate with a legacy banner after migration.

2. Create `Measurement and Value Tracking`.
   - Start with lightweight metrics: adoption, time saved, quality, rework, satisfaction, and qualitative owner feedback.

3. Create `Context Readiness Checklist`.
   - Use this before recommending `New governed agent` or `Existing-agent extension`.

4. Create `User Guide - Designing Agents`.
   - Give new builders a self-service path from idea to review.

5. Move `CoP 5/15/26` under `Working Group Notes` and create `Backlog and Improvement Roadmap`.
   - Convert open meeting action items into tracked work.

## Proposed Information Architecture

```text
Agent Governance Home
|-- Agent Fit Intake
|-- Agent Inventory
|-- Context Readiness Checklist
|-- Space Structure and Navigation
|
|-- Meta-Agents
|   |-- Rovo Design Agent Project Brain
|   |   |-- Rovo Design Agent vNext - Blueprint
|   |   |-- Rovo Design Agent vNext - Knowledge Source Plan
|   |   |-- Rovo Design Agent vNext - Subagent Settings
|   |   `-- Rovo Design Agent vNext - Rovo Studio Configuration
|   |-- Agent Doc Steward Project Brain
|   |   |-- Agent Doc Steward vNext - Knowledge Source Plan
|   |   |-- Agent Doc Steward vNext - Rovo Studio Configuration
|   |   `-- Agent Doc Steward - Doc Health Gate vNext
|   `-- Collaboration Protocol - Design Agent and Doc Steward
|
|-- Templates (Reusable)
|   |-- Agent Blueprint Template vNext
|   |-- Knowledge Source Plan Template vNext
|   |-- Subagent Settings Template vNext
|   |-- Rovo Studio Configuration Copy Blocks Template
|   |-- Change Log Template
|   |-- Evaluation Template
|   |-- Agent Design Record Template
|   |-- Agent Governance Review Template
|   `-- Agent ADR Template
|
|-- Pattern Library
|   `-- Individual pattern child pages
|
|-- Agent Project Brains
|   |-- Release and Change Agents
|   |-- QA and Testing Agents
|   |-- Jira Hygiene Agents
|   |-- Product Planning Agents
|   |-- Support and Ops Agents
|   |-- Experimental and Sandbox Agents
|   `-- Performance Test Report Agent (Extension) Project Brain
|
|-- Evaluation Library
|   `-- Evaluation Library - Starter Test Cases
|
|-- Governance and Safety
|   |-- Governance Review Checklist
|   |-- Known Risks and Limitations
|   `-- Confluence Formatting Standards for Agent Docs
|
|-- Measurement and Value Tracking
|   `-- Agent Success Metrics Framework
|
|-- Decision Log
|-- User Guide - Designing Agents
|   |-- Builder Quickstart
|   `-- Admin and Owner Guide
|
|-- Working Group Notes
|   `-- CoP 5/15/26
|
|-- Backlog and Improvement Roadmap
|-- Migration and Legacy Plan
`-- Archive and Legacy References
```

## Structural Decisions

| Change | Rationale |
|---|---|
| Add Governance and Safety section | Consolidates review checklists, risks, and standards. |
| Add Measurement and Value Tracking section | Makes ROI and value tracking first-class. |
| Add Decision Log | Provides an auditable record of design decisions. |
| Add User Guide section | Lets new builders self-serve without working group context. |
| Move CoP notes under Working Group Notes | Keeps meeting records out of the top-level governance tree. |
| Merge inventory pages | Removes the biggest immediate source of human and agent confusion. |
| Add Context Readiness Checklist at top level | Context quality gates agent quality. |
| Promote patterns to child pages | Makes patterns individually linkable, searchable, and retrievable. |

## Page Recommendations

| Page | Recommendation | Notes |
|---|---|---|
| Agent Governance Home | Update | Add links to Measurement, Decision Log, User Guide, Governance and Safety, and updated structure. |
| Agent Fit Intake | Keep | Use as the front door for Design Agent-guided governance triage. |
| Agent Inventory | Update and merge | Canonical inventory. Add compliance tier, environment, runbook, SLO, and data/privacy fields. |
| Rovo Agent Inventory Home | Archive after harvest | Keep useful fields, then archive as legacy. |
| Space Structure and Navigation | Update | Match actual hierarchy after moves. |
| Pattern Library | Update | Promote core patterns to child pages. |
| Meta-Agents | Keep | Good index. |
| Templates (Reusable) | Update | Add Agent Design Record, Governance Review, and ADR templates. |
| Agent Project Brains | Keep | Good index structure. |
| Working Group Notes | Update | Move CoP notes under this page. |
| CoP 5/15/26 | Move | Meeting record, not top-level governance. |
| Collaboration Protocol - Design Agent and Doc Steward | Keep | Strong operating model. |
| Confluence Formatting Standards for Agent Docs | Move | Belongs under Governance and Safety. |
| Migration and Legacy Plan | Keep | Archive when migration closes. |
| Archive and Legacy References | Keep | Serves its purpose. |
| Evaluation Library - Starter Test Cases | Update | Add context readiness, governance review, and measurement scenarios. |

## Missing Pages

| Page | Purpose | Priority |
|---|---|---|
| Context Readiness Checklist | Assess source quality before agent design. | P0 |
| Measurement and Value Tracking | Define and track agent value. | P0 |
| Decision Log | Track design decisions and rationale. | P1 |
| Governance Review Checklist | Human-facing pre-launch review. | P1 |
| Known Risks and Limitations | Central record of technical and organizational constraints. | P1 |
| User Guide - Designing Agents | Builder onboarding guide. | P1 |
| Admin and Owner Guide | Space admin and agent owner maintenance guide. | P2 |
| Backlog and Improvement Roadmap | Track improvements and open action items. | P1 |
| Agent ADR Template | Reusable ADR format. | P1 |

## Meta-Agent Improvements

### Rovo Design Agent

Add intake questions:

- What does success look like? How would you measure whether this agent is working?
- What is the source of truth for the data this agent needs? Is it up to date?
- Who owns the source data? What happens if it goes stale?
- Has anyone tried to solve this before, with or without an agent?
- What is the worst thing this agent could do if it misunderstands?

Add outputs:

- Context readiness pre-check.
- Success metrics recommendation.
- Risk tier classification.
- ADR stub for non-obvious design decisions.

Add governance checks:

- Block `New governed agent` if no owner is assigned.
- Block `New governed agent` if context readiness is `Not Ready`.
- Warn if proposed agent overlaps with existing inventory.
- Require write action justification for Tier 2+ skills.

### Agent Doc Steward

Add checks:

- Context Readiness Assessment exists.
- Measurement plan exists as a P1 check.
- ADR exists for non-trivial design decisions as a P2 check.
- Source page freshness drift.
- Project Brain completeness score.

## Risks

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Single-person bottleneck | High | High | Assign backup owners and train at least two additional maintainers. |
| Competing inventory visions | Medium | Medium | Align with Michael before merging inventory pages. |
| Template overhead | Medium | Medium | Apply full templates only to `New governed agent` and `Existing-agent extension`. |
| Meta-agent instruction bloat | Medium | Medium | Test Studio length and split capability into subagents if needed. |
| Measurement without tooling | High | Medium | Start with self-reported metrics and qualitative owner feedback. |
| Adoption resistance | Medium | High | Emphasize least-complex governed solution and show cases where governance avoids extra work. |

## Assumptions And Information Gaps

Assumptions:

- ROVO is the canonical permanent space.
- The working group will continue meeting.
- The duplicate inventory page represents a parallel effort that needs alignment, not unilateral deletion.
- Current Rovo Studio limitations still apply.
- Labels are intended to be used consistently.

Information gaps:

- Label compliance has not been verified.
- Actual page hierarchy needs API or UI confirmation.
- Legacy MO/IQS migration completeness was not reviewed.
- Studio configuration still needs comparison against Confluence documentation.
