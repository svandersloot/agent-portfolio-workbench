# Main Merge Readiness Assessment - 2026-07-13

## Purpose

Refresh the merge-readiness view before the next commit-ready slice, per next-slash goal 30 and backlog item 8.8. The report is generated from current branch and working-tree evidence only. It is repo-only: no Confluence publish, no Studio write, no Jira write, and no push.

## Branch State

Current observed state:

- Assessment branch: `shaynevandersloot/merge-readiness-refresh`, in its own dedicated worktree at `C:/projects/rgat-worktrees/merge-readiness-refresh`. This branch is isolated from the shared `work-main-latest` worktree where a parallel session is active.
- The working-tree evidence below was gathered in the `shaynevandersloot/work-main-latest` worktree at assessment time, when that branch was level with `origin/main` at `fc701d1`. That worktree is not touched by this slice.
- `origin/main` has since advanced to `8c83055` (PR #3, the transcript-analysis prompt pack, merged after assessment). This branch has been rebased onto `8c83055` and is `1` commit ahead / `0` behind: only the single report commit below. The report file is new, so it does not conflict with the merged work.
- `config/confluence-pages.yml` and `.env` remain ignored local configuration and must not be committed.

## Working-Tree Evidence

`git status --short`, observed in the `shaynevandersloot/work-main-latest` worktree at assessment time (this `merge-readiness-refresh` worktree is clean):

| State | Path | Origin assessment |
|---|---|---|
| ` M` | `AGENTS.md` | In-progress edit by another conversation (a "Claude Cowork" import). Not this slice's work. |
| `??` | `docs/reports/qa-test-case-architect-v2-session-review-2026-07-10.md` | QA Test Case Architect v2 session-review report from another conversation. |
| `??` | `docs/reports/qa-test-case-architect-v2-session-review-followups-2026-07-10.md` | Companion follow-up slice plan for the same QA review. |

The merge-readiness report itself (`docs/reports/main-merge-readiness-assessment-2026-07-13.md`) is the only file this slice intends to commit.

## Recommended Commit Slices

### Commit A: Merge-readiness refresh (this slice)

Recommended to commit on its own branch.

Files:

- `docs/reports/main-merge-readiness-assessment-2026-07-13.md`

Why it should make `main`:

- Refreshes the merge-readiness guardrail from current evidence, replacing the stale 2026-06-08 assessment.
- Is self-contained, repo-only, and reviewable in isolation.

Status: committed on `shaynevandersloot/merge-readiness-refresh`; not pushed (push/PR is a separate explicit step per goal 30).

### Commit B: QA Test Case Architect v2 session review (NOT owned by this slice)

The two QA reports form a coherent potential slice, but they belong to another active conversation. Do not fold them into Commit A.

Files:

- `docs/reports/qa-test-case-architect-v2-session-review-2026-07-10.md`
- `docs/reports/qa-test-case-architect-v2-session-review-followups-2026-07-10.md`

Readiness signals:

- Both files pass the private-data scan (candidate scope, 0 findings) and appear internally sanitized (explicit redaction note; role labels and `[STORY-A]`/`[PROJ]` placeholders instead of names/keys).
- The follow-up plan's slice S1 names a human data-source gate (sanitized golden import) and S2 a human decision gate (shared CSV column contract). Those gates are human-owned and are not satisfied by this assessment.

Recommendation: leave these to the QA-review conversation to stage and commit after its own validation and the S1/S2 gates. Preserve them untouched in the meantime.

### Do not commit yet: AGENTS.md working-tree change

The `AGENTS.md` diff adds only a trailing section header, `## Imported Claude Cowork project instructions`, with no body content beneath it.

- As-is it would land a dangling, empty heading on `main`.
- It is an in-progress edit owned by another conversation.

Recommendation: do not commit until the importing conversation either completes the section body or reverts the header. Flag as in-progress drift, not merge-ready.

## Do Not Commit

- `.env`
- `config/confluence-pages.yml`
- Any raw Jira, Confluence, HAR, Studio export, token, cookie, credential, private URL, or unsanitized issue data.
- The incomplete `AGENTS.md` header change above, until it is finished or reverted by its owning conversation.

## Validation Performed

- `git branch --show-current` -> `shaynevandersloot/merge-readiness-refresh` (report authored here); source working tree `shaynevandersloot/work-main-latest`.
- `git status --short` and `git status --porcelain` reviewed in the `work-main-latest` worktree at assessment time; three unrelated entries identified and attributed above.
- At assessment time the source worktree was level with `origin/main` at `fc701d1`. This branch was then rebased onto the current `origin/main` (`8c83055`); `git rev-list --left-right --count origin/main...HEAD` -> `0  1` (this branch is 1 commit ahead, 0 behind: only the report commit).
- `git diff --check` -> clean; no whitespace errors.
- `.\scripts\Test-PrivateDataScan.ps1` (Candidate scope, at assessment time) -> Files checked: 3, Findings: 0. Re-run in this worktree (`-Scope AllTracked -WarnOnly`) -> Files checked: 396, Findings: 0; the report file is not flagged.
- `.\scripts\Test-StaleHandoffs.ps1 -WarnOnly` -> warnings only, all on pre-existing handoff packets unrelated to this slice's candidate file (superseded markers, one undated packet, and several "referenced file newer than handoff date" notices). No blocking finding for this commit slice.
- Two read-only sub-agent reviews (governance-boundary and accuracy) were run against this report; boundary verdict CLEAN, accuracy discrepancies (origin/main staleness) corrected in this revision.

## Recommended Next Command Sequence

Use selective staging, not `git add -A`.

This slice (already applied on the assessment branch):

```bash
git add docs/reports/main-merge-readiness-assessment-2026-07-13.md
git diff --cached --check
git commit -m "Refresh main merge-readiness assessment"
```

Push and PR are a separate, explicit step and are held pending approval:

```bash
git push -u origin shaynevandersloot/merge-readiness-refresh
# then open a PR against main
```

## Boundaries Respected

- Repo-only; read-only evidence gathering plus one repo-backed report.
- No Confluence publish, no Studio write, no Jira write.
- No push performed.
- Unrelated in-progress work from another conversation was preserved untouched and explicitly kept out of the proposed commit.
