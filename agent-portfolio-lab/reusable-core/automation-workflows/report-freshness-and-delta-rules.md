# Report Freshness and Delta Rules

Daily reports should be useful because they show change, not because they repeat every known fact.

## Freshness Fields

Every daily report draft should include:

| Field | Rule |
| --- | --- |
| `report_date` | Use supplied date or `UNKNOWN`. |
| `release_name` | Use `[release name]` or `UNKNOWN`. |
| `current_snapshot_sources` | List supplied sources only. |
| `prior_snapshot_source` | List supplied prior report or baseline, or `Data Incomplete`. |
| `stale_evidence` | Mark sources that are explicitly older than the expected report period. |

## Delta Categories

| Category | Use When |
| --- | --- |
| `New` | Current supplied evidence introduces a finding not present in the prior supplied snapshot. |
| `Still Open` | Finding appears in both prior and current supplied evidence. |
| `Resolved` | Prior finding is absent from current supplied evidence and current evidence supports closure. |
| `Changed` | Finding remains but severity, owner role, source, or action changed. |
| `Data Incomplete` | Current or prior evidence is insufficient to classify the delta. |

## Noise Controls

- Do not reword the same unresolved issue as a new issue.
- Do not mark a finding resolved unless current supplied evidence supports closure.
- Keep top actions to 3 unless the user asks for a full report.
- Prefer one question per missing source.
