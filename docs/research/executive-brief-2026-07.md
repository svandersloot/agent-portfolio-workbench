# Executive Brief: AI Agent Governance Control Plane

Date: 2026-07-08 · Status: Proposal for review · Full report: `enterprise-agent-governance-operating-model-2026-07.md`

## The problem

AI agents are multiplying across platforms — Atlassian Rovo today; Copilot, Claude, ChatGPT, and custom agents next. Every platform governs only itself, and the least mature (Rovo Studio) ships with open creation by default, no version history, no configuration API, and no group-based access control. Without a cross-platform record, we accumulate agents nobody owns, duplicates nobody finds, and changes nobody can audit. For an insurer, this is also a regulatory exposure: the NAIC Model Bulletin — adopted by 24+ states — expects a written AI systems program with a documented inventory and third-party AI oversight.

## What exists today

A working governance control plane, built and operating for the Rovo agent portfolio: a Git-backed registry and audit trail holding every governed agent's owner, status, purpose, knowledge sources, evaluation prompt packs, approval evidence, and change history. Intake triage prevents duplicate builds (reuse before create). Configuration changes are manual and approval-gated; the workbench captures runtime state back and detects drift. No unsupported automation, no fake approvals, no overclaimed readiness.

## Why this approach is right

Industry has converged on exactly this pattern in 2025-26: Microsoft now mandates a named human sponsor per agent identity (Entra Agent ID) and ships an agent registry; GitHub shipped an agent control plane; OpenAI launched Frontier for agent IAM and audit. Independent research supports the discipline: Gartner predicts >40% of agentic AI projects will be canceled by 2027 for cost, unclear value, or inadequate risk controls; IBM found shadow-AI breaches cost ~$670K more than average; MIT found the overwhelming majority of GenAI pilots produce no measurable return, failing on workflow integration — not model quality. Projects with evidence of value and risk control are the ones that survive.

## What it delivers

Faster safe adoption, not slower: a ten-minute intake, a same-day reuse answer, pilots in days — with the evidence trail produced as a by-product. Leadership gets a monthly one-page snapshot: portfolio by status and risk tier, governance coverage, adoption and acceptance trends, duplicates prevented, incidents and resolutions. Measurement is behavioral and honest (accepted/edited/rejected outputs, platform analytics) — no invented ROI.

## The ask (next 90 days)

1. Host the workbench in org Git with a second maintainer (removes single-person risk).
2. Approve the first team pilot (1-2 agents) through the existing promotion process.
3. Sponsor a risk-tier policy so lightweight agents stay lightweight and consequential ones get real review.
4. Register one non-Rovo agent (Copilot or Claude) to prove the cross-platform registry.

## Principle

Platform runtimes come and go; the governance record — who owns each agent, what it was approved to do, what evidence supported that, and what changed — is the durable asset. We build that record once and point every platform at it.
