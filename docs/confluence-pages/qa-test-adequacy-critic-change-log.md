# Change Log - QA Test Adequacy Critic

Use this page to track changes to the agent design, review pipeline, Studio configuration, evaluations, and governance status.

| Version | Date | Area | Change Summary | Reason / Outcome | Updated By |
|---|---|---|---|---|---|
| v0.1 | 2026-08-25 | Initial governed documentation scaffold | Created Project Brain, Agent Design Record, Runtime Contract (12-review pipeline, required output format, critical rules), ROVO Studio Configuration, Studio Setup, Subagent Settings (QATCA v2 hand-off contract), and Evaluation (16 embedded eval cases). Added an `agent-inventory.md` entry and a QATCA v2 Runtime Contract routing row. | Convert the owner-supplied instruction file (`QA_Test_Adequacy_Critic_Agent_Instructions.md`, 2026-08-24) and the P1 "Add ISTQB Coverage Critic Sub-Agent" decision into reviewable Confluence source drafts, without approving launch, Studio writes, or a live agent-to-agent hand-off capability. | Claude Code (governance workbench); source instructions and priority decisions supplied by the owner |

## Pending Change Gates

| Gate | Status | Notes |
|---|---|---|
| Owner assigned | Open | Not yet identified. |
| Backup owner assigned | Open | Required before pilot. |
| Hand-off mechanism confirmed | Open | Human-mediated by default (§ Runtime Contract, § Subagent Settings); confirm whether Studio supports a governed agent-to-agent hand-off instead. |
| Publish placement confirmed | Closed | Owner confirmed 2026-08-25: publish as a child of `QA Test Case Architect Project Brain`, not a sibling under `QA and Testing Agents`, since this agent is a subagent of QA Test Case Architect v2. |
| Evaluation run | Open | 16 eval cases scaffolded in `Evaluation - QA Test Adequacy Critic`; none run yet. Cases QTAC-EVAL-001–009 need either a live QATCA v2 §1–§3 run or a hand-authored synthetic TestSuite sample. |
| Studio manually configured or captured | Open | No Studio write performed during scaffolding. |
| Pilot review complete | Open | Needed before promotion. |
| Knowledge Source Plan page | Not created in v0.1 | This agent has no standing external knowledge source (its input is whatever is pasted/attached per request) — flagged by `Test-ConfluencePageFamilyConsistency.ps1` as a warning; add a Knowledge Source Plan page only if a standing source emerges. |
| Measurement Plan page | Not created in v0.1 | Deferred until pilot use exists to measure — flagged by `Test-ConfluencePageFamilyConsistency.ps1` as a warning. |
