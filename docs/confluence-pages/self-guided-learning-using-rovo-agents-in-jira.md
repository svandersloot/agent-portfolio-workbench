# Self-Guided Learning - Using Rovo Agents in Jira

Use this page when you want to practice using ROVO agents from Jira without a live trainer.

This lab is for everyday users, QA users, leads, and AI champions. It focuses on safe Jira-centered use: choosing the right entry point, giving useful context, checking what the agent used, reviewing draft output, and routing gaps through the right human path.

Plan for 30 to 45 minutes. Use a safe Jira story that is appropriate for training and does not contain sensitive, regulated, customer-private, or confidential data.

## What You Will Learn

By the end, you should be able to:

- Choose between Ask Rovo, direct agent chat, and attached or assigned agent workflows.
- Understand where context may come from in Jira and Rovo Chat.
- Ask an agent to separate confirmed facts from assumptions.
- Review draft output before using it.
- Treat missing-context flags as useful next-action checklists.
- Use QA Test Strategy Planner for draft QA planning feedback while keeping human review and approval boundaries clear.
- Route agent gaps, new ideas, or improvement requests through leads, AI champions, and the ROVO Design Agent.

## Before You Start

Use a safe Jira story and keep the training run read-only.

- Do not use sensitive, regulated, customer-private, or confidential data.
- Do not post agent output back to Jira unless a human reviews and approves it first.
- Do not ask the agent to update Jira, change status, assign work, create comments, publish pages, or make release or QA approval decisions.
- Treat agent output as draft help, not approval.
- If the agent does not have enough context, ask it to name the gap instead of guessing.
- If the UI behavior differs from these steps, follow your team guidance and record what changed.

## Entry Points To Compare

| Entry point | Best for | What to check |
|---|---|---|
| Ask Rovo from an open Jira story | Quick summaries, questions, and first-pass gap checks. | Whether it used the current story, which fields it could inspect, and what it assumed. |
| Direct chat with a named agent | Agent-specific help when you know which available named agent to use. | Whether you need to paste a safe summary, add a Smart Link, or provide more source context. |
| Attached, assigned, or mentioned agent on a Jira work item | Ticket-centered workflows when that surface is enabled and approved for the agent. | Beta behavior, output visibility, automatic context, and whether sharing is user-controlled. |

## Exercise 1: Ask Rovo From An Open Jira Story

Goal: Learn what Rovo can do when you start from the Jira story you are viewing.

Steps:

1. Open a safe Jira story.
2. Start Ask Rovo from the available Jira entry point.
3. Use this prompt:

```text
Summarize this work item in five bullets and list the top missing details for QA planning.

Separate what you can confirm from this work item from anything you are assuming.
```

4. Ask this follow-up:

```text
What source context did you use for that answer? Please separate summary, description, comments, attachments, linked work items, linked pages, and anything you could not access or verify.
```

Record what happened:

- Did it understand "this work item"?
- Which fields, comments, links, or attachments did it say it used?
- Did it separate confirmed details from assumptions?
- What would a human need to check before using the answer?

Training takeaway: Ask Rovo can be useful for quick discovery, but the best habit is to ask what context it used and what it could not verify.

## Exercise 2: Chat With A Named Agent

Goal: Compare direct agent chat with Jira work-item context.

Choose one named agent that matches the story and your allowed access:

| Agent | Use when | Notes |
|---|---|---|
| Jira Work Item Assistant | You want help improving, reviewing, or drafting Jira work item content. | Keep output draft-only and review before copying anything into Jira. |
| QA Test Strategy Planner | You want QA strategy, test planning, readiness, or missing-context guidance. | Use the output as draft planning feedback, not final QA coverage or approval. |
| ROVO Design Agent | You are not sure whether the workflow needs an existing agent, improved agent, prompt, automation, template, or new agent. | Exercise 5 focuses on this route. |

Steps:

1. Open direct Rovo Chat with one named agent from the table above.
2. First ask without a story link:

```text
I need QA planning help for a Jira story. What information do you need from me before you can give useful QA strategy guidance?
```

3. Then ask again with a safe story summary or Smart Link:

```text
Using this Jira story as the source: [paste safe summary or Smart Link]

Help identify QA strategy considerations, missing acceptance criteria, test data needs, automation candidates, and risks that should be reviewed by a human.

Separate confirmed story details from assumptions.
```

4. Ask this follow-up:

```text
How did the Smart Link or pasted story context change your answer compared with the first response?
```

Record what happened:

- Did direct chat ask for better context?
- Did the safe story summary or Smart Link improve the answer?
- What should users include when they start from chat instead of from the ticket?

Training takeaway: Direct agent chat may need an explicit source packet before it can provide useful Jira-specific guidance.

## Exercise 3: Attach, Assign, Or Mention An Agent On A Jira Work Item

Goal: Learn how adding a named agent to a Jira story behaves when the Jira agent surface is enabled for your pilot or team.

Only do this exercise when your lead, AI champion, or agent owner has confirmed that the workflow is available and safe for the training story. Jira work-item collaboration with agents may be beta or tenant-specific.

For a general work-item exercise, use Jira Work Item Assistant if it is available for the training story. For a QA-focused exercise, use QA Test Strategy Planner.

Steps:

1. Use a safe story where the agent surface is approved for testing.
2. On the Jira story, click `Agents`.
3. If you do not see the button near the main story controls, scroll lower on the story. Look for the `Agents` section near the linked work items or web links area, above the comments.
4. In the `Agents` section, use `Start work`, open the agent dropdown, and select the named agent for the exercise.
5. Observe what Jira does after you select the agent: whether it opens a panel, starts a thread, suggests a starter prompt, or asks for a scoped request.
6. Do not share the output as a Jira comment or attachment unless a human explicitly approves it.
7. Use this prompt or scoped request:

```text
Please review this work item for QA planning readiness. Identify confirmed context, missing acceptance criteria, test data needs, automation candidates, risks, and the human confirmations still required.
```

8. Ask this follow-up:

```text
What automatic context did you receive because you were added to this work item? Please separate confirmed fields from assumptions and unavailable sources.
```

Record what happened:

- Did the UI provide a starter prompt, agent panel, comment flow, or chat thread?
- Was the output private until you shared it?
- Did the agent use summary, description, comments, attachments, or linked work items?
- Was it better, worse, or just different from Ask Rovo on the open story?

Training takeaway: Attached or assigned agent workflows can provide helpful ticket-centered structure, but users must verify context, visibility, and sharing behavior before relying on the output.

## Exercise 4: QA Planning Example

Goal: Practice draft QA planning with clear human-review guardrails.

Use QA Test Strategy Planner when you want structured QA strategy, test planning, readiness, or missing-context feedback from a safe Jira story. The output is draft planning guidance only. QA approval, final test coverage, release readiness, and Jira updates remain human-owned.

Steps:

1. Open a safe QA story.
2. Start from the most context-aware approved entry point available to the pilot user.
3. Use this prompt:

```text
Using this Jira story as the source, identify what QA planning can safely start now and what must remain TBD.

Pay special attention to missing acceptance criteria, environment, state scope, mapping documents, test data, automation suite location, linked evidence, and human confirmations.

Do not create final QA coverage. Provide draft planning guidance only.
```

4. Ask this follow-up prompt:

```text
Label the confirmed story details, assumptions, unavailable sources, and human confirmations still required before anyone uses this as QA planning input.
```

5. Read the output against this checklist. Do not copy the table into the agent unless you want to use it as a review aid.

Human confirmation checklist:

| Item | Confirm before using the output |
|---|---|
| Environment | Is the target environment known or still TBD? |
| State scope | Which state, region, product, or scenario scope is in or out of scope? |
| Mapping source | Is there a current mapping document, and is it the right source? |
| Test data | What data is needed, who can provide it, and whether it is safe to use? |
| Automation | Where the automation suite lives, if automation is being discussed. |
| Acceptance criteria | Whether acceptance criteria are complete enough for QA planning. |
| Linked evidence | Whether comments, attachments, linked work items, or linked pages were actually considered. |

Example draft output label:

```text
Example draft output only. Not approved QA coverage. Requires QA, product, and engineering review before use.
```

Training takeaway: Missing-context flags are useful. They show what QA, product, engineering, or delivery leads still need to confirm before planning can move forward.

## Useful Follow-Up Prompts

Use these prompts after any exercise to understand how the agent reached its answer and what to do next.

### Context Check

```text
What source context did you use for this answer?

Please separate Jira summary, description, comments, attachments, linked work items, linked pages, Smart Links, pasted context, and anything you could not access or verify.
```

### Confirmed Facts And Assumptions

```text
Separate your answer into confirmed facts, reasonable assumptions, missing information, and human confirmations still required.

Do not treat assumptions as facts.
```

### Workflow Fit

```text
Is this the right ROVO entry point for my request: Ask Rovo, direct agent chat, Agents button / Start work, or the ROVO Design Agent?

Explain what would work better if I started from a different entry point.
```

### Better Next Prompt

```text
Based on the context you have and the gaps you found, suggest the next prompt I should ask.

Keep it focused, safe, and specific to this Jira story.
```

### Compare Entry Points

```text
Compare the results I got from Ask Rovo, direct agent chat, and the Agents button / Start work flow.

Which entry point seemed to have the best Jira story context, which needed the most context from me, and which is best for the next step?

Separate observed behavior from assumptions.
```

### Human Review Checklist

```text
Before I use this output, what should a human review, verify, or decide?

Call out anything related to QA approval, Jira updates, release readiness, ownership, sensitive data, or missing source context.
```

## Exercise 5: Request Or Improve An Agent

Goal: Practice routing a gap without assuming a new agent should be built.

Use this when an agent is not useful, does not fit your workflow, or gives confusing, incomplete, stale, or overconfident output.

Steps:

1. Describe the workflow problem, not the desired agent.
2. Bring the request to your lead or AI champion when possible.
3. Use the ROVO Design Agent with this prompt. The Design Agent should use the Agent Fit Intake as part of its governed routing instructions.

```text
I have this workflow problem: [describe the problem].

Help me decide whether this should use an existing agent, improve an existing agent, use a prompt, use automation, become a Confluence template, become an agent candidate, become a new governed agent, or be marked not ready.

Ask only the intake questions needed to choose the next route.
```

4. Ask this follow-up:

```text
Based on what I gave you, what existing agents or documentation should be checked before anyone builds something new?
```

Record what happened:

- Did the route look like reuse, improvement, prompt, automation, template, candidate, new agent, or not ready?
- What existing agents or pages did it recommend checking?
- What ownership, source, permission, or measurement gaps remained?

Training takeaway: Bring the problem, not the proposed solution. The Design Agent path helps choose the lightest useful route and slows down risky requests such as Jira writes, broad automation, or unapproved visibility changes.

## Capture Your Takeaway

After the exercises, use this prompt to gather the reflection details in one pass:

```text
I just completed a self-guided ROVO learning lab from a safe Jira story.

Help me summarize what happened so I can review the results with my lead or AI champion.

For each exercise or entry point I tried, capture:
- Entry point used: Ask Rovo, direct agent chat, Agents button / Start work, @mention, or other.
- Agent used: agent name, or general Rovo Chat.
- Prompt or starter text used.
- Source context used or claimed: story summary, description, comments, attachments, linked work items, linked pages, Smart Link, pasted safe summary, or unknown.
- Output quality: accepted, edited, rejected, or not usable.
- Human fix needed: what I had to verify, correct, add, or remove.
- Training takeaway: when this route is useful and what users should watch for.

Separate confirmed observations from my assumptions. Do not treat agent output as approval.
```

## What To Do Next

- If the output was useful, keep using the same safe habit: scoped context, confirmed facts, assumptions, and human review.
- If the output was incomplete, ask what context was missing and whether the agent could access the source.
- If the output was wrong or unsafe, do not use it. Capture the issue and route it through your lead, AI champion, or the agent owner.
- If no available named agent fits the workflow, use `Request or Improve an Agent` and the ROVO Design Agent intake path.
- If the workflow needs Jira writes, Confluence publishing, Studio configuration, broad visibility, approval, release readiness, or QA sign-off, stop and route to the human-owned decision path.
