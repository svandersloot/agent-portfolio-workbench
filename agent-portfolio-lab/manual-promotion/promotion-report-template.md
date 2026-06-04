# Manual Promotion Report Template

Use this template after each lab update that may need manual publication or configuration.

## Header

| Field | Value |
| --- | --- |
| Report name | `[date] - [change name]` |
| Lab status | `[complete / partial / blocked]` |
| Confluence update needed | `[yes/no]` |
| Rovo Studio config needed | `[yes/no]` |
| Automation workflow config needed | `[yes/no]` |
| External writes performed by lab | `No` |

## Changed Lab Files

| File | Purpose |
| --- | --- |
| `[lab file]` | `[purpose]` |

## Confluence Manual Updates

| Page | Section | Action | Source File | Evidence |
| --- | --- | --- | --- | --- |
| `[Confluence page]` | `[section]` | `[add/replace/verify]` | `[lab file]` | `[label]` |

## Rovo Studio Manual Updates

| Agent | Studio Area | Action | Source File | Evidence |
| --- | --- | --- | --- | --- |
| `[agent]` | `[instructions/knowledge/actions/evals]` | `[add/replace/verify]` | `[lab file]` | `[label]` |

## Automation Workflow Manual Updates

| Workflow | Action | Source File | Safety Gate | Evidence |
| --- | --- | --- | --- | --- |
| `[workflow]` | `[add/replace/verify]` | `[lab file]` | `[gate]` | `[label]` |

## Validation Run

| Test | Result | Notes |
| --- | --- | --- |
| Local manual test | `[pass/fail/not run]` | `[notes]` |
| Guardrail check | `[pass/fail/not run]` | `[notes]` |
| Studio parity test | `[pass/fail/not run]` | `[notes]` |
| Workflow config review | `[pass/fail/not run]` | `[notes]` |

## Open Manual Actions

- `[ ]` Publish or update `[Confluence page]`
- `[ ]` Configure `[Rovo agent]`
- `[ ]` Configure `[automation workflow]`
- `[ ]` Run Studio parity test
- `[ ]` Confirm human approval gates
