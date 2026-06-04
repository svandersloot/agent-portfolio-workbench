# Jira Work Item Assistant Migration Discovery - 2026-06-03

## Source Status

The user requested migration of Jira Work Item Assistant from the legacy MO source folder to the ROVO inventory space.

Legacy source supplied by user:

```text
https://csaaig.atlassian.net/wiki/spaces/MO/folder/5090410548
```

Target space supplied by user:

```text
https://csaaig.atlassian.net/wiki/spaces/ROVO
```

Chrome authenticated retrieval was attempted during this migration turn, but the local Chrome extension bridge reported it was not trusted. The legacy folder content was therefore not captured in this repo during this pass.

This scaffold is based on:

- The user's stated intent: create consistent, richer Jira tickets so humans can learn common tasks and AI can assess/read the work better.
- Existing repo references that list Jira Work Item Assistant as `Draft / Review Needed`.
- Existing governed patterns for Release Notes Manager, Jira Ticket Polisher, Release Health Analyst, and Release Drift Monitor.
- Existing Jira standards pages under Jira Ticket Polisher.

## Migration Hypothesis

Jira Work Item Assistant should become a governed agent in `In Review`, not just an automation or prompt, because the workflow is repeatable, release-specific, source-backed, and likely to involve write-capable Jira behavior after approval.

Proposed mission:

```text
Help release owners and delivery leads turn release/Kanban context into clear, source-backed Jira work items and common-task guidance that humans and AI can understand, assess, and execute consistently.
```

## User Decisions Captured

| Question Area | Current Decision |
|---|---|
| Scope | Design broader than MOBRM, but prove with MOBRM first. Do not create one agent per team by default. |
| First pilot board | MOBRM board/project: `https://csaaig.atlassian.net/jira/software/c/projects/MOBRM` |
| Standards model | Use a global Jira ticket standard plus documented team standards. MOBRM is the first team overlay. |
| Jira creation | The agent should be able to create Jira tickets after explicit human approval through a governed write path. |
| Bulk creation | Bulk candidate ticket creation should be supported when multiple tickets are known up front. |
| MOBRM required fields | Parent and labels are the first required/important fields. fixVersion, component, priority, and sprint are not required for the MOBRM pilot. |
| How-to section | Not every ticket needs `How to perform this task`; use it for repeatable/common/script-driven tasks. |
| Common-task candidates | SER updates, parse break updates, producer org updates, and prod sync updates. |
| Approver | Human in the loop; the human requester/reviewer approves before Jira creation. |
| Jira Ticket Polisher role | May become optional for this workflow if Jira Work Item Assistant applies standards directly; keep it available as an independent quality gate for strict review and non-release ticket polishing. |
| Team standards page creation | Jira Work Item Assistant should help draft proposed team standards pages by asking about required fields, important fields, fields not required by default, project/board mapping, labels, parent expectations, issue types, and common task patterns. Draft standards are not official until approved. |
| Global standard ownership | No owner yet. Publish as draft/best-practice guidance, not final policy; later research and owner review should harden it. |
| Future team expansion | Future teams should add team standards pages instead of new agents unless their workflow is materially different. |
| Legacy MO documentation | Build the new agent from scratch and treat old Release Management Assistant documentation as archive/superseded unless useful source content is explicitly brought forward. |

## Fit Boundary

| Related agent | Boundary |
|---|---|
| Jira Ticket Polisher | Owns standards-based ticket quality review and field polishing. Jira Work Item Assistant may use the same standards directly for first-pass drafting, then escalate to Jira Ticket Polisher for strict review. |
| Release Notes Manager | Owns release notes, business summaries, and release-note synchronization. |
| Release Health Analyst | Owns release readiness, blockers, source completeness, and go/no-go style assessment. |
| Release Drift Monitor | Owns evidence drift detection before code freeze. |

## The Grill

These questions should be answered before promotion beyond `In Review`.

### Mission And Audience

1. Who is the primary user: release manager, scrum master, product owner, engineering lead, QA lead, or you personally as pilot owner?
2. Is this agent for MOBRM only at first, or for any team with a documented Jira standard? Answer: broader than MOBRM, but prove with MOBRM first.
3. Should the agent teach a new human how to perform the task, or only draft the Jira ticket that contains that guidance?
4. What does a "rich ticket" mean for your team: detailed steps, acceptance criteria, validation evidence, rollback, screenshots, source links, owner/backup, or all of those?
5. What should the agent optimize for when there is tension: speed, completeness, onboarding value, reporting quality, AI readability, or release safety?

### Source And Standards

6. Which Jira project and Kanban board should be first pilot scope? Answer: MOBRM board/project at `https://csaaig.atlassian.net/jira/software/c/projects/MOBRM`.
7. Which team standard should apply first: MOBRM Team Jira Standards, another page in the MO folder, or a standard not yet migrated? Answer: global standard plus MOBRM team standard for the pilot.
8. Should Jira Work Item Assistant read the Organization-Wide Jira Ticket Quality Standard directly, or should Jira Ticket Polisher be the only standards gate?
9. What release sources are authoritative: fixVersion, release calendar, release plan page, change ticket, deployment notes, current Kanban board, or a weekly meeting page?
10. Are there common task templates already hiding in the MO folder, or should we derive them from current team tickets?
10a. Should the assistant help draft team standards pages? Answer: yes, as proposed standards pages for human/team owner review.

### Ticket Creation And Approval

11. May the agent create Jira tickets after explicit approval, or should it only return copy-ready drafts during pilot? Answer: create after explicit human approval should be supported through a governed write path.
12. If creation is allowed later, who approves: requester, release owner, product owner, scrum master, or team lead? Answer: human in the loop; the human requester/reviewer approves.
13. What fields must be set deterministically before create: project, issue type, parent, fixVersion, component, labels, priority, assignee, sprint, target status, or board placement? Answer for MOBRM pilot: parent and labels first; fixVersion, component, priority, and sprint are not required.
14. Should the agent be allowed to split one request into multiple candidate tickets? Answer: yes, bulk candidate tickets should be supported when multiple tickets are known up front.
15. Should the agent ever update existing tickets, or only create new draft candidates?

### Common Tasks And AI Assessment

16. What are the first three common tasks this should make teachable? Answer: SER updates, parse break updates, producer org updates, and prod sync updates.
17. What does "AI giving a better assessment and reading on things" mean in practice: clearer ticket summaries, structured acceptance criteria, explicit evidence, status flags, risk classification, or dependency mapping?
18. Should every ticket include a "How to perform this task" section? Answer: no; include it only when the work is a repeatable/common/script-driven task or when the user asks for training/onboarding value.
19. Should every ticket include an "AI assessment hints" section with source links, done criteria, risk, and validation signals?
20. Should the agent keep implementation steps beginner-friendly, or assume the reader knows internal systems?

### Safety And Boundaries

21. What should the agent refuse to do even if asked?
22. Should release readiness or go/no-go questions always route to Release Health Analyst?
23. Should release notes always route to Release Notes Manager?
24. Can the agent use sample tickets as observed patterns, or only documented standards?
25. What private or sensitive data must never be copied into generated tickets?

## Remaining Questions Before Publish

1. Should the display/domain be `Jira Work Item Assistant` under Jira Hygiene Agents, Release and Change Agents, or both via cross-link?
2. What default issue type should the MOBRM pilot use when the user does not specify one?
3. What exact Jira create tool/action will be enabled in Studio, and how will approval be captured for one ticket and bulk ticket sets?
4. Who should be named as temporary owner for the draft global Jira ticket standard?
5. Which Confluence pages should be used as source material for SER updates, parse break updates, producer org updates, and prod sync updates?
6. Should the old MO folder be archived with a pointer to Jira Work Item Assistant, or left untouched as legacy evidence?

## Initial Global Standard Research Notes

These notes support keeping the organization-wide Jira ticket standard in draft/best-practice status until an owner reviews it.

| Source | Relevant finding for global standard |
|---|---|
| Atlassian Support: Create a work item and a subtask | Jira creation starts with Summary and requires completing required and relevant fields; Jira may pre-populate some fields, so generated drafts still need human review before creation. |
| Atlassian Support: Required fields in Jira Cloud | Required fields can come from field configuration or workflow validators, and missing create-screen fields can block issue creation. The assistant should not assume global required fields beyond the target project/work type. |
| Atlassian Support: Parent required in company-managed projects | Parent can be made mandatory with a workflow validator on create. This supports treating parent as a team/project-specific field expectation, not an org-wide default. |
| Atlassian Support: Board filters | Labels and parent/epic filters help users find and organize board work. This supports labels as useful discovery metadata while keeping label conventions team-owned. |
| Atlassian Support: Jira automation actions | Jira automation create actions can set fields with smart values and require create permissions. This supports a governed create path after explicit human approval. |

Source URLs:

- `https://support.atlassian.com/jira-core-cloud/docs/create-an-issue-and-a-sub-task/`
- `https://support.atlassian.com/jira/kb/cant-create-issues-because-of-required-fields-in-jira-cloud/`
- `https://support.atlassian.com/jira/kb/how-to-make-the-parent-field-required-mandatory-on-the-issue-create-screen-in-company-managed-projects/`
- `https://support.atlassian.com/jira-software-cloud/docs/show-or-hide-issues-on-your-board/`
- `https://support.atlassian.com/jira-software-cloud/docs/automation-actions/`

## Recommended Pilot Shape

Start with a conversation-first pilot:

```text
User talks to Jira Work Item Assistant in Kanban context
-> Assistant drafts one rich candidate Jira ticket
-> Assistant applies org-wide and team Jira standards where available
-> Assistant flags missing context and asks clarifying questions
-> Optional: assistant sends draft bundle to Jira Ticket Polisher for review
-> User approves or revises
-> Approved Jira creation can run only through a governed human-approved write path
```

Do not enable unattended Jira creation. A future create action may be enabled only after the approval artifact, required field mappings, and bulk-create behavior are tested.

## Companion Artifacts Created

| Artifact | Path |
|---|---|
| Project Brain | `docs/confluence-pages/jira-work-item-assistant-project-brain.md` |
| Agent Design Record | `docs/confluence-pages/jira-work-item-assistant-agent-design-record.md` |
| Knowledge Source Plan | `docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md` |
| Subagent Settings | `docs/confluence-pages/jira-work-item-assistant-subagent-settings.md` |
| ROVO Studio Configuration | `docs/confluence-pages/jira-work-item-assistant-rovo-studio-configuration.md` |
| Evaluation | `docs/confluence-pages/jira-work-item-assistant-evaluation.md` |
| Measurement Plan | `docs/confluence-pages/jira-work-item-assistant-measurement-plan.md` |
| Change Log | `docs/confluence-pages/jira-work-item-assistant-change-log.md` |

## Publication Safety

- No Confluence pages were created or updated.
- No Jira issues were read, created, or updated.
- No Studio configuration was changed.
- Legacy MO folder content still needs authenticated capture, paste, export, or manual review before publication.
