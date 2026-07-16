# QA Test Case Architect v2 — Live Parent-Instruction Capture #2 (post-v0.23 Studio save, 2026-07-16)

| Field | Value |
|---|---|
| Date | 2026-07-16 |
| Source | Live parent instructions pulled from ROVO Studio by the owner (non-admin view; parent-instructions field only) and provided in-session. Human-performed read; no automated Studio access. |
| Comparison target | The v0.23 `Thin Parent Instructions` copy block in [qa-test-case-architect-v2-studio-setup.md](../confluence-pages/qa-test-case-architect-v2-studio-setup.md) on `origin/main` (PR #58, commits `7145d1e` + `5b0cd3c`; published to Confluence as Studio Setup v10). |
| Method | Normalized diff (bullet marker `*`↔`-`, escaped `\*` sequences, indentation, and trailing whitespace collapsed — all copy/paste rendering artifacts). |
| Result | **Content-identical: 63 normalized content lines each, zero differences.** |
| Boundary | Capture and comparison only. No Studio, Jira, XRAY, or Confluence action. Raw pull text kept outside Git (session scratchpad). |

## What this establishes

1. **The manual v0.23 Studio save happened and is faithful.** The live parent instructions match the approved v0.23 copy block exactly, including every 2026-07-16 decision marker: Manual-only first `Test Type`, Jira-sourced second `Test Type` (never inferred), Application List as the only inferred controlled value, `Mode: Evaluation`/`Mode trigger:` response metadata with the raw-only exception, the evaluation never-bypass clause, the source-isolation definition, and the synthetic `SYNTH-1001-1` TC-ID example (the real-looking example is gone from live Studio).
2. **Evaluation-run provenance upgrades from `Data Incomplete` to established-with-caveats** for the 2026-07-16 grader exports analyzed in [the results review](qa-test-case-architect-v2-studio-evaluation-v0.23-results-2026-07-16.md): the run used the v0.23 datasets (verbatim expected responses), exhibited v0.23-only instructed behavior, and the live configuration is now confirmed to carry the v0.23 instructions.

## Caveats (kept explicit)

- The pull post-dates the evaluation run within the same day; attribution assumes no interim Studio edit between the run and the pull. No Studio audit trail is available to the non-admin owner to prove this.
- Only the **parent instructions** field was captured. Name, description, conversation starters, knowledge sources, and tool/skill scoping were not visible to the non-admin pull — the Manual Setup Record in the Studio Setup page remains unfilled for those fields.
- This capture does not change readiness, approval, or lifecycle status; those remain human-owned.

## Follow-ups

- Complete the full Manual Setup Record (knowledge sources, tools, permissions) when someone with Studio admin access can view them.
- The one live-only concern surviving this capture is behavioral, not configurational: finding R-1 (production pasted-export bypass) occurred **with these exact instructions saved**, confirming it needs an instruction-hardening slice (F2), not a re-save.
