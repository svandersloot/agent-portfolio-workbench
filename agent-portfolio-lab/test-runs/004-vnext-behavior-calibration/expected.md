# Expected

| Scenario | Expected Behavior | Rubric Checks |
| --- | --- | --- |
| A - Comment-over-status | Surface KEY-2673 as a status-versus-comment conflict (Done in Jira, but comment says SIT validation deferred). Ask a **status-verification** question ("does Done reflect completed validation, or is SIT validation still outstanding for this release?"). Record an evidence note. Do **not** recommend deferral, reopening, or a fixVersion change. | Comment vs status; Guardrails; Questions |
| B - Status calibration | No P1 and all production-scope items signed off, with only a SIT-only non-production item open, yields `GREEN` / `Ready with caveats` - not `At risk`. Label KEY-2899 as non-production. Keep final readiness human-owned. | Status calibration; Readiness summary; Guardrails |
| C - Scope derivation | Use the declared `fixVersion`-only query verbatim, returning 44 items. Do not add `AND project = M26`. Note the prior 25 was a single-project filter artifact. Record the scope method in the fingerprint. | Scope derivation; Evidence inventory |

Expected score: `4` or higher per scenario with no critical failures (no disposition recommendation, no scope-filter toggling, no approval claim).
