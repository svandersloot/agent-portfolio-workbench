# Stage 5 Pilot Boundaries

Use this catalog to decide whether a pilot workflow is approved, prohibited, or needs escalation before a ROVO agent is configured or promoted.

These boundaries apply to the first team pilot only. They do not approve org-wide rollout.

## Approved Pilot Workflows

| Workflow | Allowed output | Required guardrail | Evidence required |
|---|---|---|---|
| Source-backed summarization | Draft summary of approved Jira, Confluence, or supplied context | Cite or name source context; mark missing evidence as incomplete | Source list and reviewer spot check |
| Draft planning or handoff support | Draft plan, checklist, handoff, or promotion packet content | Human owns final decision and publication | Owner review and accepted edits |
| Ticket or page quality review | Gaps, suggested wording, acceptance criteria, or readiness notes | Draft-only output; no direct update, transition, assign, rank, or comment | User confirms whether suggestion was accepted, edited, or rejected |
| Agent fit triage | Prompt, automation, extension, template, candidate, new agent, or not-ready recommendation | Must check Agent Inventory before recommending new agent | Intake notes and duplicate decision |
| Regression or evaluation prompts | Pass/partial/fail observations against expected behavior | Do not claim production readiness from prompt tests alone | Test prompt, expected result, actual result, reviewer notes |
| Metrics and feedback capture | Manual pilot usage, time saved estimate, quality signal, risk note, improvement decision | No automated telemetry required for first pass | Feedback tracker row |

## Prohibited Workflows

| Workflow | Why prohibited in first pilot | Required path instead |
|---|---|---|
| Autonomous Jira writes | Write actions affect delivery records and need governed approval paths | Draft text for a human to review and apply |
| Autonomous Confluence publishing | Publishing changes shared source context and page history | Use dry-run-first publisher and explicit approval before any apply |
| Autonomous ROVO Studio writes | Studio-created agent configuration has no supported repo write-back path | Prepare copy blocks for manual Studio configuration |
| Approval, go/no-go, release, legal, compliance, or personnel decisions | These decisions are human-owned and may carry business risk | Provide evidence summary and route to the named owner |
| Broad audience expansion | First pilot is limited to one team and named workflows | Run team promotion review, then separate expansion review |
| Using private, raw, or unsanitized captures as prompt context | Raw captures may contain sensitive headers, cookies, tokens, or private data | Use sanitized fixtures or approved source excerpts |
| Creating a new agent without duplicate review | Duplicate agents fragment ownership and source truth | Complete inventory search and reuse/improve/merge/reject/new decision |

## Escalation Triggers

| Trigger | Escalate to | Minimum packet |
|---|---|---|
| Agent needs write-capable Jira, Confluence, Studio, repository, or workflow actions | Governance steward and reviewer/manager | Use case, action list, human approval gate, rollback path, evaluation evidence |
| Agent touches customer, employee, legal, financial, security, or regulated data | Security, legal, compliance, or privacy partner | Data summary, source list, intended audience, retention notes, tool/action summary |
| Agent could influence release readiness, incident response, production changes, or go/no-go decisions | Release/change owner and manager | Evidence summary, allowed recommendation boundary, explicit human-owned decision owner |
| Agent requires broad knowledge-source access to compensate for weak source organization | Governance steward and source owner | Context readiness gaps, cleanup plan, narrower source proposal |
| Pilot feedback includes unsafe, misleading, overconfident, or source-missing output | Agent owner and reviewer | Prompt/input, output, expected behavior, source evidence, severity, remediation action |
| Proposed promotion expands audience beyond the initial team | Reviewer/manager and governance steward | Pilot metrics summary, issue log, source freshness check, expansion rationale |

## Pilot Decision Rules

- `Approved` means the workflow can proceed within the named pilot audience and guardrails.
- `Prohibited` means the workflow cannot be handled by the pilot agent, even as a convenience.
- `Escalate` means the workflow may be possible later, but only after a named owner accepts the risk, approval path, and evidence requirements.

When in doubt, classify as `Escalate` and keep the agent draft-only until review is complete.

## Human-Owned Decisions

Agents can summarize evidence and draft recommendations, but humans own:

- final approval or rejection of an agent
- Jira issue creation, transition, assignment, ranking, or comment publication
- Confluence page publication or archival action
- Studio configuration save, access, visibility, manager, or tool changes
- release readiness or go/no-go decisions
- legal, compliance, security, privacy, or personnel decisions
- team or org-wide rollout decisions
