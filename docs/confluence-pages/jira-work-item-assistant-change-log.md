# Change Log - Jira Work Item Assistant

Use this page to track changes to the agent design, knowledge sources, Studio configuration, evaluations, measurement, and governance status.

| Version | Date | Area | Change Summary | Reason / Outcome | Updated By |
|---|---|---|---|---|---|
| v0.9 | 2026-06-04 | Status comment config tightening | Updated ROVO Studio Configuration and Subagent Settings so low-value updates like "still working on it" are not returned as ready-to-copy Jira comments. | Manual testing showed the agent still produced copy-ready text for vague status updates; config now requires richer details or a `Not ready to post` placeholder with `Data Incomplete` fields. | User decision capture |
| v0.8 | 2026-06-03 | Mobilitas standards research prompts | Added Mobilitas Commercial Program research prompts to the Team Jira Standards Discovery prompt library for balanced MOBRM, M26, and MR26 analysis. | Support intelligent Rovo research across release-management and sprint-team boards without turning observed patterns into policy prematurely. | User decision capture |
| v0.7 | 2026-06-03 | Second-pass evaluation and Studio tuning | Documented v2 eval exports, manual MOBRM ticket draft test, and updated RovoStudio/Subagent copy blocks for release-notes routing, sample-ticket source handling, missing-project drafts, MOBRM field defaults, and create wording. | Second pass improved but still showed three trusted unresolved cases and one manual-test warning; Studio configuration should be updated before the next run. | Codex review |
| v0.6 | 2026-06-03 | Evaluation results | Documented first-pass Agent Studio eval exports and manual non-MOBRM test results on the Evaluation page. | Both eval exports reported 18/18 resolved, but review found launch-gate gaps around eval criteria, MOBRM overlay overreach, exact bundle schema, release notes routing, and invented source/comment evidence. | Codex review |
| v0.5 | 2026-06-03 | Studio subagent simplification | Removed the dedicated Polisher Handoff Packager subagent, kept Jira Ticket Polisher review as parent-agent bundle behavior, and renamed Team Standards Page Drafter to Team Standards Resolver/Drafter. | Keep the Studio configuration to five focused subagents for easier routing and broader team adoption. | User decision capture |
| v0.4 | 2026-06-03 | Status comments and evaluation dataset | Added the Status Comment Standard, named bulk status comment set behavior, comment-quality evaluation cases, measurement signals, and Agent Studio CSV dataset. | Support ticket upkeep and downstream evidence quality for Release Drift Monitor and Release Health Analyst while keeping comment posting draft-only. | User decision capture |
| v0.3 | 2026-06-03 | Rename and standards builder | Renamed the migrated agent to Jira Work Item Assistant, updated the bundle contract to Jira Work Item Draft Bundle, added team standards drafting behavior, and marked legacy Release Management Assistant docs as archive/superseded candidates. | Make the agent broad enough for multi-team Jira work while using MOBRM as the first pilot and preserving draft-only standards approval. | User decision capture |
| v0.2 | 2026-06-03 | Pilot decisions | Captured broad agent scope with MOBRM first pilot, global-plus-team standards model, parent and labels as first MOBRM field expectations, optional how-to sections, bulk candidate support, and human-approved Jira creation direction. | Keep the assistant generic while proving value with MOBRM and preserving approval-first write boundaries. | User decision capture |
| v0.1 | 2026-06-03 | Initial governed migration scaffold | Created Project Brain, Agent Design Record, Knowledge Source Plan, Subagent Settings, ROVO Studio Configuration, Evaluation, Measurement Plan, and migration discovery report. | Start migration from legacy MO source into ROVO governance with explicit source gaps and approval-first Jira boundaries. | Workflow setup |

## Pending Change Gates

| Gate | Status | Notes |
|---|---|---|
| Legacy MO source captured | Open | Chrome authenticated retrieval was blocked during initial scaffold. |
| Owner assigned | Open | Required before pilot. |
| Backup owner assigned | Open | Required before pilot. |
| First pilot board/project confirmed | Done | MOBRM board/project is the first pilot. |
| Common task examples chosen | Partial | SER updates, parse break updates, producer org updates, and prod sync updates identified; source details still needed. |
| Jira write stance decided | Partial | Direction is create after human approval; governed write path and field mapping still need definition. |
| Jira comment stance decided | Partial | Direction is draft status comments now; future comment posting requires separate governed approval path, exact target issue, and exact comment text approval. |
| Studio manually configured or captured | Partial | Manual Studio testing and Agent Studio evaluation exports exist; updated v0.9 Studio copy blocks need to be pasted into RovoStudio and then captured. |
| Evaluation run | Partial | First-pass and second-pass Agent Studio exports reviewed on 2026-06-03; remediation and rerun required before launch gate. |
| Pilot review complete | Partial | Non-MOBRM and one MOBRM manual test reviewed; additional MOBRM board testing still needed before promotion. |
