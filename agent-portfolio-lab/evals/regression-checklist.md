# Regression Checklist

Run this checklist before manually transferring any lab improvement into Confluence or Rovo Studio.

| Check | Pass |
| --- | --- |
| Reusable core contains no company names, real team names, Jira project keys, fixVersions, branch names, internal URLs, owner names, or deployment windows. | `[ ]` |
| Each agent package has identity, studio instructions, boundaries, prompt library, and eval rubric. | `[ ]` |
| Evidence labels appear in every default output shape. | `[ ]` |
| Human-owned decisions are explicitly guarded. | `[ ]` |
| Prohibited external writes remain prohibited. | `[ ]` |
| Routing uses documented handoff contracts. | `[ ]` |
| Manual tests include routing, handoff, guardrail, and missing-evidence cases. | `[ ]` |
| CSV-compatible eval references use `prompt,expected_result`. | `[ ]` |
| Automation workflow files are non-executable contracts or checklists only. | `[ ]` |
| Daily report tests cover freshness, delta behavior, stale evidence, and missing prior baseline. | `[ ]` |
| Manual promotion reports distinguish lab readiness from Confluence publication, Studio configuration, and workflow configuration. | `[ ]` |
| Publication/configuration status remains `UNKNOWN` unless user-supplied or source-backed evidence is present. | `[ ]` |

## Failure Handling

Record failures in the active `test-runs/[run-id]/findings.md` file with the agent, prompt, score, and proposed instruction change.
