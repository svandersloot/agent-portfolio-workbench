# Monthly ROVO Agent Governance Snapshot: May 2026

Generated from current repo docs, publish history, local page inventory, reference snippets, and dry-run reports. No Confluence or Studio writes were performed by this report.

## Executive Summary

| Signal | Current Month | Notes |
|---|---:|---|
| Known governed/candidate agents with Project Brain evidence | 5 | Rovo Design Agent, Agent Doc Steward, Release Health Analyst, Performance Test Report Agent (Extension), Jira Ticket Polisher draft. |
| Active or active-like status evidence | 2 | Rovo Design Agent has `Active / vNext Draft` inventory evidence; Release Health Analyst has `Active` Project Brain evidence. |
| Draft/scaffolding status evidence | 2 | Performance Test Report Agent shows `Scaffolding`; Jira Ticket Polisher is a draft Project Brain. |
| Published governance-front-door pages updated | 4 | Agent Fit Intake, Governance and Safety, Measurement and Value Tracking, User Guide - Designing Agents. |
| Follow-up wording correction pages updated | 2 | Agent Fit Intake and User Guide changed from app-candidate to agent-candidate language. |
| Duplicate page title groups needing review | 15 | Highest-risk groups are inventory, Project Brain, evaluation, and knowledge-source duplicates. |
| Studio visibility controls confirmed | 0 | Local evidence does not prove team assignment/discoverability controls. |

## What Changed

| Change | Evidence |
|---|---|
| Agent Fit Intake operationalized as governance front door. | `docs/confluence-pages/agent-fit-intake.md`, publish history. |
| Completeness contract created. | `docs/agent-governance-completeness-contract.md`, `schemas/agent-governance-record.schema.json`. |
| Monthly snapshot template created. | `templates/confluence/monthly-governance-snapshot-template.md`. |
| Studio visibility checklist created. | `docs/studio-visibility-team-assignment-investigation-checklist.md`. |
| Agent-candidate wording correction published. | `docs/publish-history/2026-05-21-agent-candidate-wording-correction.md`. |

## Portfolio By Lifecycle Signal

| Signal | Agents | Action Needed |
|---|---|---|
| Active / Active-like | Rovo Design Agent, Release Health Analyst | Backfill completeness fields and review dates; ensure manual Studio config aligns with Confluence. |
| Draft / Scaffolding | Performance Test Report Agent (Extension), Jira Ticket Polisher draft | Complete owner, backup owner, measurement, readiness, and review fields before broad launch. |
| Governance support agents | Agent Doc Steward | Update Doc Health Gate to check measurement and completeness. |

## Governance Completeness Themes

| Theme | Affected Area | Next Action |
|---|---|---|
| Backup owner not consistently proven | Project Brain records | Add explicit backup owner or gap/remediation owner. |
| Measurement plan not consistently proven | Main known agents | Add per-agent value signal, baseline/estimate method, quality/risk signal, and cadence. |
| Last-reviewed date not consistently proven | Portfolio-wide | Add ISO review date to Project Brain/inventory rows. |
| Lifecycle/readiness split is new | Portfolio-wide | Migrate legacy `Active / vNext Draft`, `Scaffolding`, and Green/Yellow/Red language into lifecycle plus readiness fields. |
| Duplicate page titles create reuse risk | Release Health Analyst, Performance Test Report Agent, inventory pages | Run focused comparison and legacy-banner/move plans. |

## Reuse And Duplicate Opportunities

| Opportunity | Existing Asset | Recommendation |
|---|---|---|
| New agent design request | Rovo Design Agent + Agent Fit Intake | Route through Design Agent first. |
| Documentation/governance scaffolding | Agent Doc Steward | Extend Doc Steward checks before creating separate documentation agents. |
| Release health requests | Release Health Analyst | Reuse or extend before creating a new release agent. |
| Performance report analysis | Performance Test Report Agent (Extension) | Reuse/extend extension before creating a new performance agent. |

## Leadership Notes

- The governance front door is now published in Confluence.
- Studio configuration remains a manual copy step.
- Inventory cleanup is the next highest-leverage governance operation because it strengthens reuse and duplicate prevention.
- Visibility controls remain unproven from local evidence and require manual Studio/admin confirmation.

## Builder Notes

- Check `Agent Inventory` before requesting a new governed agent.
- Use `Agent Fit Intake` when the right solution is unclear.
- Treat `Agent candidate` as a discovery state, not as approval to build.
- Do not rely on unparented duplicate pages as source of truth until canonical pages are confirmed.
