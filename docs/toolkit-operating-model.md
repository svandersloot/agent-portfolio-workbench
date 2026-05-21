# Toolkit Operating Model

This toolkit exists to make ROVO agent governance repeatable without turning agent building into a bottleneck.

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

Every governed ROVO agent should have:

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

The toolkit should help turn informal requests into structured governance artifacts:

1. Capture the agent idea.
2. Check whether it should be a prompt, automation, existing-agent extension, or governed agent.
3. Search the inventory for duplicates.
4. Create or update a Project Brain when the idea is durable enough.
5. Record owner, status, measurement, context readiness, and launch evidence.
6. Publish or report updates through dry-run-first tooling.

## Reporting Direction

Human-facing reports should eventually answer:

- What new agents or agent ideas appeared?
- Which agents are ready, blocked, experimental, or duplicate candidates?
- Which agents are missing required governance fields?
- Which pages changed this week?
- Which governance content is stale or unlinked?
- What should builders reuse before creating something new?
