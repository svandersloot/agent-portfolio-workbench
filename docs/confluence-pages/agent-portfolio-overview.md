# Agent Portfolio Overview

## What this is

Agent Portfolio Workbench is the shared, Git-backed workbench for designing, evaluating, governing, measuring, and handing off an AI agent portfolio. It keeps durable evidence reviewable while agents are configured and used in a separate runtime.

Rovo is the current first runtime. Rovo Studio and approved Atlassian surfaces such as Jira and Confluence remain the places where runtime configuration and end-user work happen. This workbench prepares the evidence and copy packets around that runtime; it does not silently publish, save, change visibility, or write to live systems.

## Who uses what

This is the canonical six-role audience model. Roles describe who someone is; lifecycle gates describe when and how a capability may be used.

| Role | Starting point | Contribution or decision |
|---|---|---|
| Governance builder | Agent Fit Intake, Agent Inventory, Project Brain, evaluations, and templates | Shape ideas, check for reuse, and draft the smallest useful governed solution |
| Agent owner | Project Brain, knowledge sources, measurement plan, and change log | Maintain sources, guardrails, readiness, measurement, and lifecycle evidence |
| Reviewer / decision owner | Promotion packet, pilot boundaries, readiness evidence, and review records | Decide whether evidence supports pilot use or promotion |
| Assurance partner | Git history, source links, validation output, and decision records | Audit, security, privacy, legal, and compliance, consolidated. Check traceability and control evidence; decide when a use case needs formal review, extra controls, or rejection; no approval authority over the workflow itself |
| End user | Approved agents and the feedback path named for their workflow | Report usefulness, edits, rejection, missing context, or risk |
| Leader / executive | Portfolio and leadership views, and Measurement and Value Tracking summaries | See portfolio shape, investment choices, risks, outcomes, and decisions needing attention |

Pilot users are a temporary subset of end users during evaluation, not a separate role, a separate consumer product, or a default broad audience. Do not describe a pilot approval as broad readiness or org-wide rollout.

## How the workbench relates to runtime

1. A builder records a workflow problem and checks for reuse.
2. The workbench holds the design, source, evaluation, measurement, and safety evidence.
3. A designated reviewer or decision owner reviews the bounded promotion packet.
4. An authorized human configures the approved result manually in Rovo Studio.
5. End users or named pilot users consume the approved runtime behavior and provide feedback.
6. The workbench records follow-up evidence, drift, remediation, and lifecycle decisions.

## Find the next page

- `Space Structure and Navigation` - page tree and navigation model.
- `Agent Inventory` - canonical reuse and lifecycle check.
- `Agent Fit Intake` - route a problem to a prompt, automation, extension, template, candidate, governed agent, or not-ready outcome.
- `Governance and Safety` - shared controls and escalation guidance.
- `Measurement and Value Tracking` - portfolio and per-agent evidence.
- `User Guide - Designing Agents` - builder workflow.
- `Admin and Owner Guide` - accountability and manual live-system boundaries.

## Source-of-truth and safety rule

Repo-backed source artifacts are the durable local audit trail. Published Confluence pages are human-facing copies of approved content. Rovo Studio is the manually configured current runtime. If these surfaces disagree about status, readiness, ownership, approval, or runtime behavior, record the drift and route it to the designated decision owner; do not silently choose a winner.

Historical ROVO pages and evidence remain valid records of the earlier or current first-runtime context. They should be read as part of the Agent Portfolio Workbench rather than treated as a second portfolio identity.
