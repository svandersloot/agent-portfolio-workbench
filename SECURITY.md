# Security Policy

Agent Portfolio Workbench is a public, Git-backed governance workbench. It stores
governed drafts, evidence, checks, and handoffs; it holds no production secrets and
writes to no live system on its own. Even so, security reports are welcome and taken
seriously.

## Reporting a vulnerability

**Use GitHub private vulnerability reporting.** Open a private report from the
repository's **Security** tab → **Report a vulnerability** (GitHub's coordinated-
disclosure workflow). This keeps the report private to the maintainer until a fix is
coordinated.

Direct link pattern:
`https://github.com/svandersloot/agent-portfolio-workbench/security/advisories/new`

Do **not** open a public issue, pull request, or discussion for a suspected
vulnerability, and do not include secrets, tokens, cookies, request headers, private
URLs, or unsanitized exports in a report. Describe the issue with the minimum evidence
needed to reproduce it.

## What to include

- A clear description of the issue and its impact.
- Steps to reproduce, or a minimal proof of concept.
- Affected files, scripts, workflows, or paths.
- Any suggested remediation, if you have one.

## Response process

This repository is currently maintained by a single owner, so responses are best-effort
rather than backed by a staffed on-call rotation:

- **Acknowledgement:** within about 5 business days of the private report.
- **Initial assessment:** a triage of severity and validity, and a coordinated-
  disclosure plan, typically within about 10 business days.
- **Fix and disclosure:** remediation is prioritized by severity. The reporter is kept
  informed, and a security advisory is published once a fix is available or the issue is
  otherwise resolved. Please allow a reasonable coordination window before any public
  disclosure.

If a report is out of scope (for example, a live Jira, Confluence, or ROVO Studio
platform issue rather than a defect in this repository), the maintainer will say so and,
where possible, point toward the right reporting path.

## Scope

In scope: the contents of this repository — scripts, workflows, hooks, schemas, config
templates, and documentation. Out of scope: vulnerabilities in third-party live systems
(Jira, Confluence, ROVO Studio, GitHub itself) and issues that require already-
compromised local credentials.

## Related governance

Security and supply-chain controls for this repository — private vulnerability
reporting, dependency and secret scanning, CodeQL, and Dependabot — are recorded in
[docs/github-governance.md](docs/github-governance.md).
