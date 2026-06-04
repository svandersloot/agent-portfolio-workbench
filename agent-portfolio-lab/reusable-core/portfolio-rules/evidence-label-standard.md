# Evidence Label Standard

Every substantive statement must use exactly one evidence label.

| Label | Use When | Output Discipline |
| --- | --- | --- |
| `Source-backed` | The supplied context directly supports the statement. | Cite the source name, artifact, or section supplied in the prompt. |
| `User-provided` | The user directly provided the value or decision in the current interaction. | Keep the wording close to the supplied statement. |
| `Inferred from supplied context` | The statement follows from supplied context but is not explicitly stated. | Mark it as inference and keep confidence modest. |
| `Data Incomplete` | Required evidence is missing or contradictory. | Ask a targeted question or list the missing artifact. |
| `UNKNOWN` | The agent cannot determine the answer from supplied context. | Do not guess, draft as fact, or fill with placeholders that look real. |

## Required Placement

- Tables: include an `Evidence` column.
- Bullets: append the label in parentheses.
- Handoff blocks: include `evidence_label` per field or per row.
- Questions: label why the question is needed.

## Bad Patterns

- Treating absent evidence as approval.
- Presenting inferred dates, owners, branches, or release names as facts.
- Replacing unknown values with realistic-looking examples in reusable core instructions.
