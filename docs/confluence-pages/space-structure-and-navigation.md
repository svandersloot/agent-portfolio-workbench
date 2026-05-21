# Space Structure and Navigation

This page defines the recommended structure for the centralized ROVO Agent Governance space.

## Design Goal

The space should be easy for both humans and ROVO agents to navigate. It should separate durable governance standards from examples, active Project Brains, evaluations, working notes, and legacy migration material.

## Recommended Page Tree

- Agent Governance Home
- Start Here - Agent Fit and Governance Front Gate
- Governance and Safety
- Agent Inventory
- Meta-Agents
- Templates
- Pattern Library
- Agent Project Brains
- Evaluation Library
- Working Group Notes
- Archive and Legacy References

## Page Tree Detail

### Agent Governance Home

Purpose:

- Acts as the main landing page.
- Explains what the space is for.
- Links to the front gate, governance and safety, inventory, templates, pattern library, evaluations, and active Project Brains.

Recommended children:

- Start Here - Agent Fit and Governance Front Gate
- Governance and Safety
- Agent Inventory
- Meta-Agents
- Templates
- Pattern Library
- Agent Project Brains
- Evaluation Library
- Working Group Notes
- Archive and Legacy References

### Governance and Safety

Purpose:

- Holds shared governance standards, launch-readiness criteria, measurement expectations, and builder guidance.
- Keeps durable governance content separate from individual agent Project Brains.
- Gives both builders and reviewers one place to find the current operating model.

Current children:

- Measurement and Value Tracking
- Context Readiness Checklist
- User Guide - Designing Agents

Planned or recommended children:

- Governance Review Checklist
- Known Risks and Limitations
- Confluence Formatting Standards
- Admin and Owner Guide

### Agent Inventory

Purpose:

- Serves as the canonical list of ROVO agents, owners, lifecycle status, and source-of-truth Project Brain links.
- Helps builders check for existing agents before creating new ones.

Cleanup note:

- The inventory structure should be inspected before any merge. Preserve page identity and history by moving or reparenting pages instead of copying content into new pages.

### Meta-Agents

Purpose:

- Holds source-of-truth documentation for meta-agents that help design and govern other agents.

Recommended children:

- ROVO Design Agent
- Agent Doc Steward
- Collaboration Protocol - Design Agent and Doc Steward

### Templates

Purpose:

- Holds reusable templates for agent documentation.
- Stays stable and governed by a smaller owner group.

Recommended children:

- Agent Design Record Template
- Agent Governance Review Template
- Agent ADR Template
- Agent Blueprint Template vNext
- Knowledge Source Plan Template vNext
- Subagent Settings Template vNext
- ROVO Studio Configuration Copy Blocks Template
- Change Log Template
- Evaluation Template

### Pattern Library

Purpose:

- Holds reusable design and governance patterns extracted from Field IQ, existing ROVO agents, working group use cases, and evaluations.

Recommended children:

- Right-Sized Solution Routing
- Org-Wide Agent Plus Team Overlay
- Scoped Knowledge, Not Search Everything
- Skill Risk Tiers
- Subagent Complexity Standard
- Human-in-the-Loop Guardrails
- Evaluation as Evidence
- Studio Drift Control

### Agent Project Brains

Purpose:

- Holds active and example Project Brains for individual agents.

Recommended children:

- Release and Change Agents
- QA and Testing Agents
- Jira Hygiene Agents
- Product Planning Agents
- Support and Ops Agents
- Experimental and Sandbox Agents

### Evaluation Library

Purpose:

- Holds evaluation CSV references, sample prompts, expected responses, and test outcomes.

Recommended children:

- Evaluation Library - Starter Test Cases
- ROVO Design Agent Evaluations
- Agent Doc Steward Evaluations
- Agent-Specific Evaluations

### Working Group Notes

Purpose:

- Holds working group agendas, meeting notes, decisions in progress, and open action items.

Recommended children:

- CoP notes and working sessions
- Backlog and Improvement Roadmap

### Archive and Legacy References

Purpose:

- Holds legacy links, migrated page references, deprecated agents, and old Commercial/Mobilitas page mappings.

Recommended children:

- Existing Export Migration Map
- Legacy Page Notices
- Deprecated Agents

## Naming Standards

Use these naming patterns:

| Page Type | Naming Pattern |
|---|---|
| Agent root | `[Agent Name] Project Brain` |
| Blueprint | `Blueprint - [Agent Name]` |
| Knowledge Source Plan | `Knowledge Source Plan - [Agent Name]` |
| Subagent settings | `Subagent Settings - [Agent Name]` |
| Change log | `Change Log - [Agent Name]` |
| Evaluation | `Evaluation - [Agent Name]` |
| Template | `[Artifact Name] Template vNext` |
| Pattern | `[Pattern Name]` |

## Source-of-Truth Rule

Each agent should have one Project Brain root page. The Project Brain links to the current Blueprint, Knowledge Source Plan, Subagent Settings, Change Log, and evaluation evidence.

Do not duplicate the same source-of-truth content across multiple pages. Link to it instead.
