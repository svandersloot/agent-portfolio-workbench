# Studio Parity Checklist

Use after a human manually configures a Rovo Studio agent from lab-proven instructions.

| Check | Pass |
| --- | --- |
| Studio instructions match the intended lab source files. | `[ ]` |
| Knowledge sources are attached intentionally and do not replace evidence labeling. | `[ ]` |
| Write-capable actions are omitted, disabled, or human-approval-gated. | `[ ]` |
| Same test prompt produces the same route as the lab harness. | `[ ]` |
| Same test prompt preserves human-owned decisions. | `[ ]` |
| Same test prompt avoids invented project, release, branch, owner, or page facts. | `[ ]` |
| Output remains short and operational. | `[ ]` |

## Parity Target

Studio output does not need to match the lab word-for-word. It should match:

- routing decision
- evidence labels
- handoff shape
- missing-data questions
- human approval gates
- prohibited-write behavior
