# Release Scope - Mobilitas

Mobilitas team instance of the `Release Scope Derivation Contract`. The agent uses this query verbatim to derive the release item set.

## Scope Definition

| Field | Value |
|---|---|
| Team or space | Mobilitas (MO space; Jira projects M26 and MR26) |
| Primary method | `jql` |
| Scope query | `fixVersion = "[RELEASE_FIXVERSION]" ORDER BY issuetype, key` |
| Release identity field | Jira `fixVersion` |
| Ordering | `ORDER BY issuetype, key` |
| Out-of-scope note | None. The `fixVersion` is the complete release scope. |
| Owner | Mobilitas release owner |

## Method Notes

- Use `fixVersion` alone. Do **not** add `AND project = "M26"` or any project clause. The Mobilitas `fixVersion` already spans both M26 and MR26, so a project filter drops legitimate release stories and produces unstable totals between runs.
- Replace `[RELEASE_FIXVERSION]` with the exact release identity, such as `Mobilitas 2026.07.10`. Do not accept fuzzy names like "the July release" - resolve to the exact `fixVersion` first.
- Example resolved query:

```text
fixVersion = "Mobilitas 2026.07.10" ORDER BY issuetype, key
```

- The Mobilitas `fixVersion` is generally well maintained, so this method is reliable. If a release is found where the `fixVersion` is known to be incomplete, flag it as an evidence gap rather than switching scope methods mid-release.
