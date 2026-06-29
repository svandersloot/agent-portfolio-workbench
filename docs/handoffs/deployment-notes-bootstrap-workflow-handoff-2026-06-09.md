# Handoff - Deployment Notes Bootstrap Workflow - 2026-06-09

Use this packet to start a fresh conversation and continue the Deployment Notes agent-governance pilot from the end of 2026-06-08.

## Start Here Prompt

```text
We are continuing the Rovo agent governance workflow for Deployment Notes.

Goal:
- Prove the Confluence-first bootstrap pattern with Jira Work Item Assistant and Release Notes Manager.
- Keep Studio instructions thin and use Confluence as the versioned source of truth.
- Keep each agent's Studio setup page human-facing: what to paste, what knowledge sources to configure, what skills/tools to enable or disable, and what smoke tests to run.
- Reduce hallucinations by explicitly scoping knowledge sources, skills/tools, source precedence, forbidden substitutes, and fallback behavior.
- Once proven, roll the pattern to remaining governed agents one at a time.

Start by reading:
- docs/handoffs/deployment-notes-bootstrap-workflow-handoff-2026-06-09.md
- docs/confluence-pages/deployment-notes-standard.md
- docs/confluence-pages/deployment-notes-agent-pilot.md
- docs/confluence-pages/agent-bootstrap-pattern.md
- docs/confluence-pages/jira-work-item-assistant-studio-setup.md
- docs/confluence-pages/release-notes-manager-studio-setup.md
- docs/confluence-pages/jira-work-item-assistant-project-brain.md
- docs/confluence-pages/release-notes-manager-project-brain.md
- docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md
- docs/confluence-pages/release-notes-manager-knowledge-source-plan.md
- docs/reports/deployment-notes-agent-live-regression-2026-06-08.md

Important:
- User is Shayne Vandersloot.
- Do not assume Studio has live version control. Confluence is the versioned source of truth.
- Studio should be a thin bootstrap: identity, routing, safety, authoritative Confluence links, fallback behavior, and manually configured knowledge sources/skills.
- Do not copy every detailed rule into Studio unless needed as temporary fallback or pilot guardrail.
- For Deployment Notes, the authoritative page is:
  [internal Atlassian URL]
- The Deployment Notes Standard must be configured as an explicit Studio knowledge source for both Jira Work Item Assistant and Release Notes Manager.
- Do not let agents substitute MOBRM Team Jira Standards, Organization-Wide Jira Ticket Quality Standard, or other Jira hygiene pages as deployment-note standards.

Current next task:
- Review and publish the targeted Deployment Notes Standard and Release Notes Manager Studio Setup updates drafted after the 2026-06-09 RNM batch failure.
- Manually add the temporary RNM batch guardrail to Studio.
- Rerun Release Notes Manager with the batch regression prompt in this handoff.
- Score pass/partial/fail and update the live regression report.
```

## Current State

The pilot is using a Confluence-first bootstrap pattern:

| Layer | Purpose |
|---|---|
| Studio bootstrap | Identity, scope, safety, routing, authoritative links, fallback behavior, and configured knowledge sources/tools. |
| Runtime/source Confluence pages | Versioned behavior, standards, examples, anti-patterns, source precedence, and evaluation prompts. |
| Studio setup Confluence pages | Human setup instructions for Studio: pasted bootstrap text, knowledge sources, skills/tools, disabled actions, and smoke tests. |
| Repo Markdown | Local source for Confluence pages, reports, and handoffs. |

Key decision to preserve:

- Runtime/source pages tell agents how to behave.
- Studio setup pages tell humans how to configure Studio.
- The agent should not depend on a setup page as its behavior source.

## Published Pages And Latest Known Versions

| Page | URL | Version |
|---|---|---:|
| Deployment Notes Standard for Jira Work Items | `[internal Atlassian URL]` | v13 |
| Deployment Notes Agent Pilot | `[internal Atlassian URL]` | v9 |
| Agent Bootstrap Pattern And Studio Setup Checklist | `[internal Atlassian URL]` | v1 |
| Studio Setup - Jira Work Item Assistant | `[internal Atlassian URL]` | v5 |
| Studio Setup - Release Notes Manager | `[internal Atlassian URL]` | v1 |
| Jira Work Item Assistant Project Brain | `[internal Atlassian URL]` | v2 |
| Release Notes Manager Project Brain | `[internal Atlassian URL]` | v3 |
| ROVO Studio Configuration - Jira Work Item Assistant | `[internal Atlassian URL]` | v12 |
| Rovo Studio Configuration - Release Notes Manager | `[internal Atlassian URL]` | v8 |
| Knowledge Source Plan - Jira Work Item Assistant | `[internal Atlassian URL]` | v10 |
| Knowledge Source Plan - Release Notes Manager | `[internal Atlassian URL]` | v9 |

## Jira Work Item Assistant Status

Jira Work Item Assistant has been updated in Studio from the new setup page and tested against real stories.

Current assessment:

| Test | Result | Notes |
|---|---|---|
| Source routing with M26-788 | Pass with minor source-verification issue | Agent used the Deployment Notes Standard, but still tends to provide the page title without the full URL. |
| Fallback trap | Pass | Agent refused to use Studio-only behavior while Confluence standard was available. |
| MOBPXD-1399 no-notes test | Pass | Agent produced no Jira Deployment Notes field draft and did not suggest `NA` or placeholder text. |
| MR26-3076 coordinator test | Pass with minor polish | Correct coordinator/additive handling, target system, file, attachment location, and related story range. It should preserve the explicit producer org validation list when available. |
| M26-788 prerequisite retest | Pass with minor source-verification issue | Kept manual permission removal only in Pre-Deployment / Sequencing Notes and did not repeat it in Deployment Steps. |

Recommendation:

- Do not keep tuning Jira Work Item Assistant before testing Release Notes Manager unless a new regression appears.
- Watch the source-verification URL issue, but treat it as a polish issue for now because the agent is using the correct standard and producing usable field drafts.

## Release Notes Manager Status

Release Notes Manager has been updated in Studio by Shayne using `Studio Setup - Release Notes Manager`.

Current assessment:

- Batch regression was run on 2026-06-09 from the Studio test panel for `Release Notes Manager v2`.
- Result: Fail for evidence preservation, with pass-shaped grouping.
- The agent produced deployment work packages and excluded `MOBPXD-1399`, but replaced known Jira evidence with `Data Incomplete`, omitted exact artifacts and pipelines, blurred distinct producer-org work, and did not provide both the Confluence page title and full URL in source verification.
- Targeted Confluence updates were published on 2026-06-09: Deployment Notes Standard v14 and Studio Setup - Release Notes Manager v2.
- Studio audit after publish found Release Notes Manager Studio is not yet aligned to the setup page: parent knowledge has only the Deployment Notes Standard; the Deployment Notes Agent Pilot and Knowledge Source Plan - Release Notes Manager are missing at the parent level; only Deployment Runbook Drafter appears enabled; other subagents appear disabled; several subagents have write-capable Confluence skills such as create page, edit page append, and create label; some subagent knowledge includes broad `All spaces`.
- Next action is to manually align Studio with `Studio Setup - Release Notes Manager` v2, including the temporary RNM batch guardrail, then rerun the batch prompt below.

## Release Notes Manager Batch Prompt

Run this first tomorrow:

```text
Review these Jira work items for release deployment coordination using the Deployment Notes Standard for Jira Work Items:

MR26-3076, MR26-2831, M26-788, SRNGR-4539, MR26-810, MR26-2708, SMOBL-4073, SRNGR-3815, M26-231, MOBPXD-1399

Before producing the work packages, verify which Deployment Notes Standard source you used:
- Did you use the latest Confluence page "Deployment Notes Standard for Jira Work Items"?
- Provide the Confluence page title and full link you used.
- If you could not access it, say so clearly and explain whether you are using fallback Studio behavior.

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
- Do not add routine environment, evidence capture, rollback/recovery, IAM, prod-sync, or screenshot-capture gaps unless the source explicitly mentions them.
- Keep unresolved questions outside any Jira field draft.
- Preserve explicit Jira story evidence; use Data Incomplete only when a detail is missing, inaccessible, or conflicting.
```

## Known Story Evidence For Scoring

Use this evidence when assessing Release Notes Manager output:

| Story | Expected handling |
|---|---|
| MR26-3076 | PolicyCenter producer org XML import. Master/coordinator for MR26-3076 through MR26-3082. File `ProducerOrg_2026.06.01_Org_AdminData.xml` is a Jira attachment. Import is additive. |
| M26-788 | ClaimCenter permission prerequisite plus XML data import. File `M26-788_Supervisor_Manager_Roles.xml`; path `modules\configuration\etc\surepath\cc\configuration\data\default`; validation missing. |
| MOBPXD-1399 | No deployment action required. Exclude from deployment work packages. |
| M26-231 | CASFormPatterns_Ext.xml import. Do not treat as generic/misc work. |
| SRNGR-4539 | Guidewire Runtime Properties / IG properties. Do not infer AWS Parameter Store unless source says it. |
| MR26-810 and MR26-2708 | Both are AWS work but should not be collapsed because the actions/pipelines differ. |

## Pass / Partial / Fail Guide

Pass when:

- The agent names and links the Deployment Notes Standard.
- Output is deployment work packages grouped by action, target system, artifact, and dependency.
- It preserves exact Jira evidence and known answers.
- It keeps no-action stories separate.
- It avoids invented release metadata, AWS account/role, branch/tag, IAM, rollback, prod-sync, screenshots, evidence capture, and validation paths.

Partial when:

- The work-package shape is mostly right but one or two labels, source-verification details, or evidence-preservation items are incomplete.
- The issue is correctable with setup-page polish rather than a standard change.

Fail when:

- It substitutes Jira hygiene standards for the Deployment Notes Standard.
- It returns a flat story list instead of work packages.
- It collapses distinct AWS actions/pipelines.
- It invents major operational details or marks known source evidence as `Data Incomplete`.
- It includes MOBPXD-1399 in a deployment package despite no manual action.

## Next Steps

1. Manually align Release Notes Manager Studio with `Studio Setup - Release Notes Manager` v2:
   - Add the missing required parent knowledge sources.
   - Add the temporary Release Notes Manager batch guardrail.
   - Enable intended subagents or intentionally record why they are disabled.
   - Remove write-capable Confluence skills and broad knowledge scopes from pilot surfaces.
2. Rerun the Release Notes Manager batch prompt.
3. Score pass/partial/fail in `docs/reports/deployment-notes-agent-live-regression-2026-06-08.md`.
4. If Release Notes Manager misses are still material, update Confluence in this order:
   - Deployment Notes Standard only if the behavior rule is generally true.
   - Release Notes Manager Studio Setup only if Studio wiring, skills/tools, or temporary pilot guardrails need changing.
   - Deployment Notes Agent Pilot only if the test prompt or scoring rubric needs tightening.
5. If Release Notes Manager passes or is only minor-partial, treat the bootstrap pattern as provisionally proven for the two pilot agents.
6. Start rollout one agent at a time:
   - Release Drift Monitor.
   - Release Health Analyst.
   - Jira Ticket Polisher.
   - Remaining governed agents and extensions.

## Rollout Pattern For Each Remaining Agent

For each agent:

1. Identify runtime behavior that belongs in Confluence.
2. Create or refine the runtime/source page.
3. Create or refine the human-facing Studio setup page.
4. Keep Studio bootstrap thin.
5. Configure explicit knowledge sources.
6. Scope skills/tools and disabled write actions.
7. Run a source-verification smoke test.
8. Run two or three behavior regression prompts.
9. Record pass/partial/fail before promoting the pattern.

## Repo Notes

Relevant files for this work:

- `docs/confluence-pages/deployment-notes-standard.md`
- `docs/confluence-pages/deployment-notes-agent-pilot.md`
- `docs/confluence-pages/agent-bootstrap-pattern.md`
- `docs/confluence-pages/jira-work-item-assistant-studio-setup.md`
- `docs/confluence-pages/release-notes-manager-studio-setup.md`
- `docs/confluence-pages/jira-work-item-assistant-project-brain.md`
- `docs/confluence-pages/release-notes-manager-project-brain.md`
- `docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md`
- `docs/confluence-pages/release-notes-manager-knowledge-source-plan.md`
- `docs/reports/deployment-notes-agent-live-regression-2026-06-08.md`
- `docs/handoffs/deployment-notes-bootstrap-workflow-handoff-2026-06-08.md`
- `docs/handoffs/deployment-notes-bootstrap-workflow-handoff-2026-06-09.md`
- `config/confluence-pages.example.yml`

Do not revert unrelated workspace files. At the end of 2026-06-08, unrelated infographic files existed under `docs/infographics/` and were intentionally left out of the Deployment Notes commit.
