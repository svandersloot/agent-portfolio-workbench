# Owner And Readiness Gap Report Template

Use this template when checking whether governed agents are transferable, pilot-ready, or safe to promote. The report is field-level and evidence-based; it does not calculate percentage completeness.

## Scope

- Review date: `YYYY-MM-DD`
- Reviewer:
- Source inputs:
  - `docs/agent-governance-completeness-contract.md`
  - `schemas/agent-governance-record.schema.json`
  - `docs/confluence-pages/agent-inventory.md`
  - Relevant `docs/confluence-pages/*-project-brain.md`
  - Relevant setup, Studio configuration, knowledge source, evaluation, measurement, and change-log pages
  - Relevant safe reports under `docs/reports/`

## Summary

| Agent | Lifecycle status evidence | Readiness evidence | Missing fields | Next owner action |
|---|---|---|---|---|
| `<agent name>` | `<status and source>` | `<Ready, Needs Cleanup, Not Ready, or unknown with source>` | `<field names only>` | `<smallest accountable next step>` |

## Field-Level Review

| Agent | Field | Status | Evidence | Gap note | Remediation owner |
|---|---|---|---|---|---|
| `<agent name>` | Primary owner | Present / Missing / Unknown | `<file and section>` | `<what is missing>` | `<person or team>` |
| `<agent name>` | Backup owner | Present / Missing / Unknown | `<file and section>` | `<what is missing>` | `<person or team>` |
| `<agent name>` | Lifecycle status | Present / Missing / Unknown | `<file and section>` | `<what is missing>` | `<person or team>` |
| `<agent name>` | Purpose | Present / Missing / Unknown | `<file and section>` | `<what is missing>` | `<person or team>` |
| `<agent name>` | Audience | Present / Missing / Unknown | `<file and section>` | `<what is missing>` | `<person or team>` |
| `<agent name>` | Knowledge sources | Present / Missing / Unknown | `<file and section>` | `<what is missing>` | `<person or team>` |
| `<agent name>` | Tools or skills | Present / Missing / Unknown | `<file and section>` | `<what is missing>` | `<person or team>` |
| `<agent name>` | Measurement plan | Present / Missing / Unknown | `<file and section>` | `<what is missing>` | `<person or team>` |
| `<agent name>` | Readiness status | Present / Missing / Unknown | `<file and section>` | `<what is missing>` | `<person or team>` |
| `<agent name>` | Project Brain link | Present / Missing / Unknown | `<file and section>` | `<what is missing>` | `<person or team>` |
| `<agent name>` | Last-reviewed date | Present / Missing / Unknown | `<file and section>` | `<what is missing>` | `<person or team>` |

## Promotion Gate Notes

| Agent | Gate | Evidence | Decision | Follow-up |
|---|---|---|---|---|
| `<agent name>` | Draft to In Review | `<source>` | Proceed / Hold | `<reason and owner>` |
| `<agent name>` | In Review to Experimental | `<source>` | Proceed / Hold | `<reason and owner>` |
| `<agent name>` | Experimental to Active | `<source>` | Proceed / Hold | `<reason and owner>` |

## Rules

- Treat `Unknown` as a report limitation, not proof that the field is absent from Confluence or Studio.
- Treat missing backup owner, missing measurement plan, missing readiness evidence, or missing last-reviewed date as transferability gaps.
- Do not mark an agent `Ready` based only on a Project Brain title or an old handoff.
- Keep private config, raw captures, HARs, cookies, headers, tokens, and unsanitized exports out of the report.
