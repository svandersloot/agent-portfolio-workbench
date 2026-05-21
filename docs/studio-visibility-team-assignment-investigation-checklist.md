# Studio Visibility And Team Assignment Investigation Checklist

Use this checklist to investigate ROVO Studio visibility, team assignment, and discoverability controls without changing Studio configuration.

## Safety Boundary

- Read-only only.
- Do not save Studio changes.
- Do not publish, unpublish, assign, unassign, or alter agent visibility.
- Use screenshots or notes only when they do not expose tokens, cookies, or private request headers.
- Stop and ask for approval before any action that could change Studio state.

## Scope

| Question | Why It Matters |
|---|---|
| Can Draft agents be hidden from broad discovery? | Drafts should not be mistaken for approved agents. |
| Can In Review agents be limited to reviewers? | Review should happen before broad usage. |
| Can Experimental agents be limited to pilot users or teams? | Pilots need controlled audience and feedback. |
| Who can change team assignment or visibility? | Governance needs an accountable control owner. |
| Does Studio expose published, discoverable, or team assignment state in read-only views or exports? | Reports need evidence without write-back. |
| Can visibility differ from Confluence documentation? | Drift creates launch and safety risk. |

## Read-Only Steps

| Step | Action | Evidence To Capture |
|---|---|---|
| 1 | Open the agent detail page in Studio with no edit/save action. | Agent name, current visible status labels, URL redacted if needed. |
| 2 | Inspect visible metadata for published, draft, team, owner, or sharing controls. | Field names and current values. |
| 3 | Open settings panels only if they do not require saving or changing state. | Names of visibility/team controls and whether they appear editable. |
| 4 | Check whether Studio shows role or permission hints for who may edit or assign teams. | Permission text or disabled-control explanations. |
| 5 | Compare the visible Studio state with the Project Brain and inventory record. | Drift notes. |
| 6 | If a normalized Studio export is available, check whether assignment or discoverability fields are captured. | Field paths and sample redacted values. |
| 7 | Record unknowns that require Atlassian admin confirmation. | Open questions and owner. |

## Findings Table

| Agent | Lifecycle Status | Studio State Observed | Team/Visibility Fields Seen | Can Limit Audience? | Who Can Change It? | Evidence | Open Questions |
|---|---|---|---|---|---|---|---|
| [Agent] | Draft / In Review / Experimental / Active | [Observed state] | [Fields] | Yes / No / Unknown | [Role or unknown] | [Link or note] | [Questions] |

## Control Recommendation

| Governance Status | Recommended Studio Control Until Confirmed |
|---|---|
| Draft | Keep out of broad promotion; document as not approved in Project Brain and inventory. |
| In Review | Share only with reviewers and owner group where Studio supports it; otherwise rely on clear inventory status. |
| Experimental | Limit to pilot audience when Studio supports assignment; otherwise treat as governance-limited and document the audience clearly. |
| Active | Make discoverable only to the intended audience after governance approval. |
| Needs Remediation | Remove promotion and add remediation notes; pause use when risk is material. |
| Deprecated | Point users to replacement and remove from recommended lists where possible. |

## Decision Log Prompt

When the investigation is complete, record:

- What Studio can restrict today.
- What Studio cannot restrict today.
- Who can change assignment or visibility.
- What governance control is required when Studio cannot enforce the desired audience.
- Whether the completeness contract or lifecycle policy needs an update.
