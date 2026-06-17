# Change Log - QA Test Case Architect v2

Use this page to track changes to the agent design, knowledge sources, Studio configuration, evaluations, measurement, and governance status.

| Version | Date | Area | Change Summary | Reason / Outcome | Updated By |
|---|---|---|---|---|---|
| v0.1 | 2026-06-11 | Initial governed documentation scaffold | Created Project Brain, Agent Design Record, Knowledge Source Plan, Subagent Settings, Studio configuration copy blocks, Evaluation, and Measurement Plan. | Convert the agent self-description report into reviewable Confluence source drafts without approving launch or Studio writes. | Codex documentation scaffold |
| v0.2 | 2026-06-11 | Copilot conversation summary additions | Added retrieval-generation-validation pipeline, Feature Brief output, validation gates, golden-copy example gaps, broad-source restrictions, and unresolved full artifact catalog questions. | Incorporate follow-up design context while keeping the agent Draft / Needs Cleanup and write actions disabled. | Codex documentation scaffold |
| v0.3 | 2026-06-11 | Studio setup model | Added a dedicated Studio Setup page as the human manual setup guide and reframed the ROVO Studio Configuration page as an agent-facing configuration source. | Keep Studio instructions lean while making knowledge source and skill scoping easier to copy, audit, and test. | Codex documentation scaffold |
| v0.4 | 2026-06-11 | Publish placement | Set the recommended publish location to `Agent Project Brains > QA and Testing Agents`. | Use the existing QA and Testing Agents Confluence parent page for the QA Test Case Architect v2 page family. | Codex documentation scaffold |
| v0.5 | 2026-06-11 | Evaluation remediation | Added virtual source-packet guidance after Studio evaluation showed the agent blocking on missing formal XML ticket-pack files despite complete prompt evidence. | Improve evaluation behavior so prompt-provided story evidence can be used as the temporary input package. | Codex documentation scaffold |
| v0.6 | 2026-06-11 | Production model clarification | Confirmed production requires `TICKET_PACK_COMBINED.xml`, documented the nine required artifacts, clarified manual Copilot/XRAY CSV flow, and added a sanitized golden-copy XRAY CSV fixture. | Align governance docs with the intended production workflow while preserving prompt packets for AgentLab and Studio evaluation only. | Codex documentation scaffold |
| v0.7 | 2026-06-11 | AgentLab-style simulation | Added local AgentLab-style simulation report, CSV column skeleton, continuation-row rule, artifact alias handling, masked banking-data examples, AgentLab/production gate starters, and full-package batching guidance. | Reduce evaluation prompt drift and strengthen Studio setup before live AgentLab testing. | Codex documentation scaffold |
| v0.8 | 2026-06-11 | Simulation pass 2 baseline | Reran the AgentLab-style simulation against the improved setup and recorded a 100 / 100 high-ROI simulated baseline across the six v2 evaluation prompts. | Establish that the current prompt/config is ready for live Studio setup testing, while keeping production ticket-pack fixture testing as the next iteration. | Codex documentation scaffold |
| v0.9 | 2026-06-11 | Simulation pass 3 production baseline | Added a synthetic `TICKET_PACK_COMBINED.xml` fixture and ran production-flow simulation cases for missing ticket pack, present ticket pack, full-package batching, conflict handling, and broad-source refusal. | Met the stop rule with two consecutive 90 percent or higher passes; no pass 4 or pass 5 required for the current baseline. | Codex documentation scaffold |
| v0.10 | 2026-06-11 | Robert review updates | Added default all-nine ArtifactPack behavior, single-artifact exception, high-risk AC categories, production conflict escalation, evaluation-only precedence rationale, and clarified that Jira exports or attachments do not replace the production ticket pack. | Align parent instructions with Robert's intended manual testing model before Studio configuration and dataset evaluation. | Codex documentation scaffold |
| v0.11 | 2026-06-15 | Category eval hardening | Hardened AC normalization against deduplication, required full deterministic test ID format, and added raw-only XRAY CSV output mode after Category 2, 3, and 4 each scored 80 percent. | Address the three observed unresolved cases before Robert's next review pass. | Codex documentation scaffold |
| v0.12 | 2026-06-15 | XRAY CSV continuation-row hardening | Added explicit override that governed continuation-row rules supersede conflicting retrieved template wording, required exact `Execution Type` / `Test Type` header, and added a pre-return CSV self-check. | Address the remaining Category 4 80 percent failure where metadata repeated on continuation rows and `Test Type` was duplicated. | Codex documentation scaffold |

## Pending Change Gates

| Gate | Status | Notes |
|---|---|---|
| Owner assigned | Open | Shayne Vandersloot is a likely candidate from the report but not formally assigned. |
| Backup owner assigned | Open | Required before pilot. |
| QA standard template confirmed | Open | Confirm page location, version, and Studio knowledge source. |
| Ticket Pack Builder workflow confirmed | Open | Production requires `TICKET_PACK_COMBINED.xml`; handoff format still needs review. |
| Jira/XRAY integration model confirmed | Partial | Current design assumes ROVO returns CSV text, human copies it into Copilot or another manual step, and final CSV/import remains manual until an approved connector exists. |
| Full artifact catalog confirmed | Done | Required artifacts are FeatureBrief XML, TestSuite XRAY CSV, CoverageMap CSV, RTM CSV, E2E_Scenarios TXT, MiniTestPlan XML, TestSummary XML, ConflictLog TXT, and TBDLog TXT. |
| Golden-copy examples collected | Partial | Sanitized XRAY CSV golden-copy fixture exists; remaining artifact examples are still needed. |
| Validation thresholds defined | Open | Coverage, XRAY, CSV, and traceability pass/fail criteria need QA owner review. |
| Studio manually configured or captured | Open | No automated Studio write was performed during scaffolding. |
| Studio setup page published | Open | Required before Studio instructions can reference the live setup/source pages by URL. |
| Evaluation run | Partial | Local AgentLab-style pass 2 and pass 3 reached the high-ROI baseline in consecutive runs; live Studio/AgentLab run still needed after manual configuration. |
| Pilot review complete | Open | Needed before promotion. |
