# Fixture: Epic SMS Strategy

## Supplied Epic

`[EPIC-101] Enable two-way SMS communication for policy and quote workflows.`

## Acceptance Criteria

- Customer can opt in from `[policy admin system]` for active policies.
- Customer can self-opt in from `[customer portal]` and `[quote portal]`.
- Agent can initiate SMS from `[contact center platform]`.
- Conversation history is visible in `[contact center platform]`.
- Text delivery status is tracked.

## Known Context

- Primary systems: `[policy admin system]`, `[customer portal]`, `[quote portal]`, `[contact center platform]`.
- Integration path: `[policy/portal systems] -> [middleware] -> [contact center platform]`.
- Business dependencies: legal approval for SMS language and agent training.
- Data dependencies: valid whitelisted phone numbers and policy/quote data.
- Risk: opt-in/opt-out compliance and cross-system synchronization.

## Missing Context

- Environment map is not confirmed.
- Entry criteria and exit criteria are not provided.
- Automation ownership is not provided.
- Sign-off owner is not provided.
