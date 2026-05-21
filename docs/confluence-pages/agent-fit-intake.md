# Agent Fit Intake

Use this intake before creating a new ROVO agent. The goal is to help builders choose the lightest useful solution, avoid duplicate agents, and make governance explicit before Studio configuration starts.

The first step for most requests is to use the ROVO Design Agent. The Design Agent is the front door for agent governance: it should guide the builder through this intake, check the governance docs and Agent Inventory, and scaffold documentation only when the idea is durable enough.

## Possible Outcomes

The intake can recommend:

- Use a better prompt.
- Use an automation.
- Extend an existing agent.
- Use or create a Confluence template.
- Mark as an agent candidate for further discovery.
- Create a new governed agent.
- Mark the idea as not ready.

The Design Agent is allowed to recommend not building an agent.

## Design Agent Intake Flow

The Design Agent should run this sequence before recommending any new governed agent.

| Step | Design Agent Action | Required Evidence |
|---|---|---|
| 1 | Restate the request as a workflow problem, not an agent request. | Problem, audience, trigger, expected output |
| 2 | Check whether a better prompt or default ROVO behavior is enough. | One-time or low-repeat need, no durable ownership or source dependency |
| 3 | Check whether an automation, scheduled reminder, or workflow rule is the better fit. | Repeatable trigger, deterministic steps, low need for conversational judgment |
| 4 | Check `Agent Inventory` and related Project Brains for reuse or extension. | Existing agents, overlaps, owner to consult, extension candidate |
| 5 | Check whether a Confluence template or source cleanup would solve the need. | Missing structure, repeated document pattern, source readiness gaps |
| 6 | Check whether the idea is an agent candidate that needs further discovery before governed build. | Unclear scope, audience, ownership, workflow boundaries, or governance path |
| 7 | If a new governed agent still appears justified, collect the completeness contract fields. | Owner, backup owner, status, purpose, audience, sources, tools, measurement, readiness, Project Brain, last-reviewed date |
| 8 | If required fields or source readiness are missing, keep the idea in `Idea` and recommend discovery or remediation. | Missing fields, unresolved risk, unclear owner, duplicate risk, or unready context |

## Routing Rules

| Recommendation | Use When | Do Not Use When |
|---|---|---|
| Prompt | The need is narrow, individual, or one-time; the user can get value from a reusable prompt pattern. | The workflow needs ongoing ownership, scoped knowledge, auditability, or shared launch support. |
| Automation | The workflow is repeatable, event-based, scheduled, or mostly deterministic. | The work requires exploratory reasoning, judgment, or interactive clarification. |
| Existing-agent extension | A governed agent already serves the same audience, domain, source set, or workflow family. | The extension would broaden scope beyond the owner, risk model, or intended audience without review. |
| Confluence template | The real gap is inconsistent source material, meeting notes, Project Brain structure, or review evidence. | Users need a conversational workflow, tool use, or cross-source reasoning. |
| Agent candidate | The need appears agent-shaped but needs more discovery before it can become a governed agent recommendation. | The idea is already ready for a specific route such as prompt, automation, template, extension, new governed agent, or not ready. |
| New governed agent | The workflow is repeatable, shared, valuable, source-backed, measurable, and has an accountable owner. | Required fields are missing, context is not ready, a duplicate exists, or the risk cannot be controlled. |
| Not ready | Ownership, sources, permissions, measurement, or problem framing are unclear. | The missing information can be resolved immediately during intake. |

## Intake Questions

### Problem

- What problem are you trying to solve?
- What happens today without this agent?
- Is this a repeatable workflow or a one-time need?

### Audience

- Who will use this?
- Is the audience a team, department, role, or broader group?
- Should access or discoverability be limited while the idea is draft or experimental?

### Existing Options

- What existing agents have you checked?
- What Confluence pages, templates, automations, or prompts have you checked?
- Could an existing agent be extended instead of creating a new one?

### Context

- What knowledge sources would the agent need?
- Are those sources stable, current, and appropriate for the audience?
- Are there context gaps that would make the agent unreliable?

### Actions And Risk

- What tools, skills, or actions would the agent need?
- Could the agent affect Jira, Confluence, code, customer data, releases, or operational work?
- What would make the agent unsafe or not ready?

### Ownership

- Who owns the agent?
- Who is the backup owner?
- Who will maintain the Project Brain and review changes?

### Measurement

- What outcome should improve?
- How will success be measured?
- What baseline or comparison exists today?

## Minimum Information For Project Brain Scaffolding

Before a Project Brain is scaffolded, collect at least:

- Problem statement
- Intended users or audience
- Owner
- Backup owner, or a note that one is needed
- Proposed status
- Existing agents or pages checked
- Knowledge sources needed
- Tools, skills, or actions needed
- Measurement idea
- Readiness risks or unknowns

If these fields are not known, keep the request in `Idea` status and continue discovery before building.

## Governance Completeness Fields

Every governed agent should have these fields before it moves beyond `Draft`.

| Field | Required Content |
|---|---|
| Owner | Named primary accountable owner or owning team. |
| Backup owner | Named backup owner, delegate, or explicit gap with remediation owner. |
| Status | One lifecycle status from the policy below. |
| Purpose | Plain-language reason the agent exists and what outcome it supports. |
| Audience | Intended users, team, role, or group, including any discoverability limits. |
| Knowledge sources | Named source pages, spaces, Jira projects, filters, or other approved sources. |
| Tools or skills | Tools, skills, actions, and risk tier, including whether human approval is required. |
| Measurement plan | Value signal, baseline or estimate method, quality/risk signal, and review cadence. |
| Readiness status | Ready, Needs Cleanup, or Not Ready, with source readiness evidence. |
| Project Brain link | Link to the source-of-truth Project Brain or scaffold. |
| Last-reviewed date | Date of the last owner, reviewer, or working-group review. |

## Lifecycle Statuses

| Status | Meaning | Entry Criteria | Exit Criteria |
|---|---|---|---|
| Idea | Proposed need or use case; not yet shaped. | Intake started or problem identified. | Fit route chosen, or discovery/remediation action created. |
| Draft | Early design or Project Brain scaffold exists. | Owner or temporary steward identified; initial purpose, audience, sources, and risks captured. | Completeness fields are ready for review, or idea returns to `Idea`/`Not ready`. |
| In Review | Being checked by the working group, Doc Steward, or designated approvers. | Draft package includes completeness fields, inventory check, readiness status, and measurement plan. | Approved for `Experimental` or `Active`, or moved to `Needs Remediation`. |
| Experimental | Available for sandbox or pilot use, not broadly discoverable as an approved agent. | Pilot audience, owner, guardrails, and feedback channel are defined. | Evidence supports `Active`, or gaps move it to `Needs Remediation` or `Deprecated`. |
| Active | Approved for intended use and discoverable to the right audience. | Governance completeness passes, risk controls are accepted, and reviewer/space maintainer approval is recorded. | Periodic review keeps it active, or gaps move it to `Needs Remediation` or `Deprecated`. |
| Needs Remediation | Usable only with tracked fixes, or paused until gaps are addressed. | Review found missing ownership, stale sources, unsafe tools, duplicate risk, failed evaluation, or missing measurement. | Remediation is complete and reviewed, or agent is deprecated. |
| Deprecated | Replaced, retired, or no longer recommended. | Better solution exists, usage/value ended, risk is unacceptable, or owner retires it. | Inventory, Project Brain, and user-facing docs clearly point to replacement or retirement notes. |

Only the space maintainer and Atlassian admins should mark an agent as Active or Ready in the first operating model.

Experimental agents should be visible only to a select audience. Investigate Studio team assignment and discoverability controls before relying on this as a hard control.
