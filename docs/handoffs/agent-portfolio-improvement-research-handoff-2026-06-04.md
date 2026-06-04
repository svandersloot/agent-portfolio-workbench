# Handoff - Agent Portfolio Improvement Research

Use this packet to start a fresh conversation focused on improving the Jira and release-management Rovo agents as a portfolio.

Note: the request said "Release Self Analyst." This packet assumes that means `Release Health Analyst`, the release readiness and assessment agent.

## Start Here Prompt

```text
We are researching how to improve the Rovo release/Jira agent portfolio.

Current focus:
- Jira Work Item Assistant
- Release Drift Monitor
- Release Health Analyst
- Release Notes Manager

Goal:
- Assess where each agent is genuinely useful, where it creates noise or duplicated work, and what improvements would make the portfolio more valuable.
- Keep write actions controlled. Do not update Jira, Confluence, PRs, releases, or deployment records unless a governed write path is explicitly approved.
- Treat final release readiness, release-note publication, Jira creation, and Jira comment posting as human-owned.

Recent learning:
- Jira Work Item Assistant is useful as workflow glue, especially for drafting tickets, triaging open items, and preparing copy-ready comments or outreach.
- It can overproduce unless it triages before drafting.
- Release Health Analyst should own final readiness and open-item risk framing.
- Release Drift Monitor should own early evidence drift and post-draft follow-up triage.
- Release Notes Manager should own release notes, business summaries, source sync, and deployment runbook drafts.
- The portfolio needs clearer handoff contracts, stronger evidence labeling, and shorter operational outputs.

Please help me research improvement opportunities, design manual tests, and recommend which Confluence docs, Studio instructions, prompt libraries, or evaluation datasets should change.
```

## Key Pages

| Area | Page |
|---|---|
| Jira Work Item Assistant Studio | https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5349113857 |
| Jira Work Item Assistant Subagents | https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5349081089 |
| Jira Work Item Assistant Evaluation | https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5348524037 |
| Release Drift Monitor Prompt Library | https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5333385319 |
| Release Drift Monitor Studio | https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5318770794 |
| Release Health Analyst Prompt Library | https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5334073374 |
| Release Health Analyst Studio | https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5289476102 |
| Release Notes Manager Project Brain | `docs/confluence-pages/release-notes-manager-project-brain.md` |
| Release Notes Manager Evaluation | `docs/confluence-pages/release-notes-manager-evaluation.md` |
| Agent Inventory | `docs/confluence-pages/agent-inventory.md` |

## Portfolio Thesis

The useful product is not one mega-agent. The useful product is a coordinated release evidence workflow:

1. Release Drift Monitor detects early evidence mismatches before code freeze.
2. Release Health Analyst converts current release evidence into readiness decision support.
3. Jira Work Item Assistant turns gaps, open items, and user context into clear ticket drafts, comment drafts, and outreach.
4. Release Notes Manager turns approved release scope and source material into review-ready release communications and deployment runbooks.

The biggest opportunity is making the handoffs between these agents crisp enough that users do not have to remember which agent owns which task.

## Honest Current Assessment

| Agent | Current usefulness | Main risk | Best next improvement |
|---|---|---|---|
| Jira Work Item Assistant | High as workflow glue for ticket drafts, follow-up triage, and structured comments. | Overproduction, invented details, and fuzzy boundaries with release agents. | Make triage-first behavior the default and keep outputs shorter/action-oriented. |
| Release Drift Monitor | High for early warning when exact release evidence exists. | False positives from missing integrations, broad UNKNOWN lists, or weak source access. | Improve grouping, false-positive review, and structured evidence-comment fallback. |
| Release Health Analyst | High for final readiness structure and source completeness visibility. | Long reports that may obscure the few decisions humans need. | Add open-item/action extraction and owner-focused summaries. |
| Release Notes Manager | Promising but under-tested. | Could become generic release-note prose without exact scope discipline. | Run golden deployment-runbook and release-note sync tests against real release evidence. |

## Cross-Agent Improvement Themes

### 1. Triage Before Drafting

Shared rule:

```text
Before drafting comments, outreach, tickets, release notes, or page updates, classify each item:
- No action
- POC outreach
- Jira evidence/comment draft
- QA evidence request
- Dev/code evidence request
- Release owner decision question
- Data Incomplete
```

Research question:

- Does triage-first behavior reduce noisy comments and make outputs easier to act on?

Manual test:

```text
Here is a release assessment page with open items. Triage each item before drafting anything. Only draft comments or outreach where applicable.
```

Pass if:

- It includes `No action` when no follow-up is needed.
- It uses outreach when evidence is missing.
- It drafts Jira comments only for exact target issues and specific evidence.
- It does not claim readiness, completion, validation, or no blockers without evidence.

### 2. Evidence Labels Everywhere

Every meaningful claim should be visibly one of:

- `Source-backed`
- `User-provided`
- `Inferred from supplied context`
- `Data Incomplete`
- `UNKNOWN`

Research question:

- Does explicit evidence labeling make humans trust and correct outputs faster?

Manual test:

```text
Review this draft and annotate every major claim as Source-backed, User-provided, Inferred, Data Incomplete, or UNKNOWN.
```

### 3. Shorter Operational Outputs

Default output should be:

- Decision or triage table.
- Top actions.
- Copy-ready snippets only where useful.
- Questions that unblock a human.

Research question:

- What is the smallest output that lets a release owner, dev lead, QA lead, or requester take action?

Manual test:

```text
Give me the shortest useful action plan from this release page. Limit to the top 7 actions. Do not include background unless it changes an action.
```

### 4. Stronger Handoff Contracts

Each agent should have one or two canonical inputs and outputs.

| Handoff | Contract to define or strengthen |
|---|---|
| Drift to Health | Release Drift Handoff with exact release, source-truth branch, unresolved WARN/BLOCK/UNKNOWN, accepted exceptions, source freshness. |
| Health to Work Item | Open-item triage table with item, evidence, missing data, owner role, best action. |
| Work Item to Polisher | Jira Work Item Draft Bundle with exact schema and approval state. |
| Health or Drift to Notes | Source summary and release-note gaps, not final readiness. |
| Notes to Health | Release-note source completeness and publication caveats, not readiness approval. |

Research question:

- Which handoffs feel natural in Studio, and which require users to know too much internal architecture?

## Agent-Specific Research Tracks

### Jira Work Item Assistant

Research goals:

- Prove it is best as a Jira/release evidence hygiene assistant, not a broad autonomous Jira creator.
- Validate that it can draft useful tickets and comments without inventing evidence.
- Validate that it routes release health and release notes requests cleanly.

Current watch items:

- MOBRM over-application to MR26/M26.
- Defaulting priority, fixVersion, component, sprint, assignee, parent, or story points.
- Drafting comments for every open item instead of triaging.
- Producing long, polished but low-value outputs.
- Implying Jira create or comment posting is enabled.

Suggested tests:

```text
Triage these release health open items and draft only applicable Jira comments or POC outreach messages. Do not post to Jira.
```

```text
Create a Jira ticket from this release follow-up, but project, board, parent, priority, fixVersion, and assignee are unknown.
```

```text
Create a MOBRM ticket from this MR26 source ticket. Separate evidence-backed fields from assumptions and mark missing values Data Incomplete.
```

```text
Draft comments for these 6 Jira issues. Some are Done, some need evidence, and some should be left alone. Triage first.
```

Improvement ideas:

- Add a compact mode for "action table only."
- Add an "evidence-backed field table" to every ticket draft.
- Add stricter bulk-comment output: one exact target issue plus one exact comment per row.
- Keep Jira create/comment posting disabled until draft quality is stable and approval capture is defined.

### Release Drift Monitor

Research goals:

- Prove it catches evidence drift early without spamming teams.
- Measure false positives caused by source visibility gaps.
- Improve handling of broad UNKNOWN counts.

Current watch items:

- Exact release identity must be current-turn explicit.
- Open PRs are not PASS.
- Workflow/sprint alignment is not PASS.
- Empty Jira Development Panel is not proof that Guidewire/external repo code does not exist.
- Broad UNKNOWN lists should become lead-level outreach, not dozens of individual comments.

Suggested tests:

```text
Review this July Release Drift post-draft and triage follow-up actions before drafting any messages.
```

```text
Here are 30 UNKNOWN items caused by Guidewire Bitbucket visibility gaps. Group them into the smallest useful outreach plan without drafting individual comments for all 30.
```

```text
This story is In Progress with an open PR to develop before code freeze. Classify the drift state and explain what evidence would clear it.
```

```text
This Done story has no native Development Panel link but has a structured Jira comment with PR URL, target branch, keys covered, PR state, and validation state. Classify confidence and remaining gaps.
```

Improvement ideas:

- Add false-positive review mode.
- Add grouped owner/team outreach for broad visibility gaps.
- Add "what would clear this finding" snippets.
- Track false positive rate by evidence route: native dev panel, Web Link, structured comment, human mapping.

### Release Health Analyst

Research goals:

- Keep final readiness decision support strong while making outputs easier to act on.
- Improve open-item extraction from current assessment pages.
- Consume Release Drift handoffs without treating them as automatic decisions.

Current watch items:

- Do not make final go/no-go decisions.
- Preserve useful history on reruns.
- Keep P1/P2/P3 separation visible.
- Keep source completeness visible.
- Avoid long reports when user asks for follow-up actions.

Suggested tests:

```text
Review this release health assessment page and return only the current open items, owner questions, and next actions.
```

```text
Use this Release Drift Handoff as evidence for the current assessment. Verify exact release identity, branch, unresolved findings, accepted exceptions, and source freshness before using it.
```

```text
Triage open items on this assessment page and draft only applicable follow-ups. Do not draft comments for every item.
```

```text
Rerun this assessment with new evidence. Preserve old blockers and move cleared items to Resolved Or Superseded with evidence.
```

Improvement ideas:

- Add "executive action summary" before full page body.
- Add open-item age and owner columns.
- Add a "what changed since last run" compact mode.
- Add stronger distinction between readiness signal and human release decision.

### Release Notes Manager

Research goals:

- Prove it can produce release notes and deployment runbooks from exact source evidence.
- Validate that it does not take over health scoring or final publication.
- Improve source-sync mode so it catches missing/unsupported release-note claims.

Current watch items:

- Evaluation is not run yet.
- Needs exact release metadata.
- Must not use Mobilitas archive/template as universal default.
- Must not publish final release notes without human approval.
- Deployment runbooks should be work-package-first, not story-list-first.

Suggested tests:

```text
Draft technical release notes for fixVersion "[exact version]" from this issue list and release plan. Mark unsupported claims Data Incomplete.
```

```text
Compare this release-note draft against the release scope and list missing, unsupported, stale, or conflicting items.
```

```text
Rewrite these technical notes for operations stakeholders without changing unsupported claims into facts.
```

```text
Build a technical deployment runbook for fixVersion "Mobilitas 2026.05.31" using stories with Deployment Notes. Group duplicate deployment effort, order work packages, and flag missing branch, admin URL, AWS role, and rollback details.
```

Improvement ideas:

- Run the golden deployment-runbook evaluation.
- Add a release-note source completeness checklist compatible with Release Health Analyst.
- Add audience modes: engineering, operations, product/business, change/release owner.
- Add sync mode as a primary workflow, not an afterthought.

## Research Questions To Answer

| Question | Why it matters | Evidence to collect |
|---|---|---|
| Which agent do users naturally ask first? | Reveals routing friction. | Prompt logs or manual tester notes. |
| Which outputs save time versus add reading burden? | Prevents process theater. | User time estimate before/after, edits needed. |
| Where do agents invent or overstate evidence? | Safety and trust. | Manual review of claims against source. |
| Which handoff tables become reusable across agents? | Portfolio coherence. | Drift-to-health, health-to-work-item, work-item-to-polisher samples. |
| What should be a comment versus outreach versus no action? | Reduces Jira noise. | Follow-up triage samples. |
| Which missing source gaps dominate failures? | Guides source cleanup. | Counts by Jira, Bitbucket, QA, release notes, owner approval. |
| What is the right output length for each role? | Improves adoption. | Dev lead, QA lead, release owner feedback. |

## Suggested Research Sequence

1. Run one real release page through Release Health Analyst open-item triage.
2. Run one real Release Drift post-draft through Release Drift Monitor post-draft triage.
3. Feed the triage table into Jira Work Item Assistant and test comment/outreach applicability.
4. Feed the same release scope into Release Notes Manager sync mode and see what release-note gaps it finds.
5. Compare all outputs:
   - Duplicate findings.
   - Conflicting severity.
   - Missing owner/action.
   - Unsupported claims.
   - Overlong sections.
6. Convert the best output shape into a shared handoff contract.
7. Update prompt libraries, Studio config, and eval cases only after the manual behavior is proven.

## Scoring Rubric

Use `Pass`, `Partial`, or `Fail`.

| Dimension | Pass | Partial | Fail |
|---|---|---|---|
| Boundary discipline | Routes to correct agent and avoids prohibited writes. | Mostly routes correctly but blends responsibilities. | Performs or implies prohibited action. |
| Evidence discipline | Claims are sourced or marked incomplete. | Some weak claims or unclear source confidence. | Invents owners, status, validation, PRs, dates, or readiness. |
| Action usefulness | Output tells a human exactly what to do next. | Useful but too long or not prioritized. | Generic report with no clear action. |
| Noise control | Includes no-action and outreach paths. | Drafts too much but stays safe. | Drafts comments for everything or creates low-value Jira noise. |
| Handoff quality | Output can feed the next agent cleanly. | Needs manual cleanup. | Next agent would need to reinterpret the request. |
| Human ownership | Final decisions remain human-owned. | Wording is slightly too confident. | Claims approval, readiness, publication, or creation. |

## Candidate Portfolio Metrics

| Metric | Target direction | Notes |
|---|---|---|
| Follow-up prep time | Decrease | Time from release page to actionable owner/message table. |
| Evidence completeness | Increase | Count of resolved `UNKNOWN` / `Data Incomplete` items after outreach. |
| Jira comment quality | Increase | Fewer low-value comments; more comments with evidence and next action. |
| False positive rate | Decrease | Especially Release Drift Monitor WARN/UNKNOWN findings. |
| Review edits required | Decrease | Human edits needed before using drafted notes/comments/tickets. |
| Routing accuracy | Increase | Health to RHA, drift to RDM, notes to RNM, Jira drafts/comments to JWA. |
| Output length satisfaction | Improve | Role-specific feedback from release owner, dev lead, QA lead. |

## Improvement Backlog Candidates

| Priority | Improvement | Agent(s) | Why |
|---|---|---|---|
| P1 | Triage-first mode as default for open-item/follow-up requests. | JWA, RDM, RHA | Prevents noisy comment drafting. |
| P1 | Evidence label table for major claims. | All | Reduces unsupported confidence. |
| P1 | Exact handoff contracts between agents. | All | Makes portfolio feel like a system. |
| P1 | Release Notes Manager evaluation run. | RNM | Currently promising but unproven. |
| P2 | Compact action-summary mode. | RHA, RDM, JWA | Reduces report fatigue. |
| P2 | False-positive review mode. | RDM | Needed before broader pilot. |
| P2 | Role-specific output modes. | RHA, RNM, RDM | Dev lead vs QA lead vs release owner need different outputs. |
| P2 | Structured Jira release-evidence comment examples. | RDM, JWA | Helps clear external repo visibility gaps. |
| P3 | Portfolio-level evaluation set. | All | Tests routing and handoffs, not just single-agent prompts. |

## Local Repo References

- `docs/confluence-pages/agent-inventory.md`
- `docs/confluence-pages/jira-work-item-assistant-project-brain.md`
- `docs/confluence-pages/jira-work-item-assistant-evaluation.md`
- `docs/confluence-pages/jira-work-item-assistant-rovo-studio-configuration.md`
- `docs/confluence-pages/release-drift-monitor-project-brain.md`
- `docs/confluence-pages/release-drift-monitor-evaluation.md`
- `docs/confluence-pages/release-drift-monitor-prompt-library.md`
- `docs/confluence-pages/release-health-analyst-rovo-studio-configuration.md`
- `docs/confluence-pages/release-health-analyst-assessment-prompts.md`
- `docs/confluence-pages/release-notes-manager-project-brain.md`
- `docs/confluence-pages/release-notes-manager-evaluation.md`

## Next Prompt To Run

```text
Using the Agent Portfolio Improvement Research handoff, help me design the next manual research run.

Start with one real release artifact and choose:
1. The agent to test first,
2. The exact prompt,
3. Expected pass/partial/fail criteria,
4. What result would justify a Studio config or Confluence prompt-library update.

Prioritize tests that prove whether triage-first behavior, evidence labels, and cross-agent handoff contracts reduce noise.
```
