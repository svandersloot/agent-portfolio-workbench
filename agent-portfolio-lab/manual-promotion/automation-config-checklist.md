# Automation Configuration Checklist

Use after a human manually configures daily report automation.

| Check | Pass |
| --- | --- |
| Workflow purpose matches the daily report contract. | `[ ]` |
| Schedule or trigger is user-provided. | `[ ]` |
| Input sources are explicitly configured and reviewed. | `[ ]` |
| Prompt includes evidence labels. | `[ ]` |
| Prompt includes freshness and delta rules. | `[ ]` |
| Output mode is labeled with an automation mode. | `[ ]` |
| Publication or external write gate is explicit. | `[ ]` |
| Missing evidence behavior is documented. | `[ ]` |
| Workflow has a Studio parity or local-equivalent test case. | `[ ]` |

## Review Result

| Workflow | Result | Blocking Question |
| --- | --- | --- |
| `[workflow]` | `[ready / needs update / blocked / UNKNOWN]` | `[question]` |
