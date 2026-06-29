# Start Here

Use this repo as the source-of-truth workbench for ROVO governance artifacts. ROVO Studio, Confluence, and Jira remain live systems with explicit approval gates; this repo keeps the drafts, evidence, checks, and handoffs reviewable.

For Codex or other AI-assisted work, read `AGENTS.md` first. It owns the repo operating contract, source-of-truth order, live-system boundaries, human-owned decisions, branch posture, and validation expectations.

## Safety Boundaries

- Do not write to ROVO Studio from automation.
- Do not write to Jira from this repo.
- Do not publish or update Confluence without a focused dry-run and explicit approval.
- Keep `.env`, `config/confluence-pages.yml`, `data/raw/`, HARs, cookies, headers, tokens, private URLs, and unsanitized exports out of Git.
- Commit normalized, sanitized, repo-backed artifacts only.
- Keep personal learning notes, pitch decks, presenter scripts, stakeholder-specific ask drafts, and private operational overlays out of Git. Use ignored local folders such as `docs/private-overlays/` for material that should not become shared repo truth.

## Common Workflows

| Need | Start with | Then check |
|---|---|---|
| Shape a new agent idea | `docs/confluence-pages/agent-fit-intake.md` | Search `docs/confluence-pages/agent-inventory.md` and existing Project Brain pages before recommending a new governed agent. |
| Update an existing agent | The agent's `*-project-brain.md` page under `docs/confluence-pages/` | Confirm owner, backup owner, lifecycle status, readiness, measurement, knowledge sources, evaluation, and change log evidence. |
| Prepare Confluence publishing | `config/confluence-pages.example.yml` and the target source page | Run a dry-run with `.\scripts\Publish-ConfluencePages.ps1 -Slug <slug> -UpdateExisting`; apply only after approval. |
| Prepare or capture Studio setup | The agent's `*-rovo-studio-configuration.md` or `*-studio-setup.md` page | Follow the README Studio capture flow and keep raw captures in `data/raw/`. |
| Run regression or pilot checks | The agent's `*-evaluation.md` page and any report under `docs/reports/` | Record safe evidence in reports or change logs; keep raw outputs private until sanitized. |
| Create a handoff | `docs/handoffs/` | Include scope, branch/worktree guidance, files to read, files not to touch, validation, and companion artifacts. |
| Prepare a safe commit slice | `git status --short` and `git diff --check` | Keep Confluence, Studio, Jira, report, and config changes in separate slices when possible. |

## Maintainability Checks

Run the page-family/source-link consistency check before committing a governed-agent page family or publishing plan:

```powershell
.\scripts\Test-ConfluencePageFamilyConsistency.ps1
```

The check is read-only. It uses `config/confluence-pages.example.yml`, verifies manifest source paths, flags unmanifested Confluence source pages, and checks each Project Brain family for expected child artifacts such as design record, knowledge source plan, runtime settings, setup or Studio configuration, evaluation, measurement plan, and change log.

Use `docs/reports/owner-readiness-gap-report-template.md` when reviewing transferability or pilot readiness. The report lists missing fields and evidence paths; it does not use percentage completeness scoring.

Run the stale-handoff check before executing an older handoff packet or resuming work from `docs/handoffs/`:

```powershell
.\scripts\Test-StaleHandoffs.ps1
```

The check is read-only. It flags superseded packets, handoffs without a clear date, missing referenced repo files, and referenced files with newer repo evidence than the handoff date. It does not delete or archive handoffs.

Run the private-data scan before staging or committing a slice:

```powershell
.\scripts\Test-PrivateDataScan.ps1
```

By default, it scans candidate commit files only: staged, unstaged, and untracked non-ignored files. Use `-Scope AllTracked -WarnOnly` for a broader audit of tracked files. Keep `.env`, `config/confluence-pages.yml`, `data/raw/`, HARs, cookies, headers, tokens, private URLs, and unsanitized exports out of commits.

## Commit Slice Pattern

Keep slices small enough for another maintainer to review without live explanation:

1. Source docs and manifest updates.
2. Read-only checks or report templates.
3. Publish-history records after approved Confluence applies.
4. Studio capture normalization after manual Studio saves.
5. Backlog, roadmap, or next-goal status updates.

Before handoff, run the practical checks that match the diff: `git status --short`, `git diff --check`, `.\scripts\Test-PrivateDataScan.ps1`, `.\scripts\Test-StaleHandoffs.ps1` when handoffs are involved, JSON validation for touched schemas or fixtures, YAML validation when a parser is available, and any new script's help or dry-run mode.
