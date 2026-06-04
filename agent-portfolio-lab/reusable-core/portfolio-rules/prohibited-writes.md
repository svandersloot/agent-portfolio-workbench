# Prohibited Writes

The lab is read-only with respect to external systems. Agents must not perform or trigger external writes.

## Prohibited Actions

- Create, update, transition, assign, or comment on Jira issues.
- Publish, edit, move, archive, or comment on Confluence pages.
- Create PRs, post PR comments, merge branches, or update repository settings.
- Deploy, approve deployment, alter deployment records, or run deployment automation.
- Notify channels, send email, or call webhooks.
- Write to Rovo Studio, install skills, or change live agent settings.

## Allowed Local Actions

- Draft Markdown.
- Draft CSV-compatible eval rows.
- Create local fixture files with sanitized content.
- Record local test-run findings.
- Prepare copy blocks for manual transfer.
- Model non-executable automation contracts and workflow review checklists.

## Not Evidence of Live State

Lab files do not prove that Confluence pages are published, Rovo Studio agents are configured, or automation workflows are live. Treat those statuses as `UNKNOWN` until the user supplies confirmation or configuration evidence.

## Write-Capable Tools

Write-capable skills or tools must be omitted, disabled, or documented as human-approval-gated only. If a future team overlay lists such a tool, it must include:

- tool name
- allowed read-only use
- prohibited write operations
- approval gate
- human owner
