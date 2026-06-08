# Main Merge Readiness Assessment - 2026-06-08

## Purpose

Assess the current uncommitted work before committing, pushing, or merging to `main`.

The goal is to avoid one large unclear commit, separate deployment-notes work from older agent-factory work, and identify cleanup that should happen before anything is treated as main-ready.

## Branch State

Current observed state:

- Working branch: `codex/release-drift-pilot-tracking`.
- `HEAD`, local `main`, `origin/main`, and `origin/codex/release-drift-pilot-tracking` were observed at the same commit: `8e66267 Document follow-up triage prompt pattern`.
- The branch has no committed work ahead of `main`; all pending work is local uncommitted or untracked content.
- `config/confluence-pages.yml` remains ignored local configuration and should not be committed.

## Recommended Commit Slices

### Commit 1: Deployment Notes Bootstrap Pilot

Recommended to commit first.

Files:

- `config/confluence-pages.example.yml`
- `docs/confluence-pages/deployment-notes-standard.md`
- `docs/confluence-pages/deployment-notes-agent-pilot.md`
- `docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md`
- `docs/confluence-pages/jira-work-item-assistant-rovo-studio-configuration.md`
- `docs/confluence-pages/release-notes-manager-knowledge-source-plan.md`
- `docs/confluence-pages/release-notes-manager-rovo-studio-configuration.md`
- `docs/reports/deployment-notes-agent-backtest-2026-06-08.md`
- `docs/reports/deployment-notes-agent-backtest-v2-2026-06-08.md`
- `docs/reports/deployment-notes-agent-live-regression-2026-06-08.md`
- `docs/handoffs/deployment-notes-bootstrap-workflow-handoff-2026-06-08.md`

Why it should make `main`:

- Captures the new Deployment Notes Standard and pilot model.
- Documents the Confluence-first bootstrap pattern for Jira Work Item Assistant and Release Notes Manager.
- Records backtest evidence and known limitations.
- Preserves the latest handoff for proving the workflow before broader rollout.

Pre-commit cleanup already completed:

- Corrected the v2 backtest so `M26-788` no longer invents validation steps and no longer recommends writing no-action placeholder text into the Jira Deployment Notes field.

Remaining validation before commit:

- Run `git diff --check`.
- Review staged diff carefully to ensure only deployment-note files are included in this commit.

### Commit 2: Agent Factory / Portfolio Lab Readiness

Recommended as a separate commit after Commit 1.

Files:

- `README.md`
- `docs/implementation-backlog.md`
- `docs/next-slash-goals.md`
- `docs/roadmap.md`
- `agent-portfolio-lab/exports/confluence/reusable-core/README.md`
- `agent-portfolio-lab/exports/confluence/team-overlay/README.md`
- `agent-portfolio-lab/exports/rovo-eval-csv/README.md`
- `agent-portfolio-lab/exports/rovo-studio/reusable-core/README.md`
- `agent-portfolio-lab/exports/rovo-studio/team-overlay/README.md`
- `agent-portfolio-lab/fixtures/sanitized/deployment-runbook-inputs/README.md`
- `agent-portfolio-lab/fixtures/sanitized/jira-issue-sets/README.md`
- `agent-portfolio-lab/fixtures/sanitized/release-drift-drafts/README.md`
- `agent-portfolio-lab/fixtures/sanitized/release-health-pages/README.md`
- `agent-portfolio-lab/fixtures/sanitized/release-note-drafts/README.md`

Why it should make `main`:

- The repo already contains the `agent-portfolio-lab` structure.
- The new README placeholders clarify which export and fixture folders are safe, sanitized, and non-publishing.
- The roadmap/backlog updates document the Stage 5 agent factory and governance control-plane direction.

Risk:

- This is adjacent to, but not the same as, the Deployment Notes pilot. Keep it separate so reviewers can accept or reject it independently.

### Commit 3: Business Demo Infographic

Hold for explicit approval or commit separately.

Files:

- `docs/infographics/README.md`
- `docs/infographics/rovo-agent-factory-business-demo.html`

Why it may belong in `main`:

- It is a business-facing demo artifact for explaining the Rovo agent factory and governance control-plane model.
- A scan did not find obvious live Jira keys, private Atlassian URLs, or named internal stakeholders in this artifact.

Why it should be separate:

- It is not required for the Deployment Notes workflow.
- It is a larger HTML artifact and may deserve visual review before shipping.

## Do Not Commit

- `.env`
- `config/confluence-pages.yml`
- Any raw Jira, Confluence, HAR, Studio export, token, cookie, credential, private URL, or unsanitized issue data.
- Anything under local-private fixture areas if private data is later added.

## Cleanup Assessment

No destructive cleanup should be performed before the first commit. The current risk is not dead code; it is mixed-scope uncommitted work.

Recommended cleanup sequence:

1. Commit deployment-note work first.
2. Commit Stage 5/lab readiness work second if approved.
3. Review the infographic in-browser before committing it.
4. After commits are safely published, open a separate cleanup pass for older/superseded governance docs.

Potential cleanup candidates for a later pass:

- Legacy Release Management Assistant references currently marked as archive/superseded candidates.
- Older handoff packets that are superseded by newer packets, if they no longer help future recovery.
- Any duplicate backlog/roadmap surfaces if the repo roadmap remains the chosen source of truth.
- Any lab export folder that starts collecting real generated payloads instead of safe README placeholders.

## Validation Performed

- Reviewed current `git status --short --branch`.
- Reviewed tracked diff stats and tracked file diffs.
- Reviewed untracked lab/export/fixture README placeholders.
- Scanned untracked infographic and new lab placeholder areas for obvious private URLs, live issue keys, and named internal stakeholders.
- Ran `git diff --check`; no whitespace errors were reported.

## Recommended Next Command Sequence

Use selective staging, not `git add -A`, until the commit slices are confirmed.

Suggested first commit:

```powershell
git add config/confluence-pages.example.yml `
  docs/confluence-pages/deployment-notes-standard.md `
  docs/confluence-pages/deployment-notes-agent-pilot.md `
  docs/confluence-pages/jira-work-item-assistant-knowledge-source-plan.md `
  docs/confluence-pages/jira-work-item-assistant-rovo-studio-configuration.md `
  docs/confluence-pages/release-notes-manager-knowledge-source-plan.md `
  docs/confluence-pages/release-notes-manager-rovo-studio-configuration.md `
  docs/reports/deployment-notes-agent-backtest-2026-06-08.md `
  docs/reports/deployment-notes-agent-backtest-v2-2026-06-08.md `
  docs/reports/deployment-notes-agent-live-regression-2026-06-08.md `
  docs/handoffs/deployment-notes-bootstrap-workflow-handoff-2026-06-08.md `
  docs/reports/main-merge-readiness-assessment-2026-06-08.md

git diff --cached --check
git diff --cached --stat
git commit -m "Document deployment notes bootstrap pilot"
```

Suggested second commit:

```powershell
git add README.md `
  docs/implementation-backlog.md `
  docs/next-slash-goals.md `
  docs/roadmap.md `
  agent-portfolio-lab/exports/confluence/reusable-core/README.md `
  agent-portfolio-lab/exports/confluence/team-overlay/README.md `
  agent-portfolio-lab/exports/rovo-eval-csv/README.md `
  agent-portfolio-lab/exports/rovo-studio/reusable-core/README.md `
  agent-portfolio-lab/exports/rovo-studio/team-overlay/README.md `
  agent-portfolio-lab/fixtures/sanitized/deployment-runbook-inputs/README.md `
  agent-portfolio-lab/fixtures/sanitized/jira-issue-sets/README.md `
  agent-portfolio-lab/fixtures/sanitized/release-drift-drafts/README.md `
  agent-portfolio-lab/fixtures/sanitized/release-health-pages/README.md `
  agent-portfolio-lab/fixtures/sanitized/release-note-drafts/README.md

git diff --cached --check
git diff --cached --stat
git commit -m "Document agent factory pilot readiness"
```

After commits:

```powershell
git status --short --branch
git push
```

If the branch still matches `main` except for these new commits, merge can be fast-forwarded or opened as a small PR depending on the preferred workflow.
