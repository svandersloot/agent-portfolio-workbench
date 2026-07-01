# Prompt Library - Release Health Analyst Assessment Pages

Use these prompts with Release Health Analyst when creating or rerunning release assessment pages.

These prompts are designed to preserve the useful structure from `Template - Release Health Analyst Assessment Page`, keep final readiness human-owned, and make each page easy to rerun from its fingerprint.

This page is both a human prompt library and an agent playbook. Users should not need to paste the full prompt every time. Release Health Analyst should consult this page when a user naturally asks to create, rerun, refresh, update, compare, or regenerate an assessment page.

## Agent Playbook

| User intent | Agent behavior |
|---|---|
| Create a new assessment page | Use `Initial Assessment Page` and the assessment template. Infer release identity from supplied current evidence. |
| Rerun or refresh an existing assessment | Use `Rerun Existing Assessment Page`. Treat the current page as the source for release identity and prior state. |
| Compare new evidence with the current page | Use the rerun workflow and include `What Changed Since The Current Page`. |
| Use a Release Drift Handoff | Add `Rerun With Release Drift Handoff` rules. Treat the handoff as evidence, not an automatic decision. |
| Prepare follow-up for open items | Use `Open Item Follow-Up Triage` before drafting comments or outreach. Decide whether each item needs a Jira comment, POC outreach, release owner question, or no action. |
| User provides a short or vague request | Ask for the smallest missing input needed, or mark missing evidence as `Data Incomplete` / `UNKNOWN`. |

## Studio Configuration Patch

Add this block to Release Health Analyst Studio instructions so the agent uses this page without requiring humans to copy long prompts.

```text
When the user asks to create, rerun, refresh, update, compare, or regenerate a Release Health Analyst assessment page, first consult these knowledge sources:
- Template - Release Health Analyst Assessment Page
- Prompt Library - Release Health Analyst Assessment Pages
- Release Scope Definition for this team (created from Template - Release Scope Definition)
- Release Health Analyst Assessment Behavior Rules

Use those pages as the canonical assessment workflow and output structure. Do not require the user to paste the full prompt. Infer blanks from the current assessment page, linked release page, Jira scope, Release Drift Handoff, QA evidence, code evidence, deployment notes, release notes, and user-provided context when available.

Derive release scope only from the team's Release Scope Definition, running its declared query verbatim. Do not add or remove project filters or infer scope.

Set status and classification per the Assessment Behavior Rules: key status to production impact, use P1-P5 consistently, and when a Jira item's status conflicts with its comments, ask a status-verification question and record an evidence note rather than recommending deferral, reopening, or a fixVersion change.

For initial assessment requests, follow the Initial Assessment Page workflow.
For rerun, refresh, update, or compare requests, follow the Rerun Existing Assessment Page workflow.
If a Release Drift Handoff is provided or discoverable, apply the Rerun With Release Drift Handoff rules.
If the user asks for comments, outreach, or follow-up for open assessment items, apply Open Item Follow-Up Triage before drafting any Jira comment.

If required release identity or source evidence is missing or ambiguous, ask the smallest number of clarifying questions needed, or mark the field as `Data Incomplete` / `UNKNOWN` instead of guessing.

Always return a copy-ready Confluence page body, preserve useful existing page content, keep source completeness visible, keep final readiness human-owned, and include an Assessment Fingerprint for the next run. Keep required section headings visible even when there are no active items; use `None identified from current evidence` or `Not applicable` instead of omitting sections.
```

## Knowledge Source Checklist

Release Health Analyst should have these named sources available before broad use:

- Template - Release Health Analyst Assessment Page
- Prompt Library - Release Health Analyst Assessment Pages
- Release Scope Definition for this team (created from Template - Release Scope Definition)
- Template - Release Scope Definition
- Release Health Analyst Assessment Behavior Rules
- Release Evidence Ledger Contract
- Release Drift Monitor handoff pages when available for the release
- Current release assessment page when rerunning
- Current release plan, Jira scope, QA evidence, code evidence, deployment/change evidence, and release notes when provided or accessible

## Initial Assessment Page

Use this when creating the first Release Health Analyst assessment page for a release.

```text
Create a new Release Health Analyst assessment page for the current release.

Use this template page as the structure and quality model:
[PASTE LINK TO TEMPLATE - RELEASE HEALTH ANALYST ASSESSMENT PAGE]

Use the current evidence I provide as the only source for release identity, release stage, source-truth branch, Jira scope, QA evidence, code evidence, deployment evidence, release notes, accepted exceptions, and owner approval.

Current release source material:
[PASTE RELEASE PAGE, RELEASE PLAN, JIRA FILTER, RELEASE DRIFT HANDOFF, QA NOTES, BITBUCKET/BUILD EVIDENCE, DEPLOYMENT NOTES, RELEASE NOTES, OWNER UPDATE, OR OTHER CURRENT EVIDENCE]

Create a complete copy-ready Confluence page for the new assessment.

Rules:
- Infer release identity, fixVersion, release stage, and source-truth branch only from the provided current evidence.
- If release identity, source-truth branch, Jira scope, QA evidence, Bitbucket/code evidence, deployment evidence, release-note evidence, or owner approval is missing or ambiguous, mark it as `Data Incomplete` or `UNKNOWN`.
- Do not infer readiness from missing evidence.
- Keep final release readiness human-owned. Provide decision support only.
- Separate P1 blockers from P2/P3 risks and cleanup items.
- Preserve accepted exceptions as human-owned caveats, not automatic passes.
- Include useful template concepts such as Assessment Fingerprint, Executive Summary, Issue Classification, Risk Analysis, Trend Analysis, Source Completeness, Recommendations, Questions For Release Owner, and Next Assessment Instructions.
- Keep required sections visible even when empty. If there are no P1 blockers, include the P1 Blockers section with `None identified from current evidence`.
- For the first page, use `Baseline` in trend sections where no prior assessment exists.
- Do not update Confluence, Jira, PRs, branches, release status, deployment records, or release notes directly.

Return:

# Release Health Analyst Assessment: [inferred release name]

## Assessment Fingerprint
Include the run date/time, inferred release identity, evidence sources used, inferred release stage, inferred source-truth branch if available, Jira scope source and issue count if available, QA evidence, code evidence, deployment/release-note evidence, Release Drift Handoff if used, counts for P1 blockers, P2/P3 risks, accepted exceptions, UNKNOWN/Data Incomplete items, and a short fingerprint summary string for the next rerun.

## Executive Summary
Give the initial readiness signal: `Ready with caveats`, `At risk`, `Blocked`, or `Unknown / Data Incomplete`.

Explain why in plain language.

## Issue Classification
Use P1-P5 classification with counts and key issues.

## Risk Analysis And Deep Dive
Group the most important risks by theme, owner, business deadline, aging item, test gap, deployment dependency, or source gap.

## Business Deadline Or Change Risk
Include this section if any current evidence has an effective date, business deadline, deployment window, customer commitment, or workaround.

## Trend Analysis
Use `Baseline` for the previous state on an initial page.

## Source Completeness
Use a table for Jira scope, Bitbucket/code, QA/testing, deployment/change, release notes, Release Drift Handoff, and owner approval.

## P1 Blockers
List active P1 blockers only, with evidence, owner/needed owner, required action, and timing if known. If none are active, include the section and state `None identified from current evidence`.

## P2/P3 Risks And Cleanup Items
List lower-priority risks separately from blockers.

## Accepted Exceptions And Caveats
Keep accepted exceptions visible with owner, evidence, residual risk, and revisit condition when known.

## Recommendations
Give action-oriented recommendations tied to evidence and owners.

## Questions For Release Owner
List only the questions needed for a human release owner to make or confirm the final decision.

## Next Assessment Instructions
Always include this section. Include the fingerprint summary, the evidence that should be added before the next rerun, and the suggested rerun trigger.

## Fully Updated Page Body
Provide final copy-ready Confluence page content suitable to create the initial page.
```

## Rerun Existing Assessment Page

Use this when a current assessment page already exists and new evidence needs to be incorporated.

```text
Rerun the release health assessment for the current assessment page and produce a fully updated replacement page that I can paste back into Confluence.

Use the current page as the source for release identity, fixVersion, release stage, source-truth branch, existing scope, prior assessment state, and assessment context. If any of those are missing or ambiguous on the current page, flag them as `Data Incomplete` instead of guessing.

Current assessment page:
[PASTE CONFLUENCE PAGE LINK]

Current page content:
[PASTE CURRENT PAGE CONTENT]

New information to incorporate:
[PASTE NEW JIRA, QA, BITBUCKET, DEPLOYMENT, RELEASE NOTE, EXCEPTION, RELEASE DRIFT HANDOFF, OWNER UPDATE, OR OTHER EVIDENCE]

Please compare the current page against the new information and produce a complete updated page.

Rules:
- Clearly distinguish the previous/current state from the new assessed state.
- Keep all useful existing items from the page unless new evidence supersedes them.
- Do not silently delete useful blockers, risks, accepted exceptions, decisions, source gaps, or follow-up items.
- If an item is no longer current, move it to a resolved/superseded section with the reason.
- Mark missing Jira, Bitbucket, QA, deployment, release-note, or source evidence as `UNKNOWN` or `Data Incomplete`; do not infer readiness.
- Preserve accepted exceptions as human-owned caveats, not automatic passes.
- Separate P1 release blockers from P2/P3 risks and cleanup items.
- Do not update Jira, Confluence, PRs, branches, or release status directly.
- Do not make the final human go/no-go decision. Provide decision support only.
- Keep required sections visible even when empty. If there are no P1 blockers, include the P1 Blockers section with `None identified from current evidence`. Always include Next Assessment Instructions.

Return:

# Release Health Analyst Assessment: [release name inferred from current page]

## Assessment Fingerprint
Include a fingerprint for the next run with:
- Assessment run date/time
- Inferred release identity
- Current assessment page link
- Current page version or last reviewed date, if visible
- Inferred release stage
- Inferred source-truth branch, if visible
- Evidence sources used
- Count of P1 blockers, P2/P3 risks, accepted exceptions, and UNKNOWN/Data Incomplete items
- Short fingerprint summary string that can be copied into the next run

## Previous State From Current Page
Summarize prior readiness, blockers, risks, accepted exceptions, source gaps, and follow-up items.

## New Evidence Reviewed
List each new evidence item, what it changes, and whether it is authoritative, supporting, or incomplete.

## What Changed Since The Current Page
Use a table:
| Area | Previous state | New state | Reason / Evidence |

## Updated Readiness Summary
Include:
- Overall readiness signal: `Ready with caveats`, `At risk`, `Blocked`, or `Unknown / Data Incomplete`
- Why
- What must happen before a human release owner can make the final decision

## P1 Blockers
List active P1 blockers only with evidence, owner/needed owner, required action, and timing if known. If none are active, include the section and state `None identified from current evidence`.

## P2/P3 Risks And Cleanup Items
List lower-priority risks separately from blockers.

## Accepted Exceptions And Caveats
Keep accepted exceptions visible with owner, evidence, residual risk, and revisit condition when known.

## Resolved Or Superseded Items
Move old useful items here when new evidence shows they are no longer active. Keep this section visible on reruns. If no items changed, state `None identified from current evidence`.

## Source Completeness
Use a table:
| Source area | Status | Evidence | Gap / next action |
Include Jira, Bitbucket/code, QA/testing, deployment/change, release notes, release drift handoff, and owner approval.

## Questions For Release Owner
List only the questions needed for a human release owner to make or confirm the final decision.

## Fully Updated Page Body
Provide final copy-ready Confluence page content suitable to paste over the current page while preserving useful history, caveats, and the fingerprint for the next run.
```

## Rerun With Release Drift Handoff

Use this add-on block when the rerun includes a Release Drift Monitor handoff page.

```text
Release Drift Handoff page:
[PASTE HANDOFF PAGE LINK]

Use the handoff as source evidence only after verifying:
- The release identity matches the current assessment page.
- The source-truth branch matches the release stage or documented override.
- Source freshness is acceptable for this assessment.
- Unresolved `BLOCK`, `WARN`, and `UNKNOWN` findings are still current.
- Accepted exceptions are human-owned and documented.

Do not treat Release Drift Monitor findings as automatic go/no-go decisions.
```

## Open Item Follow-Up Triage

Use this when the user wants help with comments, outreach, or next actions for open items on a release health assessment page.

```text
Review this release health assessment page and prepare follow-up for current open items.

Assessment page:
[PASTE CONFLUENCE PAGE LINK OR PAGE BODY]

Release identity:
[PASTE EXACT RELEASE NAME OR FIXVERSION IF KNOWN]

Return a table with:
- Open item, risk, blocker, or Data Incomplete flag
- Severity: P1 blocker, P2/P3 risk, cleanup, accepted-exception follow-up, or Data Incomplete
- Related Jira key, if visible
- Current evidence
- Missing evidence or decision
- Likely POC or needed owner role, if visible
- Best next action: Jira comment draft, POC outreach, QA evidence request, dev/code evidence request, release owner decision question, or no action
- Why this action is appropriate

Rules:
- Triage before drafting.
- Do not draft Jira comments for every open item by default.
- Draft Jira comments only when the target Jira key is exact, the update is useful, and the evidence is specific enough.
- Use POC outreach when evidence is missing or a person needs to provide status.
- Use release owner questions for decisions, accepted exceptions, scope calls, or go/no-go inputs.
- Use `Data Incomplete` or `UNKNOWN` instead of guessing.
- Do not post to Jira, update Confluence, approve release readiness, or make the final go/no-go decision.
```

## Assessment Follow-Up Drafting

Use this only after the open-item triage table exists.

```text
Using this open-item triage table, draft only the applicable follow-ups.

Open-item triage table:
[PASTE TABLE]

For each item, choose exactly one best next action:
- Jira comment draft
- POC outreach message
- QA lead evidence request
- Dev lead evidence request
- Release owner decision question
- No action

For Jira comments, include:
- Target Jira key
- Comment type
- Copy-ready comment
- Evidence used
- Data Incomplete fields
- Open questions

Rules:
- Do not post to Jira.
- Do not draft comments for items where the better action is asking a POC for missing status or evidence.
- Do not group multiple Jira issues into one comment unless each exact target issue and exact comment text is shown separately.
- Do not claim `no blockers`, completion, validation, approval, promotion, or readiness unless the assessment evidence explicitly supports it.
- Preserve final release readiness as human-owned.
```

## Quick Evidence Block

Use this when you need a compact structure for pasting evidence into either prompt.

```text
Evidence update:
- Source:
- Date observed:
- Release or fixVersion shown:
- Jira keys or scope affected:
- What changed:
- Evidence link or pasted excerpt:
- Owner or confirming person:
- Confidence: [high / medium / low / unknown]
- Should this clear an old item, add a new item, or change severity?
```
