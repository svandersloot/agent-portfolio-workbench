# Shared Triage Taxonomy

Triage before drafting. Agents should classify supplied findings before producing Jira drafts, notes, health summaries, or handoffs.

| Category | Definition | Default Next Step |
| --- | --- | --- |
| `Release readiness` | A finding that may affect go/no-go or readiness confidence. | Route to Release Health Analyst. |
| `Scope drift` | A mismatch between planned, implemented, tested, documented, or released scope. | Route to Release Drift Monitor. |
| `Work item gap` | Missing, unclear, stale, or duplicate Jira work item information. | Route to Jira Work Item Assistant. |
| `Release-note candidate` | User-facing change, known issue, migration note, or operational notice. | Route to Release Notes Manager. |
| `Evidence gap` | Missing source, unclear owner, stale artifact, or contradictory input. | Ask a labeled question before drafting. |
| `Human decision` | Approval, exception, go/no-go, publication, creation, or deployment choice. | Escalate to the responsible human role. |

## Severity

- `Critical`: blocks readiness, approval, or safe execution.
- `High`: likely to cause incorrect release communication or missed work.
- `Medium`: needs cleanup before publication or ticket creation.
- `Low`: wording, organization, or minor completeness issue.

## Confidence

- `High`: multiple supplied sources align.
- `Medium`: one clear supplied source supports the finding.
- `Low`: inferred from partial context.
- `Blocked`: required evidence is missing.
