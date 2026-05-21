# Agent Fit Intake

Use this intake before creating a new ROVO agent. The goal is to help builders choose the lightest useful solution and avoid duplicate or unnecessary agents.

The first step for most requests is to use the ROVO Design Agent. The Design Agent should guide the builder through this intake, check the governance docs, and scaffold documentation when the idea is durable enough.

## Possible Outcomes

The intake can recommend:

- Use a better prompt.
- Use an automation.
- Use an existing agent.
- Extend an existing agent.
- Use or create a Confluence template.
- Create a new governed agent.
- Consider an app or Forge candidate.
- Mark the idea as not ready.

The Design Agent is allowed to recommend not building an agent.

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

## Lifecycle Statuses

| Status | Meaning |
|---|---|
| Idea | Proposed need or use case; not yet shaped. |
| Draft | Early design or Project Brain scaffold exists. |
| In Review | Being checked by the working group, Doc Steward, or designated approvers. |
| Experimental | Available for sandbox or pilot use, not broadly discoverable as an approved agent. |
| Active | Approved for intended use and discoverable to the right audience. |
| Needs Remediation | Usable only with tracked fixes, or paused until gaps are addressed. |
| Deprecated | Replaced, retired, or no longer recommended. |

Only the space maintainer and Atlassian admins should mark an agent as Active or Ready in the first operating model.

Experimental agents should be visible only to a select audience. Investigate Studio team assignment and discoverability controls before relying on this as a hard control.
