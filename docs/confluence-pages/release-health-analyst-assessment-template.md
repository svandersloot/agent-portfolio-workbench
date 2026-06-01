# Template - Release Health Analyst Assessment Page

Use this template when Release Health Analyst creates the initial assessment page for one release or reruns an existing assessment with new evidence.

Create one normal Confluence page per assessed release. Use this page title pattern:

```text
Release Health Analyst Assessment: [Release Name]
```

Example:

```text
Release Health Analyst Assessment: Mobilitas 2026.07.10
```

This template is based on the useful structure from `Release Health Analyst Assessment: Mobilitas 2026.06.12 v2`, MO page `5310382145`, version `14`. The source page is a structure and quality reference only. Do not carry forward release-specific findings, blockers, risks, exceptions, counts, or readiness conclusions unless they are provided as current evidence for the release being assessed.

## How To Use This Page

| Audience | Use |
|---|---|
| Release owners | Review readiness signal, blockers, risks, source gaps, and questions before making the human release decision. |
| Change stakeholders | Understand what changed, what remains unresolved, and what evidence supports the assessment. |
| Dev leads | Confirm code, branch, PR, merge, dependency, and owner evidence for unresolved items. |
| QA leads | Confirm test coverage, regression status, signoff, and validation gaps. |
| Release Health Analyst | Use this as the preferred page structure for initial assessments and reruns. |

## Assessment Rules

- Treat this template as the canonical output structure for Release Health Analyst assessment pages.
- When a user asks naturally to create, rerun, refresh, update, compare, or regenerate a release health assessment, use this template even if the user does not paste a full prompt.
- Pair this template with `Prompt Library - Release Health Analyst Assessment Pages` when deciding whether the request is an initial assessment or a rerun of an existing page.
- Use exact release identity from the supplied release page, current assessment page, Jira scope, release plan, or handoff evidence.
- If release identity, source-truth branch, Jira scope, QA evidence, Bitbucket evidence, deployment evidence, release notes, or owner approval is missing or ambiguous, mark it as `Data Incomplete` or `UNKNOWN`.
- Do not infer readiness from missing evidence.
- Keep final release readiness human-owned. This page provides decision support only.
- Keep accepted exceptions visible as human-owned caveats, not automatic passes.
- Separate P1 blockers from P2/P3 risks and cleanup items.
- Preserve useful history, prior blockers, accepted exceptions, source gaps, and follow-up items when rerunning an assessment.
- If prior items are no longer current, move them to `Resolved Or Superseded Items` with the reason.
- Keep required section headings visible even when there are no active items. Use `None identified from current evidence` or `Not applicable` rather than omitting the section.

## Required Page Sections

### Assessment Fingerprint

Include this section at the top so the next run can compare against a stable state.

| Field | Value |
|---|---|
| Assessment run date/time | `[timestamp and timezone]` |
| Release identity | `[release name / fixVersion / release page identity]` |
| Assessment page | `[page link]` |
| Current page version or last reviewed date | `[version/date/unknown]` |
| Release stage | `[pre-freeze / code freeze / release readiness / post-freeze / unknown]` |
| Code freeze date | `[date/unknown/not applicable]` |
| Source-truth branch | `[branch/documented override/unknown]` |
| Jira scope source | `[JQL/filter/export/release page/unknown]` |
| Jira issue count | `[count/unknown]` |
| QA evidence | `[link/date/unknown]` |
| Code evidence | `[Bitbucket/build/PR evidence/date/unknown]` |
| Deployment or release-note evidence | `[link/date/unknown]` |
| Release Drift Handoff | `[link/version/date/not used]` |
| P1 blocker count | `[count]` |
| P2/P3 risk count | `[count]` |
| Accepted exception count | `[count]` |
| UNKNOWN/Data Incomplete count | `[count]` |

Fingerprint summary:

```text
release=[release identity] stage=[stage] freeze=[date/unknown] assessmentDate=[date] status=[Ready with caveats / At risk / Blocked / Unknown] trend=[Improving / Stable / Worsening / Unknown] p1=[count] p2p3=[count] unknown=[count]
```

### Executive Summary

Include:

- Overall readiness signal: `Ready with caveats`, `At risk`, `Blocked`, or `Unknown / Data Incomplete`.
- Short explanation of why the signal changed or stayed the same.
- Most important release deadline, blocker, or evidence gap.
- What must happen before a human release owner can make or confirm the final decision.

### Issue Classification

Use P1-P5 classification to keep the assessment scannable.

| Category | Meaning | Count | Key Issues |
|---|---|---:|---|
| P1 | Blockers, critical defects, failed release gates, or evidence that contradicts readiness. | `[count]` | `[keys/items]` |
| P2 | High-risk open items, post-freeze bugs, missing validation, or unresolved decision points. | `[count]` | `[keys/items]` |
| P3 | Scope additions, late changes, dependency risks, or cleanup items that may affect confidence. | `[count]` | `[keys/items]` |
| P4 | Resolved carry-over items retained for context or audit history. | `[count]` | `[keys/items]` |
| P5 | Informational or minor items that do not materially affect release readiness. | `[count]` | `[keys/items]` |

### Risk Analysis And Deep Dive

Group the most important risks by theme, owner, business deadline, aging item, test gap, deployment dependency, or source gap.

For each item include:

- Item or Jira key.
- Current state.
- Evidence.
- Risk.
- Required action.
- Owner or needed owner.

### Business Deadline Or Change Risk

Use this section when the release has an effective date, business commitment, regulatory date, customer commitment, deployment window, or time-sensitive workaround.

| Item | Deadline / window | Current state | Risk if missed | Needed action |
|---|---|---|---|---|
| `[item]` | `[date/window]` | `[state]` | `[risk]` | `[action]` |

### Trend Analysis

When rerunning, compare the prior page state to the new assessed state.

| Metric | Previous assessment | Current assessment | Trend |
|---|---:|---:|---|
| Total scope | `[count/unknown]` | `[count/unknown]` | `[improving/stable/worsening/unknown]` |
| Open items | `[count/unknown]` | `[count/unknown]` | `[trend]` |
| P1 count | `[count]` | `[count]` | `[trend]` |
| P2/P3 count | `[count]` | `[count]` | `[trend]` |
| UNKNOWN/Data Incomplete count | `[count]` | `[count]` | `[trend]` |
| Readiness signal | `[prior signal]` | `[current signal]` | `[trend]` |

For initial pages, use `Baseline` for the previous assessment column.

### Source Completeness

| Source area | Status | Evidence | Gap / next action |
|---|---|---|---|
| Jira scope | `[Complete / Incomplete / Unknown]` | `[source]` | `[gap/action]` |
| Bitbucket/code | `[Complete / Incomplete / Unknown]` | `[source]` | `[gap/action]` |
| QA/testing | `[Complete / Incomplete / Unknown]` | `[source]` | `[gap/action]` |
| Deployment/change | `[Complete / Incomplete / Unknown]` | `[source]` | `[gap/action]` |
| Release notes | `[Complete / Incomplete / Unknown]` | `[source]` | `[gap/action]` |
| Release Drift Handoff | `[Used / Not used / Unknown]` | `[source]` | `[gap/action]` |
| Owner approval | `[Complete / Incomplete / Unknown]` | `[source]` | `[gap/action]` |

### P1 Blockers

List only active P1 blockers. Keep this section visible even when there are zero P1 blockers.

| Blocker | Evidence | Owner / needed owner | Required action | Timing |
|---|---|---|---|---|
| `[blocker]` | `[evidence]` | `[owner]` | `[action]` | `[date/window]` |

If none are active, use:

| Blocker | Evidence | Owner / needed owner | Required action | Timing |
|---|---|---|---|---|
| None identified from current evidence. | P1 count is `0`. | Not applicable. | Continue monitoring source completeness. | Next assessment. |

### P2/P3 Risks And Cleanup Items

| Priority | Item | Evidence | Risk | Recommended action |
|---|---|---|---|---|
| `[P2/P3]` | `[item]` | `[evidence]` | `[risk]` | `[action]` |

### Accepted Exceptions And Caveats

| Exception | Accepted by | Evidence | Residual risk | Expiration / revisit condition |
|---|---|---|---|---|
| `[exception]` | `[owner/unknown]` | `[evidence]` | `[risk]` | `[condition]` |

### Resolved Or Superseded Items

Use this section on reruns to preserve useful prior context without leaving old items in active blocker/risk sections. Keep this section visible on reruns even when no items were resolved or superseded.

| Item | Previous state | New state | Reason / evidence |
|---|---|---|---|
| `[item]` | `[prior state]` | `[resolved/superseded/deferred]` | `[evidence]` |

If no items changed, use:

| Item | Previous state | New state | Reason / evidence |
|---|---|---|---|
| None identified from current evidence. | No prior item was cleared. | No change. | Rerun did not provide evidence that superseded prior items. |

### Recommendations

Use action-oriented recommendations. Keep them tied to evidence and owners.

| Priority | Recommendation | Owner / needed owner | Evidence | Timing |
|---|---|---|---|---|
| `[P1/P2/P3]` | `[recommendation]` | `[owner]` | `[evidence]` | `[date/window]` |

### Questions For Release Owner

List only the questions needed for a human release owner to make or confirm the final decision.

- `[question]`

### Next Assessment Instructions

Always include this section, even when the next step is simple. Include:

- Fingerprint summary string from this assessment.
- Evidence that should be added before the next rerun.
- Known source gaps that should remain visible if not cleared.
- Any accepted exceptions that must not be silently removed.
- Suggested rerun trigger, such as after QA signoff, handoff update, deployment evidence, owner decision, or the next daily release review.

## Creation Checklist

- [ ] Release identity is explicit or marked `Data Incomplete`.
- [ ] Jira scope source and issue count are captured or marked `UNKNOWN`.
- [ ] Source-truth branch is captured or marked `UNKNOWN`.
- [ ] QA/test evidence is captured or marked `UNKNOWN`.
- [ ] Code/deployment evidence is captured or marked `UNKNOWN`.
- [ ] P1 blockers are separate from P2/P3 risks.
- [ ] Accepted exceptions are visible.
- [ ] Fingerprint summary is present for the next run.
- [ ] Final decision remains human-owned.

## Agent Usage Notes

Release Health Analyst should use this page as a knowledge source, not only as a human-facing template.

When the user asks for an assessment in plain language, the agent should:

1. Identify whether the request is an initial page, rerun, evidence update, handoff comparison, or stakeholder review.
2. Consult `Prompt Library - Release Health Analyst Assessment Pages` for the matching workflow.
3. Use this template for the final page structure.
4. Fill fields from current evidence when available.
5. Ask only for required missing information that cannot be inferred from provided pages or evidence.
6. Mark unclear or missing evidence as `Data Incomplete` or `UNKNOWN` instead of inventing it.
