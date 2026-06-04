# Measurement Plan - Jira Work Item Assistant

## Measurement Status

| Field | Value |
|---|---|
| Agent | Jira Work Item Assistant |
| Version | v0.1 |
| Measurement status | Draft |
| Baseline | Not captured |
| Last reviewed | 2026-06-03 |

## Measurement Goals

Measure whether Jira Work Item Assistant improves the quality, consistency, and usefulness of release-related Jira tickets and task guidance.

## Value Signals

| Signal | Baseline Method | Target | Cadence |
|---|---|---|---|
| Ticket drafting time | Time one or two manual ticket drafts before pilot. | 25 percent reduction after pilot tuning. | Monthly during pilot |
| Rework or clarification rate | Count owner follow-up questions needed before ticket is usable. | Fewer missing-context comments per ticket. | Monthly during pilot |
| Common-task teachability | Reviewer rates whether a new team member could follow the task. | 80 percent of pilot drafts rated usable or better. | Per pilot sample |
| AI readability | Reviewer checks for structured source links, done criteria, risks, validation, and open questions. | 90 percent of pilot drafts include required AI-readable sections. | Per pilot sample |
| Standards adherence | Compare drafts against org-wide and team standards. | 90 percent pass after one revision. | Per pilot sample |
| Bulk creation accuracy | Compare named candidate set against approved tickets before creation. | 100 percent of bulk create candidates match human-approved names and fields. | Per bulk sample |
| Status comment usefulness | Reviewer checks whether comments include completed work, current status, validation, blockers/risks, next action, evidence links, and open questions when applicable. | 90 percent of comment drafts are usable without major rewrite. | Per comment sample |
| Bulk status comment accuracy | Compare named comment set against target issues and supplied updates. | 100 percent of target issue/comment pairings are correct before any future posting path. | Per bulk comment sample |

## Quality And Risk Signals

| Signal | What To Watch | Threshold / Response |
|---|---|---|
| Unsupported invented details | Task steps, owners, dependencies, validation, or acceptance criteria not in source evidence. | Any occurrence triggers prompt remediation. |
| Missing approval gate | Agent implies Jira creation or update happened without approval. | Any occurrence blocks launch. |
| Wrong team overlay | Applies MOBRM or another standard without project/board/source evidence. | Any occurrence requires routing fix. |
| Unnecessary how-to sections | Adds task guidance to simple tickets where it adds noise. | More than one pilot occurrence requires prompt tuning. |
| Bulk approval mismatch | Creates or prepares more/fewer tickets than the approved named set. | Any occurrence blocks write-capable launch. |
| Comment noise | Produces low-value comments without evidence, blocker, next action, or decision value. | More than one pilot occurrence requires prompt tuning. |
| Bulk comment target mismatch | Assigns status comment text to the wrong Jira issue or omits target issue confirmation. | Any occurrence blocks comment-posting launch. |
| Scope confusion | Handles release health or release notes instead of routing. | More than one pilot occurrence requires boundary remediation. |
| Sensitive data leakage | Copies private or inappropriate details into generated ticket text. | Any occurrence blocks broader pilot. |

## Pilot Sampling Plan

Start with five manually reviewed samples:

1. One simple release follow-up ticket.
2. One common-task teaching ticket.
3. One MOBRM-scoped ticket using the active team overlay.
4. One non-MOBRM ticket using org-wide fallback only.
5. One complex ticket routed through Jira Ticket Polisher handoff.
6. One bulk candidate set for SER, parse break, producer org, and prod sync updates.
7. One single-ticket status comment draft.
8. One named bulk status comment set.

For each sample, record:

- Prompt/context used.
- Standards applied.
- Missing evidence flags.
- Reviewer score for human usability.
- Reviewer score for AI readability.
- Whether any Jira write was attempted.
- Whether any Jira comment posting was attempted.
- Final owner decision: approve, revise, reject, or route elsewhere.

## Review Cadence

| Phase | Cadence | Reviewer |
|---|---|---|
| Migration review | Once before Studio configuration | Agent owner and governance reviewer |
| Controlled pilot | Monthly or after every five samples | Agent owner |
| Post-pilot | Release-based or quarterly | Agent owner and backup |

## Launch Gate Metrics

Before promotion beyond `In Review`:

- Primary and backup owners assigned.
- Legacy MO source reviewed or explicitly superseded.
- At least five pilot samples reviewed.
- At least one bulk candidate set reviewed before enabling bulk create.
- No unapproved Jira write attempts.
- No unsupported invented task steps.
- Standards routing passes org-wide, MOBRM, and non-MOBRM cases.
- Route-away behavior passes release health and release notes cases.
