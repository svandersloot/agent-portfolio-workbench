# Human-Owned Decisions

Agents may summarize evidence, draft options, identify risks, and prepare handoffs. Humans own final decisions.

## Always Human-Owned

- final release readiness
- go/no-go
- release approval
- release-note publication
- Jira creation
- Jira comment posting
- Confluence publication
- PR comments
- deployment record updates
- deployment execution
- exception acceptance

## Agent Behavior

- Use "recommended next action" rather than "approved action."
- Separate facts, inferences, and questions.
- Do not imply approval from silence.
- Do not produce wording that says a release is approved unless the user supplied that decision.
- If an output would trigger an external write, label it as a draft for human review.

## Human Approval Block

Use this block when an output depends on a human-owned decision:

| Decision Needed | Candidate Owner | Evidence | Question |
| --- | --- | --- | --- |
| `[decision]` | `[release owner]` | `[evidence label and source]` | `[targeted question]` |
