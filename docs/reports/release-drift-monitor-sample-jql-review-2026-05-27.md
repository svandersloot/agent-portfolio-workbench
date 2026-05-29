# Release Drift Monitor Sample JQL Review - 2026-05-27

## Source

| Field | Value |
|---|---|
| Export file | `C:\Users\gzxvand\Downloads\JIRA (1).csv` |
| JQL | `fixVersion = "Mobilitas 2026.07.10"` |
| Rows | 48 |
| Review purpose | Use real Jira export shape to refine Release Drift Monitor pilot rules. |

## Export Shape

The CSV includes:

- Issue Type
- Issue key
- Issue id
- Summary
- Status
- Sprint
- Custom field (Deployment Notes)
- Fix versions
- Assignee
- Assignee Id
- Created

The CSV does not include:

- Jira status category
- Resolution
- Updated date
- Jira development panel fields
- Bitbucket branch, PR, commit, or merge status
- Test case, test execution, QA signoff, or CI result fields

## Counts

| Dimension | Count |
|---|---:|
| Total issues | 48 |
| Story | 41 |
| Tech Story | 4 |
| Production Defect | 2 |
| Story Bug | 1 |
| Backlog | 5 |
| To Do | 37 |
| In Progress | 6 |
| Done or Done-like statuses | 0 |
| Deployment notes present | 4 |
| Deployment notes missing | 44 |

## Pilot Learnings

| Learning | Design Impact |
|---|---|
| The sample has no Done items. | It cannot test "Done with no code evidence" yet. The monitor needs a source-readiness summary before it produces drift findings. |
| Bitbucket fields are absent. | Code evidence must be `UNKNOWN` from this export alone. The monitor should ask for Jira development links or a Bitbucket export. |
| Test/QA fields are absent. | Test and QA evidence must be `UNKNOWN` unless supplied separately. |
| Deployment notes exist on 4 items before Done. | Deployment evidence can be monitored earlier than code freeze, especially for runbook readiness. |
| Statuses are Backlog, To Do, and In Progress. | Missing code should not be treated as drift for all items by default. Evidence expectations should depend on status and team rules. |
| Both M26 and MR26 issue keys appear. | Matching rules should allow multiple project prefixes in one release. |

## Deployment Note Candidates

| Jira Key | Status | Why It Matters |
|---|---|---|
| MR26-3033 | To Do | References an admin data file import path. |
| MR26-1502 | In Progress | References a Copart admin file import and override instruction. |
| M26-2163 | In Progress | References a PAT update XML import path. |
| M26-2124 | Backlog | References a CC/Admin/Utilities import path. |

These are not code-readiness findings yet. They are deployment-readiness candidates that Release Notes Manager or Release Health Analyst may later consume.

## Recommended Next JQL Fields Or Export Columns

For the next direct JQL retrieval or fallback export, include:

| Field | Reason |
|---|---|
| Status Category | Normalizes Done/In Progress/To Do across team workflows. |
| Resolution | Distinguishes completed, duplicate, won't do, and unresolved items. |
| Updated | Supports freshness checks. |
| Development links | Helps map Jira to Bitbucket. |
| Linked pull requests | Confirms PR state and target branch. |
| Branch names | Confirms issue key presence and source branch. |
| Commit hashes or merge commits | Confirms code landed in source-truth branch. |
| Test execution or QA signoff fields | Supports validation evidence checks. |
| Parent epic or parent link | Supports shared test-plan and parent-level coverage checks. |
| Linked issues | Supports cross-story code, test, and dependency evidence. |

## Suggested Next JQL Slices

To test Done drift when the release matures:

```text
fixVersion = "Mobilitas 2026.07.10" AND statusCategory = Done
```

To test in-flight code evidence before freeze:

```text
fixVersion = "Mobilitas 2026.07.10" AND status in ("In Progress", "Code Review", "In QA")
```

To test deployment-readiness evidence:

```text
fixVersion = "Mobilitas 2026.07.10" AND "Deployment Notes" is not EMPTY
```

## Candidate Output Rule

For this exact CSV, a well-behaved Release Drift Monitor should say:

> This export confirms release scope and current Jira status, but it does not include Bitbucket, test, QA, status category, resolution, or updated-date evidence. I can identify source-readiness gaps and deployment-note candidates, but I cannot verify code drift or test drift from this file alone.
