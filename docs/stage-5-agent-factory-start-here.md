# Stage 5 Agent Factory Start Here

Use this page to run the first team pilot of the ROVO agent factory model.

Stage 5 reframes this repo as the behind-the-scenes control plane for approved ROVO agents. The repo holds specs, source links, evaluation prompts, approval evidence, pilot metrics, promotion packets, and retirement decisions. Normal pilot users should not need this repo. They should use approved agents through Jira, Confluence, and ROVO/Studio workflows, then send feedback through the pilot channel named in the promotion packet.

The first target is one initial team pilot. Do not treat these artifacts as an org-wide launch plan.

## Start Here

| Need | Start With | Output |
|---|---|---|
| New agent idea or workflow pain point | `docs/confluence-pages/agent-fit-intake.md` | Fit decision: prompt, automation, existing-agent extension, template, candidate, new governed agent, or not ready |
| Existing-agent reuse check | `docs/confluence-pages/agent-inventory.md` | Similar-agent comparison and reuse/improve/merge/reject/new decision |
| Pilot boundary or safety question | `docs/stage-5-pilot-boundaries.md` | Approved, prohibited, or escalate classification |
| Pilot usage or feedback capture | `templates/stage-5-pilot-feedback-tracker-template.md` | Manual usage, value, quality, risk, and improvement records |
| Helper or Codex-assisted drafting | `docs/stage-5-contributor-helper-guide.md` | Safe draft artifacts and approval handoff |
| Agent promotion request | `templates/stage-5-pilot-promotion-packet-template.md` | Reviewer-ready packet for 1-2 pilot agents |

## Control-Plane Promise

The Stage 5 control plane keeps governance evidence durable while keeping user experience simple:

- Builders use this repo to draft and review specs, tests, templates, metrics, promotion packets, and retirement notes.
- Agent owners use this repo to maintain Project Brain evidence, approved sources, evaluation results, measurement plans, and change history.
- Reviewers use this repo to approve pilot scope, risk boundaries, audience, escalation triggers, and promotion decisions.
- Pilot users use approved ROVO agents in Atlassian tools. They should not need Git, branch names, Markdown templates, or Studio configuration details.
- ROVO Studio remains the runtime where approved configuration is copied manually. This repo does not write to Studio.

## Audience Map

| Audience | Primary interface | Should not need | Decisions owned | Required artifacts |
|---|---|---|---|---|
| Governance builders | This repo, Agent Fit Intake, Agent Inventory, Codex-assisted drafts | Live Studio writes, Jira writes, broad Confluence publishing rights | Fit route, duplicate-check recommendation, draft artifact readiness | Intake notes, duplicate comparison, Project Brain scaffold, evaluation prompts, promotion packet draft |
| Agent owners | Project Brain pages, Studio manual configuration, measurement records | Raw captures, unreviewed helper drafts, unrelated repo internals | Source approval, guardrails, measurement cadence, remediation ownership | Project Brain, knowledge source plan, Studio configuration copy blocks, measurement plan, change log |
| Pilot users | Approved ROVO agents in Jira, Confluence, and ROVO/Studio | This repo, Studio builder settings, governance templates | Workflow feedback, whether outputs are accepted, edited, or rejected | Lightweight feedback entry, issue or page context where allowed |
| Reviewers and managers | Promotion packet, pilot boundaries, readiness review | Raw local data, branch mechanics, draft-only experiments | Pilot approval, team promotion, go/no-go, escalation acceptance | Promotion packet, approved/prohibited/escalate catalog, metrics summary, test evidence |
| Security, legal, compliance, and privacy partners | Escalation packet and source/risk summary | Full repo history or unrelated agent drafts | Whether a use case needs formal review, extra controls, or rejection | Escalation trigger, data/source summary, tool/action summary, risk notes, decision record |

## Lifecycle

| Step | Purpose | Required evidence | Exit decision |
|---|---|---|---|
| 1. Pain point | Name the workflow problem before naming an agent. | Problem, audience, trigger, expected output, current friction | Continue intake or reject as not worth solving |
| 2. Intake | Choose the lightest governed solution. | Agent Fit Intake answers and fit route | Prompt, automation, extension, template, candidate, new governed agent, or not ready |
| 3. Duplicate check | Prevent duplicate agents and hidden overlap. | Inventory search and similar-agent comparison | Reuse, improve, merge, reject, or new |
| 4. Spec | Capture the durable agent design. | Purpose, owner, backup owner, audience, sources, tools, measurement idea, readiness risks | Keep as Draft or move to context review |
| 5. Context review | Confirm the source material is usable. | Source owner, freshness, scope, permissions, gaps, and cleanup actions | Ready, Needs Cleanup, or Not Ready |
| 6. Prototype | Build draft artifacts without live writes. | Project Brain scaffold, Studio copy blocks, evaluation prompts, safety notes | Continue, remediate, or stop |
| 7. Dry run | Test behavior against source-backed prompts. | Pass/partial/fail results, unsafe output notes, missing source notes | Ready for human review or needs remediation |
| 8. Human review | Confirm governance completeness and pilot safety. | Reviewer notes, owner approval, boundary catalog, escalation triggers | Approve pilot, reject, or remediate |
| 9. Pilot approval | Allow select pilot use. | Promotion packet, pilot audience, feedback channel, metrics tracker | Pilot Approved or Needs Remediation |
| 10. Team promotion | Expand to the named team only. | Pilot metrics, feedback summary, test evidence, accepted risks | Team Approved, continue pilot, or stop |
| 11. Metrics and improvement | Keep value and risk visible. | Usage, time saved estimate, accepted/edited/rejected outputs, review issues, unsafe outputs, feedback | Improve, keep as is, remediate, deprecate |
| 12. Deprecation | Mark replaced or no-longer-recommended agents. | Replacement guidance, owner decision, user-facing note | Deprecated or Retired |
| 13. Retirement | Remove from recommended use without losing history. | Inventory update, Project Brain retirement note, final review date | Retired |

## Promotion Stages

| Stage | Entry criteria | Approver | Required evidence | Allowed audience | ROVO/Studio use | Expansion review |
|---|---|---|---|---|---|---|
| Idea | Pain point named and intake started | Governance builder or agent owner | Problem, audience, suspected route | Builder and owner only | None required | Fit route must be chosen before build |
| Candidate | Intake suggests agent-shaped solution but details are incomplete | Governance steward | Intake answers, open questions, duplicate search started | Builder, owner, reviewer | Optional draft-only exploration | Must resolve ownership, sources, risks, and duplicate decision |
| Prototype | Project Brain scaffold and draft Studio copy blocks exist | Agent owner | Owner, backup owner or gap owner, sources, tools, readiness risks, evaluation prompts | Builder and owner | Manual draft configuration only if approved by owner | Dry-run evidence required before pilot review |
| Pilot Approved | Human review accepts a narrow pilot | Reviewer or manager plus agent owner | Promotion packet, pilot boundaries, test evidence, metrics tracker, feedback channel | Named pilot users only | Manual Studio configuration only; no automated write-back | Review after agreed number of uses or review date |
| Team Approved | Pilot evidence supports team use | Reviewer or manager plus governance steward | Pilot metrics summary, issue log, unsafe output review, source freshness check | Named team only | Approved ROVO/Studio agent for team workflow | Review before any broader audience or new tools |
| Needs Remediation | Review finds missing owner, stale source, unsafe output, duplicate risk, or failed eval | Agent owner | Remediation owner, issue, due date, limited-use decision | Restricted to owners/reviewers unless explicitly allowed | Pause, restrict, or use with warning based on severity | Remediation review before returning to pilot/team use |
| Deprecated | Better solution exists or value/risk no longer supports use | Agent owner and governance steward | Replacement guidance, inventory note, user-facing message | Existing users during transition only | Avoid new use | Retire after transition period or final review |
| Retired | Agent is no longer recommended or available | Governance steward or authorized admin | Retirement note, final review date, replacement or archive link | None, except archive readers | Remove or disable through manual admin path where applicable | Reopen only through new intake |

## Duplicate-Prevention Workflow

Before starting new-agent work, record the duplicate decision:

| Field | Required content |
|---|---|
| Submitted idea | Plain-language request or pain point |
| Target pain point | Workflow friction the agent would reduce |
| Inventory matches reviewed | Existing agents, candidates, extensions, or Project Brains checked |
| Similar-agent comparison | Overlap in audience, sources, workflow, tools, and expected output |
| Decision | Reuse / Improve / Merge / Reject / New |
| Rationale | Why the decision is safest and least duplicative |
| Proposed owner | Accountable owner or owning team |
| Backup owner | Backup owner, delegate, or gap/remediation owner |
| Naming check | Whether the proposed name conflicts with an existing agent or page |
| Next review date | ISO date for follow-up, pilot review, or remediation review |

Use `New` only when reuse, improvement, merge, or rejection are not sufficient.

## Stage 5 Readiness Review

Answer these before starting the pilot:

| Question | Ready signal |
|---|---|
| Can a builder start from the new artifacts without live explanation from the maintainer? | Start-here, boundaries, helper guide, feedback tracker, and promotion packet template are linked and internally consistent. |
| Can a normal pilot user use approved agents without reading the repo? | Promotion packet names the user-facing agent, approved workflows, feedback path, and escalation path. |
| Are duplicate checks required before any new-agent work? | Intake and inventory guidance require similar-agent comparison and a reuse/improve/merge/reject/new decision. |
| Are prohibited actions and escalation triggers visible to reviewers and helpers? | Pilot boundaries document is linked from the start-here and promotion packet. |
| Are metrics and feedback fields ready for manual pilot collection? | Tracker captures usage, pain point, time saved, accepted/edited/rejected output, review issues, unsafe outputs, feedback, and improvement decision. |
| Is Claude Code migration future-only? | Roadmap keeps migration as a separate future lane and does not expand first pilot scope. |

## Current Boundary

For the first pilot:

- Do not publish Confluence changes without a focused dry-run and explicit approval.
- Do not write to Jira.
- Do not write to ROVO Studio from this repo or Codex.
- Do not build Studio write-back.
- Do not begin org-wide rollout.
- Keep Claude Code migration as future planning, not a pilot dependency.
