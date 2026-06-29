# Rovo Self-Guided Learning Confluence Handoff - 2026-06-23

Status: Completed / superseded by `docs/confluence-pages/self-guided-learning-using-rovo-agents-in-jira.md` and `docs/publish-history/2026-06-23-rovo-self-guided-learning.md`.

Do not execute this packet as an active next-conversation handoff without first re-reading the current Confluence source page, publish-history record, `config/confluence-pages.example.yml`, and `START-HERE.md`. Preserve this file as source context for how the self-guided learning page was shaped.

## Purpose

Build learner-facing Confluence source drafts from the local Rovo training session material.

The next slice should turn the current facilitator-oriented training draft into self-guided learning pages that everyday users, QA pilot users, leads, and AI champions can follow without a live trainer. The learning path should be hands-on, Jira-centered, and clear about safe use, context, human review, and when to route a gap through the Rovo Design Agent.

Do not publish to Confluence in this slice unless the user explicitly approves a focused dry-run and live apply.

## First Instruction For The Next Conversation

Start from latest `main` and create a dedicated branch before editing durable Confluence source files.

Recommended command flow:

```powershell
git fetch --prune origin
git switch main
git pull --ff-only origin main
git switch -c shaynevandersloot/rovo-self-guided-learning
```

If the active workspace is occupied by another conversation, use a worktree instead:

```powershell
git fetch --prune origin
git worktree add .codex-worktrees/rovo-self-guided-learning main
Set-Location .codex-worktrees/rovo-self-guided-learning
git switch -c shaynevandersloot/rovo-self-guided-learning
```

If that branch name already exists, choose a similarly specific branch name such as `shaynevandersloot/rovo-hands-on-learning-lab`.

## Operating Boundaries

- Keep work read-only-first and dry-run-first.
- Do not write to ROVO Studio.
- Do not create, update, transition, assign, rank, sprint, or comment on Jira issues.
- Do not publish, update, move, or archive Confluence pages without a focused dry-run and explicit user approval.
- Do not treat QA Test Strategy Planner as broadly approved. It is pilot-only for the named pilot audience unless a human-owned source changes that status.
- Do not present example QA strategy, manual test steps, or agent output as approved QA coverage.
- Keep Jira issue links, private URLs, raw agent transcripts, HARs, cookies, headers, tokens, and unsanitized exports out of Git.
- Use sanitized examples or placeholders in learner-facing Confluence pages.

## Current Source Material

Read these first:

- `AGENTS.md`
- `README.md`
- `START-HERE.md`
- `docs/toolkit-operating-model.md`
- `docs/reports/rovo-training-session-script-draft-2026-06-23.md`
- `docs/confluence-pages/user-guide-using-approved-agents.md`
- `docs/confluence-pages/request-or-improve-agent.md`
- `docs/confluence-pages/agent-inventory.md`
- `docs/confluence-pages/governance-and-safety.md`

The current local training draft contains:

- Three-session facilitator plan.
- Jira Work Item Assistant training guide.
- QA Test Strategy Planner pilot training guide.
- Work-item collaboration exploration plan.
- Five-test data-gathering script.
- Prompt pack for Ask Rovo, direct agent chat, attached/assigned agents, Rovo Design Agent intake, and incomplete QA stories.
- Initial observed training takeaways.

Treat that report as facilitator source material, not as a page-ready Confluence draft.

## Recommended Confluence Page Shape

Create the smallest useful Confluence source set first.

Recommended first page:

- `docs/confluence-pages/self-guided-learning-using-rovo-agents-in-jira.md`
- Page title: `Self-Guided Learning - Using Rovo Agents in Jira`
- Parent recommendation: `User Guide - Using Approved Agents`
- Also plan a link from `Agent Governance Home` after review, but do not update or publish the home page until explicitly approved.

Optional second page if the first page becomes too long:

- `docs/confluence-pages/hands-on-lab-using-rovo-agents-in-jira.md`
- Page title: `Hands-On Lab - Using Rovo Agents in Jira`
- Parent recommendation: `Self-Guided Learning - Using Rovo Agents in Jira`

Keep the first implementation reviewable. Prefer one self-guided page with clear exercises before splitting into multiple pages.

## Learner-Facing Content Goals

The self-guided page should teach users how to:

- Choose between Ask Rovo, direct agent chat, and attached/assigned agent workflows.
- Understand where context may come from in Jira and Rovo Chat.
- Ask agents to separate confirmed facts from assumptions.
- Review draft output before using it.
- Recognize missing-context flags as useful signals.
- Use QA Test Strategy Planner only when they are in the pilot audience.
- Route agent gaps, new ideas, or improvement requests through leads, AI champions, and the Rovo Design Agent.

The hands-on lab should feel like something a user can run in 30-45 minutes with a safe Jira story.

## Suggested Page Outline

```text
# Self-Guided Learning - Using Rovo Agents in Jira

## What You Will Learn

## Before You Start
- Use a safe Jira story.
- Do not use sensitive or regulated data.
- Do not post agent output back to Jira unless reviewed.
- Treat output as draft help, not approval.

## Exercise 1: Ask Rovo From An Open Jira Story
- Goal
- Steps
- Prompt
- What to observe
- Training takeaway

## Exercise 2: Chat With A Named Agent
- Prompt without story context
- Prompt with Smart Link or safe story summary
- Compare the difference

## Exercise 3: Attach Or Mention An Agent On A Jira Work Item
- Pilot or beta caveat
- Prompt
- What to verify
- Visibility and sharing reminder

## Exercise 4: QA Pilot Example
- QA Test Strategy Planner pilot-only caveat
- Prompt
- Human confirmation checklist
- Example draft output label

## Exercise 5: Request Or Improve An Agent
- Rovo Design Agent prompt
- Explain that Agent Fit Intake means running the idea through Rovo Design Agent.

## Capture Your Takeaway
- Entry point
- Agent
- Prompt
- Context used
- Output quality
- Human fix needed
- Training takeaway

## What To Do Next
```

## Required Tone And Structure Changes

Convert trainer-facing language into learner-facing guidance.

Use:

- "Try this"
- "Record what happened"
- "Check whether the agent used..."
- "Ask a follow-up"
- "Do not treat this as approval"

Avoid:

- Long facilitator narration.
- Internal implementation chatter.
- Private Jira examples, private URLs, or raw transcript details.
- Overstating beta work-item collaboration behavior as settled fact.
- Telling users to build or publish agents directly.

## Prompt Pack To Carry Forward

Use sanitized versions of these prompts from the training draft:

```text
Summarize this work item in five bullets and list the top missing details for QA planning.

Separate what you can confirm from this work item from anything you are assuming.
```

```text
What source context did you use for that answer? Please separate summary, description, comments, attachments, linked work items, linked pages, and anything you could not access or verify.
```

```text
I need QA planning help for a Jira story. What information do you need from me before you can give useful QA strategy guidance?
```

```text
Using this Jira story as the source: [paste safe summary or Smart Link]

Help identify QA strategy considerations, missing acceptance criteria, test data needs, automation candidates, and risks that should be reviewed by a human.

Separate confirmed story details from assumptions.
```

```text
Please review this work item for QA planning readiness. Identify confirmed context, missing acceptance criteria, test data needs, automation candidates, risks, and the human confirmations still required.
```

```text
I have this workflow problem: [describe the problem].

Help me decide whether this should use an existing agent, improve an existing agent, use a prompt, use automation, become a Confluence template, become an agent candidate, become a new governed agent, or be marked not ready.

Ask only the intake questions needed to choose the next route.
```

```text
Using this Jira story as the source, identify what QA planning can safely start now and what must remain TBD.

Pay special attention to missing acceptance criteria, environment, state scope, mapping documents, test data, automation suite location, linked evidence, and human confirmations.

Do not create final QA coverage. Provide draft planning guidance only.
```

## QA Pilot Caveats To Preserve

For QA Test Strategy Planner content, keep these points explicit:

- QA Test Strategy Planner is pilot-only for the named pilot audience.
- Output is draft planning guidance only.
- Manual test steps are example draft output, not approved QA coverage.
- Environment, state scope, mapping document source, automation suite location, and final acceptance criteria require human confirmation.
- QA approval, test skipping, Jira writes, Confluence publication, Studio configuration, and release readiness decisions remain human-owned.

## Initial Observed Takeaways To Adapt

Use these as learner-facing examples, not policy:

- Ask Rovo from an open Jira story can summarize ticket context well, but users should ask it to separate confirmed details from assumptions.
- Direct chat with QA Test Strategy Planner may need a source packet or story details before it can help.
- Attached Jira-agent workflows may provide useful structure, but users must verify environment, state scope, forms, mapping, and automation details.
- Rovo Design Agent is useful when a user has a workflow problem but is not sure whether the answer is reuse, improvement, prompt, template, or new agent.
- Missing-context flags are useful next-action checklists, not failures.

## Likely Companion Artifacts

Update only the smallest coherent companion set:

- `docs/confluence-pages/self-guided-learning-using-rovo-agents-in-jira.md`: primary new learner-facing page.
- `docs/confluence-pages/hands-on-lab-using-rovo-agents-in-jira.md`: optional if the lab needs its own child page.
- `config/confluence-pages.example.yml`: add new slug(s), parent relationship, and labels after the source page shape is stable.
- `docs/confluence-pages/user-guide-using-approved-agents.md`: optional link to the self-guided page after review.
- `docs/confluence-pages/governance-and-safety.md`: optional Start Here or user-learning link after review.
- `docs/publish-history/`: update only after a user-approved live Confluence apply.

No inventory status update is expected unless the user makes a new human-owned decision about agent approval, pilot audience, owner, backup owner, or lifecycle state.

## Acceptance Criteria

- A new branch or worktree branch is used before durable page edits.
- Training draft remains available as facilitator source, not the published learner page.
- Self-guided page is written for everyday users and can be followed without a trainer.
- Hands-on lab exercises use safe placeholders and sanitized prompts.
- QA Test Strategy Planner remains clearly pilot-only.
- Example QA output is labeled as draft/example only.
- Page links and labels are added to `config/confluence-pages.example.yml` only after source page names are decided.
- No Confluence publish happens without dry-run and explicit approval.

## Validation

Run the smallest truthful checks for the touched surface:

```powershell
git status --short
git diff --check
.\scripts\Test-ConfluencePageFamilyConsistency.ps1
.\scripts\Test-PrivateDataScan.ps1
```

If `config/confluence-pages.example.yml` changes, parse or inspect the YAML before committing. If a Confluence publish is requested later, run a focused dry-run for the changed slug(s) first and only apply after explicit approval.

## Suggested Prompt For The New Conversation

```text
Continue from docs/handoffs/rovo-self-guided-learning-confluence-handoff-2026-06-23.md. Start from latest main, create a new branch named shaynevandersloot/rovo-self-guided-learning or similar, and turn the local Rovo training session draft into learner-facing Confluence source page(s). Focus on a self-guided hands-on lab for using Rovo agents in Jira. Do not publish to Confluence. Keep QA Test Strategy Planner pilot-only and label example QA outputs as draft-only.
```
