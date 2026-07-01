# Release Scope - Example Team

Example team instance of the `Release Scope Derivation Contract`. Copy this shape for a new team and fill in one primary method.

## Scope Definition

| Field | Value |
|---|---|
| Team or space | `[team or Confluence space]` |
| Primary method | `[jql / saved_filter / board_sprint / label]` |
| Scope query | `[exact query string, filter id, or board + sprint]` |
| Release identity field | `[fixVersion / release field / label]` |
| Ordering | `[optional stable ordering]` |
| Out-of-scope note | `[anything excluded, with reason, or "None"]` |
| Owner | `[human owner]` |

## Method Notes

- Declare exactly one primary method. The agent uses the query verbatim and does not add or remove filters.
- Recommended default is `jql` against an accurate release identifier:

```text
fixVersion = "[RELEASE_FIXVERSION]" ORDER BY issuetype, key
```

- A team that does not use `fixVersion` may declare a saved filter, board and sprint, or label instead. Whatever the method, keep it stable for the whole release so totals reflect real movement, not method changes.
- If the release identity is fuzzy or the query is missing, the agent marks scope `Data Incomplete` and asks for the smallest missing input.
