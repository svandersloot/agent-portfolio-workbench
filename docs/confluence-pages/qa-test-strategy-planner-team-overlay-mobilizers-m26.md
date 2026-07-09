# Team Overlay - Mobilizers M26

## Status And Source Scope

| Field | Value |
|---|---|
| Overlay status | Draft / Pilot Evidence Only |
| Source scope | Approximately 100 recent M26 stories, including open stories and stories resolved in the last 90 days |
| Evidence type | Historical Jira/story-pattern analysis supplied for pilot planning |
| Standard status | Observed patterns only; not validated team standards |
| Last reviewed | 2026-06-17 |

## Studio Use

Use this overlay only when the user is working with Mobilizers, M26, or explicitly supplied M26 source packets.

Treat all findings as `Observed Pattern` until a QA lead validates them. Use them to ask sharper intake questions and identify likely gaps. Do not infer owners, environments, test data, readiness, release approval, or automation coverage from this overlay.

## Recurring QA Planning Gaps

| Gap | Observed pattern | Runtime use |
|---|---|---|
| Structured QA intake fields unused | Existing QA custom fields were not populated in the sampled stories. | Ask whether inline notes or structured fields are authoritative for the current story. |
| QA scope embedded ad hoc | Testing scope appears in descriptions, `Notes to QA`, `Regression Scope`, or `Test Strategy` text. | Extract only supplied scope and ask what is missing. |
| E2E testing split into QA-only stories | E2E stories exist but may lack ACs, estimates, fixVersions, or links to component stories. | Ask for linked component stories, scope, fixVersion, and ownership. |
| External partner coordination not tracked structurally | CCC, PayPilot, partner, or external lead-time notes appear inline. | Ask for dependency owner, expected readiness date, and test environment status. |
| Release readiness fields unused | Fields such as Release Feature to Production? and QA Drop Date exist but were not populated. | Do not infer readiness from field absence; ask for current readiness evidence. |

## Common Systems And Workstreams

| System/workstream | Observed role |
|---|---|
| ClaimCenter | Claims handling, reserves, assignment rules, ISO reporting, GL, activities, permissions, documents. |
| PolicyCenter | Forms, endorsements, UW companies, product model, conditions, coverage configuration. |
| BillingCenter | Billing, premium audit, payments, UW company validation. |
| AWS / Lambda | Partner API integrations, callbacks, SSM/Secrets management. |
| SmartComm | Document template generation and branding. |
| PayPilot | Payment processing and bank account configuration. |
| ISO | Regulatory claims reporting. |
| GL / General Ledger | Financial transaction feeds from CC and PC. |
| Partner workstreams | Uber, Waymo, Cruise, Lyft, DoorDash, HelloFresh, and related partner flows. |

## Common Test Types

Observed test types include:

- E2E / cross-system validation across PC, CC, BC, AWS, and partner flows.
- Regression.
- Multi-state / jurisdictional validation.
- Transaction-based testing for submission, renewal, policy change, rewrite, rewrite new account, and related flows.
- Document / template validation.
- Integration / API validation.
- Configuration / admin validation.
- GL / financial validation.

## Environment And Data Patterns

| Pattern | Runtime use |
|---|---|
| Multi-environment awareness exists but is not formalized. | Ask for target environment, deployment state, external endpoints, and environment-specific data. |
| Test data is partner-specific and state-specific. | Ask for TPA type, UW company, jurisdiction, policy type, claim/policy/account identifiers, and whether data is safe for testing. |
| SharePoint requirements are common. | Ask whether QA has access to the specific linked version of mapping, form, or data documents. |
| External environment dependencies exist. | Ask for CCC, PayPilot, ISO, partner, or other external readiness confirmation. |

## Automation And Suite Ownership Patterns

Observed pattern: the Automation custom field exists but was not populated in the sampled stories. No references to automated QA suites, CI-triggered test runs, or automation coverage targets were found. Static analysis tooling was referenced separately, but that is not functional QA automation evidence.

Runtime use:

- Ask whether automation exists outside Jira.
- Do not assume automation is absent or unnecessary.
- Distinguish code-quality scans from functional QA automation.
- Do not claim automation is implemented, passing, or blocking without explicit evidence.

## Release And Readiness Signals

Observed patterns:

- FixVersions appear to follow a regular release cadence.
- Release Feature to Production? and QA Drop Date fields exist but were not populated in the sample.
- Story status flow appears to be Backlog, To Do, In Progress, Done, with occasional Canceled.
- There was no visible In QA, QA Ready, or Ready for Release workflow status in the sample.
- E2E QA-only stories can act as informal readiness checkpoints, but some sit in Backlog without fix versions.
- Notes to QA and shoulder-check requests appear as informal readiness handoffs.

Runtime use:

- Ask for current fixVersion, QA drop date, E2E story linkage, and release-readiness evidence.
- Do not treat Done status or an E2E placeholder story as release readiness.
- Route release evidence drift and readiness decisions to the release agents.

## Existing Jira Fields To Validate

| Candidate field | Jira field ID | Observed state | Potential use |
|---|---|---|---|
| QA Drop Date | customfield_13382 | Exists, unpopulated | Date dev hands off to QA. |
| Testing Impact | customfield_13697 | Exists, unpopulated | Testing effort/impact triage. |
| Test Case Complexity | customfield_13758 | Exists, unpopulated | Estimation aid. |
| Test Case Type | customfield_13767 | Exists, unpopulated | E2E, regression, integration, and related classification. |
| Test Type | customfield_13213 | Exists, unpopulated | Alternate or complementary test classification. |
| Performance Test Candidate | customfield_14949 | Exists, unpopulated | Flag performance testing needs. |
| Automation | customfield_13323 | Exists, unpopulated | Automation applicability or ownership flag. |
| Environments Impacted | customfield_13882 | Exists, unpopulated | Environment scope awareness. |
| Deployed to Environment | customfield_13451 | Exists, unpopulated | Deployment tracking. |
| Release Feature to Production? | customfield_15964 | Exists, unpopulated | Release gate candidate. |

## Candidate New Overlay Fields

| Candidate Overlay Field | Why it may help | Validation status |
|---|---|---|
| Regression Scope | Currently inline text. | QA lead review needed. |
| External Dependency | CCC, PayPilot, partner, ISO, or other readiness may affect testing. | QA lead review needed. |
| States to Test | State scope is often embedded in story text. | QA lead review needed. |
| E2E Story Linkage | QA-only E2E stories can lose linkage to component work. | QA lead review needed. |
| Source Document Version | SharePoint artifacts appear to drive requirements. | QA lead review needed. |

## QA Lead Validation Questions

- Why are the existing QA custom fields unused: process friction, field confusion, tooling, or no agreed ownership?
- Who owns scheduling and linking QA-only E2E stories?
- Does automation exist outside Jira?
- Is QA tracked in a separate tool or does In Progress cover both dev and QA?
- Is `Notes to QA` the agreed handoff mechanism or a workaround?
- Who tracks CCC, PayPilot, partner, and external environment readiness?
- Is there a formal state prioritization matrix?
- Does QA have stable access to versioned SharePoint requirements?
- Is regression managed as a checklist, test plan, tool suite, or ad-hoc story-by-story activity?
- What currently constitutes ready for release?

## Guardrails

- Do not use this overlay as policy until validated.
- Do not infer environment, data, owner, sign-off, automation coverage, release readiness, or accepted risk.
- Do not treat unpopulated Jira fields as proof that the underlying work is not needed.
- If a current M26 story conflicts with this overlay, prefer the current story and mark the conflict.
