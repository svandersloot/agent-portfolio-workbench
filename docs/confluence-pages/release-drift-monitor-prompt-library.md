# Prompt Library - Release Drift Monitor Handoff Pages

Use this page as both a human prompt library and an agent playbook for Release Drift Monitor. Users should be able to ask naturally for a drift pulse, handoff page, update, stakeholder review, or evidence intake without pasting a long prompt every time.

## Canonical Companion Pages

| Page | Use |
|---|---|
| Template - Release Drift Monitor Handoff Page | Required output structure for canonical handoff pages. |
| User Guide - Release Drift Monitor Handoff Pages | Human-facing interpretation guide for dev leads, QA leads, release owners, and Release Health Analyst. |
| Release Evidence Ledger Contract | Evidence states, source rules, and ledger-compatible row structure. |
| Knowledge Source Plan - Release Drift Monitor | Approved source families, fallback evidence, and repository scope. |

## Agent Playbook

| User intent | Agent behavior |
|---|---|
| Initial drift check | Use `Initial Drift Pulse`. Require exact release identity before producing counts. |
| Create a handoff page draft | Use `Create Handoff Page Draft` and the handoff template. |
| Update an existing handoff | Use `Update Existing Handoff`. Preserve accepted exceptions and Release Health Analyst notes. |
| Low-risk daily update | Use `Append Trend History Only`. Update snapshot and trend rows without rewriting the whole page. |
| Stakeholder review | Use `Stakeholder Review` from the requested role perspective. |
| Post-draft follow-up triage | Use `Post-Draft Follow-Up Triage` after a pulse draft or handoff draft to decide what needs owner follow-up, Jira evidence comments, QA evidence, PR or branch evidence, false-positive review, or no action. |
| Draft applicable follow-ups | Use `Applicable Follow-Up Drafting` only after triage. Draft Jira comments only when the target issue is exact and the evidence is specific enough; otherwise draft POC outreach or evidence requests. |
| Pasted PR, QA, test, or owner evidence | Use `Evidence Intake Helper` to convert raw evidence into structured drift evidence. |
| Workflow quality check | Use `Workflow Audit` to verify the agent followed the Drift Monitor rules. |

## Studio Configuration Patch

Add this block to Release Drift Monitor Studio instructions so natural user requests use this prompt library without requiring humans to paste long prompts.

```text
When the user asks to run a drift pulse, create a handoff, update a handoff, refresh trend history, review drift findings, or prepare evidence for Release Health Analyst, first consult:
- Prompt Library - Release Drift Monitor Handoff Pages
- Template - Release Drift Monitor Handoff Page
- User Guide - Release Drift Monitor Handoff Pages

Use those pages as the canonical workflow and output structure. Do not require the user to paste the full prompt.

Infer fields only from current user-provided evidence. If exact release identity is missing or vague, stop and ask for exact fixVersion, release identifier, JQL result, issue list, or release branch plus matching fixVersion confirmation.

For initial drift checks, use Initial Drift Pulse.
For new handoff pages, use Create Handoff Page Draft.
For existing handoff pages, use Update Existing Handoff.
For daily low-risk updates, use Append Trend History Only.
For stakeholder review, use Stakeholder Review.
For post-draft follow-up requests, use Post-Draft Follow-Up Triage before drafting any Jira comment or outreach.
For requested follow-up drafts, use Applicable Follow-Up Drafting and draft only the applicable action for each item.
For pasted PR, test, QA, deployment, or owner evidence, use Evidence Intake Helper.

Never make final readiness or go/no-go recommendations. Route final readiness decision support to Release Health Analyst.
```

## Initial Drift Pulse

Use this when a user asks for an initial drift check, daily pulse, evidence gap check, or pre-freeze release drift review.

```text
Run an initial Release Drift pulse using the standard Release Drift Monitor workflow.

Current release evidence:
[PASTE FIXVERSION, RELEASE PAGE, JQL RESULT, JIRA EXPORT, OR ISSUE LIST]

Release stage:
[Before code freeze / At code freeze / After code freeze / Unknown]

Code freeze target:
[DATE OR UNKNOWN]

Source-truth branch:
[develop / release branch / documented override / unknown]

Use:
- Prompt Library - Release Drift Monitor Handoff Pages
- Template - Release Drift Monitor Handoff Page
- Release Evidence Ledger Contract

Rules:
- If exact release identity is missing, stop and ask for it. Do not infer latest/current release.
- Do not produce PASS/WARN/BLOCK/UNKNOWN counts until exact release identity is confirmed.
- Do not mark PASS from Jira status, sprint assignment, priority, owner alignment, or active work alone.
- Before code freeze, use WARN or UNKNOWN for active work with missing evidence unless a hard gate failed, evidence contradicts readiness, or policy says it blocks.
- Use UNKNOWN when source access, indexing, mapping, or freshness prevents judgment.
- Do not make final readiness or go/no-go recommendations.

Return:
- Release metadata
- Source-truth branch assumptions
- PASS/WARN/BLOCK/UNKNOWN counts
- Top actionable findings grouped by owner, team, or Epic when available
- Evidence route and confidence
- Data incomplete flags
- Next data needed
- Trend History row for a future handoff page
```

## Create Handoff Page Draft

Use this when a user asks to prepare the canonical handoff for Release Health Analyst.

```text
Prepare a copy-ready Release Drift Handoff page for this release.

Use:
- Template - Release Drift Monitor Handoff Page
- Prompt Library - Release Drift Monitor Handoff Pages

Current evidence:
[PASTE RELEASE SCOPE, DRIFT PULSE, JIRA EXPORT, QA EVIDENCE, CODE EVIDENCE, ACCEPTED EXCEPTIONS]

Rules:
- Create one normal handoff page for one exact release.
- Use title pattern: `Release Drift Handoff - [Exact fixVersion]`.
- Do not make final readiness or go/no-go recommendations.
- Keep accepted exceptions visible.
- Mark missing evidence as `UNKNOWN` or `Data Incomplete`.
- Include Release Health Analyst Handoff section.
- Keep required sections visible even when empty; use `None identified from current evidence` or `Not applicable` instead of omitting sections.

Return:
- Full copy-ready Confluence page body
- Any missing evidence that should be collected before publication
- Questions needing release owner, dev lead, or QA lead confirmation
```

## Update Existing Handoff

Use this when a user asks to refresh or rerun an existing handoff page with new evidence.

```text
Update this existing Release Drift Handoff page using the latest evidence.

Existing handoff page:
[PASTE PAGE LINK]

New evidence:
[PASTE NEW JIRA, PR, QA, TEST, RELEASE OWNER, OR EXCEPTION EVIDENCE]

Compare the existing page with the new evidence and update only:
- Current Snapshot
- Trend History
- New or worsened findings
- Resolved Drift
- Shared Evidence And Validation Anchors
- Accepted Exceptions
- Data Incomplete Flags

Rules:
- Do not create a duplicate page.
- Do not overwrite accepted exceptions or Release Health Analyst notes.
- Do not make a final readiness or go/no-go recommendation.
- Preserve useful existing findings unless new evidence supersedes them.
- Move cleared items to Resolved Drift with evidence.
- Keep required sections visible even when empty.

Return:
- Planned changes
- Copy-ready updated sections
- Questions needing owner confirmation
```

## Append Trend History Only

Use this for low-risk daily pulse updates when the full handoff body does not need to be rewritten.

```text
Create a Trend History update for the existing Release Drift Handoff page.

Existing handoff page:
[PASTE PAGE LINK]

Current pulse evidence:
[PASTE CURRENT COUNTS AND FINDINGS]

Return only:
- Updated Current Snapshot
- One new Trend History row
- New drift
- Resolved drift
- Data gaps
- Next data needed

Do not rewrite the whole page unless I ask.
Do not overwrite accepted exceptions or Release Health Analyst notes.
Do not make final readiness or go/no-go recommendations.
```

## Stakeholder Review

Use this when a dev lead, QA lead, release owner, or other reviewer wants to validate the handoff from their perspective.

```text
Review this Release Drift Handoff page from the perspective of:
[Dev Lead / QA Lead / Release Owner]

Handoff page:
[PASTE PAGE LINK]

Focus on:
- Findings that are actionable
- Findings that look stale or wrong
- Missing evidence sources
- Owner corrections
- Accepted exceptions that need confirmation
- Validation or shared test anchor updates

Return:
- Confirmed items
- Corrections needed
- Missing evidence
- Questions for the stakeholder
- Suggested handoff updates, if any
```

## Post-Draft Follow-Up Triage

Use this after a Release Drift pulse draft or handoff draft exists and the user wants to prepare follow-up actions.

```text
Review this Release Drift post-draft and help me prepare follow-up actions.

Draft or handoff page:
[PASTE CONFLUENCE PAGE LINK OR PAGE BODY]

Release identity:
[PASTE EXACT FIXVERSION OR RELEASE NAME]

Release stage:
[Before code freeze / At code freeze / After code freeze / Unknown]

Source-truth branch:
[develop / release branch / documented override / unknown]

Return:
- Items ready to keep as-is
- Findings that need owner follow-up
- Findings that need a Jira release-evidence comment
- Findings that need QA or test evidence
- Findings that need PR, branch, or code evidence
- Findings that look stale, duplicated, or possibly false positive
- Data Incomplete flags that must be cleared before Release Health Analyst consumes this handoff

For each recommended follow-up, include:
- Jira key or finding ID
- Likely owner or owner role, if visible
- Current evidence
- Missing evidence
- Best next action
- Why this action is appropriate

Rules:
- Do not make a final release readiness or go/no-go recommendation.
- Do not mark PASS from Jira status alone.
- Do not treat open PRs as complete code evidence.
- Preserve accepted exceptions.
- If evidence is missing, use `UNKNOWN` or `Data Incomplete`.
- Do not update Confluence or Jira.
```

## Applicable Follow-Up Drafting

Use this only after a triage table exists. The goal is to draft the right follow-up, not to draft a Jira comment for every WARN or UNKNOWN item.

```text
Using the follow-up table from the Release Drift review, draft only the follow-ups that are applicable.

Follow-up table:
[PASTE TRIAGE TABLE]

For each item, choose exactly one best next action:
- Jira release-evidence comment draft
- POC outreach message
- QA lead evidence request
- Dev lead PR or branch evidence request
- Release owner decision question
- No action

For Jira comment drafts, include:
- Target Jira key
- Comment type
- Copy-ready comment
- Evidence used
- Data Incomplete fields
- Open questions

Rules:
- Do not post to Jira.
- Do not draft comments where the better action is asking a POC for status or evidence.
- Do not draft a Jira comment unless the target Jira key is exact and the comment adds useful release evidence.
- Do not claim completion, validation, merge, approval, or readiness unless the triage table or source evidence explicitly supports it.
- Keep broad visibility gaps as program or lead outreach unless individual issue evidence is specific enough.
```

## Evidence Intake Helper

Use this when a user pastes raw PR, branch, commit, QA, test, deployment, or owner evidence and wants to know how it should affect the handoff.

```text
Convert this release evidence into a structured Release Drift Monitor evidence update.

Raw evidence:
[PASTE COMMENT, PR LINK, QA NOTE, TEST PLAN, DEPLOYMENT NOTE, OR OWNER UPDATE]

Return:
- Source type
- Jira keys covered
- Repo/provider if code evidence
- Target branch
- Evidence state: PASS/WARN/BLOCK/UNKNOWN
- Confidence: high/medium/low/unknown
- Whether it clears code evidence, validation evidence, both, or neither
- Recommended Jira comment or handoff row
- Any source gaps that remain
```

## Workflow Audit

Use this after a test run to verify whether Release Drift Monitor used the prompt library, handoff template, and Studio rules correctly.

```text
Review this conversation and report whether you followed the Release Drift Monitor workflow correctly.

Evaluate against:
- Prompt Library - Release Drift Monitor Handoff Pages
- Template - Release Drift Monitor Handoff Page
- Release Drift Monitor Studio instructions
- Release Evidence Ledger Contract

Report:
1. Workflow used:
   - Initial Drift Pulse
   - Create Handoff Page Draft
   - Update Existing Handoff
   - Append Trend History Only
   - Stakeholder Review
   - Evidence Intake Helper
   - Other / unclear
2. Was exact release identity confirmed before drift counts were produced?
3. Was vague release language rejected instead of inferred?
4. Were PASS/WARN/BLOCK/UNKNOWN states used correctly?
5. Were source-truth branch assumptions stated?
6. Were open PRs avoided as PASS?
7. Were accepted exceptions preserved?
8. Did the output avoid final readiness or go/no-go recommendations?
9. Were required handoff sections preserved or clearly marked as empty?
10. What worked well?
11. What should be improved before the handoff is used?

Return a concise audit report with:
- Overall result: PASS / PARTIAL / FAIL
- Evidence from this conversation
- Missing or weak spots
- Recommended Studio or knowledge-source adjustment, if any
```
