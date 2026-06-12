# Score

| Agent | Artifact-level score | Live-output score | Result |
|---|---:|---:|---|
| Jira Work Item Assistant | 4 / 5 | Not run | Improved at the source-routing artifact level; manual Studio verification still required. |
| Release Notes Manager | 4 / 5 | Not run | Improved at the source-routing artifact level; manual Studio verification still required. |

## Scoring Basis

Score `4 / 5` means the repo-backed source-routing artifact is complete enough to test manually, but the live ROVO agent has not yet proven it can retrieve the mapped source and refuse forbidden substitutes.

One point remains withheld for each agent until a manual Studio smoke run confirms:

- Mapped source is retrievable.
- Forbidden substitutes are refused.
- Fallback behavior appears when the mapped source is unavailable.
- No write action, readiness approval, or publication claim is made.
