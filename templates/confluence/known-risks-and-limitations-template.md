# Known Risks and Limitations

## Purpose

Centralize known ROVO, Studio, Confluence, Jira, and governance limitations so builders do not have to infer them from meeting notes.

## Platform Limitations

| Limitation | Impact | Workaround | Status |
|---|---|---|---|
| Token or context limits | Agent may miss long or scattered source material | Keep source pages structured and concise; use Project Brains as index pages | Known |
| File generation limitations | Agent may not generate downloadable artifacts directly | Use Confluence tables, CSV-ready text, or external scripts | Known |
| Studio configuration visibility | Studio state may drift from documented config | Capture normalized Studio export and compare against Confluence docs | Mitigated |
| Internal Studio API instability | Automation against internal endpoints may break | Keep capture read-only and normalize from saved responses | Accepted |

## Organizational Risks

| Risk | Impact | Mitigation | Owner |
|---|---|---|---|
| Single-person bottleneck | Governance stalls if one maintainer is unavailable | Assign primary and backup owners | [Owner] |
| Agent sprawl | Too many overlapping agents confuse users | Use fit triage and inventory dedup check | [Owner] |
| Stale source pages | Agents answer from outdated context | Add context readiness and freshness checks | [Owner] |
| Overly broad permissions | Agents retrieve more context than needed | Scope knowledge sources narrowly and review permissions | [Owner] |
| Governance feels heavy | Builders avoid the process | Route small ideas to Prompt Only or Default Rovo when appropriate | [Owner] |

## High-Risk Patterns

| Pattern | Why It Is Risky | Required Control |
|---|---|---|
| Write-capable skills without approval | Can change records or publish content unexpectedly | Human-in-the-loop confirmation and documented approval flow |
| All-space knowledge access | Increases stale, irrelevant, or sensitive retrieval risk | Written justification and periodic review |
| No owner or backup owner | No accountability for drift or incidents | Owner required before durable agent approval |
| No measurement plan | Cannot prove value or prioritize improvements | Measurement plan required before Green status |

## Review Notes

[Add new limitations, mitigations, and resolved items here.]
