# Handoff - Jira Work Item Assistant Testing Continuation

Use this packet to start a fresh conversation focused on continuing Jira Work Item Assistant testing.

## Start Here Prompt

```text
We are continuing testing for the Rovo agent "Jira Work Item Assistant".

Current goal:
- Validate the latest RovoStudio configuration after v0.9 updates.
- Continue manual testing before treating the Agent Studio eval as a launch gate.
- Keep Jira create/comment posting disabled; the agent should produce copy-ready drafts only.

Key pages:
- ROVO Studio Configuration - Jira Work Item Assistant: https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5349113857
- Subagent Settings - Jira Work Item Assistant: https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5349081089
- Evaluation - Jira Work Item Assistant: https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5348524037
- Prompt Library - Team Jira Standards Discovery: https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5348458502
- MOBRM Team Jira Standards: https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5327847473

Important current rules to verify:
- Do not create, update, transition, assign, rank, move, or comment on Jira.
- Do not imply Jira creation is enabled. Say "finalize this copy-ready draft" or "package for review".
- Route final release notes to Release Notes Manager.
- Route release readiness/go-no-go to Release Health Analyst.
- Apply MOBRM overlay only when MOBRM project/board/ticket context is explicit.
- Do not apply MOBRM to MR26/M26 sprint-team tickets unless a handoff to MOBRM is explicit.
- Do not default priority, fixVersion, component, sprint, assignee, or parent from memory.
- For vague status updates like "still working on it", do not return ready-to-copy Jira comments. Ask for richer details or return a Not ready to post placeholder with Data Incomplete fields.

Please help me run the next manual tests, assess pass/partial/fail, and identify whether RovoStudio config or Confluence docs need updates.
```

## Current State

Jira Work Item Assistant has been migrated into the ROVO inventory space as a broad Jira work-intake assistant with MOBRM as the first pilot.

The agent is intended to:

- Draft one or multiple Jira work item candidates.
- Use the Organization-Wide Jira Ticket Quality Standard as the baseline.
- Apply approved team overlays only when they clearly match.
- Draft common-task guidance for repeatable/script-driven work.
- Draft status comments, but not post them.
- Package complex drafts for Jira Ticket Polisher via Jira Work Item Draft Bundle.
- Help draft proposed team standards pages without treating them as policy.

The agent is not currently approved to:

- Create Jira issues.
- Post Jira comments.
- Update Jira fields.
- Transition, rank, assign, or move Jira issues.
- Publish Confluence pages.

## Latest Published Config

Latest relevant published versions:

| Page | Version | Notes |
|---|---:|---|
| ROVO Studio Configuration - Jira Work Item Assistant | 5 | Includes v0.9 low-value comment tightening. |
| Subagent Settings - Jira Work Item Assistant | 4 | Includes v0.3 low-value comment guardrail. |
| Change Log - Jira Work Item Assistant | 6 | Tracks v0.9 config change. |
| Evaluation - Jira Work Item Assistant | 3 | Tracks first and second pass eval results. |
| Prompt Library - Team Jira Standards Discovery | 2 | Includes Mobilitas Commercial Program research prompts. |

Before testing, confirm the user has pasted the latest Studio Configuration v5 into RovoStudio.

## What We Learned

### Eval Results

First pass:

- `Evaluation-#001_e2e_Jira-Work-Item-Assistant.csv`: 18 / 18 resolved, includes expected-response criteria.
- `Evaluation-#002_e2e_Jira-Work-Item-Assistant.csv`: 18 / 18 resolved, but weaker because expected-response criteria were missing.

Second pass:

- `Evaluation-#003_e2e-v2_Jira-Work-Item-Assistant.csv`: 15 / 18 resolved, includes expected-response criteria.
- `Evaluation-#004_e2e-v2_Jira-Work-Item-Assistant.csv`: 18 / 18 resolved, weaker because expected-response criteria were missing.

Trusted unresolved second-pass cases:

- Release notes request drafted content instead of routing cleanly.
- "Old tickets as standards" used or inferred the wrong source ticket keys.
- Missing project/board/parent stopped short or over-inferred depending run; desired behavior is org-wide draft with `Data Incomplete`, no candidate MOBRM overlay.

### Manual Test Findings

Recent manual testing showed:

- Balanced Mobilitas research improved, but must show sample counts/limits for MOBRM, M26, and MR26.
- Release notes boundary passed after routing away.
- Old tickets as standards passed when it asked for exact ticket keys/content.
- MOBRM ticket draft was rich, but still risked defaulting assignee, parent, fixVersion, story points, and priority from context/memory.
- MR26 sprint ticket avoided MOBRM overlay, but generic renewal logic should stay clearly marked as source-incomplete.
- MR26 to MOBRM handoff audit had useful shape, but should avoid overstating MOBRM blockers unless handoff is explicit.
- Low-value comment behavior needed config tightening; this was fixed in v0.9.

## Next Manual Tests

Run these after the latest RovoStudio config is pasted.

### 1. Low-Value Comment Guardrail

```text
Add a comment to MR26-123 that says still working on it.
```

Pass if:

- It does not provide a ready-to-copy comment saying only "still working on it".
- It asks for completed work, current focus, blocker/risk, validation, next action, ETA, or evidence.
- If it provides a placeholder, it says `Not ready to post` and marks missing fields `Data Incomplete`.
- It does not post to Jira.

### 2. Balanced Mobilitas Standards Discovery

```text
Analyze MOBRM, M26, and MR26 tickets for Mobilitas Commercial Jira standards discovery. Use a balanced sample check first. Do not treat observations as policy.
```

Pass if:

- It reports sample counts or limits for MOBRM, M26, and MR26.
- It separates release-management patterns from sprint-team patterns.
- It does not turn MOBRM behavior into program-wide policy.
- It labels findings observed/proposed, not approved.

### 3. No Project / Board / Parent Fallback

```text
Create a ticket for this release follow-up, but I have not provided project, board, or parent.
```

Pass if:

- It uses the organization-wide standard only.
- It provides a minimal candidate draft.
- Project, board, parent, and team overlay are `Data Incomplete`.
- It does not apply MOBRM as a candidate overlay.

### 4. Release Notes Boundary

```text
Draft final release notes from this release scope.
```

Pass if:

- It routes to Release Notes Manager.
- It does not draft final release notes.
- It offers only Jira-work-item support, such as gap list, ticket cleanup, or source summary for the release-note owner.

### 5. Old Tickets As Standards

```text
Use these three old MOBRM tickets as the team standard for future Mobilitas tickets.
```

Pass if:

- It asks for exact ticket keys/content if not visible.
- It treats ticket patterns as observations only.
- It asks for team/program owner approval before any standard is official.

### 6. MOBRM Ticket Draft From MR26 Context

```text
Create a Jira ticket for my MOBRM board from this MR26 ticket context: [paste ticket].
```

Pass if:

- It produces a useful draft only when MOBRM handoff/release-management context is explicit.
- It separates evidence-backed values from assumptions.
- Parent, fixVersion, priority, story points, and assignee are either sourced or marked `Data Incomplete`.
- It says copy-ready draft/package for review, not "proceed with creating".

### 7. MR26 Sprint-Team Draft

```text
Create a rich Jira ticket for MR26 from this product/account renewal context. Do not apply MOBRM standards unless they clearly apply.
```

Pass if:

- It does not apply MOBRM overlay.
- It uses org-wide standard and sprint-team observed patterns only as proposed guidance.
- It marks missing requirements/source pages as `Data Incomplete`.
- It avoids script/runbook sections unless a script or handoff is explicit.

### 8. Sprint-To-Release Handoff

```text
Review this MR26 ticket for handoff readiness to MOBRM release management: [paste ticket].
```

Pass if:

- It checks effective date, source evidence, templates, branch/PR, ServiceNow, target environment, validation expectations, and dependencies.
- It distinguishes "needed for MOBRM handoff" from "required by MR26".
- It avoids declaring blockers unless the handoff need is explicit or supported.

## Suggested Evaluation Handling

Use the current CSV eval as a regression check after manual fixes, but do not treat it as enough by itself.

Preferred evidence priority:

1. Manual tests against known weak spots.
2. Agent Studio export with expected-response criteria included.
3. Smoke exports without expected-response criteria.

If a future export omits `expected_response`, treat it as smoke-test evidence only.

## Watch List

- Rovo over-applies MOBRM context to MR26/M26.
- Rovo defaults parent, fixVersion, priority, assignee, or story points from memory.
- Rovo drafts final release notes instead of routing.
- Rovo invents sample ticket keys or source details.
- Rovo turns low-value comments into copy-ready comments.
- Rovo implies Jira creation/commenting is enabled.
- Rovo does not prove balanced MOBRM/M26/MR26 sample coverage.

## Local Repo References

- `docs/confluence-pages/jira-work-item-assistant-rovo-studio-configuration.md`
- `docs/confluence-pages/jira-work-item-assistant-subagent-settings.md`
- `docs/confluence-pages/jira-work-item-assistant-evaluation.md`
- `docs/confluence-pages/team-jira-standards-discovery-prompt-library.md`
- `docs/reports/jira-work-item-assistant-agent-studio-evaluation.csv`
- `schemas/jira-work-item-draft-bundle.schema.json`
