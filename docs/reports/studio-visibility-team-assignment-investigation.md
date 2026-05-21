# Studio Visibility And Team Assignment Investigation

Read-only investigation using local repo docs, schemas, examples, and exported metadata. No Studio writes were performed.

## Summary

The current local evidence does not prove whether ROVO Studio can restrict Draft, In Review, or Experimental agents by team assignment or discoverability controls. The local normalized Studio schema captures `isPublished`, knowledge sources, tools, and subagent activation/default state, but it does not currently capture team assignment, discoverability, visibility scope, sharing scope, or editor role fields.

## Evidence Reviewed

| Source | Relevant Evidence |
|---|---|
| `schemas/studio-normalized.schema.json` | Includes `isPublished`, `parent`, `subagents`, `knowledgeSources`, `tools`, `webSearchEnabled`, and `deepResearchEnabled`; no team assignment or discoverability fields. |
| `examples/studio-response.sample.json` | Includes `isPublished: false`; no visible team assignment or sharing scope fields in the sample. |
| `scripts/Normalize-StudioExport.ps1` | Normalizes publication state, tools, knowledge sources, and subagents; no logic for visibility/team fields. |
| `docs/studio-visibility-team-assignment-investigation-checklist.md` | Defines safe manual inspection steps and open questions. |
| Current repo docs | Lifecycle policy says Experimental should be visible only to a select audience, but flags Studio controls as needing investigation. |

## Findings

| Question | Current Evidence-Based Answer | Confidence | Follow-Up |
|---|---|---|---|
| Can Draft agents be hidden from broad discovery? | Unknown from local export/schema evidence. | Low | Manual Studio UI/admin inspection required. |
| Can In Review agents be limited to reviewers? | Unknown from local export/schema evidence. | Low | Manual Studio UI/admin inspection required. |
| Can Experimental agents be limited to pilot users or teams? | Unknown from local export/schema evidence. | Low | Manual Studio UI/admin inspection required. |
| Who can change team assignment or visibility? | Unknown from local export/schema evidence. | Low | Atlassian admin confirmation required. |
| Does the normalized export capture visibility/team assignment fields today? | No, not in the current schema or sample. | Medium | Extend normalizer only if read-only captures expose stable fields. |
| Can governance status differ from Studio publication state? | Yes. The schema can capture `isPublished`, but governance lifecycle status lives in Confluence/inventory. | Medium | Report drift between Confluence status and `isPublished` when captures exist. |

## Interim Control Recommendation

| Lifecycle Status | Interim Control |
|---|---|
| Draft | Treat as not approved in Confluence inventory and Project Brain. Avoid broad promotion. |
| In Review | Share links only with reviewers/owners until Studio controls are confirmed. |
| Experimental | Document pilot audience in Project Brain and inventory. Do not describe as broadly approved. |
| Active | Require governance approval plus intended-audience documentation before broad discoverability. |
| Needs Remediation | Add remediation notes and pause promotion. |
| Deprecated | Point users to replacement guidance and remove from recommended lists where possible. |

## Normalizer Gap

If a future read-only Studio capture exposes fields such as team assignment, sharing scope, visibility, discoverability, editors, viewers, or publication channel, add those fields to:

- `schemas/studio-normalized.schema.json`
- `scripts/Normalize-StudioExport.ps1`
- examples under `examples/`
- governance completeness or visibility reports

Do not add Studio write-back.
