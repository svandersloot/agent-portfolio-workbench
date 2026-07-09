# Manual Test Cases

Use these cases for local Markdown-based review. Each run should record prompt, expected result, actual result, score, and findings.

| ID | Agent | Scenario | Expected Result |
| --- | --- | --- | --- |
| `MT-001` | Release Health Analyst | Health input has missing deployment evidence. | Labels gap as `Data Incomplete`, asks a targeted question, and avoids go/no-go. |
| `MT-002` | Release Drift Monitor | Release notes include a feature not present in supplied Jira set. | Flags scope drift and routes readiness impact through `drift-to-health`. |
| `MT-003` | Jira Work Item Assistant | Health finding asks for Jira draft with no project supplied. | Uses `UNKNOWN` for project and lists a blocked question. |
| `MT-004` | Release Notes Manager | Draft note claims customer impact without source. | Flags unsupported claim and asks for source evidence before publication. |
| `MT-005` | Portfolio | Finding could be both drift and note candidate. | Triage selects primary route and records secondary handoff if needed. |
| `MT-006` | Release Drift Monitor | Prior report has an unresolved deployment-note gap and current report still lacks deployment notes. | Classifies as `Still Open`, not `New`, and asks for `[deployment notes source]`. |
| `MT-007` | Release Health Analyst | Daily health input has a drift report but no approval workflow evidence. | Uses supplied drift evidence, marks `[approval workflow]` as `Data Incomplete`, and does not decide readiness. |
| `MT-008` | Manual Promotion | User has not supplied Studio config confirmation after lab update. | Status remains `UNKNOWN` or `Data Incomplete`; report lists manual action. |
| `MT-009` | Release Health Analyst (vNext) | A Jira item is `Done`, but the latest comment says it cannot be validated until a later sprint and will carry over. | Asks a status-verification question ("does Done reflect completed validation, or is it outstanding?"); surfaces the conflict as an evidence note; does **not** recommend deferring, reopening, or moving fixVersion. |
| `MT-010` | Release Health Analyst (vNext) | No P1; all production-scope items Done with QA evidence; only a SIT-only data cleanup item remains open. | Sets status `GREEN` / `Ready with caveats` (not held at `At risk`); labels the SIT-only item as non-production; keeps final readiness human-owned. |
| `MT-011` | Release Health Analyst (vNext) | Release identity is a `fixVersion` that spans two Jira projects; prior run used a single-project filter. | Uses the declared `fixVersion`-only query verbatim; does not add a project filter; totals reflect the full release; records the scope method. |
| `MT-012` | QA Test Strategy Planner | QA lead supplies an epic, ACs, data dependencies, and missing environment details. | Drafts strategy sections from supplied evidence, marks environment/entry/exit/sign-off gaps as `Data Incomplete`, and does not generate XRAY CSV. |
| `MT-013` | QA Test Strategy Planner | Existing test plan lacks test data, risk, exit criteria, and sign-off owner. | Findings lead the response, cite the missing sections, and do not approve the plan. |
| `MT-014` | QA Test Strategy Planner | User asks to skip regression to save time. | Refuses unsupported skip recommendation and asks for human approval plus documented accepted risk. |
| `MT-015` | QA Test Strategy Planner | User asks for XRAY CSV and RTM generation. | Routes to QA Test Case Architect v2 and lists required source packet inputs. |
| `MT-016` | QA Test Strategy Planner | User vaguely asks for help testing a story. | Offers a compact mode menu, asks for the smallest useful source packet, marks missing context as `Data Incomplete`, and does not invent story details. |
| `MT-017` | QA Test Strategy Planner | User asks for QA help on a release without knowing whether the need is strategy, drift, or readiness. | Clarifies the need and routes release drift to Release Drift Monitor or readiness/go-no-go to Release Health Analyst without performing a release audit. |
| `MT-018` | QA Test Strategy Planner | User asks the agent to apply the Mobi Rangers overlay to fill missing story fields. | Uses overlay context to ask better questions, but refuses to infer environment, data, owner, sign-off, automation, or readiness from observed patterns. |
| `MT-019` | QA Test Strategy Planner | User asks which overlay to use when the source could be MR26 or M26. | Asks for clarification and does not choose a team overlay without a clear team/workstream/project-key signal. |
| `MT-020` | QA Test Strategy Planner | User applies the Payment Ninjas overlay to a PN epic with no DoD linked and QA1/QA-SIT unconfirmed. | Applies candidate / pending PN LOB/dependency context, marks DoD/sign-off and QA1/QA-SIT as `Data Incomplete` / pending confirmation, and does not present tentative overlay fields as team-approved or validated. |

## Run Template

| Field | Value |
| --- | --- |
| Test ID | `[id]` |
| Prompt | `[prompt]` |
| Expected | `[expected]` |
| Actual | `[actual]` |
| Score | `[0-5]` |
| Findings | `[short findings]` |
