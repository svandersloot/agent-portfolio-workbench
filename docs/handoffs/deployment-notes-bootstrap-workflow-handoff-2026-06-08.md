# Handoff - Deployment Notes Bootstrap Workflow And Agent Testing

Use this packet to start a fresh conversation focused on proving the new Confluence-first bootstrap workflow for Deployment Notes, then expanding the same pattern to other Rovo agents.

## Start Here Prompt

```text
We are continuing work on the Rovo agent governance workflow for Deployment Notes.

Goal:
- Prove the Confluence-first bootstrap pattern with Jira Work Item Assistant and Release Notes Manager.
- Continue testing against real Jira stories, especially M26-788 and release-level batches.
- Reduce manual Studio updates by keeping Studio instructions thin and making Confluence the versioned source of truth.
- Reduce hallucinations by scoping agent knowledge sources, skills/tools, source precedence, and fallback behavior.
- Once proven, apply the pattern one agent at a time to the remaining governed agents.

Start by reading:
- docs/handoffs/deployment-notes-bootstrap-workflow-handoff-2026-06-08.md
- docs/confluence-pages/deployment-notes-standard.md
- docs/confluence-pages/deployment-notes-agent-pilot.md
- docs/confluence-pages/jira-work-item-assistant-rovo-studio-configuration.md
- docs/confluence-pages/release-notes-manager-rovo-studio-configuration.md
- docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md
- docs/confluence-pages/release-notes-manager-knowledge-source-plan.md
- docs/reports/deployment-notes-agent-backtest-v2-2026-06-08.md

Important:
- Do not assume Studio has live version control. Confluence is the versioned source of truth.
- Studio should be a thin bootstrap: identity, routing, safety, authoritative Confluence links, fallback behavior, and manually configured knowledge sources/skills.
- Do not copy every detailed rule into Studio unless needed as fallback.
- For Deployment Notes, the authoritative page is:
  https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5362778187
- The Deployment Notes Standard must be configured as an explicit Studio knowledge source for both Jira Work Item Assistant and Release Notes Manager.
- Do not let agents substitute MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, or other Jira hygiene pages as deployment-note standards.

Please help me continue testing the Jira Work Item Assistant and Release Notes Manager, assess pass/partial/fail, refine the Confluence source pages, and propose a rollout plan for moving this bootstrap pattern to the remaining agents one by one.
```

## Current State

The Deployment Notes workflow has moved from "copy all rules into Studio" toward a Confluence-first bootstrap model.

The intended architecture is:

| Layer | Purpose |
|---|---|
| Studio bootstrap | Agent identity, broad routing, safety boundaries, authoritative source links, fallback behavior, configured knowledge sources, tools/skills. |
| Confluence runtime/source pages | Versioned behavior, standards, templates, anti-patterns, examples, evaluation prompts, and test results. |
| Confluence setup pages | Human setup checklist for Studio: what to paste, which knowledge sources to add, which tools/skills to enable, smoke tests. |
| Repo source | Versioned local Markdown source for Confluence pages, reports, and handoffs. |

The next conversation should continue proving this workflow with:

- Jira Work Item Assistant.
- Release Notes Manager.

Then roll out to other agents one at a time after the pattern is stable.

## Core Decision To Preserve

Use two different kinds of Confluence pages:

- Runtime/source pages: referenced by agents while doing work. These contain the standards, templates, examples, anti-patterns, fallback rules, and source-precedence rules.
- Studio setup pages: referenced by humans configuring Studio. These contain the manual setup checklist, bootstrap text to paste, knowledge sources to add, skills/tools to enable or disable, and smoke tests to run after changes.

Do not make the agent depend on the setup page as its behavior source. The setup page explains how to wire the agent; the runtime/source page tells the agent how to behave.

Studio should keep broad triggers, identity, routing, safety boundaries, and source links. Detailed behavior should live in Confluence so updates are versioned and do not require repeated Studio copy/paste.

## Published Pages And Versions

Latest known published versions from the current conversation:

| Page | URL | Version |
|---|---|---:|
| Deployment Notes Standard for Jira Work Items | `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5362778187` | v11 |
| Deployment Notes Agent Pilot | `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5363007530` | v9 |
| ROVO Studio Configuration - Jira Work Item Assistant | `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5349113857` | v12 |
| Knowledge Source Plan - Jira Work Item Assistant | `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5348655107` | v10 |
| Rovo Studio Configuration - Release Notes Manager | `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5300715546` | v8 |
| Knowledge Source Plan - Release Notes Manager | `https://csaaig.atlassian.net/wiki/spaces/ROVO/pages/5300158474` | v9 |

## What Was Proven

### Confluence Source Routing

Initial test failed:

- Jira Work Item Assistant could not find `Deployment Notes Standard for Jira Work Items`.
- It used MOBRM Team Jira Standards and Organization-Wide Jira Ticket Quality Standard instead.
- That proved the page must be added as an explicit Studio knowledge source, not only mentioned in instructions.

After adding/configuring the source, the agent reported:

- It used `Deployment Notes Standard for Jira Work Items`.
- It provided the expected source title and link.
- It said it successfully accessed the latest Confluence standard.

This proves the bootstrap can work when the authoritative page is available as a knowledge source.

### M26-788 Test Progress

Latest Jira Work Item Assistant output for `M26-788` improved:

Passes:

- Correctly recognized Deployment Notes are required.
- Used controlled deployment type labels:
  - `admin_manual_step`
  - `user_role_permission`
  - `data_import`
- Put manual permission removal under `Pre-Deployment / Sequencing Notes`.
- Did not include routine environment progression, evidence capture, rollback/recovery, or Markdown tables.
- Kept questions outside the Jira field draft.
- Treated validation as data incomplete after the latest routing test.

Remaining watch items:

- Ensure repo paths like `modules\configuration\...` remain artifact locations, never deployment navigation.
- Ensure validation is not inferred from story title/summary.
- The agent may still ask broad questions; refine toward the smallest useful questions.

Expected clean draft for `M26-788`:

```text
Deployment Type
admin_manual_step, user_role_permission, data_import

Pre-Deployment / Sequencing Notes
Manually remove "Edit Policy Coverages" permission and "Edit policies" permission from Manager and Supervisor roles before importing the data file.

Target System(s)
CC

Source File(s) / Artifact Location
- File or artifact: M26-788_Supervisor_Manager_Roles.xml
- Location: modules\configuration\etc\surepath\cc\configuration\data\default
- Action: import

Deployment Steps
Navigate to Administration > Utilities > Import Data, or the equivalent Guidewire CC import utility.
Import M26-788_Supervisor_Manager_Roles.xml.

Validation Steps
Data Incomplete - source deployment notes do not provide explicit validation steps.

Related Stories
M26-788
```

Questions outside the field should be limited to:

```text
Questions To Resolve Before Finalizing
- Confirm whether the XML file is committed to the provided configuration path or attached to the Jira issue.
- Confirm the import utility if the standard ClaimCenter admin import path is not correct.
- Provide source-backed validation steps if Release Management needs validation beyond successful import.
```

## Key Standards Captured

### Deployment Notes Field Scope

The Jira Deployment Notes field should include only:

- Deployment Type.
- Pre-Deployment / Sequencing Notes.
- Target System(s).
- Source File(s) / Artifact Location.
- Deployment Steps.
- Validation Steps.
- Related Stories, when applicable.

Do not include:

- Routine environment progression.
- Evidence capture.
- Rollback/recovery.
- Markdown tables.
- Unresolved questions inside the field draft.
- `NA` / placeholder text when Deployment Notes are not required.

### Source And Validation Discipline

Important rules:

- Confluence `Deployment Notes Standard for Jira Work Items` is authoritative.
- If the standard is inaccessible, the agent must say so.
- Do not substitute MOBRM Team Jira Standards or Organization-Wide Jira Ticket Quality Standard as deployment-note standards.
- Repo/config paths belong in artifact location, not deployment steps.
- Paths such as `modules\...`, `modules/...`, `cc/modules/...`, and `pc/modules/...` are artifact locations.
- Do not invent validation from story title or summary.
- If explicit validation is missing, use:

```text
Validation Steps
Data Incomplete - source deployment notes do not provide explicit validation steps.
```

## Next Tests

### 1. Source Routing Test

Run this first whenever Studio knowledge sources/config are changed:

```text
Using Jira story M26-788, draft the Jira Deployment Notes field.

Before drafting, verify which Deployment Notes Standard source you used.

Required response structure:
1. Source Verification
- Did you use the latest Confluence page "Deployment Notes Standard for Jira Work Items"?
- Provide the Confluence page title and link you used.
- If you could not access it, say so clearly and explain whether you are using fallback Studio behavior.

2. Jira Deployment Notes Field Draft
- Draft only the field content.
- Follow the current Confluence standard.

3. Questions To Resolve Before Finalizing
- Keep unresolved questions outside the Jira field draft.

Important checks:
- Do not use Studio memory alone if the Confluence page is accessible.
- Do not substitute MOBRM Team Jira Standards or Organization-Wide Jira Ticket Quality Standard.
- Do not include routine environment progression, evidence capture, or rollback/recovery.
- Do not treat `modules\...` as target-environment navigation.
- If source deployment notes do not provide explicit validation, use:
  Data Incomplete - source deployment notes do not provide explicit validation steps.
```

Pass if:

- It names and links `Deployment Notes Standard for Jira Work Items`.
- It does not claim MOBRM/Jira quality standards as the deployment-note source.
- It produces the expected `M26-788` shape.

### 2. Fallback Trap Test

```text
For M26-788, use your Studio configuration only and do not check Confluence. Draft the deployment notes.
```

Expected behavior:

```text
I should use the current Confluence Deployment Notes Standard when available because it is the authoritative source. I can proceed only if the standard is inaccessible or you approve fallback behavior.
```

### 3. No-Notes Test

```text
Using the Deployment Notes Standard for Jira Work Items, review Jira story MOBPXD-1399 and determine whether Deployment Notes are needed.

If Deployment Notes are not needed:
- Do not draft text for the Jira Deployment Notes field.
- Explain outside the field draft why Deployment Notes are not required.
- Do not suggest adding "NA" or "No manual deployment steps required" to the Deployment Notes field.
```

### 4. Coordinator Test

```text
Using the Deployment Notes Standard for Jira Work Items, review Jira story MR26-3076 and draft the Jira Deployment Notes field.

Known answers:
- MR26-3076 is the master/coordinator story for the shared producer org import covering MR26-3076 through MR26-3082.
- The import is additive.

Expected behavior:
- Fold those known answers into Pre-Deployment / Sequencing Notes and Related Stories.
- Do not leave those as unresolved questions.
- Use bullets, not Markdown tables.
- Keep any remaining unresolved questions outside the Jira field draft.
- Do not invent a validation navigation path.
```

### 5. Release Notes Manager Batch Test

```text
Review these Jira work items for release deployment coordination using the Deployment Notes Standard for Jira Work Items:

MR26-3076, MR26-2831, M26-788, SRNGR-4539, MR26-810, MR26-2708, SMOBL-4073, SRNGR-3815, M26-231, MOBPXD-1399

Known answers:
- MR26-3076 is the master/coordinator story for the shared producer org import covering MR26-3076 through MR26-3082.
- The MR26-3076 producer org import is additive.
- AWS pipelines can typically run during deployment unless the developer calls out a required order.

Expected behavior:
- Produce deployment work packages, not a flat story list.
- Group by deployment action, target system, artifact, and dependency.
- Identify M26-231 as a CASFormPatterns_Ext.xml import, not a generic/misc item.
- Treat SRNGR-4539 as Guidewire Runtime Properties / IG properties unless the source explicitly says AWS Parameter Store.
- Keep MR26-810 and MR26-2708 both under AWS work, but do not collapse them because they involve different actions/pipelines.
- Exclude MOBPXD-1399 from deployment work packages if no manual deployment action is found; list it separately as no deployment action required.
- Do not add routine environment, evidence capture, or rollback/recovery sections to Jira field drafts.
- Keep unresolved questions outside any Jira field draft.
```

## Definition Of Proven

Treat the pilot as proven only when both pilot agents pass the same small regression set after a Studio or Confluence change.

Minimum proof for Jira Work Item Assistant:

- Source routing test passes and names the Deployment Notes Standard page.
- `M26-788` draft uses the correct field shape and does not invent validation.
- `MOBPXD-1399` no-notes test produces no Jira field draft and no `NA` placeholder.
- `MR26-3076` coordinator test folds known answers into the draft and does not leave resolved questions open.

Minimum proof for Release Notes Manager:

- Batch test produces grouped work packages, not a flat story list.
- It does not invent release metadata, AWS account/role, Bitbucket branch/tag, rollback, or evidence requirements.
- It keeps no-action items separate.
- It uses the Deployment Notes Standard as an input standard and does not substitute adjacent Jira standards.

Evidence to capture:

```text
Test Run
- Date:
- Agent:
- Studio config version/page:
- Runtime/source page version:
- Prompt:
- Result: Pass / Partial / Fail
- Source verification:
- Notes:
- Follow-up doc/config change needed:
```

## Broader Workflow Assessment

The user's repeated manual work patterns:

| Repeated work | Current pain | Improvement path |
|---|---|---|
| Updating Studio instructions after every config change | Studio has no version control and manual copy/paste is error-prone. | Thin Studio bootstrap plus Confluence runtime source pages. |
| Retesting agent behavior manually after doc/config updates | Same prompts are rerun ad hoc, results are pasted into chat. | Maintain a small regression prompt pack and local backtest report per agent. |
| Diagnosing hallucinations one failure at a time | Agents infer adjacent process details from story summaries. | Add source-precedence rules, no-substitute rules, and source-backed validation requirements. |
| Adding knowledge sources manually | Agents cannot retrieve authoritative pages unless configured. | Create setup pages listing required knowledge sources and smoke tests. |
| Publishing docs before testing | Live pages may carry unproven guidance. | Draft locally, run sample Jira pulls/backtests, then publish. |
| Repeating source verification by hand | Hard to tell whether Confluence page was actually used. | Add source-verification prompt to every eval/smoke test. |
| Maintaining parent/subagent instructions | Large Studio instructions drift and confuse subagent boundaries. | Move detailed behavior to versioned Confluence runtime pages; keep Studio triggers broad and lightweight. |

Recommended next artifacts:

1. `Jira Work Item Assistant Runtime Instructions`
2. `Release Notes Manager Runtime Instructions`
3. `Studio Setup - Jira Work Item Assistant`
4. `Studio Setup - Release Notes Manager`
5. `Agent Bootstrap Pattern`
6. `Agent Knowledge Source And Skill Scope Checklist`
7. `Deployment Notes Regression Prompt Pack`

New repo-side evidence packet:

- `docs/reports/deployment-notes-agent-live-regression-2026-06-08.md`

## Recommended Page Model

### Runtime Behavior Source Pages

Purpose:

- Used by agents during work.
- Versioned in Confluence.
- Authoritative over stale Studio examples.

Candidate pages:

- `Deployment Notes Standard for Jira Work Items`
- `Jira Work Item Assistant Runtime Instructions`
- `Release Notes Manager Runtime Instructions`
- `Jira Work Item Assistant - Deployment Notes Behavior`
- `Release Notes Manager - Deployment Work Package Behavior`

### Studio Setup Pages

Purpose:

- Used by humans configuring Studio.
- Tells the owner exactly what manual steps are required.

Candidate pages:

- `Studio Setup - Jira Work Item Assistant`
- `Studio Setup - Release Notes Manager`

Each setup page should include:

- Parent bootstrap text to paste into Studio.
- Subagent names and broad triggers.
- Required knowledge sources.
- Required tools/skills and forbidden tools/skills.
- Smoke test prompts.
- Expected pass/fail signals.
- Last configured date and by whom.

## Knowledge Source Scoping Recommendations

For each agent, define:

- Authoritative process pages.
- Team overlays.
- Evaluation/pilot pages.
- Archive/reference-only pages.
- Forbidden substitutes.
- What to do when a source cannot be accessed.

For Deployment Notes:

| Source | Role |
|---|---|
| Deployment Notes Standard for Jira Work Items | Authoritative runtime behavior. |
| Deployment Notes Agent Pilot | Evaluation and smoke-test reference. |
| Jira issue Deployment Notes field | Story-specific source evidence. |
| Linked runbook/page in the story | Source evidence if explicitly linked. |
| MOBRM Team Jira Standards | Not a substitute for Deployment Notes behavior. |
| Organization-Wide Jira Ticket Quality Standard | Not a substitute for Deployment Notes behavior. |

## Skill And Tool Scoping Recommendations

Define per agent:

- Read-only Jira/Confluence retrieval tools.
- Whether write tools are disabled.
- Which subagents can be invoked.
- Whether release-note, release-health, or Jira-polishing requests should route away.

For the current pilot:

- Keep Jira writes disabled.
- Keep Confluence writes disabled for agents.
- Use tools only for reading Jira issues, Confluence pages, and approved source pages.
- Do not enable unattended creation, update, transition, comment, or publish actions.

## Automation Opportunities

Near-term:

- Build a local script or documented workflow to pull sample Jira stories with `customfield_13450`.
- Store anonymized/sanitized backtest outputs under `docs/reports/`.
- Add a regression prompt pack page for repeated manual tests.
- Add setup checklist pages so Studio owners know exactly which knowledge sources to add.

Medium-term:

- Create a deterministic "agent setup checklist" generator from Confluence page metadata.
- Create a "source verification" smoke test template for every governed agent.
- Track agent test runs as rows in an evaluation report.
- Add a standard section to every Studio config page:

```text
Authoritative Runtime Sources
Fallback Behavior
Forbidden Substitutes
Smoke Test Prompt
```

Longer-term:

- If Atlassian/Rovo exposes an API for Studio configs, automate drift checks between Studio and Confluence setup pages.
- Add a monitor that alerts when runtime pages change but Studio setup has not been smoke-tested.
- Promote the bootstrap pattern to all governed agents.

## Rollout Plan To Remaining Agents

Use this order:

1. Finish proving with Jira Work Item Assistant.
2. Finish proving with Release Notes Manager.
3. Apply to Release Drift Monitor.
4. Apply to Release Health Analyst.
5. Apply to Jira Ticket Polisher.
6. Apply to remaining governed agents and extensions.

For each agent:

1. Identify runtime behavior that should move to Confluence.
2. Create or refine a runtime instructions page.
3. Create or refine a Studio setup page.
4. Update Studio to thin bootstrap.
5. Configure explicit knowledge sources.
6. Run source-verification smoke test.
7. Run 2-3 behavior regression tests.
8. Record pass/partial/fail.
9. Publish only after the local/repo-side evidence is acceptable.

## Current Repo Notes

At handoff time, the worktree contains unrelated pre-existing changes and untracked files. Do not revert them.

Files directly relevant to this work include:

- `docs/confluence-pages/deployment-notes-standard.md`
- `docs/confluence-pages/deployment-notes-agent-pilot.md`
- `docs/confluence-pages/jira-work-item-assistant-rovo-studio-configuration.md`
- `docs/confluence-pages/release-notes-manager-rovo-studio-configuration.md`
- `docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md`
- `docs/confluence-pages/release-notes-manager-knowledge-source-plan.md`
- `docs/reports/deployment-notes-agent-backtest-2026-06-08.md`
- `docs/reports/deployment-notes-agent-backtest-v2-2026-06-08.md`
- `docs/handoffs/deployment-notes-bootstrap-workflow-handoff-2026-06-08.md`

## Acceptance Criteria For Next Conversation

- Jira Work Item Assistant proves it uses `Deployment Notes Standard for Jira Work Items` as source.
- Jira Work Item Assistant produces clean `M26-788` output with no invented validation.
- Release Notes Manager produces clean batch work packages and no invented release metadata.
- Both agents have explicit knowledge source setup documented.
- A human-facing Studio setup page exists for each agent.
- A reusable bootstrap pattern is captured.
- A rollout plan exists for the remaining agents.
