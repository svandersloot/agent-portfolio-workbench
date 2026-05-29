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
| Missing board/filter metadata | The polisher could apply MOBRM standards to the wrong tickets. | Resolved for initial draft with project key `MOBRM` and board `7690`; confirm whether project key alone is sufficient. |
| Time-bound epic examples | Current active epics can go stale after 2026. | Keep evergreen epic-selection rules in the main standard; review whether 2026 values should remain in the main table or move to a dated appendix. |
| Real-person example in ServiceNow section | The migrated ROVO page should avoid unnecessary personal data. | Resolved: keep the ServiceNow example generic. |
| Uneven work type detail | Some labels have robust templates while others are lighter. | Add templates for vendor coordination and tooling/process improvement. |
| MR26/M26/CLE ambiguity | Related release or epic keys may be confused with team ownership. | Resolved: these keys do not trigger MOBRM standards; `CLE` is used for epics, not team overlay detection. |

## Decisions Captured From Owner Review

| Question | Decision |
|---|---|
| Automatic application | MOBRM standards should theoretically apply to every `MOBRM-*` ticket. |
| Board mapping | MOBRM board URL confirmed: `https://csaaig.atlassian.net/jira/software/c/projects/MOBRM/boards/7690?issueType=10001`. |
| Related keys | `MR26`, `M26`, and `CLE` should not trigger MOBRM standards. `CLE` may appear as the selected epic for monthly release cards, environment maintenance, or quarterly planning. |
| ROVO owner | Shane Vandersloot. |
| ROVO backup owner | Harish. |
| Epic freshness | The listed epics cover 2026 and will eventually go stale; refresh the list when the next year's epics are created. |
| Script evidence | PR links, generated artifacts, import evidence, and validation evidence are ideal for auditability and traceability, but should not always be treated as blocking requirements. |
| ServiceNow example | Keep generic. |

## Questions To Grill Before Official Migration

1. What review cadence should the page have: annual, quarterly, or release-cycle based?
2. Should `project = MOBRM` alone trigger automatic overlay use, or should the agent also verify board `7690` when board context is visible?
3. Should each work type require a specific Jira issue type, such as Story, Task, Bug, or Sub-task?
4. Should work type labels be mutually exclusive, or can a story have more than one work type label?
5. Should script execution evidence be a `should have for auditability` signal, a Definition of Done item, or a blocker only for certain work types?
6. Should `release-deployment` tickets require `fixVersion`, deployment window, rollback owner, and post-deployment validator?
7. Should `vendor-coordination` define required vendor ticket link, owner, expected response date, escalation path, and closure evidence?
8. Should `tooling-improvement` include explicit user outcome, operational owner, adoption plan, measurement, and support handoff?
9. Should access provisioning require least-privilege rationale, approval evidence, expiration date, or periodic access review notes?
10. Should priority calibration include SLA or due-date examples?
11. Should the 2026 epic list remain in the main table, or should it move to a dated release/quarter appendix?

## Recommended Next Step

Publish only after the metadata block is confirmed:

```text
Team: MOBRM
Approved status: Team-owned source current in MO; ROVO publish review pending
Jira project keys: MOBRM
Boards: MOBRM board 7690
Filters: TBD if a saved filter should be named
Owner: Shane Vandersloot
Backup owner: Harish
Last reviewed:
Applies automatically when: Jira project key is MOBRM, or approved MOBRM board mapping is available.
Does not apply when: Ticket only references MR26, M26, or CLE.
```
