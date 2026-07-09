# Contributor Setup

Use this guide to set up a new contributor with the MCP-first access path. This repository stores governed drafts, evidence, checks, and handoffs; Jira, Confluence, and ROVO Studio remain live systems with explicit approval boundaries.

## Access model

Use these paths in this order:

1. **Primary — Atlassian Remote MCP:** use MCP for permission-scoped Jira and Confluence reads and searches from an interactive Claude Code session.
2. **Secondary — work GitHub account:** use the work GitHub identity for cloning, branching, committing, pushing, and pull requests.
3. **Optional fallback — direct API environment:** use a local `.env` only when a repository script explicitly requires direct Atlassian API access. `.env` is not an MCP credential store.

MCP and GitHub are complementary: MCP provides live Atlassian context, while GitHub provides the repository audit trail and review workflow.

## Prerequisites

Install or obtain access to:

- Git
- PowerShell 7 for repository scripts
- GitHub CLI (`gh`) for work-account authentication
- Claude Code CLI and an interactive browser session for Atlassian MCP OAuth
- An authorized Atlassian account and access to this private GitHub repository

## First-time setup

1. Clone the repository and enter it:

   `git clone https://github.com/svandersloot/agent-portfolio-workbench.git`

   Then run `Set-Location agent-portfolio-workbench`.
2. Read `AGENTS.md`, `README.md`, `START-HERE.md`, and `docs/toolkit-operating-model.md`.
3. Complete the primary MCP setup below.
4. Configure the secondary work GitHub identity.
5. Configure the direct API fallback only if a script requires it.
6. Run the first validation checks before making changes.

## Primary path: Atlassian Remote MCP

Register the official Atlassian Remote MCP server at user scope. Do not add account-specific OAuth configuration to this repository.

```powershell
claude mcp add --transport http --scope user atlassian https://mcp.atlassian.com/v1/mcp/authv2
claude mcp login atlassian
claude mcp get atlassian
```

`claude mcp login` requires an interactive terminal and browser-based OAuth. If the server is already registered, run `claude mcp get atlassian` and `claude mcp login atlassian` instead of registering a duplicate. Restart Claude Code after adding a new server so its tools are available.

MCP reads and searches are appropriate for normal read-first work. Jira writes and Confluence writes remain draft/dry-run actions requiring explicit human approval. MCP capability is not approval authority, and the connector has no self-service delete/trash path. See [docs/mcp-setup.md](docs/mcp-setup.md).

## Secondary path: work GitHub account

Use the work account for repository submissions. Replace placeholders with the work account and verified work identity for the contributor.

```powershell
gh auth login
gh auth switch --user <work-login>
gh auth setup-git
git config user.name "<work name>"
git config user.email "<verified work email or work noreply email>"
git remote add work https://github.com/svandersloot/agent-portfolio-workbench.git
git config remote.pushDefault work
gh auth status
git remote -v
```

Keep the personal `origin` remote only if it is useful for fetching or comparison. The `work` remote should be the default push target. Start work from a clean `main`, use a named branch, and publish it explicitly:

```powershell
git switch -c agent/<short-description>
git push -u work agent/<short-description>
```

Never place GitHub tokens, OAuth output, or private URLs in tracked files, prompts, issues, or pull requests.

## Optional fallback: direct Atlassian API `.env`

Use this path only for scripts that explicitly require direct API credentials, such as the Confluence publisher. MCP OAuth and `.env` credentials are separate mechanisms.

```powershell
Copy-Item .env.example .env
```

Fill the local file with the required values from `.env.example`, including the direct API base, Atlassian email, API token, and any script-specific space or page settings. Keep `.env` local and never commit it. Do not paste its contents into prompts, issues, or pull requests.

Before staging, run:

```powershell
.\scripts\Test-PrivateDataScan.ps1
```

## First validation

From a clean checkout, run the checks that match the change:

```powershell
git diff --check
.\scripts\Test-PrivateDataScan.ps1
.\scripts\Test-StaleHandoffs.ps1
.\scripts\Test-ConfluencePageFamilyConsistency.ps1
```

When schemas or fixtures change, parse every touched JSON file. When scripts change, run their help or dry-run mode. Record any manual-only verification plainly in the pull request.

## Pull request expectations

- Keep the branch and diff small enough to review without live explanation.
- Explain the user impact, scope, validation, and any follow-up.
- Identify companion docs, schemas, workflows, reports, or templates that changed with the slice.
- Do not claim a Studio save, Jira action, Confluence publish, MCP write, or live verification unless it actually happened.
- Stop and ask for human direction when the change affects ownership, readiness, visibility, approval authority, write permissions, secrets, or privacy-sensitive evidence.
