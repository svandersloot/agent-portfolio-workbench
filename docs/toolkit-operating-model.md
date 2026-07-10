# Agent Portfolio Workbench Operating Model

Agent Portfolio Workbench exists to make agent portfolio governance repeatable without turning agent building into a bottleneck. The current implementation is Rovo-first, but the operating model is intended to work across runtimes.

The current Atlassian reality is:

- ROVO Studio is where agents are built and changed.
- Confluence is the only practical shared context layer for builders, reviewers, leaders, and ROVO agents.
- Studio does not yet provide enough version control for durable governance.
- Git provides the local audit trail for source drafts, scripts, manifests, and publish history.

## Direction

Build toward a governance operating system, sequenced deliberately:

1. Publishing confidence
2. Space health checks
3. Agent governance completeness checks
4. Human-facing reporting and dashboard output

The toolkit should eventually help publish, audit, maintain, and report on the governance space. It should not rush into brittle Studio write-back or broad automation before the dry-run, history, and verification loops are reliable.

## Source Of Truth

Use Git-backed source files for core durable governance pages first, with the option to expand page by page.

Current Git-backed page set:

- `Space Structure and Navigation`
- `Governance and Safety`
- `Measurement and Value Tracking`
- `Context Readiness Checklist`
- `User Guide - Designing Agents`

Other Confluence pages can remain Confluence-authored until they become durable enough to justify repo-backed publishing.

## Inventory Model

Use a hybrid inventory model:

- Confluence remains the human-readable place people discover agents.
- A future structured local inventory file should become the checkable source for non-negotiable fields.
- Publishing can later update the Confluence inventory from that structured source.

The current read-only evidence suggests:

- `Agent Inventory` is the likely canonical inventory page.
- `Rovo Agent Inventory Home` is the space overview/root.

## Non-Negotiable Agent Fields

Every governed agent should have:

- Agent name
- Owner
- Backup owner
- Status
- Purpose
- Audience
- Knowledge sources
- Tools or skills
- Measurement plan
- Readiness status
- Project Brain link
- Last reviewed date

These fields are the starting contract for future linting, reporting, and builder guidance.

## Agent Lifecycle Statuses

Use these starting statuses for governed ROVO agents and agent ideas:

- `Idea`: proposed need or use case; not yet shaped.
- `Draft`: early design or Project Brain scaffold exists.
- `In Review`: being checked by the working group, Doc Steward, or designated approvers.
- `Experimental`: available for sandbox or pilot use, not broadly discoverable as an approved agent.
- `Active`: approved for intended use and discoverable to the right audience.
- `Needs Remediation`: usable only with tracked fixes, or paused until gaps are addressed.
- `Deprecated`: replaced, retired, or no longer recommended.

Only the space maintainer and Atlassian admins should be able to mark an agent as `Active` or broadly `Ready` in the first operating model. The exact Studio control model still needs investigation, including whether team assignment can reduce discoverability for draft or experimental agents.

Experimental agents should be visible only to a select audience. If Studio team assignment can limit discoverability, use that for `Draft`, `In Review`, and `Experimental` agents until they are approved.

## Success Measures

Success should be measured by whether governance work becomes easier, faster, and more trustworthy.

Primary measures:

- Time to publish or update a governance page drops from manual editing to a reviewed command.
- The toolkit can answer what changed, when it changed, which page changed, and which source file drove the change.
- ROVO agents consistently have a Project Brain, owner, status, measurement plan, and readiness evidence.
- Builders can find existing agents before creating duplicate work.
- The Confluence structure stays useful as context for both humans and ROVO agents.

Secondary measures:

- Fewer duplicate agent ideas move forward without an inventory check.
- Fewer pages have unclear canonical ownership.
- Leadership can see that agent governance exists and is improving.
- Builders can follow the process without the space maintainer reviewing every agent personally.

## Day-To-Day Operating Assumptions

Current intake is informal and often chat-driven. The near-term process should support that reality instead of pretending Jira or formal intake already exists.

The first response to a new agent idea should usually be: use the ROVO Design Agent. The Design Agent should guide the builder to the Confluence governance docs, scaffold the documentation, and decide whether the need should be a prompt, automation, existing-agent extension, Confluence template, agent candidate, new governed agent, or not ready yet.

The Design Agent is allowed to recommend "do not build an agent" when the need is better served by a prompt, automation, existing page/template, existing agent, agent-candidate discovery path, or no durable solution yet.

The toolkit should help turn informal requests into structured governance artifacts:

1. Capture the agent idea.
2. Route the builder through the ROVO Design Agent or Agent Fit Intake.
3. Check whether it should be a prompt, automation, existing-agent extension, Confluence template, agent candidate, new governed agent, or not ready yet.
4. Search the inventory for duplicates.
5. Create or update a Project Brain when the idea is durable enough.
6. Record owner, status, measurement, context readiness, and launch evidence.
7. Publish or report updates through dry-run-first tooling.

## Workbench-To-Runtime Handoff

Use this repo and Codex as the builder workbench for technical builders who can move faster in Git-backed artifacts than in ROVO Studio.

ROVO remains the Atlassian-facing runtime and shared user experience. Codex should not write to Studio. Instead, Codex prepares the governed agent package, Confluence pages, and Studio copy blocks so the builder can manually configure ROVO Studio.

Use this pattern when:

- A builder wants to brainstorm or shape a personal or team agent quickly.
- The agent needs governed documentation before broader Atlassian access.
- The work benefits from local diffs, schema checks, reusable templates, and dry-run publishing.
- Less-technical users should eventually use the agent through Atlassian rather than this repo.

Pipeline:

1. Brainstorm the idea in Codex.
2. Route through Agent Fit Intake.
3. Check Agent Inventory for reuse or extension.
4. Generate or update the Project Brain, Agent Design Record, Knowledge Source Plan, Evaluation, Measurement Plan, and ROVO Studio Configuration copy blocks.
5. Dry-run and publish approved Confluence documentation.
6. Manually copy the configuration into ROVO Studio.
7. Capture the Studio configuration back into this repo for version control and drift review.

This pattern is especially useful for personal agents and early prototypes. Before broad launch, the agent still needs the normal ownership, backup owner, readiness, measurement, and review evidence.

## Agent Fit Intake

Create a lightweight Agent Fit Intake so builders can answer enough questions to avoid duplicate or unnecessary agents before they build.

The intake should ask:

- What problem are you trying to solve?
- Who is the audience?
- Is this a repeatable workflow or a one-time need?
- Could this be a better prompt, automation, existing-agent extension, or Confluence template?
- What existing agents or pages have you checked?
- What knowledge sources would the agent need?
- What actions, tools, or permissions would it need?
- Who owns the agent and who is the backup?
- How will success be measured?
- What would make the agent unsafe or not ready?

The intake should feed the Design Agent, inventory check, Project Brain scaffold, and future governance reports.

Minimum information before scaffolding a Project Brain:

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

If these fields are not known, the idea can remain `Idea` status, but it should not be treated as ready for build.

## Reporting Direction

Human-facing reports should eventually answer:

- What new agents or agent ideas appeared?
- Which agents are ready, blocked, experimental, or duplicate candidates?
- Which agents are missing required governance fields?
- Which pages changed this week?
- Which governance content is stale or unlinked?
- What should builders reuse before creating something new?

Start with a monthly governance snapshot for leadership and interested builders. The report should summarize what changed, what exists, what is ready, what is experimental, what is missing required fields, and which duplicate candidates or reuse opportunities were found.
