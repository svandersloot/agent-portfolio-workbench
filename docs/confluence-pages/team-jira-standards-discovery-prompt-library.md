# Prompt Library - Team Jira Standards Discovery

Use this page as both a human prompt library and an agent playbook for discovering, drafting, and reviewing proposed team Jira standards.

This page is shared by Jira Work Item Assistant and future Jira hygiene agents. Jira Ticket Polisher is retained only as archived/superseded history. The library helps teams create standards without turning observed ticket patterns into policy before a team owner approves them.

## Companion Pages

| Page | Use |
|---|---|
| Jira Ticket Standards | Shared parent for Jira ticket standards. |
| Organization-Wide Jira Ticket Quality Standard | Default baseline for every ticket draft or review. |
| Team Jira Standards | Index of approved team overlays. |
| MOBRM Team Jira Standards | Example of an approved team overlay. |
| Jira Work Item Assistant Project Brain | Agent that can draft proposed team standards pages and review ticket quality against standards. |
| Jira Ticket Polisher Project Brain | Archived / superseded historical record for the retired standalone ticket-polishing agent. |

## Agent Playbook

| User intent | Agent behavior |
|---|---|
| Find the applicable team standard | Check Team Jira Standards using project key, board, filter, issue key, team name, or supplied context. |
| No matching team standard exists | Apply Organization-Wide Jira Ticket Quality Standard only and state `No team overlay applied.` |
| User wants to create a team standard | Use Team Standards Intake and return a proposed standards page. |
| User wants to analyze a board or sample tickets | Use Kanban Board Standards Discovery and label findings as observed patterns, not policy. |
| User wants to validate a draft standard | Use Proposed Standard Review and check owner approval, mappings, boundaries, and evidence. |
| User wants ticket review only | Use global standard plus approved team overlay if one clearly matches; otherwise use global only. |

## Studio Configuration Patch

Add this block to Jira Work Item Assistant instructions so natural user requests can use this prompt library without requiring humans to paste the full prompt.

```text
When the user asks to find a team standard, create a team standard, analyze a board for patterns, review tickets for team-specific conventions, or explain why no team standard was applied, first consult:
- Jira Ticket Standards
- Organization-Wide Jira Ticket Quality Standard
- Team Jira Standards
- Prompt Library - Team Jira Standards Discovery

Always apply the organization-wide standard first.
Apply a team overlay only when Team Jira Standards or an approved supplied page clearly maps to the current project key, board, filter, issue key, or team.

If no team overlay matches, state:
No team overlay applied. I am using the organization-wide Jira ticket quality standard only.

If the user wants a team standard, draft it as Proposed until a human/team owner approves it.
Keep documented standards, team owner answers, observed ticket patterns, proposed recommendations, and open questions separate.
Do not treat sampled tickets as policy.
```

## Team Standards Intake

Use this when a team wants to create a proposed team Jira standards page.

```text
Draft a proposed team Jira standards page.

Team context:
- Team name:
- Jira project key:
- Board URL or board ID:
- Filter or JQL, if relevant:
- Team owner:
- Backup owner:
- Review cadence:

Ask for or infer only from supplied evidence:
- Issue types in scope
- Required fields
- Important fields
- Fields not required by default
- Parent expectations
- Label conventions
- Component expectations
- Priority expectations
- fixVersion expectations
- Sprint expectations
- Assignee and owner expectations
- Summary naming conventions
- Description expectations
- Acceptance criteria expectations
- Validation or QA expectations
- Done/readiness expectations
- Common task or script-driven ticket patterns
- Status comment expectations
- Examples or source pages used
- Does-not-apply boundaries

Separate the output into:
1. Documented standards
2. Team owner answers
3. Observed patterns from sample tickets
4. Proposed recommendations
5. Open questions

Return a copy-ready Confluence page titled:
[TEAM] Team Jira Standards

Mark the page:
Status: Proposed until approved by [owner].

Do not apply the proposed standard as official policy.
```

## Kanban Board Standards Discovery

Use this when a user wants the agent to review a Kanban board, Jira filter, or set of tickets to gather data for a future team standard.

```text
Analyze this Kanban board, Jira filter, or ticket sample to discover candidate team Jira standards.

Board or filter:
[PASTE BOARD URL, FILTER, JQL, OR CURRENT BOARD CONTEXT]

Sample scope:
[NUMBER OF TICKETS, STATUSES, ISSUE TYPES, DATE RANGE, OR KNOWN LIMITATIONS]

Use:
- Organization-Wide Jira Ticket Quality Standard
- Team Jira Standards
- Prompt Library - Team Jira Standards Discovery

Rules:
- Treat sampled tickets as observed patterns only.
- Do not turn observed patterns into official team standards.
- Do not assume the visible sample represents every workflow.
- Do not infer required fields unless Jira configuration, create-screen evidence, workflow validators, or team owner answers support it.
- Separate what is documented, what is observed, what is missing, and what should be asked.
- Preserve privacy and avoid copying sensitive ticket details into the proposed standard.

Return:
- Sample reviewed
- Matching approved team standard, if any
- No team overlay applied statement, if none matched
- Issue types observed
- Field usage observed
- Labels observed
- Parent/epic usage observed
- Summary patterns observed
- Description and acceptance-criteria patterns observed
- Validation or QA patterns observed
- Status/comment patterns observed
- Repeated common-task patterns
- Gaps that reduce ticket quality
- Candidate recommendations marked Proposed
- Questions for team owner
- Suggested next step: use global only, draft proposed team standard, or review with team owner
```

## Mobilitas Commercial Program Research Prompts

Use these when researching the Mobilitas Commercial program family across `MOBRM`, `M26`, and `MR26`.

Important framing:

- `MOBRM` is the release management team.
- `M26` and `MR26` are sprint teams with development, QA, and product-owner work.
- Treat all findings as observed patterns until approved by the relevant team or program owner.
- Do not let `MOBRM` examples dominate the research. Compare release-management patterns against sprint-team patterns.
- Do not invent ticket keys, owners, source pages, or board configuration. If the agent cannot see enough evidence, it must say so.

### Cross-Board Standards Discovery

```text
Analyze MOBRM, M26, and MR26 tickets as part of the Mobilitas Commercial program.

Treat patterns as observations only, not policy.

Compare:
- MOBRM release-management tickets
- M26 sprint-team tickets
- MR26 sprint-team tickets

Identify:
- Similarities across all three projects
- Differences between release-management work and sprint-team work
- Field usage patterns
- Summary and description patterns
- Acceptance criteria patterns
- Evidence and validation patterns
- Status comment and handoff patterns
- Gaps that make tickets harder for humans or AI agents to assess

Recommend whether the program should use:
- One combined Mobilitas Commercial Program Standard
- Separate team standards for MOBRM, M26, and MR26
- A shared Mobilitas program standard plus team-specific addenda

Keep documented standards, observed patterns, proposed recommendations, and open questions separate.
```

### Balanced Sample Check

Use this when an answer appears to be relying too heavily on `MOBRM`.

```text
Check whether your analysis actually used evidence from MOBRM, M26, and MR26.

Return:
- Number of MOBRM tickets reviewed
- Number of M26 tickets reviewed
- Number of MR26 tickets reviewed
- Statuses represented
- Issue types represented
- Date range or sprint/release range represented
- Any project with weak or missing evidence

If M26 or MR26 evidence is thin, say so and do not present MOBRM patterns as program-wide standards.
```

### Good Ticket / Weak Ticket Contrast

```text
Review a sample of recently completed MOBRM, M26, and MR26 tickets.

Identify examples that are easy for a new team member or AI agent to understand, and examples that are hard to assess.

Do not name-and-shame individuals.

Summarize:
- Traits that make tickets high-quality
- Traits that make tickets difficult to assess
- Differences between MOBRM procedural/release tickets and M26/MR26 functional sprint tickets
- Recommendations for a ticket quality checklist

Treat recommendations as proposed until approved.
```

### Definition Of Ready Discovery

```text
Analyze tickets that successfully moved from backlog or refinement into active work across MOBRM, M26, and MR26.

Identify what was usually present before work started:
- Project or board context
- Parent or epic link
- fixVersion or release target
- Labels or work type
- Business context
- Source evidence
- Attachments or templates
- ServiceNow references
- Runbook or design links
- Acceptance criteria
- Validation path
- Owner decisions
- Dependencies

Separate:
- Program-wide readiness signals
- MOBRM-specific readiness signals
- M26/MR26 sprint-team readiness signals
- Open questions for owners

Do not claim a field is required unless Jira configuration, workflow validators, documented standards, or owner answers support it.
```

### Definition Of Done / Evidence Discovery

```text
Analyze completed tickets across MOBRM, M26, and MR26.

Identify what evidence was present at completion:
- PR or code links
- Test evidence
- Validation notes
- Screenshots
- Logs
- Generated files
- Rate diff reports
- ServiceNow updates
- Deployment notes
- Final status comments
- Handoff notes

Recommend a proposed evidence checklist for:
- Program-wide tickets
- MOBRM release-management tickets
- M26/MR26 sprint-team tickets

Flag gaps where tickets are marked Done but evidence is missing or hard to find.
```

### Comment Quality Research

```text
Review recent ticket comments across MOBRM, M26, and MR26.

Identify comment patterns that help future humans and AI agents understand:
- Current status
- Completed work
- Validation
- Blockers or risks
- Dependencies
- Handoffs
- Next action
- Evidence links

Also identify low-value comment patterns to avoid, such as bare status updates, bare links, or long threads without a final decision.

Recommend a proposed status comment standard for the Mobilitas Commercial program.
```

### Sprint-To-Release Handoff Discovery

```text
Analyze tickets that appear to hand off work between M26/MR26 sprint teams and MOBRM release management.

Identify what information is needed for a clean handoff:
- Business context
- Effective date
- Source ticket or requirement
- Attached templates or data files
- Target branch or PR
- StandardChange flag or equivalent execution decision
- Target environment
- ServiceNow reference
- Runbook link
- Validation expectation
- Stop condition or dependency

Return:
- Clean handoff patterns
- Common missing information
- Proposed sprint-to-release handoff checklist
- Questions for sprint-team and release-management owners
```

### Common Work Type Classification

```text
Cluster recent MOBRM, M26, and MR26 tickets into common work types.

For each work type, suggest:
- Candidate label
- Summary pattern
- Description expectations
- Required or important evidence
- Acceptance criteria pattern
- Validation expectation
- Whether a How to perform this task section is useful
- Whether the pattern is MOBRM-specific, sprint-team-specific, or program-wide

Do not convert clusters into official labels or standards without owner approval.
```

### AI Readability Audit

```text
Audit selected MOBRM, M26, and MR26 tickets for AI readability.

For each ticket or sample group, assess whether another agent can determine:
- Purpose
- Owner
- Current status
- Dependencies
- Validation
- Release impact
- Next action
- Source evidence
- Whether work is ready, blocked, or done

Return:
- Readability strengths
- Readability gaps
- Suggested ticket structure improvements
- Recommended fields or sections that would help Release Health Analyst, Release Drift Monitor, Jira Work Item Assistant, and future Jira hygiene agents.
```

### Source Evidence Gap Scan

```text
Review selected MOBRM, M26, and MR26 tickets for source evidence gaps.

Look for missing or unclear:
- ServiceNow links
- Confluence requirement pages
- Runbooks
- Design docs
- Attached templates
- PR or branch links
- Test evidence
- Validation artifacts
- Release notes or release scope references
- Owner decisions

Return a prioritized gap list with:
- Severity
- Project
- Ticket key
- Missing evidence
- Impact
- Recommended owner question

Do not invent missing sources.
```

### Proposed Mobilitas Commercial Program Standard

```text
Using only approved standards plus observed patterns from MOBRM, M26, and MR26, draft a proposed Mobilitas Commercial Program Jira Standard.

Include:
- Status: Proposed until approved
- Program scope and does-not-apply boundaries
- Relationship to Organization-Wide Jira Ticket Quality Standard
- Relationship to MOBRM, M26, and MR26 team addenda
- Shared program requirements
- Sprint-team addendum for M26/MR26
- Release-management addendum for MOBRM
- Handoff checklist between sprint teams and release management
- Evidence checklist
- Status comment standard
- AI readability recommendations
- Open questions for program and team owners

Keep these sections separate:
1. Documented standards
2. Team owner answers
3. Observed patterns
4. Proposed recommendations
5. Open questions

Do not mark this standard approved.
```

## Proposed Standard Review

Use this when a team has a draft team standard and wants to know whether it is ready to add under Team Jira Standards.

```text
Review this proposed team Jira standard before it is added to Team Jira Standards.

Proposed standard:
[PASTE OR LINK STANDARD]

Check:
- Team owner named
- Backup owner named
- Jira project key, board, or filter mapping is exact
- Applies automatically when rules are clear
- Does not apply when boundaries are clear
- Required fields are supported by Jira configuration, workflow, or owner confirmation
- Important fields are separated from required fields
- Fields not required by default are documented
- Issue type expectations are clear
- Parent, labels, components, priority, fixVersion, sprint, and assignee expectations are explicit
- Common task patterns are source-backed
- Acceptance criteria and validation expectations are clear
- Observed patterns are not presented as official policy
- Open questions are captured

Return:
- Ready / Needs revision / Not ready
- Blocking gaps
- Recommended revisions
- Questions for owner approval
- Whether the proposed page can be linked from Team Jira Standards
```

## Global-Only Fallback Prompt

Use this when no matching team standard exists or the team does not want to create one yet.

```text
Use the organization-wide Jira ticket quality standard only.

Ticket or draft:
[PASTE TICKET, DRAFT, OR BOARD CONTEXT]

State:
No team overlay applied. I am using the organization-wide Jira ticket quality standard only.

Then return:
- Standards used
- Ticket fields or draft sections reviewed
- P0/P1 gaps
- P2 improvements
- Suggested field text
- Open questions
- Whether a team standard would help in the future
```

## Proposed Team Standard Page Template

Use this output structure for proposed team standards.

```text
# [TEAM] Team Jira Standards

Status: Proposed until approved by [OWNER].

## Team Identity

| Field | Value |
|---|---|
| Team | |
| Jira project key | |
| Board or filter | |
| Team owner | |
| Backup owner | |
| Review cadence | |
| Applies automatically when | |
| Does not apply when | |

## Source And Approval Notes

- Documented sources:
- Team owner answers:
- Observed sample tickets:
- Proposed recommendations:
- Open questions:

## Issue Types In Scope

| Issue type | Expected use | Required sections |
|---|---|---|

## Field Expectations

| Field | Required / Important / Not required by default | Rule | Evidence |
|---|---|---|---|

## Labels And Metadata

| Label or field | When to use | Notes |
|---|---|---|

## Summary And Description Standards

| Work type | Summary pattern | Description expectations |
|---|---|---|

## Acceptance Criteria And Validation

| Work type | Acceptance criteria expectations | Validation expectations |
|---|---|---|

## Common Task Patterns

| Task | When to use | Source/runbook | Required ticket guidance |
|---|---|---|---|

## Status Comment Expectations

| Comment type | Expected content |
|---|---|
| Progress update | Completed work, current status, next action. |
| Validation evidence | Validation performed, environment, evidence link, result. |
| Blocker/risk update | Blocker, impact, owner, next action. |
| Handoff note | What changed, what remains, who owns next step. |

## Open Questions

| Question | Owner | Needed before approval? |
|---|---|---|

## Approval

| Field | Value |
|---|---|
| Approved by | |
| Approval date | |
| Effective date | |
```
