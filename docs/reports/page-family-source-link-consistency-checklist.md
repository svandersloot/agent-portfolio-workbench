# Page-Family And Source-Link Consistency Checklist

Use this checklist before publishing, committing, or handing off governed-agent Confluence source pages. Prefer the script for mechanical checks, then use the manual checks for evidence that requires judgment.

## Mechanical Check

```powershell
.\scripts\Test-ConfluencePageFamilyConsistency.ps1
```

The script is read-only and checks:

- Manifest entries in `config/confluence-pages.example.yml` have existing `sourcePath` files.
- Source paths are unique.
- Source paths follow the `docs/confluence-pages/<slug>.md` convention.
- `parentSlug` values refer to another manifest slug.
- Confluence source files under `docs/confluence-pages/` are not accidentally omitted from the manifest.
- Each Project Brain family has linked child artifacts for design record, knowledge source plan, runtime settings, setup or ROVO Studio configuration, evaluation, measurement plan, and change log.

## Manual Evidence Check

| Check | Evidence to inspect | Pass condition | Gap handling |
|---|---|---|---|
| Project Brain source | `*-project-brain.md` and manifest entry | Project Brain has a manifest slug, source file, and `project-brain` label or `*-project-brain` slug. | Add the manifest entry or explain why the page is not a governed Project Brain. |
| Setup link | `*-studio-setup.md`, `*-rovo-studio-configuration.md`, or equivalent child page | Setup/config page is linked under the Project Brain or explicitly named as not applicable. | Add the child page or record the missing setup page in the owner/readiness gap report. |
| Runtime link | `*-subagent-settings.md`, prompt library, handoff template, or runtime equivalent | Runtime behavior source is linked from the Project Brain family. | Add the missing child link or document why runtime configuration lives elsewhere. |
| Knowledge link | `*-knowledge-source-plan.md` | Approved sources, permission notes, and freshness expectations are visible. | Add a knowledge source plan or keep the agent out of Ready/Active status. |
| Evaluation link | `*-evaluation.md` or current report | Evaluation prompts, expected behavior, and pass/fail notes are discoverable. | Add evaluation evidence before pilot or broad visibility. |
| Measurement link | `*-measurement-plan.md` or pilot tracking plan | Value signal, quality or risk signal, and cadence are visible. | Add measurement plan or mark readiness as `Needs Cleanup` or `Not Ready`. |
| Change log link | `*-change-log.md` or publish-history record | Material source, Studio, or Confluence changes have reviewable history. | Add or update the change log before handoff. |
| Source-link drift | Manifest `sourcePath`, page title, and markdown heading | Slug, title, source path, and first heading describe the same artifact. | Fix the drift before publishing; avoid changing live page IDs unless a focused plan says so. |
| Forbidden substitute gap | Project Brain, setup, knowledge, evaluation, or measurement page | A report, handoff, or raw capture is not treated as the only durable source for a governed artifact. | Promote sanitized durable content into the appropriate source page. |

## Report Output Shape

When recording results in a handoff or report, list findings as fields:

| Family | Missing or drifting field | Evidence | Recommended next action |
|---|---|---|---|
| `<project-brain-slug>` | `<field or artifact>` | `<file, manifest entry, or absence>` | `<smallest safe fix>` |

Do not use percentage completeness scoring. Missing field names and evidence are more useful for transfer and audit.
