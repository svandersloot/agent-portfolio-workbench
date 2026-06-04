# Daily Drift Report Contract

Use this contract when Release Drift Monitor prepares a daily local draft report from supplied snapshots.

## Purpose

Detect release drift since the prior supplied baseline. The report should avoid repeating unchanged findings as new issues.

## Required Inputs

| Input | Required | Evidence Rule |
| --- | --- | --- |
| `[release name]` | Yes | `User-provided` or `UNKNOWN` |
| `[fixVersion]` | Preferred | `User-provided`, `Source-backed`, or `UNKNOWN` |
| Current release scope snapshot | Yes | `Source-backed` if supplied |
| Current release notes draft | Preferred | `Source-backed` if supplied |
| Current deployment notes snapshot | Preferred | `Source-backed` if supplied |
| Prior daily drift report or baseline | Preferred | `Source-backed` if supplied; otherwise `Data Incomplete` |

## Output Shape

| Section | Content |
| --- | --- |
| Top 3 Actions | Highest-impact drift actions or questions. |
| New Since Prior Snapshot | Drift not present in the supplied prior baseline. |
| Still Open | Previously reported drift still unresolved. |
| Resolved | Previously reported drift no longer present in supplied current evidence. |
| Evidence Gaps | Missing sources needed to confirm or clear drift. |
| Handoffs | `drift-to-health` or `health-or-drift-to-notes` as needed. |

## Guardrails

- Do not claim live Jira, Confluence, branch, release-note, or deployment state.
- Do not publish the report from the lab.
- Do not accept exceptions.
- Do not treat missing prior baseline as proof there is no drift.
- Label unchanged findings as `Still Open`, not `New`.
