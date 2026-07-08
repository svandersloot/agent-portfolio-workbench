# Studio Visibility And Team Assignment Investigation

Read-only investigation using local repo docs, schemas, examples, exported metadata, public Atlassian Rovo guidance, and human-provided tenant observations. No Studio writes were performed.

## Summary

The current local export evidence does not prove whether ROVO Studio can restrict Draft, In Review, or Experimental agents by team assignment or discoverability controls. The local normalized Studio schema captures `isPublished`, knowledge sources, tools, and subagent activation/default state, but it does not currently capture team assignment, discoverability, visibility scope, sharing scope, editor role fields, manager role fields, or user-access restrictions.

Human-provided tenant observation narrows the current Design Agent state: the user reports being the current owner of the Design Agent and the only editor/manager, and believes the agent is open to all users. The user also reports that people can be added as collaborators so they can edit and update it. The org-level Studio creation setting is believed to be `All users`, but this remains admin-unconfirmed because the user is likely not a Studio admin.

Public Atlassian guidance confirms that Studio admins can restrict who creates agents, agent owners can turn `Open to all users` off, specific users can be added as editors or managers, and group/team-based agent access restriction is not currently supported.

## Evidence Reviewed

| Source | Relevant Evidence |
|---|---|
| `schemas/studio-normalized.schema.json` | Includes `isPublished`, `parent`, `subagents`, `knowledgeSources`, `tools`, `webSearchEnabled`, and `deepResearchEnabled`; no team assignment or discoverability fields. |
| `examples/studio-response.sample.json` | Includes `isPublished: false`; no visible team assignment or sharing scope fields in the sample. |
| `scripts/Normalize-StudioExport.ps1` | Normalizes publication state, tools, knowledge sources, and subagents; no logic for visibility/team fields. |
| `docs/studio-visibility-team-assignment-investigation-checklist.md` | Defines safe manual inspection steps and open questions. |
| Current repo docs | Lifecycle policy says Experimental should be visible only to a select audience, but flags Studio controls as needing investigation. |
| Human-provided tenant observation, 2026-07-08 | User reports current Design Agent ownership and access posture: user is owner and only editor/manager; user believes the Design Agent is open to all users; collaborators can be added to edit/update. User believes org-level agent creation is set to all users, but not admin-confirmed. |
| Atlassian Support: `Create and edit Rovo agents` | Public guidance says agents can be created from Chat, Studio, or Jira; the create/edit article says agents can be edited by the creator or an organizational admin, while the permissions/governance article adds that owners can assign individual editors or managers who can edit; owners can transfer ownership; managers can take ownership of ownerless agents; organization admins can delete site-created agents. |
| Atlassian Support: `Rovo agent permissions and governance` | Public guidance says Studio agent creation is open to all users by default, Studio admins can set creation to all users, selected groups, or no users, owners can add individuals as editors or managers, `Open to all users` can be turned off, specific users can be added, and group/team-based agent access restriction is not supported. |
| Atlassian Support: `Share a Rovo agent` and `Browse Rovo agents` | Public guidance says shared/profile-linked agents do not grant additional data permissions, browsing shows organization agents, and profiles show creator, instructions, knowledge sources, tools, and conversation starters where applicable. |

## Findings

| Question | Current Evidence-Based Answer | Confidence | Follow-Up |
|---|---|---|---|
| Who can create agents? | Public guidance says creation is open to all users by default and Studio admins can restrict creation to all users, selected groups, or no users. User believes this tenant is currently set to all users, but that is not admin-confirmed. | Medium | Studio admin confirmation required before treating this as final tenant truth. |
| Who can edit/manage the Design Agent? | User reports being the current owner and only editor/manager of the Design Agent. Public guidance should be read as creator/organization-admin edit authority plus owner-assigned individual editor or manager roles. Owners can add individual editors or managers. | Medium | Optional read-only cross-check in Design Agent `Users and permissions`; do not save changes. |
| Can `Open to all users` be disabled? | Public guidance says yes. User believes the Design Agent is currently open to all users. | Medium | Confirm the current Design Agent toggle state without saving changes. |
| Can specific users be added? | Yes, per public guidance and user observation. Public guidance says added users currently receive editor or manager roles. User described these as collaborators who can edit and update the agent. | Medium | Confirm exact tenant UI role labels before using this as a pilot control. |
| Can Draft agents be hidden from broad discovery? | Public guidance suggests yes for owner-only or individually restricted agents when `Open to all users` is off, but tenant Draft-state behavior was not directly observed. | Medium | Manual Studio UI/admin inspection required. |
| Can In Review agents be limited to reviewers? | Public guidance supports individual user restriction, but not group/team restriction. Because added users can edit/update the agent, reviewer access needs human risk acceptance. | Medium | Manual Studio UI/admin inspection required. |
| Can Experimental agents be limited to pilot users or teams? | Public guidance supports limiting access to individually added users. It does not support access restriction by groups or teams. Team attribution is not an audience-control boundary. | Medium | Human decision required on whether collaborator access is acceptable for pilot users. |
| Who can change team assignment or visibility? | Public guidance says owners manage user access/editors/managers and Studio admins manage creation controls. User reports owning the Design Agent. | Medium | Admin confirmation required for org-level creation controls. |
| Does the normalized export capture visibility/team assignment fields today? | No, not in the current schema or sample. | Medium | Extend normalizer only if read-only captures expose stable fields. |
| Can governance status differ from Studio publication state? | Yes. The schema can capture `isPublished`, but governance lifecycle status lives in Confluence/inventory. | Medium | Report drift between Confluence status and `isPublished` when captures exist. |

## Manual Inspection Status

| Screen | Current Status | Remaining Check |
|---|---|---|
| Studio settings | Likely `All users`, based on user context that the environment is currently broad and unmanaged; not admin-confirmed. | Ask a Studio admin to confirm the selected creation setting without changing it. |
| Design Agent `Users and permissions` | User reports they are owner and only editor/manager. | Optional read-only cross-check for exact role labels and whether any disabled-control text appears. |
| Design Agent `User access` | User reports the Design Agent should be open to all users. | Confirm the toggle state without saving changes. |
| Design Agent collaborators | User reports collaborators can be added so they can edit and update the Design Agent. | Confirm whether all added users receive edit/update capability; do not add anyone during inspection. |
| Group/team access restriction | Public guidance says group/team access restriction is not supported for agent access; users must be added individually. | Confirm tenant UI does not expose group/team access restriction before relying on this as final. |

## Interim Control Recommendation

| Lifecycle Status | Interim Control |
|---|---|
| Draft | Keep `Open to all users` off when available. Do not add collaborators unless the owner accepts that they can edit/update the agent. Treat as not approved in Confluence inventory and Project Brain. Avoid broad promotion. |
| In Review | Prefer owner-only configuration plus manual review/demo until reviewer access is approved. If reviewers need direct access, add named individuals only and record the role accepted. Do not rely on group/team access restriction. |
| Experimental | Limit to named pilot users only if the human owner accepts the collaborator role model. Document the pilot audience in Project Brain and inventory. Do not describe as broadly approved. |
| Active | Require governance approval plus intended-audience documentation before broad discoverability. |
| Needs Remediation | Add remediation notes and pause promotion. |
| Deprecated | Point users to replacement guidance and remove from recommended lists where possible. |

## Decision Brief Input

The likely current posture is broad creation plus a broadly open Design Agent. That supports the original governance concern: without admin-level creation controls and lifecycle policy, Studio can become an unmanaged agent directory.

User-accepted recommendations for owner/admin decision as of 2026-07-08:

1. Keep the Design Agent open to all users as the governed intake/front-door agent only after owner/admin confirmation; no Studio change was made by this investigation.
2. Default new Draft, In Review, and Experimental agents to `Open to all users` off.
3. Ask a Studio admin to restrict agent creation from `All users` to selected governed builder groups, or at minimum confirm the current setting before pilot expansion.
4. Do not treat named collaborators as ordinary pilot viewers because collaborators can edit/update the agent; use collaborators only for trusted reviewers/builders.

## Normalizer Gap

If a future read-only Studio capture exposes fields such as team assignment, sharing scope, visibility, discoverability, editors, viewers, or publication channel, add those fields to:

- `schemas/studio-normalized.schema.json`
- `scripts/Normalize-StudioExport.ps1`
- examples under `examples/`
- governance completeness or visibility reports

Do not add Studio write-back.
