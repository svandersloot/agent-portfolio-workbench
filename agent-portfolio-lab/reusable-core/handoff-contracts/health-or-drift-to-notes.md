# Health or Drift to Notes Handoff

Use when Release Health Analyst or Release Drift Monitor identifies a user-facing release-note candidate.

## Required Fields

| Field | Description |
| --- | --- |
| `release_name` | `[release name]` or `UNKNOWN`. |
| `candidate_note` | Short plain-language note candidate. |
| `note_type` | Added, changed, fixed, known issue, removed, migration, or `UNKNOWN`. |
| `audience` | User, admin, operator, support, or `UNKNOWN`. |
| `source_evidence` | Labeled supplied source rows. |
| `risk_if_published_wrong` | Short risk statement. |
| `questions_before_publication` | Required questions for missing evidence. |
| `human_decision_needed` | Release-note publication or exception decision. |

## Output Shape

| Note Candidate | Type | Audience | Evidence | Questions |
| --- | --- | --- | --- | --- |
| `[candidate]` | `[type]` | `[audience]` | `[label + source]` | `[question]` |
