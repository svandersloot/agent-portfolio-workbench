# Release Drift Monitor Pilot Rule Decisions Publish

## Summary

Prepared Release Drift Monitor pilot rule updates for Confluence publication.

## Changes

- Accepted Jira Web Links as fallback evidence while warning when they are the only PR linkage.
- Added adaptive parent Epic scanning rules.
- Introduced the Shared Validation Anchor pattern for complex Epic validation evidence.
- Added Production Defect classification guidance.
- Extended the Release Evidence Ledger schema with optional work classification, shared validation anchor evidence, and discovery route fields.

## Validation

- Parsed `schemas/release-evidence-ledger-record.schema.json`.
- Confirmed `docs/reports/release-drift-monitor-rovo-e2e.csv` still has 14 rows.
- Confirmed updated rule terms are present across Release Drift Monitor governance pages.
