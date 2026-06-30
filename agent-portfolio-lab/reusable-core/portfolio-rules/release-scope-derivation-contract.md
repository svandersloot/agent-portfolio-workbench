# Release Scope Derivation Contract

This contract defines how a release agent derives the authoritative set of work items for a release. It is team-agnostic and reusable. The team-specific query lives in a per-team Release Scope Definition, not in agent instructions.

## Why This Exists

Release agents must agree on what is in a release before they assess readiness, drift, or notes. When scope is derived inconsistently - for example by toggling a project filter on and off between runs - the totals swing, trend math becomes noise, and trust drops even when the analysis is correct.

This contract keeps scope derivation:

- Declared, not inferred.
- Stable across runs for the same release.
- Configurable per team without changing the agent's core instructions.

## Core Rules

| Rule | Detail |
|---|---|
| One declared query | Use exactly one scope query from the team's Release Scope Definition. Do not blend, union, or alternate methods between runs. |
| No project-filter toggling | Do not add or remove a project clause that the declared query does not contain. If the declared query is `fixVersion = "X"`, do not narrow it to a single project, and do not expand it. |
| No scope inference | Do not infer scope from page titles, prior drafts, partial lists, or "latest release" language. Derive scope only from the declared query result. |
| Fail closed | If the Release Scope Definition or the release identity is missing or ambiguous, mark scope `Data Incomplete` / `UNKNOWN` and ask for the smallest missing input. Do not produce counts from a guessed scope. |
| Record the source | Every assessment records which scope method and query produced the item set, so the next run can compare like for like. |

Release identity rules (exact `fixVersion` preferred, vague release language fails closed) follow the Release Identity Policy in `Release Evidence Ledger Contract`. This contract does not restate them.

## Scope Methods

A team's Release Scope Definition declares exactly one primary method. JQL is the recommended default because a correctly maintained release identifier captures all stories regardless of project.

| Method | When it fits | Declared inputs |
|---|---|---|
| `jql` (recommended) | The team maintains an accurate release identifier such as `fixVersion`. | The exact JQL string. |
| `saved_filter` | The team curates a shared Jira filter for the release. | Filter id or name, and owner. |
| `board_sprint` | The team scopes by board and sprint rather than a release field. | Board id and sprint name or id. |
| `label` | The team tags release scope with a label convention. | Label value and any qualifier. |

For any method, the declared query is used verbatim. The agent does not edit it to "improve" coverage.

## Required Fields In A Release Scope Definition

| Field | Meaning |
|---|---|
| Team or space | Which team or Confluence space this definition serves. |
| Primary method | One of `jql`, `saved_filter`, `board_sprint`, or `label`. |
| Scope query | The exact query string, filter id, or board/sprint identifiers. |
| Release identity field | Where the exact release identity comes from, such as `fixVersion`. |
| Ordering | Optional stable ordering, such as `ORDER BY issuetype, key`. |
| Out-of-scope note | Anything explicitly excluded, with the reason. |
| Owner | Human who maintains this definition. |

## Consumer Responsibilities

| Consumer | Responsibility |
|---|---|
| Release Health Analyst | Derives scope from the active team's Release Scope Definition; records the method and query in the Assessment Fingerprint. |
| Release Drift Monitor | Uses the same Release Scope Definition so drift and health agree on scope. |
| Team owner | Maintains the team's Release Scope Definition and keeps the release identifier accurate in Jira. |
| Human release owner | Owns disposition decisions about scope, deferral, and readiness. |

## Validation Notes

- If two runs of the same release report different totals, the first check is whether the declared query changed or whether a project filter was toggled. Stable scope should produce stable totals plus real movement, not method artifacts.
- A scope method that returns zero items, or that the agent cannot run, is `UNKNOWN`, not an empty release.
