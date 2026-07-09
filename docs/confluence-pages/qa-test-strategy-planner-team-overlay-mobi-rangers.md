# Team Overlay - Mobi Rangers

## Status And Source Scope

| Field | Value |
|---|---|
| Overlay status | Draft / Pilot Evidence Only |
| Source scope | Approximately 15 QA-relevant MR26 stories across Mobilitas 2026.06.26, 2026.07.10, and 2026.08.07 plus child task structures |
| Evidence type | Historical Jira/story-pattern analysis supplied for pilot planning |
| Standard status | Observed patterns only; not validated team standards |
| Last reviewed | 2026-06-17 |

## Studio Use

Use this overlay only when the user is working with Mobi Rangers, MR26, or explicitly supplied Mobi Rangers source packets.

Treat all findings as `Observed Pattern` until a QA lead validates them. Use them to ask sharper intake questions and identify likely gaps. Do not infer owners, environments, test data, readiness, or automation coverage from this overlay.

## Recurring QA Planning Gaps

| Gap | Observed frequency | Runtime use |
|---|---|---|
| Target QA environment missing | High | Ask for target environment and mark `Data Incomplete` if absent. |
| Test data setup guidance missing | High | Ask for claim/policy/state/segment setup and data source. |
| Automation ownership or suite references missing | Universal in sample | Ask whether the work is manual, automated, hybrid, or not applicable. |
| Explicit QA sign-off owner missing | High | Ask who owns QA review/sign-off; do not infer from assignee. |
| Risks/dependencies undocumented | Moderate | Ask for external systems, partner coordination, and dependency status. |
| Regression scope vague or absent | Moderate | Ask for impacted areas, negative paths, transaction types, and downstream checks. |

## Common Systems And Workstreams

| System/workstream | Observed role |
|---|---|
| ClaimCenter / mCAS | Claims processing, PAT, UW tables, reserves, payments, document templates. |
| PolicyCenter | Coverage terms, PIP, forms, TPA Agreement, GL file generation. |
| GL outbound feed | Recovery, reserve, payment, and financial downstream validation. |
| ISO / Verisk | External regulatory reporting integration. |
| Snowflake | Data warehouse / reporting validation. |
| SharePoint requirement docs | DEMs, form specs, GL mappings, product models, and external requirement artifacts. |

## Common Test Types

Observed test types include:

- E2E / integration validation.
- UI / functional validation.
- GL file / financial validation.
- Document / template validation.
- Regression.
- Admin / configuration import.
- Transaction-type matrix coverage for new business, policy change, renewal, rewrite, endorsement, and related flows when relevant.

## Environment And Data Patterns

| Pattern | Runtime use |
|---|---|
| Environment is usually not named in story descriptions. | Ask for QA/staging/UAT target and access constraints. |
| Test data is assumed rather than provisioned. | Ask for claim IDs, policy data, UW company, TPA type, state, segment, and setup/reset steps. |
| SharePoint links are frequent source-of-truth references. | Ask whether QA has access to the specific linked version. |
| XML configuration imports appear for admin data. | Ask for pre/post-import validation steps and rollback expectations. |

## Automation And Suite Ownership Patterns

Observed pattern: automation references were absent from the sampled stories. All QA execution appeared manual through child tasks such as Analysis and Test Case Design, Test Case Execution, Review Test, and SC/Demo.

Runtime use:

- Ask whether automation exists outside Jira.
- Do not assume no automation exists.
- Do not claim automation is implemented, passing, or unnecessary without explicit evidence.

## Release And Readiness Signals

Observed child-task lifecycle:

| Stage | Observed task type |
|---|---|
| Development | Dev Task |
| Unit Testing | Dev Task |
| Code Review | Dev Task |
| Code Deployment | Dev Task |
| DEV to QA Handoff | Dev Task; sometimes canceled |
| Analysis and Test Case Design | QA Task |
| Test Case Execution | QA Task |
| Review Test | QA Task |
| SC/Demo / Shoulder Check | Shoulder Check |

Runtime use:

- Use the task lifecycle as a checklist for questions.
- Do not treat task completion as release readiness or QA sign-off.
- Ask whether DEV to QA Handoff and SC/Demo are formal gates or informal practices.

## Candidate Overlay Fields

| Candidate Overlay Field | Why it may help | Validation status |
|---|---|---|
| Target QA Environment | Environment was usually missing. | QA lead review needed. |
| Test Data Requirements | Claim, policy, state, UW company, TPA, and segment data were often assumed. | QA lead review needed. |
| Impacted Systems | Systems are often present but unstructured. | QA lead review needed. |
| Impacted Transaction Types | Transaction scope appears in several stories. | QA lead review needed. |
| Regression Scope | Regression is often vague or deferred. | QA lead review needed. |
| Automation Applicability | Automation ownership and suite use are invisible. | QA lead review needed. |
| QA Sign-off Owner | Assignee is not the same as sign-off authority. | QA lead review needed. |
| External Dependencies | Verisk, SharePoint, finance, and partner dependency risks can be high impact. | QA lead review needed. |

## QA Lead Validation Questions

- What are the standard environment names and when should each be used?
- Is test data managed through a catalog, seed scripts, shared claims/policies, or ad-hoc setup?
- Do automated suites exist outside Jira?
- Is DEV to QA Handoff ever intentionally skipped?
- Is SC/Demo a formal release gate or optional review?
- Is Review Test the de facto QA sign-off, or is there a separate sign-off authority?
- Who owns regression scope when a story says "identify regression areas"?
- Is there a standard GL file comparison or finance validation process?
- Should SharePoint document version links be required for QA readiness?
- Should multi-system work be decomposed into separate QA checks or one consolidated E2E pass?

## Guardrails

- Do not use this overlay as policy until validated.
- Do not infer environment, data, owner, sign-off, automation coverage, release readiness, or accepted risk.
- If a current MR26 story conflicts with this overlay, prefer the current story and mark the conflict.
