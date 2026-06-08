# Deployment Notes Agent Backtest v2 - 2026-06-08

## Purpose

This v2 report retests the Deployment Notes Standard after Release Management feedback.

Key changes from v1:

- Do not include a routine Environment section in the Jira Deployment Notes field.
- Do not include Evidence Capture in the Jira Deployment Notes field.
- Do not include Rollback / Recovery Context in the Jira Deployment Notes field.
- Move Pre-Deployment / Sequencing Notes above deployment steps.
- Treat runbook references as Confluence/agent context, not a required Jira field.
- Use Source File(s) / Artifact Location bullets to show where release management can find files, repo paths, attached files, pipelines, or linked instructions.
- Keep unresolved questions outside the Jira field draft under `Questions To Resolve Before Finalizing`.
- For AWS pipelines, list the pipelines to deploy. Do not invent ordering; developers should call out order only when it matters.

## Test Method

| Item | Result |
|---|---|
| Standard used | `docs/confluence-pages/deployment-notes-standard.md` |
| Pilot page used | `docs/confluence-pages/deployment-notes-agent-pilot.md` |
| Jira endpoint used | `/rest/api/3/search/jql` |
| Deployment Notes field | `customfield_13450` |
| Agent behavior | Simulated locally from the revised draft instructions |
| Live Rovo execution | Not run in this repo-side test |

## Sample Jira Pull

```text
key in (MR26-3076,MR26-2831,M26-788,SRNGR-4539,MR26-810,MR26-2708,SMOBL-4073,SRNGR-3815,M26-231,MOBPXD-1399)
```

## Simulated Jira Work Item Assistant Output

### MR26-3076

```text
Deployment Type
data_import, batch_multi_story

Pre-Deployment / Sequencing Notes
- Confirm `ProducerOrg_2026.06.01_Org_AdminData.xml` is the approved final file attached to `MR26-3076`.
- Confirm the file covers all producer org setup stories `MR26-3076` through `MR26-3082`.
- `MR26-3076` is the master/coordinator story for the shared import.
- Import is additive.

Target System(s)
PC

Source File(s) / Artifact Location
- File: `ProducerOrg_2026.06.01_Org_AdminData.xml`
- Location: Attached to `MR26-3076`
- Action: Import

Deployment Steps
1. Log in to PolicyCenter.
2. Navigate to Administration > Utilities > Import Data.
3. Import `ProducerOrg_2026.06.01_Org_AdminData.xml`.

Validation Steps
1. Verify these Producer Orgs are present: American Business Insurance Services, CA; Christensen Group Insurance MN; RT Specialty Illinois; Aon Risk Services West, Inc.; MOTER Technologies Inc., CA; Lockton Companies, LLC, CA; HUB International Insurance Services Inc, CA.
2. Confirm no duplicate producer org records were created.

Related Stories
- `MR26-3076` through `MR26-3082`; `MR26-3076` owns the shared import file.

Questions To Resolve Before Finalizing
- None identified for the shared import ownership or additive import behavior.
```

### MR26-2831

```text
Deployment Type
data_import

Pre-Deployment / Sequencing Notes
- Confirm `MR26-2831_Org_AdminData.xml` is attached to this story and is the approved file.
- Use `Aon Risk Services Central, Inc. - New Producer_OrgSetup.xlsx` attached to the story for validation details.

Target System(s)
PC

Source File(s) / Artifact Location
- File: `MR26-2831_Org_AdminData.xml`
- Location: Attached to `MR26-2831`
- Action: Import
- File: `Aon Risk Services Central, Inc. - New Producer_OrgSetup.xlsx`
- Location: Attached to `MR26-2831`
- Action: Validation reference

Deployment Steps
1. Navigate to Administration > Utilities > Import Data.
2. Import `MR26-2831_Org_AdminData.xml`.

Validation Steps
1. Validate that Producer Code `001-0129` is present.
2. Use the attached producer org setup spreadsheet for expected details.

Related Stories
- None identified.

Questions To Resolve Before Finalizing
- Confirm target xCenter if not PolicyCenter.
```

### M26-788

```text
Deployment Type
admin_manual_step, user_role_permission, data_import

Pre-Deployment / Sequencing Notes
- Before importing the file, manually remove `Edit Policy Coverages` and `Edit policies` permissions from Manager and Supervisor roles.

Target System(s)
CC

Source File(s) / Artifact Location
- File: `M26-788_Supervisor_Manager_Roles.xml`
- Location: `modules/configuration/etc/surepath/cc/configuration/data/default`
- Action: Import

Deployment Steps
1. Navigate to Administration > Utilities > Import Data, or the equivalent Guidewire CC import utility.
2. Import `M26-788_Supervisor_Manager_Roles.xml`.

Validation Steps
Data Incomplete - source deployment notes do not provide explicit validation steps.

Related Stories
- None identified.

Questions To Resolve Before Finalizing
- Confirm whether the XML file is committed to the provided configuration path or attached to the Jira issue.
- Confirm the import utility if the standard ClaimCenter admin import path is not correct.
- Provide source-backed validation steps if Release Management needs validation beyond successful import.
```

### SRNGR-4539

```text
Deployment Type
configuration_change

Pre-Deployment / Sequencing Notes
- Import the runtime properties file for the respective region.
- Confirm the correct runtime properties file before import, for example `cc-runtimeproperties-cloud-dev-qa.xml` where applicable.
- Use the attached screenshot as the validation reference.

Target System(s)
CC, Integration Gateway properties

Source File(s) / Artifact Location
- File: Runtime properties file
- Location: Story-specific/runtime properties source; exact file varies by region
- Action: Import
- Artifact: Attached screenshot
- Location: Attached to `SRNGR-4539`
- Action: Validation reference

Deployment Steps
1. Navigate to Administration > Utilities > Runtime Properties import path.
2. Import the correct runtime properties file for the respective region.
3. Delete IG properties:
   - `gw.connect.lexisnexis.police.account.number`
   - `gw.connect.lexisnexis.police.carrier.agency.acct.no`
4. Create the new TPA and non-TPA IG properties listed in the story with the appropriate suffix values.

Validation Steps
1. Navigate to Administration > Utilities > Runtime Properties > LN Police Reports.
2. Validate the highlighted properties match the attached screenshot.
3. Confirm `Account_TPA` is present.

Related Stories
- None identified.

Questions To Resolve Before Finalizing
- Exact runtime properties file per release-management region.
- Confirm whether suffix values `AAA` and `AAB` vary by region.
```

### MR26-810

```text
Deployment Type
aws_pipeline, configuration_change

Pre-Deployment / Sequencing Notes
- Confirm the AWS account and role Release Management should use.
- Add new secret `mobilitas-ccm-csaa-entra` as part of this deployment.

Target System(s)
AWS

Source File(s) / Artifact Location
- Pipeline: `mobilitas-ccm-pipeline-payments-api`
- Location: AWS CodePipeline
- Action: Approve/deploy
- Secret: `mobilitas-ccm-csaa-entra`
- Location: AWS secret
- Action: Add

Deployment Steps
1. Add new secret `mobilitas-ccm-csaa-entra`.
2. Approve and deploy pipeline `mobilitas-ccm-pipeline-payments-api`.

Validation Steps
1. Confirm the pipeline completed successfully.
2. Confirm the secret exists where the pipeline/application expects it.

Related Stories
- None identified.

Questions To Resolve Before Finalizing
- Confirm AWS account and role.
- Confirm whether the secret must be added before pipeline approval.
```

### MR26-2708

```text
Deployment Type
aws_pipeline

Pre-Deployment / Sequencing Notes
- AWS pipelines typically run during deployment.
- No specific order was provided in the source note; run in release-management-approved order unless the developer provides sequencing.

Target System(s)
AWS

Source File(s) / Artifact Location
- Pipeline: `mobilitas-ccm-pipeline-doordash-document-webhook-api`
- Location: AWS CodePipeline
- Action: Approve/deploy
- Pipeline: `mobilitas-ccm-pipeline-uber-document-webhook-api`
- Location: AWS CodePipeline
- Action: Approve/deploy
- Pipeline: `mobilitas-ccm-pipeline-partner-document-process-api`
- Location: AWS CodePipeline
- Action: Approve/deploy

Deployment Steps
1. Approve and deploy `mobilitas-ccm-pipeline-doordash-document-webhook-api`.
2. Approve and deploy `mobilitas-ccm-pipeline-uber-document-webhook-api`.
3. Approve and deploy `mobilitas-ccm-pipeline-partner-document-process-api`.

Validation Steps
1. Confirm all listed pipelines completed successfully.
2. Confirm the applicable document webhook/process APIs support 3gp and 3gpp files after deployment.

Related Stories
- None identified in the sampled issue.

Questions To Resolve Before Finalizing
- Confirm AWS account and role.
- Confirm whether any pipeline order is required.
```

### SMOBL-4073

```text
Deployment Type
business_rule, admin_manual_step

Pre-Deployment / Sequencing Notes
- Before importing the new file, delete existing rule `Send Claim Acknowledgement Letter Ext`.

Target System(s)
CC

Source File(s) / Artifact Location
- File: `ActivityRule-SMOBL-4073_Send_Ack_Letter.gwrules`
- Location: `cc/modules/configuration/config/import/bizrules/mobilitas/custom`
- Action: Import

Deployment Steps
1. Go to cc/admin/business settings/activity rules.
2. Delete existing rule `Send Claim Acknowledgement Letter Ext`.
3. Use the More dropdown to import `ActivityRule-SMOBL-4073_Send_Ack_Letter.gwrules`.

Validation Steps
1. Confirm the replacement activity rule is present.
2. Confirm the acknowledgment letter reminder behavior is corrected.

Related Stories
- None identified.

Questions To Resolve Before Finalizing
- Should the existing rule be exported or backed up before deletion?
- Confirm validation scenario or test data.
```

### SRNGR-3815

```text
Deployment Type
external_dependency

Pre-Deployment / Sequencing Notes
- Follow the linked detailed release instructions for External APIs - Okta to Entra Migration.
- Do not rely on this Jira note alone; the linked page is the authoritative instruction source.

Target System(s)
External API integration

Source File(s) / Artifact Location
- Artifact: Detailed Release Instructions for External APIs - Okta to Entra Migration
- Location: Confluence page linked from `SRNGR-3815`
- Action: Reference

Deployment Steps
1. Open the linked Confluence instructions.
2. Follow the Uber-specific external API migration steps from that page.

Validation Steps
1. Validate the Uber external API migration according to the linked instructions.

Related Stories
- Historical analysis indicates related external migration stories `SRNGR-3815` through `SRNGR-3818`.

Questions To Resolve Before Finalizing
- The Jira field should include a short inline summary of the key required action so the linked page is not the only instruction.
- Confirm any partner/team coordination contact or timing.
```

### M26-231

```text
Deployment Type
data_import, batch_multi_story

Pre-Deployment / Sequencing Notes
- Confirm this story is part of the shared `CASFormPatterns_Ext.xml` deployment set.
- Confirm which story owns the final shared `CASFormPatterns_Ext.xml` file before import.

Target System(s)
PC

Source File(s) / Artifact Location
- File: `CASFormPatterns_Ext.xml`
- Location: `modules/configuration/etc/surepath/pc/configuration/data/default`
- Action: Import

Deployment Steps
1. Load/import `CASFormPatterns_Ext.xml`.

Validation Steps
1. Confirm new form `CA01480326_CAS_Ext` was added.
2. Confirm retired form `CA01480214_CAS_Ext` is retired.

Related Stories
- Data Incomplete - historical analysis identified multiple `CASFormPatterns_Ext.xml` stories. Link the coordinator/master story when known.

Questions To Resolve Before Finalizing
- Which story owns the final shared file?
- Should this import happen once for the batch rather than once per story?
```

### MOBPXD-1399

Deployment Notes Field Draft

Not required. Do not add text to the Deployment Notes field unless a manual deployment action is identified.

Questions To Resolve Before Finalizing
- Historical Deployment Notes value was `NA`. Confirm there are truly no manual deployment steps before leaving the field empty.

## Simulated Release Notes Manager Rollup

| Work package | Source stories | Release-level handling |
|---|---|---|
| Runtime properties / Lexis Nexis properties | `SRNGR-4539` | Confirm correct region-specific runtime properties file and validation screenshot reference. |
| Producer org / producer code imports | `MR26-3076`, `MR26-2831` | Separate imports unless Release Management confirms shared timing. `MR26-3076` is the coordinator story for the shared producer org import covering `MR26-3076` through `MR26-3082`; import is additive. |
| Permission and role import with manual pre-step | `M26-788` | Manual permission removal must happen before XML import. This precondition should remain above import steps. |
| AWS pipeline deployments | `MR26-810`, `MR26-2708` | Group as AWS work, but keep separate work packages because pipeline lists differ and `MR26-810` includes a secret. Pipelines can run during deployment unless source notes specify order. |
| Business rule replacement | `SMOBL-4073` | Delete existing rule before import. Ask whether backup/export is needed before deletion. |
| External API migration coordination | `SRNGR-3815` | Confluence-link-only note should include a short inline summary or remain data incomplete. |
| Shared form pattern import | `M26-231` | Candidate for master/coordinator story because `CASFormPatterns_Ext.xml` is shared across multiple stories. |
| No deployment notes / code-only | `MOBPXD-1399` | Keep outside deployment work packages when no manual action is found. Do not add `NA` or no-action placeholder text to the Jira Deployment Notes field. |

## Backtest Findings

| Finding | Severity | Recommendation |
|---|---|---|
| Removing routine Environment, Evidence Capture, and Rollback / Recovery makes the Jira field much more usable. | High | Keep those topics out of story-level Deployment Notes unless a separate process asks for them. |
| Pre-Deployment / Sequencing Notes should stay near the top. | High | This prevents cases like `M26-788` and `SMOBL-4073` from being executed in the wrong order. |
| Source File(s) / Artifact Location is clearer than Runbook Reference for Jira. | High | Keep runbooks in Confluence/agent context and use the Jira field to show where files, pipelines, or linked instructions live. |
| Jira field output should avoid Markdown tables. | High | Use bullets because the Jira/plugin rendering path does not handle tables reliably. |
| AWS notes should avoid invented order. | Medium | State when no specific order was provided and let Release Management use normal deployment sequencing. |
| A no-action explanation is useful outside the Jira field. | Medium | Explain why Deployment Notes are not required in the agent response or review notes, but do not write `NA` or no-action placeholder text into the Jira Deployment Notes field. |

## Recommended Next Step

Publish the revised standard after review, then run these same prompts in Jira Work Item Assistant and Release Notes Manager to compare live Rovo output against this local expected behavior.
