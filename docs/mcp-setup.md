# Atlassian MCP Setup

This page documents the primary live-context path for contributors. The official Atlassian Remote MCP Server is configured in the user's Claude Code settings, not in this repository.

## Register and authenticate

Use an interactive terminal:

```powershell
claude mcp add --transport http --scope user atlassian https://mcp.atlassian.com/v1/mcp/authv2
claude mcp login atlassian
claude mcp get atlassian
```

The login opens browser-based OAuth and runs as the signed-in Atlassian user. A new MCP server may require a Claude Code restart before its tools appear. To inspect or remove the local registration:

```powershell
claude mcp list
claude mcp logout atlassian
claude mcp remove atlassian -s user
```

Do not commit `.mcp.json`, OAuth tokens, browser cookies, access headers, or account-specific MCP settings to this repository. Do not copy machine-specific site, cloud ID, or email values into general onboarding docs.

## Operating boundary

- Read and search tools support normal read-first governance work.
- Jira create, edit, transition, comment, worklog, and link tools remain draft/dry-run only and require explicit human approval per action.
- Confluence create, update, and comment tools require a focused dry-run and explicit human approval per action.
- ROVO Studio writes, saves, visibility changes, and permission changes remain manual.
- MCP write capability does not change the repository's approval boundaries.
- The connector has no delete/trash tool, so any approved write plan must include manual UI cleanup or rollback steps.

## Troubleshooting

- If `claude mcp get atlassian` fails, confirm the server name and rerun `claude mcp login atlassian`.
- If tools do not appear, restart Claude Code after registration.
- If the account or site is wrong, log out and authenticate again rather than sharing credentials.
- If the work requires a direct API script instead of MCP, use the optional `.env` fallback described in [CONTRIBUTING.md](../CONTRIBUTING.md).
