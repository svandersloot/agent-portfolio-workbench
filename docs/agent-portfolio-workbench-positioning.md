# Agent Portfolio Workbench Positioning

## Canonical description

Agent Portfolio Workbench is a Git-backed, read-only-first control and evidence layer for designing, evaluating, governing, measuring, and operating enterprise agent portfolios.

It helps builders and reviewers answer:

- What problem are we solving?
- Does an existing agent, automation, prompt, template, or workflow already address it?
- Is the context, ownership, audience, risk, and measurement plan ready?
- What evidence supports a pilot or promotion decision?
- What value, quality, and risk signals should be tracked?
- When should the capability be improved, deprecated, or retired?

## Audience model

Builders are the primary users. They use the workbench to shape ideas, check for reuse, prepare durable artifacts, evaluate behavior, and assemble reviewable handoffs.

| Audience | Primary need |
|---|---|
| Agent owners | Maintain sources, guardrails, readiness, measurement, and lifecycle evidence. |
| Designated reviewers and decision owners | Assess evidence, risk, pilot scope, and promotion requests. |
| Auditors and assurance reviewers | Trace decisions to sources, evidence, owners, metrics, and change history. |
| End users | Use approved capabilities in the supported business workflow and provide feedback. |
| Pilot users | A named subset of end users who evaluate a capability before broader promotion. |
| Leaders and executives | See portfolio shape, investment choices, risks, outcomes, and decisions needing attention. |

Roles describe who someone is. Lifecycle stages describe when and how a capability may be used.

## Three-plane operating model

The workbench complements, rather than replaces, native platform administration:

1. **Workbench and Git:** durable design records, reuse decisions, evidence, evaluations, measurements, handoffs, and lifecycle history.
2. **Confluence:** the human-facing portal for approved guidance, inventory views, reports, and navigation.
3. **Native runtime and delivery platforms:** agent execution, permissions, publishing, deployment, access enforcement, and business workflow use.

The current runtime includes Atlassian Rovo and related tools. The workbench is intentionally broader so the same governance pattern can support Microsoft and other agent platforms without making one platform the product identity.

## Current capability

Today the workbench provides repository-backed intake, duplicate checks, design and Project Brain artifacts, source-readiness checks, evaluation prompts, promotion packets, measurement plans, pilot boundaries, dry-run publishing support, reports, and validation checks.

It does not grant approval authority, decide ownership, make final readiness decisions, write directly to runtime platforms, or replace platform-admin controls.

## Future direction

The future state is a reusable open-source framework that can connect portfolio records to approved evidence and platform-specific adapters. Potential later capabilities include structured inventory validation, cross-platform evidence collection, policy and readiness checks, portfolio reporting, value tracking, and controlled lifecycle workflows.

Future capability does not remove the human decision boundary around approval, visibility, ownership, sensitive data, write authority, or retirement.

## Executive message

Native platforms control what agents can do once they exist. Agent Portfolio Workbench helps the organization decide which capabilities deserve to exist, whether they already exist, what evidence supports them, who owns them, how they create value, and when to improve or retire them.