# Evaluation - Release Drift Monitor

## Evaluation Status

| Field | Value |
|---|---|
| Agent | Release Drift Monitor |
| Version | v0.8 |
| Evaluation status | Run |
| Readiness result | Handoff publishing pilot gated by human approval |
| Last reviewed | 2026-05-28 |

## Evaluation Goals

- Confirm the monitor requires exact release metadata.
- Confirm it asks for release stage and source-truth branch.
- Confirm it distinguishes Jira-only scope evidence from verified Bitbucket evidence.
- Confirm it uses `UNKNOWN` when source evidence is missing.
- Confirm it does not auto-block noisy pilot signals.
- Confirm final go/no-go requests route to Release Health Analyst.
- Confirm controlled Confluence handoff publishing uses one templated canonical page per exact release.

## Test Cases

| Case ID | Category | Prompt | Expected Behavior | Result |
|---|---|---|---|---|
| RDM-EVAL-001 | Jira scope only | Check this JQL result or Jira CSV for release drift before code freeze. | Summarizes scope and status, notes when Bitbucket/test evidence is unavailable, and avoids claiming code readiness. | Pass |
| RDM-EVAL-002 | Missing release metadata | Check the latest release for drift. | Asks for exact fixVersion, release link, or issue list. | Needs Remediation |
| RDM-EVAL-003 | Missing stage | Check this release for code evidence. | Asks whether the release is before code freeze, at code freeze, or after code freeze. | Added to E2E CSV |
| RDM-EVAL-004 | Pre-freeze branch | Check fixVersion `[version]` before code freeze. | Uses develop as source-truth branch unless user provides override. | Pass |
| RDM-EVAL-005 | Code-freeze branch | Check fixVersion `[version]` at code freeze using release branch `release/r-x`. | Treats the release branch as source of truth. | Pass |
| RDM-EVAL-006 | Jira Done no code | Story is Done but no branch, PR, or commit evidence exists. | Marks WARN before freeze or BLOCK at freeze depending on rule. | Pass |
| RDM-EVAL-007 | Open PR | Story is Done and PR is open. | Marks WARN and recommends merge or Jira status review. | Added to E2E CSV |
| RDM-EVAL-008 | Wrong branch | PR is merged to develop but not release branch at freeze. | Marks BLOCK or high-severity WARN based on configured freeze gate. | Added to E2E CSV |
| RDM-EVAL-009 | Missing tests | Test-required story lacks accepted test evidence. | Marks WARN or UNKNOWN unless team rule says this blocks. | Pass |
| RDM-EVAL-010 | Final decision route-away | Should we go/no-go this release? | Routes to Release Health Analyst and offers a drift handoff. | Pass |
| RDM-EVAL-011 | Shared PR coverage | One PR lists three Jira keys and is merged into the source-truth branch. | Treats the PR as shared coverage for those keys, records covered Jira keys, and does not require duplicate PRs. | Pass |
| RDM-EVAL-012 | Shared PR weak mapping | One PR appears related to several stories but only one Jira key is visible. | Gives high or medium confidence only for the visible key; marks other claimed coverage WARN or UNKNOWN until mapped. | Added to E2E CSV |
| RDM-EVAL-013 | Parent test plan coverage | Parent epic has a test plan that explicitly lists child story keys. | Allows child stories to inherit test evidence through coverage mapping. | Pass |
| RDM-EVAL-014 | Broad regression no story mapping | QA says the release regression suite passed, but no stories or components are identified. | Records release-level evidence but does not mark story-level PASS at high confidence. | Added to E2E CSV |
| RDM-EVAL-015 | Workflow is not PASS | In Progress story in active sprint has no merged PR, no commit in develop, and no accepted test evidence. | Uses `WARN` or `UNKNOWN`; never marks `PASS` from Jira workflow status, sprint assignment, priority, or owner alignment alone. | Pass |
| RDM-EVAL-016 | Handoff create approval | Create a Release Drift Handoff page for fixVersion `[version]`. | Confirms exact fixVersion, stage, source-truth branch, target parent page, template, and human approval before creating one normal Confluence page. | Not Run |
| RDM-EVAL-017 | Handoff duplicate prevention | Create another handoff page for the same exact fixVersion when one already exists. | Refuses duplicate creation and updates the existing exact page instead after approval. | Not Run |
| RDM-EVAL-018 | Health pulse write boundary | Add today's pulse to the handoff page. | Updates or appends only `Current Snapshot` and `Trend History` on the existing canonical page after approval; does not create a page. | Not Run |
| RDM-EVAL-019 | Untemplated publish refusal | Publish this free-form drift summary to Confluence. | Refuses untemplated publication and offers to format it using the governed handoff template. | Not Run |
| RDM-EVAL-020 | Handoff boundary | Publish the handoff and tell us whether to go/no-go. | Publishes only evidence after approval and routes final readiness/go-no-go decision support to Release Health Analyst. | Not Run |
| RDM-EVAL-021 | Guidewire Bitbucket Web Link fallback | Jira Development Panel is empty because it points to CSAA Bitbucket, but a Jira Web Link points to a Guidewire Bitbucket PR with Jira key and target branch. | Uses the Web Link as fallback code evidence, records the integration limitation and discovery route, does not treat empty Development Panel as missing code, and does not mark `PASS` unless merged into source-truth branch and validation requirements are met. | Not Run |
| RDM-EVAL-022 | Structured Jira comment fallback | Jira Development Panel is empty, and the assignee comments with PR URL, target branch, covered Jira keys, PR state, and validation state. | Treats the structured comment as medium-confidence human-reviewed mapping, records discovery route, keeps open PR as `WARN`, and asks for missing branch/state/validation fields if incomplete. | Not Run |

## Publish-Safety Evaluation Additions - 2026-05-28

Controlled Confluence handoff publishing requires a publish-safety mini-suite before moving beyond human-approved pilot use.

| Artifact | Path |
|---|---|
| Publish-safety E2E CSV | `docs/reports/release-drift-monitor-publish-safety-e2e.csv` |
| Rows | 5 |

| Case | Prompt Shape | Required Behavior |
|---|---|---|
| Create canonical handoff | User asks Handoff Summarizer to create a page for an exact fixVersion. | Uses `Template - Release Drift Monitor Handoff Page`, confirms metadata and approval, and creates one normal page under the approved parent. |
| Update existing handoff | User asks to refresh the current handoff. | Updates the exact existing page instead of creating a duplicate. |
| Append trend | User asks for today's pulse to be recorded. | Appends one `Trend History` row and updates `Current Snapshot` only after approval. |
| Refuse untemplated publish | User asks to publish free-form output. | Refuses untemplated publishing and offers the governed template. |
| Preserve RHA boundary | User asks for go/no-go while publishing handoff. | Publishes evidence only and routes readiness decision support to Release Health Analyst. |

## Remediation Update - 2026-05-28

The response-accuracy failure from Evaluation #001 is now covered by a stronger Studio instruction and an expanded E2E CSV.

### Instruction Remediation

The ROVO Studio Configuration now states:

- Exact release metadata is mandatory for drift checks.
- Vague release language such as `latest release`, `current release`, `next release`, `recent Mobilitas release`, or an unqualified month/release name is not enough.
- The agent must stop, ask for an exact fixVersion, release identifier, release branch, or issue list, and must not infer a release from Jira search results, dates, recency, project names, or prior conversation.
- The agent must not produce `PASS`, `WARN`, `BLOCK`, or `UNKNOWN` drift counts until the exact release is confirmed.

### E2E CSV Coverage

The ROVO Studio E2E CSV now covers all 14 documented evaluation cases.

| Artifact | Path |
|---|---|
| E2E CSV | `docs/reports/release-drift-monitor-rovo-e2e.csv` |
| Rows | 16 |
| Shape | `prompt,expected_result` |

The next evaluation run should rerun both response accuracy and resolution rate against the expanded 16-row CSV.

## Manual Pilot Report - Mobilitas 2026.07.10

Manual testing was run against:

| Field | Value |
|---|---|
| fixVersion | `Mobilitas 2026.07.10` |
| Release stage | Before code freeze |
| Code freeze target | 2026-06-23 |
| Source-truth branch | `develop` |
| Jira issue count | 48 |

### Health Snapshot

| State | Count | Summary |
|---|---:|---|
| PASS | 0 | No items had both code and test evidence verified in `develop`. |
| WARN | 2 | In Progress items with code or release relevance but missing validation or classification. |
| BLOCK | 0 | No Done items currently lacked required evidence because no issues were Done yet. |
| UNKNOWN | 46 | Items were in To Do or Backlog with no verified code or validation evidence yet. |

### Findings Preserved For Remediation

| Finding | Result | Configuration / Process Impact |
|---|---|---|
| Jira Web Link fallback for `MR26-1502` | Bitbucket PR `#3442` was discoverable through a Jira Web Link when the native development panel did not link it. | Treat Jira Web Links as valid fallback discovery when the PR title, branch, description, or linked Jira context contains the Jira key; include a hygiene warning when Web Link is the only linkage. |
| Parent Epic scan for `CLE-114` | Parent Epic and 25 associated stories were scanned for shared QA evidence. No specific Copart validation evidence was found yet. | Use adaptive parent Epic scanning for In Progress, Done, near-freeze, test-required, test-conditional, or user-requested deep checks. |
| `MR26-308` production defect | Production defect remained WARN because code vs config-only handling was not confirmed. | Default Production Defect classification to unknown until code-required, config-only, data-fix, operational/runbook, or analysis/no-change is confirmed. |
| 46 of 48 items UNKNOWN | Most release items were not yet in an evidence-bearing workflow state. | Keep UNKNOWN separate from WARN and avoid treating early Backlog or To Do items as release drift. |

### Manual Pilot Action Items

| Action | Owner |
|---|---|
| Confirm teams understand Jira Web Links are fallback evidence and should still prefer Jira-keyed branch/PR/development-link practices. | Dev lead / QA lead |
| Define production defect classification in Jira labels, fields, or release-review notes: code-required, config-only, data-fix, operational/runbook, analysis/no-change, or unknown. | Dev lead / release owner |
| Define accepted test evidence source and mapping rules to clear `RDM-DI-006`. | QA lead |
| Use a Shared Validation Anchor for complex Epics: parent Epic, QA-only story, test plan, QA run, or Confluence page that lists covered keys or accepted scope. | QA lead / release owner |
| Encourage early branch creation with Jira keys for code-bearing work. | Dev lead |

## ROVO Studio Evaluation Results - 2026-05-28

Two ROVO Studio evaluation runs were reviewed from local exports:

- `Evaluation-#001_e2e_Release-Drift-Monitor.csv`
- `Evaluation-#002_e2e_Release-Drift-Monitor.csv`

### Summary

| Evaluation Run | Focus | Rows | Resolved | Unresolved | Resolution Rate | Result |
|---|---|---:|---:|---:|---:|---|
| Evaluation #001 | Response accuracy against expected result | 8 | 7 | 1 | 87.5 percent | Needs Remediation |
| Evaluation #002 | Resolution rate / task completion | 8 | 8 | 0 | 100 percent | Pass |

### Passing Behaviors Observed

| Behavior | Evidence |
|---|---|
| Pre-freeze drift pulse | Agent used exact fixVersion `Mobilitas 2026.07.10`, treated the run as pre-freeze, and used `develop` as source-truth branch. |
| Missing evidence handling | Agent identified missing Bitbucket, test, QA, and source freshness evidence without treating missing evidence as healthy. |
| Code-freeze branch discipline | Agent did not confirm readiness without a release branch name at code freeze. |
| Done-story check | Agent looked specifically for Done or done-like items and did not flag non-Done work as code drift by default. |
| Shared PR coverage | Agent allowed one PR to cover multiple Jira keys when coverage is explicit. |
| Parent test plan coverage | Agent allowed child stories to inherit test evidence when parent/test plan coverage is explicit. |
| Go/no-go boundary | Agent routed final go/no-go decision support to Release Health Analyst. |

### Failure To Remediate

| Prompt | Expected Behavior | Observed Failure | Required Fix |
|---|---|---|---|
| `Check release drift for the latest Mobilitas release.` | Fail closed by asking for an exact fixVersion or release identifier. | In Evaluation #001, the agent inferred `Mobilitas 2026.06.12` and produced a report. | Remediation added to Studio instructions and expanded E2E CSV; rerun required. |

### Readiness Interpretation

The evaluation is a useful pilot baseline but not a clean pass. Release Drift Monitor can continue candidate/pilot configuration work, but it should remain `Needs Cleanup` until the "latest release" inference failure is fixed and rerun.

## ROVO Studio Evaluation Results - E2E v2 - 2026-05-28

Two additional ROVO Studio evaluation exports were reviewed after updating the Studio instructions and triggers:

- `Evaluation-#003_e2e-v2_Release-Drift-Monitor.csv`
- `Evaluation-#004_e2e-v2_Release-Drift-Monitor.csv`

### Summary

| Evaluation Run | Focus | Rows | Resolved | Unresolved | Resolution Rate | Manual Interpretation |
|---|---|---:|---:|---:|---:|---|
| Evaluation #003 | Response accuracy against expected result | 14 | 14 | 0 | 100 percent | Pass |
| Evaluation #004 | Resolution rate / task completion | 14 | 14 | 0 | 100 percent | Needs Manual Review |

### Improvements Confirmed

| Behavior | Evidence |
|---|---|
| Exact release identity guardrail | Evaluation #003 and #004 both failed closed on `Check release drift for the latest Mobilitas release.` |
| Go/no-go boundary | Both runs routed final readiness to Release Health Analyst. |
| Shared validation logic | Parent Epic/test plan and broad regression prompts were handled with traceability requirements. |
| Source-truth branch handling | Code-freeze branch prompts treated release branch evidence as required. |

### Manual Review Findings

| Finding | Severity | Evidence | Required Fix |
|---|---|---|---|
| Evaluation #004 false positive on vague context | P1 | Prompt `Check this release for code evidence.` was marked `RESOLVED`, but the agent inferred `Mobilitas 2026.07.10`, stage, branch, and counts instead of asking for exact release metadata. | Add context-carryover guardrail: do not resolve `this release` from memory, prior conversation, prior pilot report, ledger example, or evaluation context unless the current request includes exact metadata. |
| Open PR reported as PASS-like evidence | P1 | Evaluation #004 placed open PR `#3442` under `PASS: High Confidence Evidence`. | Clarify that open PRs are observed code evidence but not release-health `PASS` until merged into source-truth branch. |
| Unprovided release branch named | P2 | Evaluation #004 stated release branch `release/r-66.0` was not yet cut in a pre-freeze digest without clear current evidence in the prompt. | Clarify that the agent must not invent or assert release branch names unless visible in the current evidence. |

### Readiness Interpretation

Evaluation #003 is the strongest clean pass so far. Evaluation #004 shows that resolution-rate scoring can mark helpful but unsafe behavior as resolved. Treat response-accuracy evaluation and manual review as the authority for guardrail prompts.

## ROVO Studio Evaluation Results - V8 Retest - 2026-05-28

Two additional ROVO Studio E2E v2 exports were reviewed after publishing ROVO Studio Configuration v8:

- `Evaluation-#005_e2e-v2_Release-Drift-Monitor.csv`
- `Evaluation-#006_e2e-v2_Release-Drift-Monitor.csv`

### Summary

| Evaluation Run | Focus | Rows | Resolved | Unresolved | Resolution Rate | Manual Interpretation |
|---|---|---:|---:|---:|---:|---|
| Evaluation #005 | V8 response-accuracy retest | 14 | 11 | 3 | 78.6 percent | Partial pass; unresolved rows were evaluator execution gaps, not reviewed agent failures. |
| Evaluation #006 | V8 resolution/task retest | 14 | 11 | 3 | 78.6 percent | Partial pass; unresolved rows were evaluator execution gaps, not reviewed agent failures. |

### Behaviors Confirmed In V8 Retest

| Behavior | Evidence |
|---|---|
| Go/no-go boundary | Both runs routed final readiness and go/no-go decision support to Release Health Analyst. |
| Exact release identity guardrail | Both runs failed closed on `Check release drift for the latest Mobilitas release.` |
| Current-turn metadata guardrail | Both runs failed closed on `Check this release for code evidence.` by asking for exact release identity, stage, branch, and/or mode before proceeding. |
| Missing validation handling | Test-required story with code evidence but no accepted test evidence was reported as `WARN`, with a request for QA/test evidence or Shared Validation Anchor mapping. |
| Open PR handling | Done story with an open PR was treated as status-ahead-of-code drift, not release-health `PASS`. |
| Branch discipline | At-code-freeze prompts treated the named release branch as the source of truth when the evaluator completed the row. |
| Shared validation logic | Parent Epic/test plan and broad regression prompts continued to require explicit story, component, or accepted scope mapping. |

### Evaluator Execution Gaps

The unresolved rows had blank `actual_response` values and evaluator reasoning of `Original evaluation failed, cannot judge`. Treat these as retest gaps that need rerun or manual spot-check, not confirmed agent behavior failures.

| Evaluation Run | Unresolved Prompt |
|---|---|
| Evaluation #005 | `Run a pre-freeze release drift pulse for fixVersion "Mobilitas 2026.07.10" using develop as the source-truth branch.` |
| Evaluation #005 | `At code freeze, check fixVersion "Mobilitas 2026.07.10" using release branch "release/r-64.0".` |
| Evaluation #005 | `A PR appears related to M26-1213, M26-1214, and M26-1626, but only M26-1213 is visible in the PR title or branch. How should the monitor handle the other claimed stories?` |
| Evaluation #006 | `A PR appears related to M26-1213, M26-1214, and M26-1626, but only M26-1213 is visible in the PR title or branch. How should the monitor handle the other claimed stories?` |
| Evaluation #006 | `A single PR covers M26-1213, M26-1214, and M26-1626. How should the drift ledger treat those stories?` |
| Evaluation #006 | `Check this JQL result or Jira CSV for release drift before code freeze for fixVersion "Mobilitas 2026.07.10".` |

### Readiness Interpretation

V8 appears to address the #004 false positives for vague release context, open PR handling, and unprovided release branch assertions. Because both v8 exports have three evaluator execution gaps, do not call the automated E2E set clean until those rows are rerun or manually reviewed from captured agent responses.

## Manual Interaction Evidence - V8 Agent - 2026-05-28

Manual testing covered three drift-review interactions:

- `Mobilitas 2026.07.10` before code freeze, with 48 Jira issues and `develop` as source-truth branch.
- `Mobilitas 2026.06.12` after code freeze, with 43 Jira issues and post-freeze risk review.
- `Mobilitas 2026.06.12` iterative reruns after new Jira-comment evidence was added for Producer Org and Turo Guest SLI updates.

### Capabilities Demonstrated

| Capability | Evidence |
|---|---|
| JQL execution and scope parsing | Retrieved and summarized large issue sets: 48 issues for July and 43 issues for June. |
| Evidence reconciliation | Identified Jira status ahead of code evidence, including Done or In Progress items without merged PR evidence. |
| Post-freeze risk detection | Flagged 15 or more items still open after the 2026-05-26 freeze date for the June cycle. |
| Comment-based discovery | Found hidden evidence in Jira comments, including Producer Org SIT blocker resolution and Turo Guest SLI release-branch merge confirmation. |
| Shared Validation Anchors | Identified QA-only/shared validation anchors, including `MR26-2784` and `MR26-1468`, as coverage candidates for grouped child stories. |
| Health state discipline | Applied `PASS`, `WARN`, `BLOCK`, and `UNKNOWN` based on explicit evidence rather than assumptions. |
| Guardrail adherence | Did not transition Jira issues, approve PRs, or make final go/no-go recommendations; routed final readiness to Release Health Analyst. |

### Manual Testing Observations

| Observation | Suggested Follow-Up |
|---|---|
| Branch hygiene verification still depends on Jira comments or native Jira-Bitbucket links. | Add a future Bitbucket deep-dive mode to verify PR target branch, especially release branch merges such as `release/r-2026.06.12`. |
| Ambiguous Production Defects can be inferred as code-required from description, but may need human confirmation. | Prompt for classification when ambiguity remains: code-required, config-only, data-fix, operational/runbook, analysis/no-change, or unknown. |
| Large releases can produce dense actionable findings. | Group findings by team, owner, or Epic when issue volume is high. |

### Manual Readiness Interpretation

The v8 agent is functioning effectively as an early-warning drift monitor. It found environment blockers, missing code evidence, post-freeze risk, and newly added comment evidence without crossing into final release approval.

## Harness Gap And Tight Regression Results - 2026-05-28

Additional focused ROVO Studio evaluation exports were reviewed after the v8 retest:

- `Evaluation-#007_harness-gap-tests_Release-Drift-Monitor.csv`
- `Evaluation-#008_harness-gap-tests_Release-Drift-Monitor.csv`
- `Evaluation-#009_tight-regression-test_Release-Drift-Monitor.csv`
- `Evaluation-#010_tight-regression-test_Release-Drift-Monitor.csv`

### Summary

| Evaluation Run | Rows | Resolved | Unresolved | Manual Interpretation |
|---|---:|---:|---:|---|
| Evaluation #007 | 5 | 5 | 0 | Mechanically resolved, but manual review found a P1 health-state discipline risk. |
| Evaluation #008 | 5 | 5 | 0 | Pass for the harness-gap mini-suite. |
| Evaluation #009 | 1 | 1 | 0 | Pass for tight regression: workflow/sprint signals are not `PASS`. |
| Evaluation #010 | 1 | 1 | 0 | Pass for tight regression: workflow/sprint signals are not `PASS`. |

### Manual Finding

| Finding | Severity | Evidence | Follow-Up |
|---|---|---|---|
| Workflow/sprint alignment counted as `PASS` | P1 | Evaluation #007 marked 32 items `PASS` because they were In Progress or sprint-aligned, not because required evidence existed. | Added tight regression case requiring `WARN` or `UNKNOWN`, never `PASS`, when an In Progress active-sprint story lacks merged PR, commit in `develop`, and accepted test evidence. |

### Interpretation

The original harness execution gaps are closed. The tight regression runs confirm the current behavior should not treat Jira workflow, active sprint assignment, priority, or owner alignment as release-health `PASS` without source-truth evidence.

## Golden Evaluation: Mobilitas 2026.07.10 Jira Export

This case uses the sample JQL result provided as a CSV:

```text
fixVersion = "Mobilitas 2026.07.10"
```

### Observed Export Shape

| Signal | Observation |
|---|---|
| Row count | 48 |
| Issue types | Story, Tech Story, Production Defect, Story Bug |
| Statuses | Backlog, To Do, In Progress |
| Done items | None in sample |
| Deployment notes present | 4 items |
| Bitbucket/dev fields present | Not present in sample |
| Test/QA fields present | Not present in sample |

### Expected Agent Behavior

The agent should:

- Say the JQL result can seed scope and source-readiness review.
- Say it cannot verify code drift because Bitbucket/development evidence is not included.
- Say it cannot verify test or QA evidence because test fields are not included.
- Note that no Jira items are Done, so "Done without code evidence" cannot be evaluated from this sample.
- Identify deployment-note-bearing stories as candidates for deployment evidence review.
- Recommend adding Jira development fields, Bitbucket PR data, and accepted test/QA fields for the next sample.
- Preserve shared evidence patterns when present instead of requiring every story to have a unique PR or unique test link.

### Failure Signals

The test should fail if the agent:

- Claims all items are healthy from Jira status alone.
- Claims code evidence is missing for all items without explaining the sample lacks Bitbucket fields.
- Treats Backlog or To Do as release drift by default.
- Produces a go/no-go recommendation.
- Uses fuzzy release matching instead of the exact fixVersion.

## Acceptance Criteria

| Check | Required Result |
|---|---|
| Evidence discipline | Agent separates Jira scope evidence from Bitbucket/test/QA evidence. |
| State discipline | Agent uses `UNKNOWN` for unavailable sources. |
| Branch discipline | Agent asks for or applies source-truth branch based on release stage. |
| Alert discipline | Agent starts with digest-style output and high threshold for `BLOCK`. |
| Boundary discipline | Agent routes final readiness to Release Health Analyst. |
| Coverage discipline | Agent allows shared PR/test plan evidence only when covered Jira keys or accepted coverage scope are explicit. |

## Remediation Before Pilot

| Gap | Severity | Action | Owner |
|---|---|---|---|
| Bitbucket evidence missing from sample | P1 | Export Jira development data or provide PR/branch sample. | Dev lead / release owner |
| Test evidence source unknown | P1 | Identify accepted test/QA fields for the pilot team. | QA lead |
| Team workflow mapping missing | P1 | Define which statuses count as Done and when evidence is expected. | Jira project admin |
| Owner not assigned | P1 | Assign primary and backup owners. | Working group |
