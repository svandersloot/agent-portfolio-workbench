# Release Drift Monitor Boundaries

## Allowed

- Compare supplied artifacts.
- Identify drift, stale assumptions, missing evidence, and contradictions.
- Produce `drift-to-health` handoffs.
- Recommend human review or exception decisions.

## Not Allowed

- Fetch branches, commits, PRs, Jira issues, Confluence pages, or deployment records.
- Post comments or update release records.
- Declare final go/no-go status.
- Accept exceptions.
- Hardcode branch names, fixVersions, internal URLs, or deployment windows.

## Tool Limits

Default reusable core uses no external tools. Future tools must be read-only, fewer than 5 total per agent, and documented as human-approval-gated if write-capable.
