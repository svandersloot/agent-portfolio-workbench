# Release Notes Manager Migration Decision

## Decision

Release Notes Manager should be scaffolded as a standalone governed agent in `In Review`, not as an extension, reusable pattern only, or deprecated archive reference.

## Evidence Reviewed

| Source | Evidence |
|---|---|
| `rovo-export/entities.xml` | `Release and Change Agents` index says Release Notes Manager is a useful parent/subagent example for technical, business, and sync modes. |
| `rovo-export/entities.xml` | Same index recommends migrating or archiving Release Notes Manager depending on current use. |
| `rovo-export/entities.xml` | Release/change index says Mobilitas Release Notes Agent is domain-specific and should be kept as example or archive reference. |
| `rovo-export/entities.xml` | Agent inventory body lists Release Notes Manager as `Active / Review Needed` and Release Management Assistant as `Draft / Review Needed`. |
| `docs/confluence-pages/agent-inventory.md` | Current repo inventory has Release Health Analyst as active and explicitly recommends reuse checks before creating new release/change agents. |
| `docs/reports/duplicate-agent-discovery-dry-run.md` | Release/change health requests should check Release Health Analyst first. |

## Options Considered

| Option | Decision | Reason |
|---|---|---|
| Standalone governed agent | Chosen | Release-note drafting, audience rewriting, and sync checking are distinct from release health assessment. |
| Extension of Release Health Analyst | Rejected for now | Would blur health/readiness scoring with release-note narrative drafting and final review flow. |
| Reusable pattern only | Rejected for now | Export evidence marks Release Notes Manager active/review-needed, not merely example-only. |
| Deprecated/archive reference | Rejected for now | No evidence shows the agent was retired or replaced; archive handling fits Mobilitas instead. |

## Boundary Decisions

- Release Health Analyst remains the owner for release health, strict readiness analysis, blockers, and go/no-go style assessment.
- Release Notes Manager owns release-note drafting, audience transformation, and release-note/source synchronization.
- Release Management Assistant remains a later overlap review item.
- Mobilitas Release Notes Agent remains archive/reference and should not seed generic organization-wide defaults.

## Companion Artifacts Created

| Artifact | Path |
|---|---|
| Project Brain | `docs/confluence-pages/release-notes-manager-project-brain.md` |
| Agent Design Record | `docs/confluence-pages/release-notes-manager-agent-design-record.md` |
| Knowledge Source Plan | `docs/confluence-pages/release-notes-manager-knowledge-source-plan.md` |
| Subagent Settings | `docs/confluence-pages/release-notes-manager-subagent-settings.md` |
| ROVO Studio Configuration copy blocks | `docs/confluence-pages/release-notes-manager-rovo-studio-configuration.md` |
| Evaluation | `docs/confluence-pages/release-notes-manager-evaluation.md` |
| Measurement Plan | `docs/confluence-pages/release-notes-manager-measurement-plan.md` |
| Change Log | `docs/confluence-pages/release-notes-manager-change-log.md` |

## Publication Safety Notes

- No Studio writes were performed.
- Confluence publishing must remain dry-run only until the user approves an apply step.
- Repo-only technical workflow details stay in this report and local repo guidance, not in the user-facing Confluence copy blocks.
- `.env`, `config/confluence-pages.yml`, `data/raw`, exports, cookies, headers, and tokens must remain out of Git.

## Confluence Dry-Run

Dry-run date: 2026-05-21

Command scope: Release Notes Manager page set only.

| Slug | Planned action | Parent |
|---|---|---|
| `release-notes-manager-project-brain` | create | `5281218643` |
| `release-notes-manager-agent-design-record` | create | Release Notes Manager Project Brain after parent exists |
| `release-notes-manager-knowledge-source-plan` | create | Release Notes Manager Project Brain after parent exists |
| `release-notes-manager-subagent-settings` | create | Release Notes Manager Project Brain after parent exists |
| `release-notes-manager-rovo-studio-configuration` | create | Release Notes Manager Project Brain after parent exists |
| `release-notes-manager-evaluation` | create | Release Notes Manager Project Brain after parent exists |
| `release-notes-manager-measurement-plan` | create | Release Notes Manager Project Brain after parent exists |
| `release-notes-manager-change-log` | create | Release Notes Manager Project Brain after parent exists |

Result: dry-run only, no apply flag used, no Confluence pages created or updated.

## Confluence Apply

Apply date: 2026-05-21

Result: 8 pages created in the `ROVO` space after user approval.

| Slug | Page ID | Parent |
|---|---|---|
| `release-notes-manager-project-brain` | `5299994681` | `5281218643` |
| `release-notes-manager-agent-design-record` | `5300486153` | `5299994681` |
| `release-notes-manager-knowledge-source-plan` | `5300158474` | `5299994681` |
| `release-notes-manager-subagent-settings` | `5299994697` | `5299994681` |
| `release-notes-manager-rovo-studio-configuration` | `5300715546` | `5299994681` |
| `release-notes-manager-evaluation` | `5301403671` | `5299994681` |
| `release-notes-manager-measurement-plan` | `5300617249` | `5299994681` |
| `release-notes-manager-change-log` | `5301534762` | `5299994681` |

Post-apply dry-run confirmed all 8 pages as `exists` at current version `1`.
