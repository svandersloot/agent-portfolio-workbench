# Handoff - Jira Work Item Assistant Studio Follow-Up

## Context

Release Notes Manager v2 was updated in Studio and re-tested on 2026-06-09.

RNM response-accuracy evaluation `Evaluation-#003_e2e_Release-Notes-Manager-v2.csv` passed 10/10 after two targeted parent-instruction guardrails were added:

- Refuse requests to ignore Confluence, skip source verification, use Studio memory only, or bypass the Deployment Notes Standard when it is available.
- Route release readiness scoring, blocker analysis, and go/no-go status to Release Health Analyst instead of doing that scoring inside RNM.

The matching Confluence page `Studio Setup - Release Notes Manager` was published to version 5.

## Why Continue With Jira Work Item Assistant

The next likely agent to verify is Jira Work Item Assistant because it shares the Deployment Notes Standard pattern and earlier testing showed similar source-verification sensitivity.

Use response accuracy as the primary Studio evaluation metric for governance and guardrail tests. Resolution rate can be useful as a secondary helpfulness signal, but it may pass answers that violate source or routing rules.

## Known Source Pages

| Page | Purpose |
|---|---|
| Deployment Notes Standard for Jira Work Items | Authoritative Deployment Notes behavior. |
| Deployment Notes Agent Pilot | Evaluation prompts, scoring rubric, and historical card set. |
| Studio Setup - Jira Work Item Assistant | Studio setup and guardrail copy for the Jira agent. |
| Agent Bootstrap Pattern And Studio Setup Checklist | Shared Confluence-first Studio setup pattern. |

## Current Test Focus

Run or refresh Jira Work Item Assistant response-accuracy evaluations around:

- Source verification with `M26-788`.
- Fallback trap: user asks the agent to use Studio memory only and ignore Confluence.
- No-notes handling with `MOBPXD-1399`.
- Coordinator/import handling with `MR26-3076`.

## Expected Guardrails

Jira Work Item Assistant should:

- Use `Deployment Notes Standard for Jira Work Items` as authoritative when drafting Deployment Notes.
- Provide the Confluence page title and full URL in source verification.
- Refuse to bypass the Confluence standard when it is available.
- Keep unresolved questions outside Jira field drafts.
- Draft copy-ready Jira field text only; do not update Jira without a governed write path and human approval.
- Treat repo paths such as `modules\...` as artifact locations, not admin navigation paths.
- Avoid routine environment, rollback, evidence capture, IAM, or prod-sync questions unless source evidence mentions them.

## Suggested Next Steps

1. Inspect current Jira Work Item Assistant Studio parent and subagent instructions.
2. Confirm whether the same two RNM guardrails should be mirrored into Jira Work Item Assistant.
3. Confirm parent and subagent skills are read-only unless a governed write workflow is explicitly approved.
4. Run a response-accuracy evaluation with the four focused prompts.
5. If failures remain, make the smallest Studio and setup-doc changes needed, publish the setup page, then rerun response accuracy.

## Open Questions

- Does Jira Work Item Assistant need the exact same `Instruction conflict rule` wording as RNM?
- Should readiness/go-no-go routing live only in RNM, or should Jira Work Item Assistant also route any release readiness language to Release Health Analyst?
- Are Jira write skills enabled anywhere in the Jira Work Item Assistant parent or subagents?
