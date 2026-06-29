# Rovo Training Session Script Draft

## Purpose

Use this draft to run the first fast-but-not-firehose Rovo training cycle. The training is current-state and Rovo-only. It does not assume Claude Code, Rovo Dev, Agent Lab, or any other approved advanced AI development workbench.

The goal is to get users, leads, and AI champions comfortable with:

- finding approved or pilot-only Rovo agents
- understanding where context comes from
- using agents safely inside Jira and Rovo Chat
- routing feedback or improvement requests through leads, AI champions, and the Rovo Design Agent intake flow

## Source Notes

Atlassian's current documentation says:

- Rovo Chat is available from Jira, Jira Service Management, Jira Product Discovery, Confluence, and Bitbucket Cloud.
- Users can open Rovo Chat from the Rovo button, Ask Rovo in the top navigation, `/ai` or `/rovo`, or the browser extension.
- A custom prompt can include context such as uploaded files, @mentions, Smart Links, spaces, pull requests, or the content currently being viewed, including "this page", "this work item", or "this pull request".
- Rovo agents can be used through Chat, but agent output quality depends on instructions, knowledge sources, user access, and the probabilistic nature of LLMs.
- Jira work-item collaboration with agents is currently documented as beta. Agents can be added to work items through assignee, @mention, workflow transitions, or board columns when enabled.
- When an agent is assigned to a work item, Atlassian documents that it uses the work item's summary and description and may use comments and attachments for context.

Treat any specific UI behavior in our tenant as something to verify live before presenting it as settled fact.

## Session Plan

Run three sessions plus one optional office hour.

| Session | Length | Audience | Outcome |
|---|---:|---|---|
| 1. Use Rovo Agents Safely | 60 min | Everyone | Users can open Rovo, understand context, use approved or pilot-only agents, and review outputs safely. |
| 2. Request Or Improve An Agent | 75 min | Users, leads, AI champions | Users know what to do when an existing agent does not fit. Leads/champions can route through Rovo Design Agent intake. |
| 3. Audience-Specific Lab | 75 min | QA, leads, champions, or another target group | Learners practice against their real workflow with the right approved or pilot-only agent. |
| Optional Office Hour | 30 min | Anyone | Capture questions, feedback, and pilot improvement data. |

## Session 1: Use Rovo Agents Safely

### Trainer Goal

Do not make everyone feel like they are learning to build agents. This session is about safe use, context, review, and feedback.

### Opening Script

Today is about using the Rovo flow we have now. We are not training on Claude Code, Rovo Dev, or an advanced agent workbench. Those are future maturity paths. For this first round, the goal is simpler: know how to find the right Rovo agent, give it the right context, review what it gives back, and know where to send feedback when it does not help.

### Key Points

- Rovo is most useful when it has clear context.
- Context can come from the open Jira work item, a page, a Smart Link, an uploaded file, an @mention, a named space, or a specific prompt.
- An agent response is draft help, not final approval.
- Some Rovo features are general chat. Some are agent-specific. Some are work-item collaboration in Jira.
- Work-item collaboration appears to give the agent stronger starting context because the agent is attached to the ticket workflow.

### Demo Flow

1. Open a Jira story.
2. Show the Rovo button or Ask Rovo entry point.
3. Ask a basic question using the open ticket as context:

   ```text
   Summarize this work item and list what information is missing for QA planning.
   ```

4. Explain what context you believe Rovo is using, and mark this as a live behavior to verify:

   ```text
   We expect Rovo to understand "this work item" because the chat is opened while the ticket is in view, but we should verify what fields it actually uses.
   ```

5. If available, add or assign the pilot agent to the work item and compare the output:

   ```text
   Use QA Test Strategy Planner to identify likely test strategy considerations for this story.
   ```

6. Compare the two routes:

| Route | Best For | What To Watch |
|---|---|---|
| Ask Rovo from open ticket | Quick questions and lightweight summaries | May need explicit instructions to use "this work item" and named sources. |
| Chat directly with a named agent | Agent-specific help when you know which agent to use | May need you to paste or link the ticket/page context. |
| Add/assign agent to work item | Ticket-centered tasks and repeatable agent collaboration | Beta behavior; verify permissions, context used, output visibility, and sharing steps. |

### Training Guide: Using The Jira Work Item Assistant

When you attach an agent to a Jira story, you are doing more than starting a chat. You are starting a specialized assistant that is anchored to that specific work item.

#### 1. What happens when an agent is attached?

The agent starts from the Jira work item you are viewing. It may use the summary, description, visible comments, attachments, linked items, and other context it can access.

For the Jira Work Item Assistant, it may also retrieve relevant approved standards from Confluence so the draft aligns to the expected quality, deployment, or ticket-readiness rules.

#### 2. Why is the output so structured?

Unlike a general chat, the attached agent is designed to produce Jira-ready drafting support.

It uses structured formats, such as a draft bundle, so you can quickly see what is ready, what is missing, and what needs review.

It is intentionally opinionated. If required information is missing, such as a file path, artifact location, validation step, owner, or deployment detail, it should call that out instead of guessing.

#### 3. What should you review before copying?

The agent is a powerful drafter, but you are still the owner. Always check:

- Data Incomplete markers: fill in missing information before treating the ticket as ready.
- Inferred details: verify any educated guesses, such as system, deployment type, environment, or sequencing.
- Technical accuracy: confirm file names, repository paths, artifact locations, validation steps, and release details.
- Fit to intent: make sure the draft reflects what the team actually plans to do.

#### 4. When should you use Ask Rovo AI instead?

Use the attached agent when you want to create, improve, or check a Jira work item. It is best for drafting deployment notes, checking for gaps, aligning to standards, or turning rough ticket content into a clearer work item.

Use Ask Rovo AI when you want a more flexible conversation. For example:

- "Summarize the last several comments on this ticket."
- "What questions should I ask before grooming this story?"
- "Explain this project history."
- "Help me think through options before I update the ticket."

General chat is better for exploration. The attached agent is better for structured ticket work.

#### 5. Risks and limitations

- No automatic writes: during this pilot, the agent does not save changes directly to Jira. You must review and copy approved content yourself.
- Source-dependent: if the approved Confluence standard changes, the agent may produce different guidance after retrieving the updated source.
- Context limits: the agent only knows what it can access from Jira, linked sources, approved standards, and what you provide in chat. It does not know about offline decisions unless they are documented or you tell it.
- Human review required: the agent can draft and flag gaps, but it does not approve the work item.

#### Pro tip

If the agent says Data Incomplete, that is a good thing. It is preventing a low-quality ticket from moving forward.

Add the missing detail in the chat, then ask:

```text
Update the draft using this new information.
```

### Participant Exercise

Ask learners to use a safe sample Jira story and answer:

- What did Rovo know immediately?
- What did you have to clarify?
- Did it cite or name enough source context?
- Was the answer accepted, edited, rejected, or not usable?
- What feedback should we capture?

### Close

The most important habit is not "trust the agent." The habit is: give it scoped context, review the answer, and report what worked or failed.

## Session 2: Request Or Improve An Agent

### Trainer Goal

Teach the intake path without making it feel bureaucratic. "Agent Fit Intake" should be explained as "run the idea through the Rovo Design Agent."

### Opening Script

If an agent does not fit your need, the answer is not automatically "build a new agent." The current flow is to bring the workflow problem to a lead or AI champion and run it through the Rovo Design Agent. That intake helps decide whether the right answer is an existing agent, an improvement, a prompt, an automation, a template, an agent candidate, a new governed agent, or not ready yet.

### Key Points

- Start with the workflow problem.
- Check approved and pilot-only agents first.
- Improve or extend an existing agent before creating a new one.
- Leads and AI champions help with routing.
- Owners and reviewers still own approval, launch, visibility, and risky actions.

### Demo Flow

Use two or three real-ish examples:

1. "I need help planning QA for this story."
2. "I need a release summary from scattered Jira and Confluence evidence."
3. "I need an agent to rewrite all my tickets automatically."

For each one, ask the Rovo Design Agent:

```text
I have this workflow problem: [problem].
Please help me decide whether this should use an existing agent, improve an existing agent, use a prompt, use automation, become a template, become an agent candidate, become a new governed agent, or be marked not ready.
Ask only the intake questions needed to choose the next route.
```

### Expected Teaching Moment

- QA planning likely routes to QA Test Strategy Planner if the learner is in the pilot audience.
- Release summary may route to an existing release/change agent or a request for source readiness.
- Automatic ticket rewriting should be slowed down because Jira writes and broad automation need governed approval.

### Close

If you remember one sentence: bring the problem, not the solution. Rovo Design Agent helps choose the route.

## Session 3: Audience-Specific Lab

### Trainer Goal

Make the session match the audience instead of forcing one generic agent across everyone.

### QA-Heavy Audience

Use QA Test Strategy Planner as the primary pilot example.

Suggested lab:

```text
Using this Jira story as the source, help identify QA strategy considerations, missing acceptance criteria, test data needs, automation candidates, and risks that should be reviewed by a human.
```

Review questions:

- Did the agent use the ticket context correctly?
- Did it identify missing or ambiguous information?
- Did it avoid inventing requirements?
- Did it separate recommendations from decisions?
- What would Lisa Porter or the QA pilot audience need to know before using this output?

### Training Guide: Using QA Test Strategy Planner In Jira

Use this guide only for the named QA pilot audience. QA Test Strategy Planner is pilot-only, not a broadly approved agent for all users.

#### 1. When to use it

Use QA Test Strategy Planner when the team needs help thinking through QA strategy for a Jira story or related delivery item.

Good uses include:

- identifying QA strategy considerations
- finding missing or ambiguous acceptance criteria
- calling out test data needs
- separating manual test ideas from automation candidates
- preparing questions for QA, product, engineering, or delivery leads
- identifying risks that should be reviewed before test planning is treated as ready

Do not use it as the final approval source for QA coverage. The output is planning support and draft analysis only.

#### 2. Best Jira entry point

Start from the Jira work item when the story is the source of truth for the discussion.

Preferred pilot flow:

1. Open a safe Jira story that is appropriate for training.
2. Start from the Jira work item context using the available Rovo entry point.
3. Use QA Test Strategy Planner if it is available to the pilot user.
4. Ask the agent to separate confirmed story details from assumptions.
5. Ask what a human must confirm before using the output.

Suggested prompt:

```text
Using this Jira story as the source, help identify QA strategy considerations, missing acceptance criteria, test data needs, automation candidates, and risks that should be reviewed by a human.

Separate confirmed story details from assumptions. Do not invent requirements. Tell me what QA, product, or engineering still needs to confirm.
```

#### 3. How to explain the value

The value is not that the agent knows the final QA answer. The value is that it can quickly organize the visible Jira context into reviewable QA planning categories.

For training, describe it this way:

```text
QA Test Strategy Planner helps us turn a Jira story into a structured QA planning conversation. It should show what it can infer from the ticket, what is missing, and what a human still needs to confirm before we rely on the plan.
```

#### 4. What users must review

Before using the output, the pilot user must confirm:

- whether the environment is known or still TBD
- which state scope is in scope, out of scope, or unknown
- whether mapping documents exist and are the right source
- where the automation suite lives, if automation is being discussed
- whether acceptance criteria are complete enough for test planning
- whether any linked documents, comments, or attachments were actually considered
- whether recommendations are feasible for the team and release timing

If those items are not confirmed, the output should stay in draft form.

#### 5. Example draft output: manual test steps

The following example is demo evidence only. It is not approved QA coverage, not a committed test plan, and not a replacement for QA review.

```text
Example draft output

Manual test steps:
1. Review the Jira story summary, description, and acceptance criteria.
2. Confirm the target environment with QA or the delivery lead.
3. Confirm which state scope applies to this story.
4. Locate the relevant mapping document and verify it matches the current story.
5. Identify whether an existing automation suite covers this workflow.
6. Draft happy-path and negative-path scenarios from the confirmed acceptance criteria.
7. Mark any scenario that depends on unconfirmed environment, state, mapping, or automation details as TBD.
8. Review the draft scenarios with QA before treating them as coverage.

Human confirmation still required:
- Environment
- State scope
- Mapping document source
- Automation suite location
- Final acceptance criteria
```

Trainer note: keep this example framed as a sample of how the agent may structure uncertainty. Do not present it as the correct or complete answer for any real story.

### Leads And AI Champions

Use Rovo Design Agent and Request or Improve an Agent.

Suggested lab:

```text
A teammate says the current agent is not useful for their workflow. Help me triage whether we should reuse, improve, extend, create a template, create an agent candidate, create a new governed agent, or stop because the idea is not ready.
```

Review questions:

- What existing agents did we check?
- What source context is missing?
- Who owns the workflow?
- What would prove this is worth improving?

### Mixed Audience

Use two lanes:

- Users practice safe use and feedback.
- Leads/champions practice intake and routing.

Do not teach Studio build steps unless the room is explicitly builder/owner-heavy.

## Work-Item Collaboration Exploration Plan

Use this as the first data-gathering loop before the training is finalized.

### Data-Gathering Script

Use this script before the first training session or during a small pilot dry run. Use safe, non-sensitive Jira stories only. Do not update Jira fields, post comments, share agent output, change workflow status, or save Studio changes during this test unless a human explicitly approves that live action.

#### Setup

Trainer says:

```text
We are testing how Rovo behaves from different entry points so we can teach the right habits. We are not judging whether the agent is perfect. We are looking for what context it used, where the output was useful, what still required human review, and which entry point gave the clearest starting point.
```

Prepare:

- one complete-enough QA story
- one intentionally incomplete QA story
- one general Jira story that is not QA-specific
- one example where the current agent may not fit the user's need
- one safe Confluence page or Smart Link if direct chat testing needs source context

For each test, capture:

- entry point used
- exact prompt or visible starter text
- agent used
- context the agent appears to use
- missing context or assumptions
- output quality: accepted, edited, rejected, or not usable
- one training takeaway

#### Test 1: Ask Rovo From An Open Jira Story

Goal: learn what Rovo can use when the user starts from the work item.

Trainer action:

1. Open the complete-enough QA story.
2. Start Ask Rovo or the Rovo button from the open Jira story.
3. Run the prompt below.

Prompt:

```text
Summarize this work item in five bullets and list the top missing details for QA planning.

Separate what you can confirm from this work item from anything you are assuming.
```

Follow-up prompt:

```text
What source context did you use for that answer? Please separate summary, description, comments, attachments, linked work items, linked pages, and anything you could not access or verify.
```

Record:

- Did it understand "this work item"?
- Which fields did it mention?
- Did it overstate anything?
- Would this be good enough as a first user demo?

#### Test 2: Direct Chat With A Named Agent

Goal: compare direct agent chat against Jira work-item context.

Trainer action:

1. Open direct Rovo Chat with the target agent.
2. First ask without pasting or linking the story.
3. Then ask again with a Smart Link or pasted safe summary.

Prompt without link:

```text
I need QA planning help for a Jira story. What information do you need from me before you can give useful QA strategy guidance?
```

Prompt with link or pasted safe summary:

```text
Using this Jira story as the source: [paste safe summary or Smart Link]

Help identify QA strategy considerations, missing acceptance criteria, test data needs, automation candidates, and risks that should be reviewed by a human.

Separate confirmed story details from assumptions.
```

Follow-up prompt:

```text
How did the Smart Link or pasted story context change your answer compared with the first response?
```

Record:

- Did direct chat ask for better context?
- Did the Smart Link materially improve the output?
- What should users be taught to include when they start from chat instead of the ticket?

#### Test 3: Add, Assign, Or Mention An Agent On A Work Item

Goal: test whether Jira work-item collaboration gives a stronger starting prompt and more ticket-centered output.

Trainer action:

1. Use a safe story where work-item collaboration is allowed.
2. Add, assign, or @mention the enabled agent only if this is approved for the test.
3. Do not share the output as a Jira comment or attachment during this test unless explicitly approved.

Prompt or comment text:

```text
Please review this work item for QA planning readiness. Identify confirmed context, missing acceptance criteria, test data needs, automation candidates, risks, and the human confirmations still required.
```

Follow-up prompt:

```text
What automatic context did you receive because you were added to this work item? Please separate confirmed fields from assumptions and unavailable sources.
```

Record:

- Did the UI provide a starter prompt or structured agent panel?
- Did output appear in an Agents section or chat thread?
- Was the output private to the tester until shared?
- Did it use summary, description, comments, attachments, or linked items?
- Was it noticeably better than Ask Rovo from the open story?

#### Test 4: Rovo Design Agent Intake Route

Goal: gather examples for Session 2 so leads and AI champions know when to reuse, improve, or request an agent.

Trainer action:

1. Use a realistic problem statement where a user says an existing agent does not help.
2. Run it through Rovo Design Agent.

Prompt:

```text
I have this workflow problem: [describe the problem].

Help me decide whether this should use an existing agent, improve an existing agent, use a prompt, use automation, become a Confluence template, become an agent candidate, become a new governed agent, or be marked not ready.

Ask only the intake questions needed to choose the next route.
```

Follow-up prompt:

```text
Based on what I gave you, what existing agents or documentation should be checked before anyone builds something new?
```

Record:

- Did it recommend reuse, improvement, template, prompt, candidate, new agent, or not ready?
- What questions did it ask?
- Was the routing easy enough for a lead or AI champion to explain?
- Did it slow down risky requests, such as Jira writes or broad automation?

#### Test 5: Incomplete Story With QA Test Strategy Planner

Goal: prove the training message that missing-context flags are useful, not failures.

Trainer action:

1. Open the intentionally incomplete QA story.
2. Start from the Jira story if possible.
3. Use QA Test Strategy Planner if the tester is in the named pilot audience.

Prompt:

```text
Using this Jira story as the source, identify what QA planning can safely start now and what must remain TBD.

Pay special attention to missing acceptance criteria, environment, state scope, mapping documents, test data, automation suite location, linked evidence, and human confirmations.

Do not create final QA coverage. Provide draft planning guidance only.
```

Follow-up prompt:

```text
Turn this into a short trainer note that explains why the missing-context flags are helpful and what a user should do next.
```

Record:

- Did the agent avoid inventing missing QA details?
- Did it keep manual test steps in draft form?
- Did it call out environment, state scope, mapping docs, and automation suite location?
- Would this make a good training example?

#### Closing Capture

After each test, trainer asks:

```text
What would we teach a first-time user from this example?
```

Then write one sentence in this format:

```text
Training takeaway: When [entry point or agent] is used for [scenario], users should [recommended habit] because [observed behavior].
```

#### Initial Observed Training Takeaways

Use these examples as the first training-data readout. They should be refined after more pilot users test the same flows.

Training takeaway: When Ask Rovo from an open Jira story is used for quick QA planning discovery, users should ask it to separate confirmed details from assumptions because it can summarize the ticket well, but may infer meaning from struck-through forms, effective dates, or linked sources it has not actually opened.

Training takeaway: When direct chat with QA Test Strategy Planner is used for starting QA planning without attached Jira context, users should expect the agent to ask for a source packet or story details first because direct chat does not automatically have the same grounded work-item context as an attached Jira agent.

Training takeaway: When QA Test Strategy Planner is attached directly to a Jira story for draft QA strategy creation, users should treat the output as a structured starting draft and verify environment, state scope, forms, mapping, and automation details because the agent produced a useful plan but also introduced assumptions such as environment names and form examples.

Training takeaway: When Rovo Design Agent is used for an improvement or request idea, such as richer ticket status for downstream release or sprint health agents, users should bring the workflow problem and answer the intake questions before proposing a new agent because the Design Agent can check existing inventory paths and narrow the decision to reuse or extend existing agents.

Training takeaway: When QA Test Strategy Planner is used on an incomplete story for readiness-gap discovery, users should use the missing-context flags as the next-action checklist because the agent separated what QA can safely start from what still needs human confirmation, including environment, state scope, mapping docs, test data, and automation suite location.

### Hypotheses To Test

| Hypothesis | How To Test | Evidence To Capture |
|---|---|---|
| Ask Rovo from an open Jira ticket can use "this work item" as context. | Open a ticket, use Ask Rovo, ask it to summarize "this work item." | Whether it references summary, description, comments, attachments, linked items, or only visible fields. |
| Adding or assigning an agent to a work item gives stronger upfront context. | Assign QA Test Strategy Planner or another enabled agent to a safe sample story. | Initial prompt shape if visible, output quality, fields used, and whether it appears in the Agents section. |
| @mentioning an agent in a comment uses comment context plus ticket details. | @mention a safe enabled agent in a comment with a scoped ask. | Whether it uses the comment, description, attachments, and prior comments. |
| Direct agent chat needs more explicit context than work-item collaboration. | Start the same agent from Chat and ask the same question without linking the ticket, then with a Smart Link. | Difference in answer quality and missing-context behavior. |
| Output sharing is user-controlled. | Check whether agent output is private until shared as comment or attachment. | UI evidence and whether other users can see the output before sharing. |

### Safe Sample Prompt Set

Use non-sensitive or sanitized tickets only.

```text
Summarize this work item in five bullets and list the top missing details for QA planning.
```

```text
What test strategy considerations can you identify from this work item? Mark assumptions and missing information separately.
```

```text
What source context did you use? Please separate work item summary, description, comments, attachments, linked issues, and external pages if available.
```

```text
What should a human review before using your output?
```

### Reusable Agent Context Discovery Prompt

Use this prompt after an agent produces its first useful answer. It is designed to collect comparable training evidence across Jira Work Item Assistant, QA Test Strategy Planner, Rovo Design Agent, and other approved or pilot-only agents.

```text
I am testing this agent so we can train users on when to use it and which entry point works best.

Please explain how you produced your initial response.

Focus on:
1. What automatic context you used from the current Jira work item, Confluence page, chat, Smart Link, attachment, or other source.
2. Which fields, comments, attachments, linked items, pages, or source documents appeared relevant.
3. Which agent instructions, standards, templates, or knowledge sources shaped your answer.
4. What assumptions you made because the source context did not explicitly say something.
5. What information you did not have access to or could not verify.
6. Whether this entry point shaped your starting task or prompt, such as attached-to-work-item, Ask Rovo AI, direct agent chat, @mention, workflow transition, or board column.
7. How this experience differs from starting the same request through Ask Rovo AI or direct chat.
8. What follow-up prompt would help a user get the best next output from you.

Please separate confirmed context from inferred context. Do not invent details if you cannot inspect or verify them.
```

For a shorter live-demo version:

```text
Explain how you arrived at your initial response. List the automatic context you used, what instructions or sources shaped the answer, what you inferred, what you could not verify, and how this entry point differs from Ask Rovo AI. Separate confirmed context from assumptions.
```

### Data To Capture

| Field | What To Record |
|---|---|
| Date | Date of test. |
| Tester | Person running the test. |
| Jira work item | Safe issue key or sanitized reference. |
| Entry point | Ask Rovo, direct agent chat, agent assigned to work item, @mention, workflow transition, or board column. |
| Agent | Agent name, or general Rovo Chat. |
| Prompt | Exact prompt or visible starter. |
| Context observed | Ticket fields, comments, attachments, links, or user-provided context. |
| Output quality | Accepted, edited, rejected, or not usable. |
| Missing or unsafe behavior | Any unsupported claim, stale source, wrong assumption, or risky instruction. |
| Training takeaway | What should be taught or warned about. |

## Recommended Training Message

Use this wording consistently:

```text
Use the most context-aware entry point available for the job. If you are working on one Jira story, start from that story. If you need a specific governed workflow, use the approved or pilot-only agent for that workflow. If the agent is not useful, route the gap through your lead or AI champion and the Rovo Design Agent intake flow.
```

## Current Boundaries

- Do not teach Claude Code, Rovo Dev, or Agent Lab as current approved workflow.
- Do not tell users to create new agents from work items as the default path.
- Do not enable Jira writes, workflow automation, Studio changes, or broad pilot expansion during training.
- Do not use sensitive Jira tickets, private exports, raw HARs, tokens, or customer/regulated data in demos.
- Do not treat agent output as approval.

## Immediate Prep Checklist

- Choose one safe QA story for the demo.
- Confirm QA Test Strategy Planner can be used by Lisa Porter and the training pilot audience.
- Confirm whether QA Test Strategy Planner has Work items enabled as a Surface in Studio.
- Test Ask Rovo from an open Jira ticket.
- Test direct chat with QA Test Strategy Planner using a Smart Link to the same ticket.
- Test agent assignment or @mention on a work item if enabled.
- Capture results in the exploration table before finalizing the training script.
