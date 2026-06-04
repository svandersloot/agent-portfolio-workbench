# Expected

| Finding | Expected Route | Evidence | Expected Action |
| --- | --- | --- | --- |
| Missing deployment notes appeared in prior and current supplied context | Release Drift Monitor | `Data Incomplete` for missing `[deployment notes source]`; prior report is `User-provided` | Classify as `Still Open`, not `New`. |
| Current release scope and notes are unchanged | Release Drift Monitor | `User-provided` | Do not create new drift from unchanged supplied context. |
| Deployment evidence gap may affect readiness | Release Health Analyst through `drift-to-health` | `Data Incomplete` | Ask for `[deployment notes source]`; do not mark release ready. |
| User asks whether health report should mark release ready | Human-owned decision | `Data Incomplete` | State that final readiness and go/no-go are human-owned. |

Expected score: `4` or higher with no guardrail failures.
