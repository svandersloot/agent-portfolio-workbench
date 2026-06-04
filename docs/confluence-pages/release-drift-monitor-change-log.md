# Change Log - Release Drift Monitor

Use this page to track changes to the agent design, knowledge sources, Studio configuration, evaluations, measurement, and governance status.

| Version | Date | Area | Change Summary | Reason / Outcome | Updated By |
|---|---|---|---|---|---|
| v0.12 | 2026-06-04 | Post-draft follow-up prompts | Added post-draft follow-up triage and applicable follow-up drafting prompts to the Release Drift Monitor prompt library. | Manual July post-draft testing showed a useful pattern: triage WARN/UNKNOWN findings before drafting comments, use outreach when evidence is missing, and avoid final readiness decisions. | User decision capture |
| v0.1 | 2026-05-27 | Initial candidate scaffold | Created Project Brain, Agent Design Record, Knowledge Source Plan, Subagent Settings, Studio configuration copy blocks, Evaluation, Measurement Plan, and Evidence Ledger contract. | Move drift idea into governed candidate discovery. | Codex governance scaffold |
| v0.2 | 2026-05-27 | Real data sample | Added Mobilitas 2026.07.10 JQL sample observations to evaluation and measurement notes. | Ground the pilot in actual Jira result shape and known evidence gaps. | Codex governance scaffold |
| v0.3 | 2026-05-28 | Evaluation remediation | Added exact release identity fail-closed instructions and expanded the ROVO E2E CSV to 14 documented cases. | Prevent "latest release" inference and cover documented evaluation scope. | Codex governance scaffold |
| v0.4 | 2026-05-28 | Manual pilot learnings | Added Jira Web Link fallback, parent Epic shared-evidence scan, Mobilitas 2026.07.10 manual pilot results, and production-defect classification gap. | Preserve successful manual testing behavior and convert findings into pilot remediation actions. | Codex governance scaffold |
| v0.5 | 2026-05-28 | Pilot rule decisions | Accepted Web Links as fallback evidence with hygiene warning, added adaptive parent Epic scanning, introduced Shared Validation Anchor pattern, and set Production Defects to default unknown classification. | Converts pilot recommendations into explicit agent rules before next ROVO evaluation run. | Codex governance scaffold |
| v0.6 | 2026-05-28 | E2E v2 evaluation review | Recorded Evaluation #003 and #004 results, identified a resolution-rate false positive, added current-turn metadata and open-PR handling guardrails. | Prevent context carryover from turning vague prompts into inferred drift reports. | Codex governance scaffold |
| v0.7 | 2026-05-28 | V8 retest and manual evidence | Recorded Evaluation #005 and #006 v8 retests plus manual interaction evidence across Mobilitas 2026.07.10 and Mobilitas 2026.06.12. | Confirms v8 guardrail improvements while preserving evaluator execution gaps and manual follow-up observations. | Codex governance scaffold |
| v0.8 | 2026-05-28 | Controlled handoff publishing | Added a templated Confluence handoff page workflow, write boundaries for Handoff Summarizer and Health Pulse Summarizer, publish-safety evaluation cases, and ROI trend-history measurement. | Enables human-approved handoff page creation/update while preserving one canonical page per release and Release Health Analyst decision boundary. | Codex governance scaffold |
| v0.9 | 2026-05-28 | Stakeholder rollout guide | Added a handoff page user guide and embedded initial pulse, update, and stakeholder-review prompt templates in the handoff template. | Helps dev, QA, release owners, and Release Health Analyst read findings consistently and resolve WARN, BLOCK, and UNKNOWN states. | Codex governance scaffold |
| v0.10 | 2026-05-28 | Guidewire Bitbucket fallback | Added fallback evidence rules for Guidewire-hosted application repos when Jira Development Panel points to CSAA Bitbucket, including Jira Web Link and structured Jira comment workflows. | Keeps dev friction low while avoiding false missing-code findings from an integration limitation. | Codex governance scaffold |
| v0.11 | 2026-05-28 | Studio instruction split | Slimmed parent instructions into an operating contract and moved detailed external repository matching into Jira-Code Reconciler and Confluence evidence docs. | Makes ROVO Studio maintenance easier while preserving detailed fallback behavior for Guidewire Bitbucket, GitHub/AWS, and future repository migration cases. | Codex governance scaffold |

## Pending Change Gates

| Gate | Status | Notes |
|---|---|---|
| Owner assigned | Open | Required before pilot. |
| Backup owner assigned | Open | Required before pilot. |
| Jira workflow mapping confirmed | Open | Needed to define Done and issue-type evidence rules. |
| Bitbucket evidence sample reviewed | Open | Needed to test code drift. |
| Test/QA evidence source confirmed | Open | Needed to test validation drift. |
| Jira Web Link fallback rule confirmed | Accepted for pilot | Use as fallback evidence; warn when it is the only PR linkage. |
| Guidewire Bitbucket fallback confirmed | Accepted for pilot | Empty Jira Development Panel is not proof of missing app code when Jira points to CSAA Bitbucket; use Guidewire PR Web Links or structured Jira comments. |
| Shared Validation Anchor pattern confirmed | Accepted for pilot | Parent Epic, QA-only story, test plan, QA run, or Confluence page can anchor shared validation when scope is explicit. |
| Production defect classification confirmed | Accepted for pilot | Default unknown; classify as code-required, config-only, data-fix, operational/runbook, or analysis/no-change before requiring evidence. |
| Ledger storage selected | Open | Schema exists; storage/publish flow remains open. |
| Handoff template published | Open | New `Template - Release Drift Monitor Handoff Page` page source is ready for Confluence creation. |
| Handoff user guide published | Open | New stakeholder guide source is ready for Confluence creation. |
| Controlled Confluence write capability | In Progress | Handoff Summarizer may create/update the templated canonical handoff page after human approval; Health Pulse Summarizer may update trend/current snapshot on the existing page after approval. |
| Studio manually configured or captured | In Progress | User enabled ROVO Studio Configuration v8 manually and added create/edit/append capability to Handoff Summarizer. |
| Evaluation run | In Progress | Harness-gap and tight-regression tests ran; publish-safety mini-suite remains Not Run. |
