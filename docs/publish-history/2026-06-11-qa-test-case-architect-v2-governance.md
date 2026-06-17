# Publish History - QA Test Case Architect v2 Governance

## Summary

Published the initial QA Test Case Architect v2 governed page family to Confluence after a focused dry-run.

## Publish Details

| Field | Value |
|---|---|
| Date | 2026-06-11 |
| Space | ROVO |
| Parent page | QA and Testing Agents |
| Parent page ID | `5281382490` |
| Mode | Create |
| Apply command | `.\scripts\Publish-ConfluencePages.ps1 -Slug qa-test-case-architect-v2-project-brain,qa-test-case-architect-v2-agent-design-record,qa-test-case-architect-v2-knowledge-source-plan,qa-test-case-architect-v2-subagent-settings,qa-test-case-architect-v2-studio-setup,qa-test-case-architect-v2-rovo-studio-configuration,qa-test-case-architect-v2-evaluation,qa-test-case-architect-v2-measurement-plan,qa-test-case-architect-v2-change-log -Apply` |

## Pages Created

| Page | Page ID | Parent page ID | Source |
|---|---|---|---|
| QA Test Case Architect v2 Project Brain | `5377720354` | `5281382490` | `docs/confluence-pages/qa-test-case-architect-v2-project-brain.md` |
| QA Test Case Architect v2 - Agent Design Record | `5378768948` | `5377720354` | `docs/confluence-pages/qa-test-case-architect-v2-agent-design-record.md` |
| Knowledge Source Plan - QA Test Case Architect v2 | `5377785933` | `5377720354` | `docs/confluence-pages/qa-test-case-architect-v2-knowledge-source-plan.md` |
| Subagent Settings - QA Test Case Architect v2 | `5378244651` | `5377720354` | `docs/confluence-pages/qa-test-case-architect-v2-subagent-settings.md` |
| Studio Setup - QA Test Case Architect v2 | `5377490989` | `5377720354` | `docs/confluence-pages/qa-test-case-architect-v2-studio-setup.md` |
| ROVO Studio Configuration - QA Test Case Architect v2 | `5377884217` | `5377720354` | `docs/confluence-pages/qa-test-case-architect-v2-rovo-studio-configuration.md` |
| Evaluation - QA Test Case Architect v2 | `5378572351` | `5377720354` | `docs/confluence-pages/qa-test-case-architect-v2-evaluation.md` |
| Measurement Plan - QA Test Case Architect v2 | `5378703415` | `5377720354` | `docs/confluence-pages/qa-test-case-architect-v2-measurement-plan.md` |
| Change Log - QA Test Case Architect v2 | `5379194894` | `5377720354` | `docs/confluence-pages/qa-test-case-architect-v2-change-log.md` |

## Notes

- The dry-run showed exactly nine creates before apply.
- No ROVO Studio, Jira, XRAY, or Confluence write-capable agent permissions were configured by this publish.
- The local ignored `config/confluence-pages.yml` was updated with the created page IDs by the publisher.
- The page family remains `Draft` / `Needs Cleanup`; owner, backup owner, QA standard source, golden-copy examples, deterministic ID logic, XRAY upload model, and evaluation evidence still need confirmation.

## Update Publish - 2026-06-11

Republished the QA Test Case Architect v2 page family after AgentLab-style simulation passes and production ticket-pack clarification.

| Field | Value |
|---|---|
| Date | 2026-06-11 |
| Space | ROVO |
| Mode | Update existing |
| Dry-run command | `.\scripts\Publish-ConfluencePages.ps1 -Slug qa-test-case-architect-v2-project-brain,qa-test-case-architect-v2-agent-design-record,qa-test-case-architect-v2-knowledge-source-plan,qa-test-case-architect-v2-subagent-settings,qa-test-case-architect-v2-studio-setup,qa-test-case-architect-v2-rovo-studio-configuration,qa-test-case-architect-v2-evaluation,qa-test-case-architect-v2-measurement-plan,qa-test-case-architect-v2-change-log -UpdateExisting` |
| Apply command | `.\scripts\Publish-ConfluencePages.ps1 -Slug qa-test-case-architect-v2-project-brain,qa-test-case-architect-v2-agent-design-record,qa-test-case-architect-v2-knowledge-source-plan,qa-test-case-architect-v2-subagent-settings,qa-test-case-architect-v2-studio-setup,qa-test-case-architect-v2-rovo-studio-configuration,qa-test-case-architect-v2-evaluation,qa-test-case-architect-v2-measurement-plan,qa-test-case-architect-v2-change-log -UpdateExisting -Apply` |

| Page | Page ID | Published version |
|---|---|---:|
| QA Test Case Architect v2 Project Brain | `5377720354` | 2 |
| QA Test Case Architect v2 - Agent Design Record | `5378768948` | 2 |
| Knowledge Source Plan - QA Test Case Architect v2 | `5377785933` | 2 |
| Subagent Settings - QA Test Case Architect v2 | `5378244651` | 3 |
| Studio Setup - QA Test Case Architect v2 | `5377490989` | 2 |
| ROVO Studio Configuration - QA Test Case Architect v2 | `5377884217` | 2 |
| Evaluation - QA Test Case Architect v2 | `5378572351` | 2 |
| Measurement Plan - QA Test Case Architect v2 | `5378703415` | 2 |
| Change Log - QA Test Case Architect v2 | `5379194894` | 2 |

Update scope:

- Published the production `TICKET_PACK_COMBINED.xml` rule.
- Published evaluation/AgentLab source-packet exception wording.
- Published XRAY CSV column and continuation-row guidance.
- Published masked banking/account examples, artifact alias handling, and full-package batching guidance.
- Published links to local AgentLab-style simulation pass 2, pass 3, and synthetic ticket-pack evidence.

Notes:

- `agent-inventory` was not included because it is not present in the active local publish config.
- No ROVO Studio, Jira, XRAY, or Confluence permission/visibility configuration was changed by this publish.

## Robert Review Update Publish - 2026-06-11

Republished the affected QA Test Case Architect v2 pages after incorporating Robert's parent-instruction decisions.

| Field | Value |
|---|---|
| Date | 2026-06-11 |
| Space | ROVO |
| Mode | Update existing |
| Dry-run command | `.\scripts\Publish-ConfluencePages.ps1 -EnvPath C:\projects\rovo-governance-admin-toolkit\.env -ConfigPath C:\projects\rovo-governance-admin-toolkit\config\confluence-pages.yml -Slug qa-test-case-architect-v2-studio-setup,qa-test-case-architect-v2-rovo-studio-configuration,qa-test-case-architect-v2-evaluation,qa-test-case-architect-v2-change-log -UpdateExisting` |
| Apply command | `.\scripts\Publish-ConfluencePages.ps1 -EnvPath C:\projects\rovo-governance-admin-toolkit\.env -ConfigPath C:\projects\rovo-governance-admin-toolkit\config\confluence-pages.yml -Slug qa-test-case-architect-v2-studio-setup,qa-test-case-architect-v2-rovo-studio-configuration,qa-test-case-architect-v2-evaluation,qa-test-case-architect-v2-change-log -UpdateExisting -Apply` |

| Page | Page ID | Published version |
|---|---|---:|
| Studio Setup - QA Test Case Architect v2 | `5377490989` | 4 |
| ROVO Studio Configuration - QA Test Case Architect v2 | `5377884217` | 3 |
| Evaluation - QA Test Case Architect v2 | `5378572351` | 3 |
| Change Log - QA Test Case Architect v2 | `5379194894` | 3 |

Update scope:

- Published default all-nine ArtifactPack behavior.
- Published the single-artifact exception.
- Published high-risk AC categories from Robert's review.
- Published production conflict handling as human-review only.
- Published evaluation-only source precedence rationale behavior.
- Published clarification that Jira exports, pasted packets, and attachments do not replace `TICKET_PACK_COMBINED.xml` in production unless included inside the ticket pack.

## Category Eval Hardening Publish - 2026-06-15

Republished the affected QA Test Case Architect v2 pages after Category 2, 3, and 4 evaluations each scored 80 percent with one unresolved case.

| Field | Value |
|---|---|
| Date | 2026-06-15 |
| Space | ROVO |
| Mode | Update existing |
| Dry-run command | `.\scripts\Publish-ConfluencePages.ps1 -EnvPath C:\projects\rovo-governance-admin-toolkit\.env -ConfigPath C:\projects\rovo-governance-admin-toolkit\config\confluence-pages.yml -Slug qa-test-case-architect-v2-studio-setup,qa-test-case-architect-v2-rovo-studio-configuration,qa-test-case-architect-v2-evaluation,qa-test-case-architect-v2-change-log -UpdateExisting` |
| Apply command | `.\scripts\Publish-ConfluencePages.ps1 -EnvPath C:\projects\rovo-governance-admin-toolkit\.env -ConfigPath C:\projects\rovo-governance-admin-toolkit\config\confluence-pages.yml -Slug qa-test-case-architect-v2-studio-setup,qa-test-case-architect-v2-rovo-studio-configuration,qa-test-case-architect-v2-evaluation,qa-test-case-architect-v2-change-log -UpdateExisting -Apply` |

| Page | Page ID | Published version |
|---|---|---:|
| Studio Setup - QA Test Case Architect v2 | `5377490989` | 5 |
| ROVO Studio Configuration - QA Test Case Architect v2 | `5377884217` | 4 |
| Evaluation - QA Test Case Architect v2 | `5378572351` | 4 |
| Change Log - QA Test Case Architect v2 | `5379194894` | 4 |

Update scope:

- Hardened AC normalization so overlapping ACs are never merged or deduplicated.
- Required deterministic IDs in `TC-{StoryID}-{AC}-{AREA}-{TYPE}-{NNN}` format when source data is available.
- Added raw-only output behavior for XRAY CSV only / raw CSV only requests.

## XRAY Continuation-Row Hardening Publish - 2026-06-15

Republished the affected QA Test Case Architect v2 pages after the Category 4 re-test still failed the multi-step continuation-row rule.

| Field | Value |
|---|---|
| Date | 2026-06-15 |
| Space | ROVO |
| Mode | Update existing |
| Dry-run command | `.\scripts\Publish-ConfluencePages.ps1 -EnvPath C:\projects\rovo-governance-admin-toolkit\.env -ConfigPath C:\projects\rovo-governance-admin-toolkit\config\confluence-pages.yml -Slug qa-test-case-architect-v2-studio-setup,qa-test-case-architect-v2-rovo-studio-configuration,qa-test-case-architect-v2-evaluation,qa-test-case-architect-v2-change-log -UpdateExisting` |
| Apply command | `.\scripts\Publish-ConfluencePages.ps1 -EnvPath C:\projects\rovo-governance-admin-toolkit\.env -ConfigPath C:\projects\rovo-governance-admin-toolkit\config\confluence-pages.yml -Slug qa-test-case-architect-v2-studio-setup,qa-test-case-architect-v2-rovo-studio-configuration,qa-test-case-architect-v2-evaluation,qa-test-case-architect-v2-change-log -UpdateExisting -Apply` |

| Page | Page ID | Published version |
|---|---|---:|
| Studio Setup - QA Test Case Architect v2 | `5377490989` | 6 |
| ROVO Studio Configuration - QA Test Case Architect v2 | `5377884217` | 5 |
| Evaluation - QA Test Case Architect v2 | `5378572351` | 5 |
| Change Log - QA Test Case Architect v2 | `5379194894` | 5 |

Update scope:

- Made the governed continuation-row rule override conflicting retrieved template wording.
- Required the exact XRAY CSV header with `Execution Type` and `Test Type`.
- Explicitly banned duplicate `Test Type` headers.
- Added a pre-return self-check for header duplication and repeated metadata on continuation rows.
