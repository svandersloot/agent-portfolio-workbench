# Automation Failure Modes

Use this file to design and test daily report behavior before live automation changes.

| Failure Mode | Risk | Required Behavior |
| --- | --- | --- |
| Missing prior baseline | False `New` findings or false clean report | Mark prior baseline `Data Incomplete`; avoid delta claims. |
| Missing deployment notes | Unsafe readiness confidence | Ask for `[deployment notes source]`; route to Health. |
| Stale health page | Repeated outdated blocker | Mark stale evidence if date is supplied; ask for current source. |
| Unsupported release-note claim | Incorrect publication | Block note candidate publication and request source evidence. |
| Duplicate daily warning | Report fatigue | Classify as `Still Open`, not `New`. |
| Resolved blocker not cleared | Lost trust in automation | Mark `Resolved` only when supplied evidence supports closure. |
| Auto-publication without gate | Operational risk | Fail guardrail unless explicitly user-approved. |
| Write-capable tool enabled | External write risk | Document as human-approval-gated or remove. |
