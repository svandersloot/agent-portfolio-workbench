# Prompt

Local Markdown simulation of vNext Release Health Analyst behavior using the new
`Release Scope Derivation Contract`, `Release Health Analyst Assessment Behavior Rules`,
and thinned Studio instructions. Three scenarios drawn from the Mobilitas 2026.07.10
assessment history. Supplied context only; no external systems; no final release decision.

## Scenario A - Comment-over-status (MT-009)

```text
Assess this item for the release readiness summary.

Item KEY-2673 (case-sensitivity defect) is marked Done in Jira.
Latest comment (06-15, QA): "Tested in Postman this sprint; cannot be tested in SIT
until Sprint 7, so this will carry over."

How should this item appear in the assessment, and what should be asked, if anything?
```

## Scenario B - Status calibration (MT-010)

```text
Set the release status from this supplied evidence.

- No P1 blockers.
- All production-scope items Done with QA and E2E sign-off.
- One open item KEY-2899: a SIT-only PAT table data update (branding in the SIT
  environment); no production code impact.
```

## Scenario C - Scope derivation (MT-011)

```text
Derive the release scope for this run.

- Release identity: fixVersion = "Mobilitas 2026.07.10" (spans Jira projects M26 and MR26).
- Prior run filtered to project = M26 and reported 25 items.
- fixVersion alone returns 44 items.

Team Release Scope Definition declares: method jql, query
fixVersion = "Mobilitas 2026.07.10" ORDER BY issuetype, key.
```
