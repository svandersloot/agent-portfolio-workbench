# Stage 5 Pilot Promotion Packet Template

Use this packet to request pilot approval or team promotion for 1-2 initial ROVO agents. Keep unknowns explicit. Do not use this packet as proof that an agent is live or approved.

## Header

| Field | Value |
|---|---|
| Packet name | `[agent / team / date]` |
| Requested decision | `[pilot approval / team promotion / continue pilot / remediation / deprecation]` |
| Agent | `[agent name]` |
| Agent type | `[governed agent / extension / candidate / meta-agent]` |
| Current lifecycle stage | `[Idea/Candidate/Prototype/Pilot Approved/Team Approved/Needs Remediation/Deprecated/Retired]` |
| Target stage | `[Pilot Approved/Team Approved/Needs Remediation/Deprecated/Retired]` |
| Target pilot audience | `[named team/users]` |
| Agent owner | `[name/team]` |
| Backup owner | `[name/team or gap owner]` |
| Reviewer/manager | `[name/team]` |
| Packet prepared by | `[name/helper]` |
| Prepared date | `[YYYY-MM-DD]` |

## Source Artifacts

| Artifact | Link or path | Evidence label |
|---|---|---|
| Project Brain | `[link/path]` | `[User-provided/Source-backed/Data Incomplete/UNKNOWN]` |
| Agent Design Record | `[link/path]` | `[label]` |
| Knowledge Source Plan | `[link/path]` | `[label]` |
| ROVO Studio Configuration copy blocks | `[link/path]` | `[label]` |
| Evaluation or regression prompts | `[link/path]` | `[label]` |
| Measurement plan | `[link/path]` | `[label]` |
| Change log | `[link/path]` | `[label]` |
| Duplicate decision | `[link/path]` | `[label]` |
| Pilot feedback tracker | `[link/path]` | `[label]` |

## Fit And Duplicate Decision

| Field | Value |
|---|---|
| Pain point | `[workflow problem]` |
| Intended users | `[team/role/users]` |
| Fit route | `[prompt/automation/extension/template/candidate/new governed agent/not ready]` |
| Existing agents reviewed | `[agents/candidates checked]` |
| Similar-agent comparison | `[audience/source/tool/output overlap]` |
| Duplicate decision | `[reuse/improve/merge/reject/new]` |
| Rationale | `[why this is the least duplicative path]` |

## Approved Pilot Workflows

| Workflow | User trigger | Allowed output | Required source | Human review point |
|---|---|---|---|---|
| `[workflow]` | `[trigger]` | `[allowed output]` | `[source]` | `[review gate]` |

## Prohibited And Escalate Rules

| Category | Rule | Handling |
|---|---|---|
| Prohibited | `[write/decision/data/audience boundary]` | `[decline or draft-only alternative]` |
| Escalate | `[security/legal/compliance/manager trigger]` | `[owner and packet required]` |

## Test Evidence

| Test | Expected result | Actual result | Status | Notes |
|---|---|---|---|---|
| Source verification | `[expected]` | `[actual]` | `[pass/partial/fail/not run]` | `[notes]` |
| Fallback trap | `[expected]` | `[actual]` | `[pass/partial/fail/not run]` | `[notes]` |
| Unsafe write boundary | `[expected]` | `[actual]` | `[pass/partial/fail/not run]` | `[notes]` |
| Behavior regression 1 | `[expected]` | `[actual]` | `[pass/partial/fail/not run]` | `[notes]` |
| Behavior regression 2 | `[expected]` | `[actual]` | `[pass/partial/fail/not run]` | `[notes]` |

## Metrics Plan

| Signal | Capture method | Baseline or estimate | Review cadence |
|---|---|---|---|
| Usage | Manual tracker row | `[baseline/unknown]` | `[cadence]` |
| Pain-point reduction | User feedback and reviewer notes | `[baseline/unknown]` | `[cadence]` |
| Time saved | User estimate or before/after comparison | `[estimate method]` | `[cadence]` |
| Output quality | Accepted/edited/rejected | `[baseline/unknown]` | `[cadence]` |
| Review issues | Issue count and severity | `[baseline/unknown]` | `[cadence]` |
| Unsafe outputs | Incident or issue log | `0 target` | `[cadence]` |

## Go/No-Go

| Question | Answer |
|---|---|
| Owner and backup owner confirmed? | `[yes/no/gap]` |
| Sources approved and current? | `[yes/no/gap]` |
| Duplicate decision recorded? | `[yes/no/gap]` |
| Prohibited actions visible to users and reviewers? | `[yes/no/gap]` |
| Escalation triggers and owners named? | `[yes/no/gap]` |
| Test evidence sufficient for requested stage? | `[yes/no/gap]` |
| Feedback tracker ready? | `[yes/no/gap]` |
| Live-system changes still manual and approved separately? | `[yes/no/gap]` |

## Decision Record

| Field | Value |
|---|---|
| Decision | `[approved/rejected/continue/remediate/deprecate]` |
| Decision owner | `[name/team]` |
| Decision date | `[YYYY-MM-DD]` |
| Conditions | `[conditions or none]` |
| Next review date | `[YYYY-MM-DD]` |
| Notes | `[notes]` |
