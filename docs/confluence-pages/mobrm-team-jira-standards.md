# MOBRM Team Jira Standards

Status: Draft migration review. Not yet the official ROVO source of truth.

Source page: `MO` page `5266898945`, `MOBRM Team Jira Standards`, current version `3`.

## Migration Notes

This page is a cleaned migration draft of the MOBRM team Jira standards for review before publishing in the ROVO space. The current MO source is treated as the documented team standard. Questions and improvement candidates are tracked separately so proposed changes do not become policy until approved by the team owner.

## Team Identity

| Field | Value |
|---|---|
| Team | MOBRM |
| Jira project key | `MOBRM` |
| Board or filter | MOBRM board `7690`: `https://csaaig.atlassian.net/jira/software/c/projects/MOBRM/boards/7690?issueType=10001` |
| Team owner | Shane Vandersloot |
| Standards owner | Shane Vandersloot |
| Backup owner | Harish |
| Approved status | Team-owned source is current in MO; ROVO publish review pending |
| Last source version reviewed | Version `3` |
| Applies automatically when | Jira project key is `MOBRM` or the approved MOBRM board mapping is available. |
| Does not apply when | Ticket only references `MR26`, `M26`, or `CLE`; those keys do not trigger MOBRM standards by themselves. |

## Overview

These standards support consistency, searchability, and auditability across the MOBRM board. They are intended to reduce ambiguity between ServiceNow and Jira and to make tickets easier to classify, groom, execute, validate, and audit.

## Work Type Classification

Every story must use one mandatory work type label. The label determines the expected description template and acceptance criteria.

| Label | When to use | Example |
|---|---|---|
| `access-provisioning` | User access grants, role changes, SSO/MFA, AD group work | `MOBRM-78` |
| `infrastructure-change` | SMTP migration, firewall rules, IP allowlisting, CyberArk | `MOBRM-128` |
| `release-deployment` | SIT/TRN/PROD deployments and general release tasks | `MOBRM-328` |
| `ser-update` | SE Rate and Exposure Type updates through automation script | TBD |
| `harsh-brake-update` | Harsh Brake rate and adjustment factor updates through automation script | TBD |
| `producer-org-setup` | New producer code or organization setup through automation script | TBD |
| `prod-sync` | Post-deployment system table sync with Production through automation script | TBD |
| `vendor-coordination` | Guidewire tickets, SailPoint, or external partner requests | `MOBRM-114` |
| `tooling-improvement` | Rovo agents, synthetic data, automation, or process design | `MOBRM-362` |

## Summary Naming Conventions

| Work type | Summary pattern |
|---|---|
| Access provisioning | `Access Provisioning: [Person Name] - [System/Role] Access` |
| Infrastructure | `Infrastructure: [Action Verb] [System/Component] - [Purpose]` |
| Release or deployment | `Release [Version] [Environment] [Action]` |
| SER update | `SER Update - [Standard Change / Release] - [Brief Description]` |
| Harsh Brake update | `Harsh Brake Rate Update - [Brief Description]` |
| Producer org setup | `New Producer Org - [Org Name] - [Producer Code]` |
| Prod sync | `Prod Sync - [System Table] - [Post RITM/Release ID]` |
| Vendor coordination | `[Vendor] Ticket | [Brief Purpose]` |
| Tooling or improvement | Descriptive phrase stating the outcome |

## Work Type Requirements

### Access Provisioning

Default estimate: `1 SP`

Description must include:

- Requestor or sponsor.
- User full name.
- System and role level.
- Hyperlinked ServiceNow reference.
- Business justification.

Minimum acceptance criteria: `2`

Example acceptance criterion:

- Verify user `[Name]` can log in to `[System]` with `[Role]`.

### Infrastructure Or Security Changes

Default estimate: `3+ SP`

Description must include:

- Current state.
- Proposed change, including IPs or endpoints when relevant.
- Impacted systems.
- Validation plan.
- Rollback plan.

Minimum acceptance criteria: `3`

Acceptance criteria should cover:

- Change applied.
- Existing functionality remains unbroken.
- Rollback tested or rollback path confirmed.

### Release Or Deployment

Default estimate: `3+ SP`

Description must include:

- Release version or tag.
- Target environment, such as SIT, TRN, or PROD.
- Deployment checklist or steps.
- Post-deployment validation.

Minimum acceptance criteria: `3`

Acceptance criteria should cover:

- Post-deployment smoke tests.
- Application accessibility.
- No error spikes.

### SER Update

Default estimate: `3 SP`

Required label: `ser-update`

Epic: Map to the release epic the change is targeting.

Description must include:

- Jira ticket number and attached Excel template with rates.
- `StandardChange` flag value, `True` or `False`, with justification.
- Target branch, such as `develop` or a release branch.
- Link to the runbook for updating SE Rates and Exposure Types.

Pre-run checklist:

- Confirm with Product whether the work adds new rates or modifies existing rates.
- Verify no duplicate entries exist for the target effective date.
- Confirm expiration dates for prior entries when applicable.

Execution notes:

- Clone or pull the `mobilitas-ccm-development-automation-scripts` repo.
- Update `config.ini`: `BaseRepoDirectory`, `TemplateDirectory`, `StoryNumber`, `SerTemplateName`, and `StandardChange`.
- Run `se_rate_update`.
- If `StandardChange=True`, validate XMLs by importing into `dev2` and attach them to Jira.
- If `StandardChange=False`, verify updates match the template in the Guidewire PolicyCenter branch.

Minimum acceptance criteria: `3`

Acceptance criteria should confirm that rates are validated in `dev2` or system tables are verified in PolicyCenter Studio, and that all coverage types are present.

### Harsh Brake Update

Default estimate: `3 SP`

Required label: `harsh-brake-update`

Epic: Map to the release epic the change is targeting.

Description must include:

- Jira ticket number and attached Excel template.
- Target branch, such as `develop` or a release branch.
- Link to the Harsh Brake runbook.

Execution notes:

- Update `config.ini`: `BaseRepoDirectory`, `TemplateDirectory`, `HBTemplateName`, and `HBSystemFileLocation`.
- Run `main.py`.
- Verify `cap_hb_adj_factors_ext.xml`; existing entries should be expired and new entries should be present.

Minimum acceptance criteria: `3`

Acceptance criteria should confirm adjustment factors were verified and a PR was opened against the release branch and reviewed.

### Producer Org Setup

Default estimate: `3 SP`

Required label: `producer-org-setup`

Epic: Map to the release epic the change is targeting.

Description must include:

- Jira ticket number and completed `OrgSetupTemplate.xlsx`.
- Link to the producer org setup runbook.

Execution notes:

- Update `config.ini`: `OrgSetupTemplateLocation`, `CurrentOrgExtractLocation`, and `OrgSetupStoryNumber`.
- Run `new_org_setup`.
- Review the four generated XML files.

Minimum acceptance criteria: `3`

Acceptance criteria should confirm generated XMLs were validated and the import into the target environment was successful.

### Prod Sync

Default estimate: `3 SP`

Required label: `prod-sync`

Epic: Map to the release epic the change is targeting.

Description must include:

- Jira ticket number and source standard change or release RITM.
- System tables being synced.
- Link to the prod sync runbook.

Execution notes:

- Export the system table from Production PolicyCenter.
- Update `config.ini`: `ProductionExportLocation`, `BaseRepoDirectory_PC`, `ImportPolicyCenter`, and `SyncSystemTables`.
- Run `production_import_update`.
- Review the diff in Guidewire Studio and validate that no extraneous updates are present.

Minimum acceptance criteria: `3`

Acceptance criteria should confirm the diff was reviewed, only expected changes are present, and the PR was merged.

### Tooling Or Process Improvement

Default estimate: `5+ SP`

Description must include:

- Objective.
- Background or context.
- Scope, including in-scope and out-of-scope items.
- Test plan.

Minimum acceptance criteria: `5+`

Acceptance criteria should be verifiable and cover deliverables and edge cases.

## Definition Of Ready

A ticket must meet all criteria before moving to `In Progress`.

- [ ] Summary follows the naming convention for its work type.
- [ ] Correct work type label is applied.
- [ ] Description meets the minimum requirements for the work type.
- [ ] Acceptance Criteria field is populated and not embedded only in the description.
- [ ] Story points are estimated.
- [ ] Priority is set and is not `Not Set`.
- [ ] Epic Link or Parent is assigned.
- [ ] ServiceNow references are hyperlinked.

## Definition Of Done

- [ ] All acceptance criteria are verified.
- [ ] Time spent is logged for stories estimated at `3+ SP`.
- [ ] Resolution field is set, such as `Done` or `Won't Do`.
- [ ] Relevant Confluence documentation is updated.
- [ ] ServiceNow ticket is closed or updated.
- [ ] All sub-tasks are resolved.

## Sub-Task Standards

- Summary must describe a specific action, not only a person's name.
- Description must include what was done and the outcome.
- Time spent must be logged upon completion.

## ServiceNow Cross-Reference Standard

Do not paste a bare ServiceNow number.

Use this format:

```text
[RITMXXXXXXX](URL) - Brief description of request.
```

Example:

```text
RITM0113754 - Request for PC Prod access.
```

## Priority Calibration

| Priority | When to use |
|---|---|
| Critical | Production down, security incident, or data breach. |
| High | Blocking other work or a time-sensitive business need. |
| Medium | Standard work within the current sprint. This is the default. |
| Low | Nice-to-have work, no deadline, or backlog candidates. |

## Epic Selection Guide

Every story must be linked to the appropriate epic based on work type and the current month or quarter.

Source filter: `https://csaaig.atlassian.net/issues/?filter=57805`

The epics listed here are 2026 planning values. Keep the selection rule evergreen, but review and refresh the epic list when the next year's epics are created.

| Work type | Current active epic from source page | Future or quarterly epics |
|---|---|---|
| Release / Deployment | `CLE-176 - Release Management 2026.05.01` | `CLE-205`, `CLE-177` |
| Script Execution | `CLE-205` | TBD |
| Access Provisioning | `CLE-172 - Access & System Support Q2` | `CLE-173`, `CLE-174` |
| Infrastructure / Stability | `CLE-169 - Env Stability & Maint Q2` | `CLE-170`, `CLE-171` |
| Tooling / Strategy | `CLE-166 - Strategy & Process Improvement Q2` | `CLE-167`, `CLE-168` |

## Script Execution Quick Reference

All script-based work types use the same repository:

```text
https://github.com/aaa-ncnu-ie/mobilitas-ccm-development-automation-scripts
```

| Script type | Label | Program to run | Config keys to update | Full runbook |
|---|---|---|---|---|
| SER Update | `ser-update` | `se_rate_update` | `BaseRepoDirectory`, `TemplateDirectory`, `StoryNumber`, `SerTemplateName`, `StandardChange` | Updating SE Rates and Exposure Types |
| Harsh Brake | `harsh-brake-update` | `main.py` | `BaseRepoDirectory`, `TemplateDirectory`, `HBTemplateName`, `HBSystemFileLocation` | Source page short link |
| Producer Org | `producer-org-setup` | `new_org_setup` | `OrgSetupTemplateLocation`, `CurrentOrgExtractLocation`, `OrgSetupStoryNumber` | Source page short link |
| Prod Sync | `prod-sync` | `production_import_update` | `ProductionExportLocation`, `BaseRepoDirectory_PC`, `ImportPolicyCenter`, `SyncSystemTables` | Source page short link |

## Labels

- `jira-team-standards`

## Review Questions Before Official ROVO Migration

- Confirm whether `project = MOBRM` is sufficient for automatic overlay detection, or whether the approved board mapping should also be required.
- Confirm the ROVO page status at publish time: `Approved`, `Draft`, or `Team-owned / pending ROVO review`.
- Confirm whether 2026 epic examples should remain in the main table or move to a dated appendix.
- Confirm whether script execution evidence should be required before `Done` or treated as preferred auditability guidance.
- Confirm whether `vendor-coordination` and `tooling-improvement` should have fuller description and acceptance-criteria templates like the script work types do.
- Should release-bound work require `fixVersion`, deployment window, rollback owner, and post-deployment validator fields?
