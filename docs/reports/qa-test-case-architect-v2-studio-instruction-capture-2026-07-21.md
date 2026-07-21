# QA Test Case Architect v2 — Live Parent-Instruction Capture #3 (post-v0.25 Studio save, 2026-07-21)

| Field | Value |
|---|---|
| Date | 2026-07-21 |
| Source | Live parent instructions pulled from ROVO Studio by the owner and provided in-session (parent-instructions field; human-performed read; no automated Studio access) |
| Comparison target | The v0.25 `Thin Parent Instructions` copy block in [qa-test-case-architect-v2-studio-setup.md](../confluence-pages/qa-test-case-architect-v2-studio-setup.md) on `origin/main` (PR #61, published as Studio Setup v11) |
| Method | Normalized diff (bullet marker `*`↔`-`, escaped `\*` sequences, indentation, trailing whitespace) — same method as captures #1 and #2 |
| Result | **Content-identical: 64 normalized content lines each, zero differences.** |
| Boundary | Capture and comparison only. No Studio, Jira, XRAY, or Confluence action. Raw pull text kept outside Git (session scratchpad). |

## What this establishes

1. **The manual v0.25 Studio save happened and is faithful.** The live parent instructions carry both hardening additions verbatim: the F2 mode-precedence self-check (inside the Production input rule) and the R-4 CSV structural-validation bullet (15-field parse, comma/quote/newline quoting with doubled embedded quotes, 13-blank continuation rows, Action-with-Expected-Result, Story ID per test case's first row).
2. **The v0.25 evaluation rerun's provenance caveat is resolved.** The 2026-07-21 grader run (reviewed in the [v0.25 results review](qa-test-case-architect-v2-studio-evaluation-v0.25-results-2026-07-21.md)) is now capture-verified as run against the v0.25 instructions, subject to the standing same-day-ordering caveat below.

## Caveats

- The pull and the evaluation run occurred the same day; attribution assumes no interim Studio edit between them (no Studio audit trail is available to the non-admin owner).
- Only the parent-instructions field was captured; knowledge sources, tools, and permissions remain unverified pending an admin-visible Manual Setup Record.

## Interpretive note for the open R-4 finding

The rerun's residual CSV field-count violations occurred **with the structural-validation instruction verifiably saved** — confirming R-4 is now an instruction-*adherence* problem (selective quoting; rule wording TestSuite-shaped for CoverageMap/RTM), not a missing-save problem. This feeds R-4 iteration 2 as scoped in the v0.25 results review and the v0.27 controlled-QA checkpoint.
