# Deployment Notes Agent Backtest - 2026-06-08

Superseded by `docs/reports/deployment-notes-agent-backtest-v2-2026-06-08.md` after Release Management feedback removed routine environment, evidence capture, and rollback/recovery sections from the Jira Deployment Notes field and moved critical preconditions/timing higher in the template.

## Purpose

This report tests the draft Deployment Notes Standard locally before relying on live Atlassian Rovo agent behavior.

The Confluence pages were already published before this backtest was captured. Going forward, this report should be the model: draft locally, pull representative Jira samples, simulate the agent output, review with stakeholders, then publish.

## Test Method

| Item | Result |
|---|---|
| Standard used | `docs/confluence-pages/deployment-notes-standard.md` |
| Pilot page used | `docs/confluence-pages/deployment-notes-agent-pilot.md` |
| Jira endpoint used | `/rest/api/3/search/jql` |
| Deployment Notes field | `customfield_13450` |
| Agent behavior | Simulated locally from the published draft instructions |
| Live Rovo execution | Not run in this repo-side test |

## Sample Jira Pull

The sample set was selected from the historical patterns identified in the January through June 2026 Mobilitas analysis.

```text
key in (MR26-3076,MR26-2831,M26-788,SRNGR-4539,MR26-810,MR26-2708,SMOBL-4073,SRNGR-3815,M26-231,MOBPXD-1399)
```

| Jira key | Pattern | Summary |
|---|---|---|
| `MR26-3076` | Producer org data import / batch multi-story | New Producer Codes Setup for American Business Insurance Services, CA |
| `MR26-2831` | Producer code data import | New Producer Code Setup for Aon Risk Services Central, Inc. |
| `M26-788` | Manual admin step / permission change / data import | Claims Supervisor unable to edit coverages on policy tab |
| `SRNGR-4539` | Runtime properties / configuration change | Lexis Nexis Reporting For Multiple Account Numbers |
| `MR26-810` | AWS pipeline / secret setup | Okta to Entra Migration - Payment Central |
| `MR26-2708` | Multiple AWS pipelines | Update livegenic to allow 3gp and 3gpp for all partnerships |
| `SMOBL-4073` | Business rule import / manual pre-step | Acknowledgment letter reminders sent after letters were already sent |
| `SRNGR-3815` | External dependency / Confluence-link-only | Okta to Entra - External - Uber |
| `M26-231` | Shared CASFormPatterns artifact | Rhode Island Changes form |
| `MOBPXD-1399` | No meaningful deployment note | PC APIs - Create Document URL |

## Simulated Jira Work Item Assistant Output

These are sample Jira Deployment Notes that should be generated from the current standard. They intentionally preserve known facts and mark missing details instead of inventing them.

### MR26-3076

```text
Deployment Type
data_import, batch_multi_story

Target System(s)
PC

Environment(s)
Data Incomplete - target environment not specified.

Runbook Reference
Deployment Notes Standard for Jira Work Items. Future runbook candidate: Producer Organization Setup / GW XML Data Import.

Preconditions
- Admin access to PolicyCenter.
- Confirm the attached file `ProducerOrg_2026.06.01_Org_AdminData.xml` is the approved final file.
- Confirm the file covers producer org setup stories `MR26-3076` through `MR26-3082`.

Deployment Steps
1. Log in to PolicyCenter.
2. Navigate to Administration > Utilities > Import Data.
3. Import the attached file `ProducerOrg_2026.06.01_Org_AdminData.xml`.
4. Capture the import result.

File(s) / Artifact(s)
| File or artifact | Path or source | Action |
|---|---|---|
| ProducerOrg_2026.06.01_Org_AdminData.xml | Attached to `MR26-3076` | Import |

Validation Steps
1. Verify the following Producer Orgs are present: American Business Insurance Services, CA; Christensen Group Insurance MN; RT Specialty Illinois; Aon Risk Services West, Inc.; MOTER Technologies Inc., CA; Lockton Companies, LLC, CA; HUB International Insurance Services Inc, CA.
2. Confirm no duplicate producer org records were created.

Evidence Capture
- Screenshot or export showing successful import result.
- Screenshot or export showing the listed Producer Orgs are present.

Rollback / Recovery Context
Release Management owns rollback execution.
- Standard release rollback expected to apply: Unknown.
- Special recovery considerations: Data import affects Producer Org setup across multiple related stories.
- Artifacts needed for recovery: Final imported XML file and any prior approved Producer Org data file if available.
- Escalation contact or team: Data Incomplete.

Related Stories
- `MR26-3076` through `MR26-3082`.

Timing Constraints
- None identified.

Open Questions / Data Incomplete
- Target environment and admin URL.
- Whether the import is additive or can overwrite existing records.
- Whether a deployment coordinator story should own the shared import.
```

### M26-788

```text
Deployment Type
admin_manual_step, user_role_permission, data_import

Target System(s)
CC

Environment(s)
Data Incomplete - target environment not specified.

Runbook Reference
Deployment Notes Standard for Jira Work Items. Future runbook candidates: User/Role/Permission Change and GW XML Data Import.

Preconditions
- Admin access to ClaimCenter.
- Before import, manually remove `Edit Policy Coverages` and `Edit policies` permissions from Manager and Supervisor roles.

Deployment Steps
1. Log in to ClaimCenter with an account that can update roles and permissions.
2. Remove `Edit Policy Coverages` and `Edit policies` permissions from Manager and Supervisor roles.
3. Navigate to Administration > Utilities > Import Data.
4. Import `M26-788_Supervisor_Manager_Roles.xml` from `modules/configuration/etc/surepath/cc/configuration/data/default`.
5. Capture the import result.

File(s) / Artifact(s)
| File or artifact | Path or source | Action |
|---|---|---|
| M26-788_Supervisor_Manager_Roles.xml | modules/configuration/etc/surepath/cc/configuration/data/default | Import |

Validation Steps
1. Verify Manager and Supervisor roles reflect the intended permissions after import.
2. Confirm the original issue behavior is resolved for the Claims Supervisor coverage-editing scenario.

Evidence Capture
- Screenshot of the role/permission state after the manual removal and import.
- Screenshot or log of successful import.

Rollback / Recovery Context
Release Management owns rollback execution.
- Standard release rollback expected to apply: Unknown.
- Special recovery considerations: Permission changes were partly manual and partly file-driven.
- Artifacts needed for recovery: Imported XML and prior role/permission state if available.
- Escalation contact or team: Data Incomplete.

Related Stories
- None identified.

Timing Constraints
- Manual permission removal must happen before the import.

Open Questions / Data Incomplete
- Target environment and admin URL.
- Exact validation user or role to test.
- Prior permission baseline for recovery comparison.
```

### SRNGR-4539

```text
Deployment Type
configuration_change

Target System(s)
CC, Integration Gateway properties

Environment(s)
Data Incomplete - story references respective regions but does not list exact target environment files.

Runbook Reference
Deployment Notes Standard for Jira Work Items. Future runbook candidate: Runtime Properties Import.

Preconditions
- Admin access to ClaimCenter runtime properties import.
- Confirm the correct runtime properties file for the target environment/region, for example `cc-runtimeproperties-cloud-dev-qa.xml` where applicable.
- Confirm the attached screenshot is available for validation reference.

Deployment Steps
1. Navigate to Administration > Utilities > Runtime Properties import path.
2. Select the runtime properties file for the target environment/region.
3. Import the file.
4. Delete IG properties:
   - `gw.connect.lexisnexis.police.account.number`
   - `gw.connect.lexisnexis.police.carrier.agency.acct.no`
5. Create the new IG properties listed in the source story with the appropriate TPA and non-TPA suffix values.

File(s) / Artifact(s)
| File or artifact | Path or source | Action |
|---|---|---|
| Runtime properties file | Data Incomplete - exact environment file needed | Import |
| Attached screenshot | Source story | Validation reference |

Validation Steps
1. Navigate to Administration > Utilities > Runtime Properties > LN Police Reports.
2. Validate the highlighted properties match the attached screenshot.
3. Confirm `Account_TPA` is present.
4. Confirm TPA properties use suffix `AAA` and non-TPA properties use suffix `AAB`, if those suffixes are correct for the target environment.

Evidence Capture
- Screenshot of runtime properties after import.
- Screenshot or note confirming old IG properties were removed and new IG properties were created.

Rollback / Recovery Context
Release Management owns rollback execution.
- Standard release rollback expected to apply: Unknown.
- Special recovery considerations: Runtime property values are environment-specific.
- Artifacts needed for recovery: Previous runtime properties values or previous environment-specific runtime property file.
- Escalation contact or team: Data Incomplete.

Related Stories
- None identified.

Timing Constraints
- None identified.

Open Questions / Data Incomplete
- Exact target environment and runtime properties file.
- Whether the old IG properties should be backed up before deletion.
- Whether suffix values vary by environment.
```

### MR26-2708

```text
Deployment Type
aws_pipeline

Target System(s)
AWS

Environment(s)
Data Incomplete - AWS account and target environment not specified.

Runbook Reference
Deployment Notes Standard for Jira Work Items. Future runbook candidate: AWS Pipeline Approve And Deploy.

Preconditions
- Access to the correct AWS account and role.
- Confirm deployment order for the listed pipelines if sequencing matters.

Deployment Steps
1. Approve and deploy `mobilitas-ccm-pipeline-doordash-document-webhook-api`.
2. Approve and deploy `mobilitas-ccm-pipeline-uber-document-webhook-api`.
3. Approve and deploy `mobilitas-ccm-pipeline-partner-document-process-api`.
4. Capture deployment status for each pipeline.

File(s) / Artifact(s)
| File or artifact | Path or source | Action |
|---|---|---|
| mobilitas-ccm-pipeline-doordash-document-webhook-api | AWS CodePipeline | Approve/deploy |
| mobilitas-ccm-pipeline-uber-document-webhook-api | AWS CodePipeline | Approve/deploy |
| mobilitas-ccm-pipeline-partner-document-process-api | AWS CodePipeline | Approve/deploy |

Validation Steps
1. Confirm all three pipelines completed successfully.
2. Confirm the deployed APIs support 3gp and 3gpp document handling for the applicable partnerships.

Evidence Capture
- Screenshot or pipeline execution links showing successful deployment for all three pipelines.

Rollback / Recovery Context
Release Management owns rollback execution.
- Standard release rollback expected to apply: Unknown.
- Special recovery considerations: Multiple AWS pipelines are involved.
- Artifacts needed for recovery: Prior successful pipeline execution/release reference.
- Escalation contact or team: Data Incomplete.

Related Stories
- None identified from this single issue pull.

Timing Constraints
- Data Incomplete - no pipeline order or timing specified.

Open Questions / Data Incomplete
- AWS account, role, and environment.
- Required pipeline order.
- Health check or smoke test after deployment.
```

### SMOBL-4073

```text
Deployment Type
business_rule, admin_manual_step

Target System(s)
CC

Environment(s)
Data Incomplete - target environment not specified.

Runbook Reference
Deployment Notes Standard for Jira Work Items. Future runbook candidate: GW Business Rules Import.

Preconditions
- Admin access to ClaimCenter business settings/activity rules.
- Existing rule `Send Claim Acknowledgement Letter Ext` must be deleted before importing the new rule file.

Deployment Steps
1. Log in to ClaimCenter.
2. Navigate to cc/admin/business settings/activity rules.
3. Delete the existing rule `Send Claim Acknowledgement Letter Ext`.
4. Use the More dropdown to import `ActivityRule-SMOBL-4073_Send_Ack_Letter.gwrules` from `cc/modules/configuration/config/import/bizrules/mobilitas/custom`.
5. Capture the import result.

File(s) / Artifact(s)
| File or artifact | Path or source | Action |
|---|---|---|
| ActivityRule-SMOBL-4073_Send_Ack_Letter.gwrules | cc/modules/configuration/config/import/bizrules/mobilitas/custom | Import |

Validation Steps
1. Confirm the replacement activity rule is present.
2. Confirm duplicate or stale `Send Claim Acknowledgement Letter Ext` rule behavior is not present.
3. Validate the acknowledgment reminder scenario if a lower-environment validation path exists.

Evidence Capture
- Screenshot of the business rule list after replacement.
- Screenshot or note confirming import success.

Rollback / Recovery Context
Release Management owns rollback execution.
- Standard release rollback expected to apply: Unknown.
- Special recovery considerations: The existing business rule is deleted before the replacement import.
- Artifacts needed for recovery: Previous rule export or prior approved `.gwrules` file, if available.
- Escalation contact or team: Data Incomplete.

Related Stories
- None identified.

Timing Constraints
- Delete existing rule before importing replacement.

Open Questions / Data Incomplete
- Whether a backup/export of the existing rule is required before deletion.
- Target environment and admin URL.
- Exact validation scenario or test data.
```

### M26-231

```text
Deployment Type
data_import, batch_multi_story

Target System(s)
PC

Environment(s)
Data Incomplete - target environment not specified.

Runbook Reference
Deployment Notes Standard for Jira Work Items. Future runbook candidate: CASFormPatterns_Ext.xml Load.

Preconditions
- Admin access to PolicyCenter.
- Confirm this story is part of the shared `CASFormPatterns_Ext.xml` deployment set.
- Confirm the final approved `CASFormPatterns_Ext.xml` file owner/coordinator before import.

Deployment Steps
1. Log in to PolicyCenter.
2. Navigate to Administration > Utilities > Import Data.
3. Import `CASFormPatterns_Ext.xml` from `modules/configuration/etc/surepath/pc/configuration/data/default`.
4. Capture the import result.

File(s) / Artifact(s)
| File or artifact | Path or source | Action |
|---|---|---|
| CASFormPatterns_Ext.xml | modules/configuration/etc/surepath/pc/configuration/data/default | Import |

Validation Steps
1. Confirm new form `CA01480326_CAS_Ext` was added.
2. Confirm retired form `CA01480214_CAS_Ext` is retired.

Evidence Capture
- Screenshot or export confirming the form pattern changes.
- Screenshot or import result showing successful import.

Rollback / Recovery Context
Release Management owns rollback execution.
- Standard release rollback expected to apply: Unknown.
- Special recovery considerations: Shared file may include changes for multiple stories.
- Artifacts needed for recovery: Previous approved `CASFormPatterns_Ext.xml` file.
- Escalation contact or team: Data Incomplete.

Related Stories
- Data Incomplete - historical analysis identified multiple CASFormPatterns stories; this issue should link to the coordinator/master story when known.

Timing Constraints
- Data Incomplete - coordinate with other stories sharing the same file.

Open Questions / Data Incomplete
- Which story owns the final shared file.
- Whether this import should happen once for the batch or per story.
- Target environment and admin URL.
```

### MOBPXD-1399

```text
No manual deployment steps required - code-only change deployed through the standard release pipeline.

Open Questions / Data Incomplete
- The historical Deployment Notes value was `NA`. Confirm this is truly code-only and does not require a manual deployment step before leaving the field as no manual deployment required.
```

## Simulated Release Notes Manager Rollup

The same sample set would roll up into these release-level work packages.

| Work package | Source stories | Release-level handling |
|---|---|---|
| Runtime properties / Lexis Nexis properties | `SRNGR-4539` | Confirm environment-specific file and values before import. Requires validation screenshot and property comparison. |
| Producer org / producer code imports | `MR26-3076`, `MR26-2831` | Separate imports unless Release Management confirms shared timing. `MR26-3076` should be treated as a batch/coordinator candidate for `MR26-3076` through `MR26-3082`. |
| Permission and role import with manual pre-step | `M26-788` | Manual permission removal must happen before XML import. Requires role/permission evidence after import. |
| AWS pipeline deployments | `MR26-810`, `MR26-2708` | Group as AWS work, but keep separate work packages because pipeline lists differ and `MR26-810` adds a secret. |
| Business rule replacement | `SMOBL-4073` | Delete existing rule before import. Needs backup/recovery question before deployment. |
| External API migration coordination | `SRNGR-3815` | Confluence-link-only note is not enough for release rollup. Pull key steps or mark as data incomplete. |
| Shared form pattern import | `M26-231` | Candidate for a master/coordinator story because `CASFormPatterns_Ext.xml` is shared across multiple stories. |
| No deployment notes / code-only | `MOBPXD-1399` | Confirm `NA` means no manual deployment steps, then replace with standard no-manual-steps wording. |

## Backtest Findings

| Finding | Severity | Recommendation |
|---|---|---|
| The standard improves weak notes, especially AWS and shared-file cases. | High | Keep the template, but let simple code-only stories use the one-line no-manual-steps wording. |
| The current standard asks for enough data, but generated notes can get long. | Medium | Add shorter pattern-specific snippets after the first pilot run. |
| Runtime properties need a dedicated runbook quickly. | High | Create the Runtime Properties Import runbook before broad rollout. |
| Shared artifact detection is essential. | High | Release Notes Manager should explicitly detect coordinator/master story candidates. |
| Rollback wording is now correctly framed as Release Management-owned context. | High | Keep the current wording; do not revert to developer-owned rollback instructions. |
| Jira API scripts should use `/rest/api/3/search/jql`. | Medium | Update future local test scripts and docs to avoid removed Jira search endpoints. |

## Recommended Next Step

Before the next Confluence publish:

1. Pull 8 to 12 samples through Jira REST.
2. Generate local Jira Work Item Assistant sample notes.
3. Generate a Release Notes Manager rollup.
4. Review with Shane Vandersloot, Hareesh, and Release Management.
5. Publish only after the local report is accepted.
