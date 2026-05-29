# Jira Ticket Polisher Team Standards - Draft Overlays

Use this page to track team-specific Jira ticket standards for Jira Ticket Polisher. Team overlays supplement the organization-wide standard. They do not replace it.

## Evidence Policy

Keep three kinds of evidence separate:

| Evidence type | Meaning | Can the agent apply it as a team overlay? |
|---|---|---|
| Documented standard | A team-owned Confluence page, board policy, or explicit team owner instruction. | Yes, when current and accessible. |
| Observed pattern | Repeated structure or field usage seen in sampled tickets. | No, use as research evidence only. |
| Proposed standard | Draft recommendation for team review. | No, unless the team owner supplies or approves it for the request. |

## Team Overlay Status

| Team or board | Documented standard status | Observed pattern status | Proposed overlay status | Current agent behavior |
|---|---|---|---|---|
| Breaking Backlogs | Not verified | Not sampled | Draft placeholder | Use org-wide standard only until source is confirmed. |
| 404 Errors | Not verified | Not sampled | Draft placeholder | Use org-wide standard only until source is confirmed. |
| MOBRM | Documented source found in MO page `5266898945`; owner confirmed project key `MOBRM`, board `7690`, owner Shane Vandersloot, backup Harish; ROVO migration review pending. | Not sampled in this pass. | Local draft migration page created for review. | Apply automatically to `MOBRM-*` tickets once the ROVO page is published or supplied; do not trigger from `MR26`, `M26`, or `CLE` alone. |
| MR26 / Mobi Rangers | Not verified | Research seed identified for `project = MR26 AND fixVersion = "Mobilitas 2026.06.12"`; local release evidence says the release had 43 Jira issues, but ticket-quality sample details are not verified. | Draft placeholder | Use org-wide standard only unless a team standard is supplied. |
| Mobilizers | Not verified | Not sampled | Draft placeholder | Use org-wide standard only until source is confirmed. |

## Draft Overlay Template

Use this template when a team standard is documented or when a team owner asks for a draft.

| Section | Team-specific content to capture |
|---|---|
| Team identity | Team name, board, project key, filter, and owner. |
| Issue types | Which issue types the team uses and how they differ. |
| Required fields | Fields, labels, components, fixVersion, sprint, priority, severity, team, or product values required for reporting. |
| Summary pattern | How summaries should be written. |
| Description pattern | Required problem, context, impact, and links. |
| Acceptance criteria | Preferred format, examples, and issue-type differences. |
| QA expectations | Test data, regression scope, evidence, automation, and owner handoff. |
| Technical expectations | Architecture links, repo, API, config, data, environment, or dependency notes. |
| Workflow readiness | Criteria before refinement, sprint pull, development, QA, and done. |
| Release expectations | FixVersion, deployment notes, rollout, feature flags, or communication notes when relevant. |
| Exceptions | Cases where the standard is intentionally different. |

## Breaking Backlogs Draft Placeholder

### Documented Standards

Not verified. Authenticated Confluence and Jira research is required.

### Observed Patterns

Not sampled in this session.

### Proposed Overlay For Review

- Require clear refinement questions before sprint pull.
- Identify whether the ticket is backlog shaping, delivery work, defect follow-up, or dependency cleanup.
- Include acceptance criteria or explicit discovery questions before marking ready.
- Link related epics, dependencies, or decision pages when available.

## 404 Errors Draft Placeholder

### Documented Standards

Not verified. Authenticated Confluence and Jira research is required.

### Observed Patterns

Not sampled in this session.

### Proposed Overlay For Review

- For bugs or defects, require reproduction steps, expected behavior, actual behavior, environment, frequency, and severity rationale.
- For reliability or support work, include affected flow, customer or operational impact, workaround, and validation path.
- Identify whether the issue is code, config, data, infrastructure, or analysis-only.

## MOBRM Draft Migration Review

### Documented Standards

Verified from the user-supplied live Confluence source:

```text
MO page 5266898945 - MOBRM Team Jira Standards - version 3
```

A cleaned migration draft is tracked in:

```text
docs/confluence-pages/mobrm-team-jira-standards.md
```

### Observed Patterns

No live Jira ticket sample was reviewed in this pass. The documented standard itself includes work type labels, summary naming conventions, description requirements, acceptance criteria minimums, Definition of Ready, Definition of Done, sub-task standards, ServiceNow cross-reference format, priority calibration, epic selection, and script execution quick reference.

### Proposed Overlay For Review

- Treat `MOBRM` as a documented team standard from the MO source, with ROVO publish review still pending.
- Apply automatically to `MOBRM-*` tickets once the ROVO page is published or the standard is supplied in the request.
- Use board `7690` as confirming board evidence when visible.
- Do not let related release or epic keys such as `MR26`, `M26`, or `CLE` trigger this overlay by themselves.
- Keep the epic-selection rule evergreen and refresh dated epic examples when the next year's epics are created.
- Treat script execution evidence as preferred auditability and traceability evidence, not automatically blocking unless the work type or owner says it is required.
- Keep ServiceNow examples generic.

## MR26 / Mobi Rangers Draft Placeholder

### Documented Standards

Not verified. Existing repo evidence includes MR26/Mobilitas release samples, but those samples do not prove a current Mobi Rangers ticket quality standard. Mobilitas/MR26 should be treated as a sample source for research, not as the owning location for the migrated ROVO agent.

### Observed Patterns

Existing release-related MR26 evidence in this repo shows the value of exact fixVersion, deployment notes, Jira-key traceability, and code/test evidence. Release Drift Monitor notes `Mobilitas 2026.06.12` had 43 Jira issues in post-freeze review, and the requested research seed is:

```text
project = MR26 AND fixVersion = "Mobilitas 2026.06.12"
```

If Jira requires exact issue-key filtering instead of project filtering, use the equivalent MR26-key export or sample, such as tickets beginning with `MR26-` including examples like `MR26-3082`. Treat all sampled patterns as observed evidence, not official team policy.

### Proposed Overlay For Review

- Include exact fixVersion or release target when work is release-bound.
- Include deployment notes when the ticket requires config, data, pipeline, or release execution work.
- Identify whether work is code-required, QA-only, config-only, data-fix, operational/runbook, or analysis-only when relevant.
- Preserve Jira-key traceability in PRs, release notes, and validation evidence.

## Mobilizers Draft Placeholder

### Documented Standards

Not verified. Authenticated Confluence and Jira research is required.

### Observed Patterns

Not sampled in this session.

### Proposed Overlay For Review

- Identify product or user outcome before implementation details.
- Include acceptance criteria that can be tested by QA or product review.
- Name data, integration, environment, and dependency needs early.
- Capture release, rollout, or support notes when the work affects customer or operational flows.

## Research Instructions For Next Pass

For each team or board:

1. Find the authoritative team standards page.
2. Confirm board name, project key, filter, and owner.
3. Sample 10-15 tickets across ready, in progress, done, blocked, reopened, or recently refined states.
4. Record documented standards separately from observed patterns.
5. Draft proposed overlay changes for team-owner review.
6. Update this page only after source evidence is safe to publish.
