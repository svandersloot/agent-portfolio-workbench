# User Guide - Designing Agents

## Who This Guide Is For

Use this guide if you have an idea for a ROVO agent, automation, prompt, or workflow improvement and need help choosing the right-sized solution.

This guide is for builders, agent owners, reviewers, and working group members. It is intentionally biased toward reuse, clear source context, and lightweight governance.

## Before You Start

You should be able to describe:

- The workflow you want to improve.
- Who uses the workflow.
- Where the source information lives.
- Who owns the process or source data.
- What success would look like.
- What could go wrong if the agent gives incomplete, stale, or overconfident guidance.

## Step 1: Start With Fit Triage

Start with `Agent Fit Intake`, preferably through the ROVO Design Agent.

The best outcome may be:

- Prompt
- Automation
- Existing-agent extension
- Confluence template
- App candidate
- New governed agent
- Not ready

Creating a new agent is only one valid outcome. A prompt, automation, Confluence template, app candidate, or extension of an existing agent may be the better governed solution.

## Step 2: Check Existing Agents And Patterns

Review `Agent Inventory` before proposing a new agent.

Look for:

- An existing agent with a similar purpose.
- A broad agent that can support the workflow with a team overlay.
- A reusable pattern in the Pattern Library.
- A Project Brain with relevant source context.
- A similar evaluation or ADR.

If an existing agent can be extended safely, prefer extension over creating another agent.

## Step 3: Check Context Readiness

Use `Context Readiness Checklist`.

Do not build an agent on top of unclear, stale, duplicated, restricted, or ownerless documentation. If the context is not ready, create cleanup actions before designing the agent.

Common context blockers:

- Multiple pages claim to be the source of truth.
- Source pages have no owner.
- Key workflow steps are tribal knowledge.
- Jira fields or statuses are inconsistent.
- Permissions are unclear.
- The agent would need broad all-space access to compensate for poor organization.

## Step 4: Create Or Update Design Artifacts

For durable agent work, create or update:

- Agent Design Record.
- Project Brain.
- Knowledge Source Plan.
- Subagent Settings.
- ROVO Studio Configuration.
- Evaluation.
- Measurement plan.
- Readiness status.
- Change Log.

Small experiments may not need the full artifact set, but durable agents need enough documentation for another owner to review, maintain, and retire the agent later.

## Step 5: Review Governance

Use `Agent Governance Review Template`.

The review should confirm:

- Owner and backup owner.
- Purpose and audience.
- Scoped knowledge sources.
- Tools or skills with risk notes.
- Documented permissions.
- Human-in-the-loop controls for risky actions.
- Evaluation coverage.
- Measurement plan.
- Project Brain link and last-reviewed date.
- Change and retirement process.

High-risk or write-capable workflows require explicit guardrails and approval language before launch.

## Step 6: Launch And Measure

After launch:

- Track adoption.
- Estimate time saved.
- Capture quality and rework signals.
- Review user feedback.
- Update source docs and Studio configuration when the workflow changes.
- Re-run governance review after major changes.

Use `Measurement and Value Tracking` to keep the portfolio reviewable.

## Common Mistakes

- Starting with `New governed agent` before checking inventory.
- Creating a team-specific agent when a broad agent plus overlay would work.
- Giving broad knowledge access without justification.
- Skipping source ownership.
- Skipping evaluation.
- Treating measurement as optional.
- Letting Studio configuration drift from Confluence documentation.
- Designing around stale documentation instead of fixing the source.

## Builder Checklist

| Question | Answer |
|---|---|
| What workflow are you improving? | TBD |
| Who uses it? | TBD |
| What is the source of truth? | TBD |
| Who owns the source? | TBD |
| Did you check existing agents? | Yes / No |
| Did you complete context readiness? | Ready / Needs Cleanup / Not Ready |
| What is the fit decision? | TBD |
| What value signal will be measured? | TBD |
| What risk needs a guardrail? | TBD |

## Handoff

When the design is ready for documentation infrastructure, use this handoff:

`Your next step is to engage the Agent Doc Steward to build your infrastructure in Confluence.`
