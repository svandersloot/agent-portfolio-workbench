# Template - Release Scope Definition

Use this template to declare how a team derives the work items for a release. Release Health Analyst and Release Drift Monitor read this page to know what is in scope, so the same release is counted the same way every run.

Create one page per team. Suggested title pattern:

```text
Release Scope Definition - [Team or Space]
```

This template implements the reusable `Release Scope Derivation Contract`. The contract holds the rules; this page holds one team's declared method.

## How To Use This Page

| Audience | Use |
|---|---|
| Team or release owner | Fill in one primary scope method and keep it accurate. |
| Release Health Analyst / Release Drift Monitor | Read the declared method and run the query verbatim. Do not infer or edit scope. |
| Reviewers | Confirm the method is stable and the release identity is exact. |

## Scope Definition

| Field | Value |
|---|---|
| Team or space | `[team or Confluence space]` |
| Primary method | `[jql / saved_filter / board_sprint / label]` |
| Scope query | `[exact query string, filter id, or board + sprint]` |
| Release identity field | `[fixVersion / release field / label]` |
| Ordering | `[optional stable ordering, e.g. ORDER BY issuetype, key]` |
| Out-of-scope note | `[anything excluded, with reason, or "None"]` |
| Owner | `[human owner]` |

## Method Options

Declare exactly one primary method. JQL is the recommended default because a correctly maintained release identifier captures all stories regardless of project.

| Method | When it fits | Declared inputs |
|---|---|---|
| `jql` (recommended) | The team maintains an accurate release identifier such as `fixVersion`. | The exact JQL string. |
| `saved_filter` | The team curates a shared Jira filter for the release. | Filter id or name, and owner. |
| `board_sprint` | The team scopes by board and sprint rather than a release field. | Board id and sprint name or id. |
| `label` | The team tags release scope with a label convention. | Label value and any qualifier. |

Recommended JQL shape:

```text
fixVersion = "[RELEASE_FIXVERSION]" ORDER BY issuetype, key
```

If a team genuinely needs more than one project and the release identifier does not already span them, name the projects explicitly and keep that clause stable for the whole release:

```text
fixVersion = "[RELEASE_FIXVERSION]" AND project in ([PROJECT_KEYS]) ORDER BY project, issuetype, key
```

## Rules That Always Apply

- Use exactly one declared query. Do not toggle a project filter on and off between runs.
- Do not narrow or widen the query to "improve" coverage. If the release identifier captures the release, that is the scope.
- Resolve fuzzy release names to the exact release identity before running. Vague inputs such as "the July release" fail closed.
- If the scope query or release identity is missing or ambiguous, mark scope `Data Incomplete` / `UNKNOWN` and ask for the smallest missing input. Do not produce counts from a guessed scope.
- Record the method and query used in each assessment so the next run compares like for like.

## Examples

Mobilitas (single release identifier spanning multiple projects):

```text
fixVersion = "Mobilitas 2026.07.10" ORDER BY issuetype, key
```

A team that scopes by saved filter:

```text
Primary method: saved_filter
Scope query: filter = "Team X Release Scope" (filter id 12345)
```

## Studio Reference

Keep the Studio agent instructions thin. They should point to this page as the scope authority rather than embedding a team-specific query, for example:

```text
To derive release scope, use the team's Release Scope Definition page and run its declared query verbatim. Do not add or remove project filters or infer scope. If the scope query or release identity is missing or ambiguous, mark scope Data Incomplete and ask for the smallest missing input.
```
