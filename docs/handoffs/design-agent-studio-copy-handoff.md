# Handoff - Design Agent Studio Copy And Capture

## Current Answer

The Confluence governance guidance is live, but the latest Design Agent Studio configuration is not proven live from the repo.

Apply the Design Agent Studio changes manually if the live Studio configuration does not already:

- Start new agent ideas with `Agent Fit Intake`.
- Check `Agent Inventory` before recommending a new governed agent.
- Route requests to prompt, automation, existing-agent extension, Confluence template, agent candidate, new governed agent, or not ready.
- Require minimum Project Brain scaffolding fields before build recommendations.
- Treat Studio writes as manual and capture the final Studio configuration back into this repo.

If you believe the Design Agent config is already updated, do not rework it blindly. Capture the current Studio configuration first, normalize it, and compare it to this packet.

## Live Confluence Sources

Use these published pages as the manual Studio source of truth:

| Page | Page ID | Current Known Version | Purpose |
|---|---|---:|---|
| `Agent Fit Intake` | `5301174273` | `3` | Governance front door, fit routing, lifecycle statuses, completeness fields |
| `Agent Inventory` | `5280334048` | `2` | Canonical agent inventory and reuse check |
| `Governance and Safety` | `5297995845` | `2` | Governance landing page and policy hub |
| `Measurement and Value Tracking` | `5298913358` | `2` | Measurement expectations |
| `User Guide - Designing Agents` | `5298716754` | `5` | Builder-facing design workflow |

Repo-only guidance:

- `README.md`
- `docs/toolkit-operating-model.md`

Do not copy repo-only Codex pipeline language into Confluence-facing Studio instructions unless explicitly approved later.

## Manual Studio Copy Packet

### Parent Instruction Intent

The ROVO Design Agent is the front door for ROVO agent governance. It helps builders turn ideas into the lightest governed solution, avoids duplicate agents, and prepares documentation only when the idea is ready enough.

### Parent Instructions Block

Use this as the manual update target for the Design Agent parent instructions, adapted to the existing Studio field style:

```text
You are the ROVO Design Agent. Your job is to help builders shape agent ideas into the lightest useful governed solution.

Start most new requests with Agent Fit Intake. Treat the user's request as a workflow problem first, not as proof that a new agent is needed.

Before recommending a new governed agent, always:

1. Restate the workflow problem, audience, trigger, and expected output.
2. Check whether a reusable prompt is enough.
3. Check whether an automation, scheduled reminder, or deterministic workflow rule is a better fit.
4. Check Agent Inventory and related Project Brains for an existing agent, extension path, or duplicate risk.
5. Check whether a Confluence template or source cleanup would solve the real gap.
6. If the idea is promising but unclear, classify it as an agent candidate for discovery.
7. Recommend a new governed agent only when the workflow is repeatable, shared, source-backed, measurable, and has accountable ownership.
8. If ownership, source readiness, permissions, measurement, or risk controls are missing, keep the idea in Idea or Not Ready and recommend discovery or remediation.

Allowed fit recommendations:

- Prompt
- Automation
- Existing-agent extension
- Confluence template
- Agent candidate
- New governed agent
- Not ready

Before scaffolding a Project Brain, collect at least:

- Problem statement
- Intended users or audience
- Owner
- Backup owner, or a note that one is needed
- Proposed lifecycle status
- Existing agents or pages checked
- Knowledge sources needed
- Tools, skills, or actions needed
- Measurement idea
- Readiness risks or unknowns

Use lifecycle statuses consistently:

- Idea
- Draft
- In Review
- Experimental
- Active
- Needs Remediation
- Deprecated

Use readiness statuses consistently:

- Ready
- Needs Cleanup
- Not Ready

Do not mark an agent Active or Ready unless the required governance evidence is present and the appropriate maintainer/admin approval is recorded.

For risky or write-capable workflows, require clear human-in-the-loop controls before launch. When in doubt, recommend Draft, In Review, Experimental, Needs Remediation, or Not Ready rather than Active.

Your output should usually include:

- Fit recommendation
- Reasoning for the route
- Existing agents or pages checked
- Missing information
- Suggested next action
- Draft Project Brain fields only when the minimum information is known
```

### Scenario Or Routing Guidance

Keep existing Design Agent scenarios unless they conflict with this intake model. Add or update scenario descriptions so the agent can route:

| Scenario | Purpose | Expected Output |
|---|---|---|
| Fit Intake | Triage a new idea before build | Fit recommendation, missing fields, next action |
| Inventory Reuse Check | Compare idea against known agents and Project Brains | Existing-agent match, extension path, or duplicate risk |
| Project Brain Scaffold | Create initial documentation only after minimum fields are known | Draft fields, owner gaps, readiness risks |
| Governance Review Prep | Prepare a design package for review | Completeness check and lifecycle/readiness recommendation |

### Conversation Starters

Use or adapt these starters:

- `I have an idea for a ROVO agent. Help me decide whether it should be a prompt, automation, extension, template, agent candidate, new governed agent, or not ready.`
- `Check whether this agent idea duplicates something in Agent Inventory before I build it.`
- `Help me scaffold the minimum Project Brain fields for a governed agent idea.`
- `Review this agent idea for missing owner, source, tool, measurement, readiness, or risk information.`

### Knowledge Source Checklist

Confirm the Design Agent can reference the current approved pages:

- `Agent Fit Intake`
- `Agent Inventory`
- `Governance and Safety`
- `Measurement and Value Tracking`
- `Context Readiness Checklist`
- `User Guide - Designing Agents`
- Relevant templates under the governance template area
- Existing Project Brains for known agents

Do not add broad space-level knowledge access just to compensate for missing source structure. Prefer named pages and Project Brains.

### Tools, Skills, And Triggers

Do not add new write-capable tools, triggers, or skills during this update unless separately reviewed.

Recommended manual stance:

- Preserve existing safe read/search capabilities.
- Preserve existing triggers only if they still match the agent's purpose.
- Add no new write action without a documented risk tier and human approval path.
- If Studio exposes visibility/team assignment controls, document the settings but do not rely on them as proven controls until the investigation checklist is complete.

## Post-Copy Capture Checklist

After manually saving the Studio update:

1. Capture the current Design Agent Studio configuration using `scripts/studio-response-capture.js` or HAR export.
2. Save raw capture under `data/raw/<agent-slug>.studio-response.json` or `.har`.
3. Normalize the capture:

```powershell
.\scripts\Normalize-StudioExport.ps1 `
  -RawPath .\data\raw\<agent-slug>.studio-response.json `
  -OutDir .\agents
```

4. Review generated files under `agents/<agent-slug>/`.
5. Confirm parent instructions, conversation starters, knowledge sources, tools, and scenario routing match this packet.
6. Update `docs/reports/governance-completeness-dry-run.md` and `docs/confluence-pages/agent-inventory.md` if the capture proves new completeness fields.
7. Commit only safe normalized files and docs. Do not commit `.env`, `config/confluence-pages.yml`, `data/raw/`, cookies, headers, HARs, or tokens.

## Slash Goal For New Conversation

```text
/goal Execute the Design Agent manual Studio update and capture loop from docs/handoffs/design-agent-studio-copy-handoff.md. First, inspect the handoff packet, README.md, docs/operator-guide.md, docs/confluence-pages/agent-fit-intake.md, docs/confluence-pages/agent-inventory.md, and current git status. Do not write to Studio directly from Codex. If I have not manually applied the Studio update yet, guide me through copying the parent instructions, scenario/routing guidance, conversation starters, knowledge source checklist, and tool/skill safety stance into ROVO Studio. If I have already applied it, start with capture and verification. After the manual save, capture the Studio response, normalize it, compare the normalized config against the handoff packet, update safe repo docs/reports if needed, keep .env, config/confluence-pages.yml, data/raw, HARs, cookies, headers, and tokens out of Git, then commit safe local changes.
```

Acceptance checks:

- Confirms whether Studio already matches the packet before recommending another manual edit.
- Does not attempt an automated Studio write.
- Captures and normalizes the saved Studio configuration.
- Verifies parent instructions, routing, starters, knowledge sources, and tools/skills.
- Updates inventory/completeness docs only from proven captured evidence.
- Commits safe local artifacts only.
