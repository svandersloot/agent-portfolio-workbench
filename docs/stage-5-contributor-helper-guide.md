# Stage 5 Contributor And Helper Guide

Use this guide when a teammate or Codex-assisted helper contributes to the Stage 5 pilot without owning live system changes.

The helper role is valuable because it can draft faster than the owner can write every artifact by hand. The helper role is limited because final approval, live configuration, and pilot promotion remain human-owned.

## Helper Can Draft

| Draft area | Allowed work | Required source |
|---|---|---|
| Agent fit notes | Restate pain point, audience, trigger, expected output, and fit-route options | `docs/confluence-pages/agent-fit-intake.md` |
| Duplicate comparison | Search inventory, list similar agents, compare audience/source/tool/output overlap | `docs/confluence-pages/agent-inventory.md` |
| Project Brain scaffold | Draft purpose, audience, sources, ownership gaps, risks, and measurement idea | Completeness contract and owner-provided context |
| Evaluation prompts | Draft source-verification, fallback, unsafe-write, and behavior regression prompts | Existing evaluation pages and approved source docs |
| Metrics tracker | Prepare manual rows for usage, value, quality, risk, feedback, and decision capture | `templates/stage-5-pilot-feedback-tracker-template.md` |
| Promotion packet | Fill known fields and leave unknowns explicit | `templates/stage-5-pilot-promotion-packet-template.md` |
| Readiness review | Summarize evidence, gaps, and recommended next action | Stage 5 start-here and pilot boundaries |

## Helper Must Not Do

- Do not publish Confluence pages.
- Do not update Jira tickets, comments, fields, statuses, assignees, ranks, or labels.
- Do not save or change ROVO Studio configuration.
- Do not change Studio access, visibility, managers, tools, or knowledge sources.
- Do not claim an agent is live, published, approved, or team-ready without user-supplied evidence.
- Do not use raw captures, HARs, cookies, headers, tokens, `.env`, `config/confluence-pages.yml`, or unsanitized exports.
- Do not choose broad audience expansion as part of first-pilot work.

## Approval Boundaries

| Item | Helper output | Required approval |
|---|---|---|
| New-agent recommendation | Fit-route rationale and duplicate decision | Governance steward or reviewer |
| Owner and backup owner | Draft field or explicit gap | Agent owner or manager |
| Approved sources | Draft source list and context readiness notes | Source owner and agent owner |
| Tool or action use | Risk notes and human approval gate proposal | Reviewer/manager; security/legal/compliance when triggered |
| Pilot promotion | Completed packet with evidence and open gaps | Reviewer/manager plus agent owner |
| Team promotion | Pilot metric summary and issue log | Reviewer/manager plus governance steward |
| Live system changes | Copy-ready text or dry-run command notes only | Human operator outside Codex |

## Safe Codex Workflow

1. Start in an isolated branch or worktree when the main checkout is dirty.
2. Read the Stage 5 start-here, pilot boundaries, intake, inventory, and completeness contract.
3. Draft only repo-backed artifacts.
4. Mark unknowns as `TBD`, `UNKNOWN`, or `Data Incomplete`; do not infer live status.
5. Keep private config and raw captures out of the diff.
6. Run practical validation, such as `git diff --check` and JSON/YAML parsing for touched structured files.
7. Propose commit slices that keep operating model, boundaries/templates, and pointer updates reviewable.

## Evidence Labels

Use the manual promotion evidence language consistently:

| Label | Meaning |
|---|---|
| `User-provided` | The user confirms publication, configuration, approval, or usage. |
| `Source-backed` | The user supplies a page export, Studio excerpt, workflow config excerpt, or other reviewable source. |
| `Data Incomplete` | Evidence is missing or partial. |
| `UNKNOWN` | Status cannot be determined from supplied context. |

## Handoff Note

When a helper finishes a draft, the handoff should name:

- changed files
- open approvals
- missing evidence
- validation run
- live-system changes explicitly not performed
- recommended next review action
