# Atlassian Remote MCP Server — Local Integration Record

Date: 2026-07-09
Author: Shayne Vandersloot (with Claude Code assistance)
Status: Connected. Read and write both verified via one governed test (a draft page,
removed manually afterward — MCP writes are not self-reversible). Write capability
present but governed.
Scope of this record: local developer tooling only. This does **not** change any
live-system approval boundary in `AGENTS.md`, `CLAUDE.md`, or `START-HERE.md`.

## Summary

The official Atlassian Remote MCP Server was connected to Claude Code so that local,
read-first governance work can query Jira and Confluence directly instead of relying on
manual copy-paste or unsanitized exports. The connector is registered at **user scope**
(all projects for this machine account), not in this repository's config. The
repository's live-system boundaries continue to govern all write behavior.

## Why

- Reduce manual export handling and the risk of pasting unsanitized data into prompts.
- Enable real-time, permission-scoped reads of Jira issues and Confluence pages for
  governance research, drift checks, and dry-run preparation.
- Keep any eventual write action (Jira drafts, Confluence publish) inside the existing
  dry-run-first, human-approved flow rather than fire-and-forget automation.

## What was connected

| Item | Value |
|---|---|
| Product | Atlassian Remote MCP Server (a.k.a. Rovo MCP Server) — one product, not a separate plugin |
| Endpoint | `https://mcp.atlassian.com/v1/mcp/authv2` (HTTP transport) |
| Registration scope | Claude Code **user** config (`~/.claude.json`), not repo `.mcp.json` |
| Auth model | OAuth 2.1 browser sign-in; actions run as the signed-in user |
| Authenticated user | Shayne Vandersloot (shayne.vandersloot@csaa.com) |
| Site | `csaaig.atlassian.net` |
| Cloud ID | `aaf3ee41-766b-44b8-8b12-92b0e035861f` |
| Granted scopes | Jira read+write; Confluence page+comment read+write |

### Connect / disconnect commands

```bash
# add (already done, user scope)
claude mcp add --transport http --scope user atlassian https://mcp.atlassian.com/v1/mcp/authv2

# authenticate (interactive terminal only — needs a TTY)
claude mcp login atlassian

# check status
claude mcp get atlassian

# revoke local credentials / remove
claude mcp logout atlassian
claude mcp remove atlassian -s user
```

Note: `claude mcp login` requires an interactive terminal. It cannot be completed from a
non-TTY context. Newly added servers only expose their tools after Claude Code restarts.

## Verified capability (read-only probe, 2026-07-09)

All checks below were read-only. No write tool was called.

- Identity resolved via `atlassianUserInfo`.
- Accessible site and scopes confirmed via `getAccessibleAtlassianResources`.
- **211 Jira projects** visible via `getVisibleJiraProjects` (read confirmed).
- Confluence spaces list returned via `getConfluenceSpaces` (read confirmed, paginated).

## Write-path verification (2026-07-09)

One governed write was executed after explicit human approval, using the lowest-risk
option available, then removed:

- `createConfluencePage` created an unpublished **draft** ("MCP Connectivity Test —
  2026-07-09 (safe to delete)", id `5478416406`) in the Demonstration Space (`ds`).
- `getConfluencePage` read it back; content matched exactly (create → read round-trip).
- The HTML+ body (`panel-info`) round-tripped to a native Confluence info macro,
  confirming the HTML+ authoring format is accepted.
- Cleanup was performed **manually in the Confluence UI** by the page author, because
  the connector exposes no delete/trash tool (see limits below).

This confirms write scope is accepted at the space level (scope-granted alone does not
guarantee this) and that the dry-run + explicit-approval flow works end to end.

## Full tool surface

### Read / search (safe, used freely)

- Identity/site: `atlassianUserInfo`, `getAccessibleAtlassianResources`
- Jira read: `getJiraIssue`, `searchJiraIssuesUsingJql`, `getVisibleJiraProjects`,
  `getJiraProjectIssueTypesMetadata`, `getJiraIssueTypeMetaWithFields`,
  `getTransitionsForJiraIssue`, `getJiraIssueRemoteIssueLinks`, `getIssueLinkTypes`,
  `lookupJiraAccountId`
- Confluence read: `getConfluencePage`, `getConfluenceSpaces`,
  `getPagesInConfluenceSpace`, `getConfluencePageDescendants`,
  `getConfluencePageFooterComments`, `getConfluencePageInlineComments`,
  `getConfluenceCommentChildren`, `searchConfluenceUsingCql`
- Cross-product: `search`, `fetch`, Compass getters, Teamwork Graph getters

### Write (capability present — GOVERNED, not used without dry-run + approval)

- Jira write: `createJiraIssue`, `editJiraIssue`, `transitionJiraIssue`,
  `addCommentToJiraIssue`, `addWorklogToJiraIssue`, `createIssueLink`
- Confluence write: `createConfluencePage`, `updateConfluencePage`,
  `createConfluenceFooterComment`, `createConfluenceInlineComment`
- Compass write: `createCompassComponent`, `createCompassComponentRelationship`,
  `createCompassCustomFieldDefinition`

## Known limits observed

- **Large list payloads overflow.** `getVisibleJiraProjects` with issue-type expansion
  returned ~357K characters and was truncated to a file. Prefer narrow JQL/CQL searches
  with small field sets and small `maxResults` over broad list calls.
- **Pagination everywhere** — Confluence cursors and Jira `startAt`/`nextPage`.
- **No caching** — real-time proxy; every call hits the live org, scoped to the
  signed-in user's existing permissions (no privilege elevation).
- **No delete/trash tool.** The connector can create and update but not delete or trash
  Jira issues or Confluence pages (`updateConfluencePage` status is limited to
  `current`/`draft`). Any MCP write is therefore **not self-reversible** — removal is
  always a manual human action in the Atlassian UI. Prefer `status: "draft"` for
  Confluence write tests so unwanted content stays unpublished until manually discarded.

## Governance boundary (unchanged)

Every write tool above maps directly to an existing Live-System Boundary. The operating
rule for this connector is:

- Reads and searches: allowed as normal read-first governance work.
- Jira writes (create/edit/transition/comment/worklog/link): **draft or dry-run only**,
  presented for explicit human approval before any call. Consistent with the existing
  "no Jira writes from this repo" boundary.
- Confluence writes (create/update page, comments): **focused dry-run + explicit human
  approval** before any call, consistent with the existing Confluence publish boundary.
- Human-owned decisions (Active/Ready status, ownership, visibility, retirement,
  approval authority) remain human-owned regardless of tool capability.

The presence of a write-capable connector in local tooling does not constitute approval
to write. Approval is per-action and human-owned.

## Follow-ups / open questions

- Confirm with an Atlassian admin whether the first-user OAuth consent auto-registered
  the MCP app org-wide or whether an admin enablement step remains.
- A first governed Confluence write was exercised on 2026-07-09 (draft in the
  Demonstration Space, since removed). Future real publishes should still go through the
  repo's dry-run-first publish flow and be recorded as publish-history evidence.
- Because MCP writes are not self-reversible, any governed write plan must include the
  manual cleanup/rollback step up front, not as an afterthought.
