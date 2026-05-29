# MOBRM Team Jira Standards Migration Review

## Source

| Field | Value |
|---|---|
| Source space | `MO` |
| Source page | `MOBRM Team Jira Standards` |
| Source page ID | `5266898945` |
| Source version reviewed | `3` |
| Retrieval date | 2026-05-29 |
| ROVO migration status | Draft only; not published |

The exact page was not found in the local old-space export by searching for `MOBRM`, `MOB RM`, or `MOBRM Team Jira Standards`. The user-supplied live Confluence URL was used as the authoritative source for this review.

## What Is Strong Already

- The standard has clear mandatory work type labels.
- Several work types have concrete description requirements and minimum acceptance criteria.
- Script execution work has useful runbook, config, branch, validation, and PR expectations.
- Definition of Ready and Definition of Done are concrete enough for grooming and audit.
- ServiceNow cross-reference guidance directly supports traceability.
- Priority calibration is written in plain language.

## Migration Risks

| Risk | Why it matters | Proposed handling |
|---|---|---|
| Missing board/filter metadata | The polisher could apply MOBRM standards to the wrong tickets. | Add exact Jira project keys, board name or ID, and JQL filter before approving automatic overlay use. |
| Time-bound epic examples | Current active epics can go stale quickly. | Keep evergreen epic-selection rules in the main standard and move dated examples to a reviewed appendix. |
| Real-person example in ServiceNow section | The migrated ROVO page should avoid unnecessary personal data. | Use a generic example unless the team approves otherwise. |
| Uneven work type detail | Some labels have robust templates while others are lighter. | Add templates for vendor coordination and tooling/process improvement. |
| MR26/M26/CLE ambiguity | Related release or epic keys may be confused with team ownership. | Explicitly list which keys trigger the MOBRM overlay and which keys are references only. |

## Questions To Grill Before Official Migration

1. Should this page be the official source for all `MOBRM-*` tickets, or only for a specific MOBRM board?
2. What exact Jira board name, board ID, or saved filter should be written into the metadata block?
3. Should Jira Ticket Polisher apply this overlay automatically for `project = MOBRM`, or should it require explicit user confirmation at first?
4. Are `MR26`, `M26`, and `CLE` only referenced release/epic keys, or should any of them also trigger MOBRM standards?
5. Who is the page owner and backup owner for ROVO?
6. What review cadence should the page have: monthly, quarterly, or release-cycle based?
7. Should each work type require a specific Jira issue type, such as Story, Task, Bug, or Sub-task?
8. Should work type labels be mutually exclusive, or can a story have more than one work type label?
9. Should script execution tickets require attached generated XMLs, PR links, import evidence, and validation screenshots before Done?
10. Should `release-deployment` tickets require `fixVersion`, deployment window, rollback owner, and post-deployment validator?
11. Should `vendor-coordination` define required vendor ticket link, owner, expected response date, escalation path, and closure evidence?
12. Should `tooling-improvement` include explicit user outcome, operational owner, adoption plan, measurement, and support handoff?
13. Should access provisioning require least-privilege rationale, approval evidence, expiration date, or periodic access review notes?
14. Should priority calibration include SLA or due-date examples?
15. Should the migrated page keep current active epics in the main table, or should those move to a dated release/quarter appendix?

## Recommended Next Step

Publish only after the metadata block is confirmed:

```text
Team: MOBRM
Approved status:
Jira project keys:
Boards:
Filters:
Owner:
Backup owner:
Last reviewed:
Applies automatically when:
Does not apply when:
```
