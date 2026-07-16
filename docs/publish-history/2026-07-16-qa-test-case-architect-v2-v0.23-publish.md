# Publish History — QA Test Case Architect v2 v0.23 Publish (2026-07-16)

| Field | Value |
|---|---|
| Date | 2026-07-16 |
| Space | ROVO (`csaaig.atlassian.net`) |
| Mechanism | Governed publisher (`scripts/Publish-ConfluencePages.ps1`), per-page dry-run then `-Apply -UpdateExisting`, run from the v0.23 worktree with owner-authorized `-EnvPath`/`-ConfigPath` pointing at the ignored local prerequisites |
| Source branch / PR | `shaynevandersloot/qatca-v2-eval-mode-manual-only` / [PR #58](https://github.com/svandersloot/agent-portfolio-workbench/pull/58) |
| Source commits | `7145d1e` (v0.23 slice) + `5b0cd3c` (bullet-syntax formatting fix, see Warnings) |
| Approval | Owner authorization for these exact seven pages after clean MCP refreshes and publisher dry-runs; per-page identity verified against expected page IDs before each apply |
| Boundary | No Jira, XRAY, or ROVO Studio write occurred. Confluence writes were limited to the seven listed pages via the governed publisher. Atlassian MCP was used for read/verification only. The Measurement Plan was excluded (unrelated uncommitted edits elsewhere). |

## Change published (v0.23)

1. First `Test Type` (execution mode) is `Manual` only — `Automated`/`Generic`/`Cucumber` are not emitted unless a future approved source changes the contract; the `Automated` column stays Yes/No.
2. Functional Test Type comes from the Jira story's test-type field (never inferred from prose); only `Application List` is inferred, with confirmation.
3. Non-raw evaluation/AgentLab responses begin with `Mode: Evaluation` and `Mode trigger:` lines; mode metadata never appears in TBDLog; raw-CSV-only responses stay CSV-only.
4. Evaluation mode never bypasses missing-data, validation, conflict, privacy, source-isolation, or safety stops; source isolation is defined (supplied packet + configured fixtures only; no unrequested live retrieval; retrieved sources listed when requested).
5. Synthetic TC-ID example `SYNTH-1001-1` replaces the real-looking project-key example everywhere.
6. New evals QATCA-EVAL-027/028/029/030; change-log row v0.23.

## Pages published (in order), with per-page results

| # | Slug | Page ID | Pre-apply version | Post-apply version | Dry-run | Apply | MCP read-back |
|---|---|---|---|---|---|---|---|
| 1 | qa-test-case-architect-v2-runtime-contract | 5406195765 | 3 | **5** (two applies; see Warnings) | clean ×2 (update, 3→4 then 4→5) | success ×2 | verified: title, parent 5377720354, v0.23 content, lists render correctly |
| 2 | qa-test-case-architect-v2-rovo-studio-configuration | 5377884217 | 8 | 9 | clean (update, 8→9) | success | verified |
| 3 | qa-test-case-architect-v2-studio-setup | 5377490989 | 9 | 10 | clean (update, 9→10) | success | verified |
| 4 | qa-test-case-architect-v2-knowledge-source-plan | 5377785933 | 4 | 5 | clean (update, 4→5) | success | verified |
| 5 | qa-test-case-architect-v2-evaluation | 5378572351 | 7 | 8 | clean (update, 7→8) | success | verified (QATCA-EVAL-027–030 present) |
| 6 | qa-test-case-architect-v2-change-log | 5379194894 | 8 | 9 | clean (update, 8→9) | success | verified (v0.23 row present) |
| 7 | qa-test-case-architect-v2-team-overlay-payment-ninjas | 5496078361 | 2 | 3 | clean (update, 2→3; unbound slug title-resolved to the expected ID before apply) | success | verified |

All applies were `UpdateExisting` updates to the expected existing page IDs; no page was created; every MCP read-back confirmed the same page ID, expected version increment, correct title, correct parent (`5377720354`, QA Test Case Architect Project Brain), and the v0.23 content. Duplicate-title checks (CQL, one candidate per title) were clean before and after publishing. Pre-publish MCP body reads confirmed every page matched the pre-v0.23 published baseline, so each diff contained only the reviewed v0.23 changes.

## Warnings and remediations

- **Bullet-syntax regression, remediated in-run.** The publisher's markdown→storage converter recognizes only hyphen bullets. `qa-test-case-architect-v2-runtime-contract.md` was the sole QATCA source using asterisk bullets (it had previously been published via the MCP connector, which accepts markdown natively). The first apply (version 4) rendered its 61 list lines as literal text. Fixed by a formatting-syntax-only source change (`* ` → `- `, zero content change; commit `5b0cd3c`), then re-published (version 5) and verified.
- **Converter inline-markdown fidelity (known trait, not remediated).** Inline `**bold**`, `*italic*`, and markdown links inside bullet items and table cells render as literal characters on pages published through this converter (visible on the Knowledge Source Plan, Change Log historical rows, and Team Overlay). Lists, tables, headings, and backtick code render correctly, and all content is complete and accurate. This trait applies to all prior publisher-published pages as well. Recommended follow-up: converter enhancement for inline markdown, or keep bold/links out of bullets/cells in source pages.
- Code-fenced copy blocks render as monospace spans rather than code-block macros (same converter trait); the copy-block text is line-complete and copy-paste usable.

## Remaining human-owned

- Manual ROVO Studio save: paste the updated configuration/setup copy blocks (this also removes the real-prefix TC-ID example from live Studio), save, and capture the saved instructions back into the repo.
- QA regression: QATCA-EVAL-027–030 plus category re-runs and the acceptance list (exact 15-column header, Priority=Low, Manual-only first Test Type, Jira-sourced second Test Type, draft-only on invalid values, raw-only purity, downloadable CSV boundary, manual XRAY import round-trip and downstream closure); capture sanitized pass/fail evidence.
- PR #58 review and merge (merge not performed by automation).
