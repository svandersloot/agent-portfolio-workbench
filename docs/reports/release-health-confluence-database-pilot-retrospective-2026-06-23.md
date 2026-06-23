# Release Health Confluence Database Pilot Retrospective

## Summary

On 2026-06-23, a short pilot tested whether a Confluence database could act as the structured store and dashboard source for release health snapshots.

Decision: stop this path. Keep the learning, remove the live Confluence experiment pages/database views as needed, and do not carry the implementation artifacts forward.

## What Worked

- CSV import into a Confluence database was fast enough for a manual seed.
- Saved database views could represent basic slices such as current state, at-risk rows, recent snapshots, trend, and needs-review queue.
- The release-health snapshot concept still appears useful as structured data.

## What Did Not Work

- Confluence database views did not become a clean dashboard data layer.
- Embedding saved database views into a normal Confluence dashboard page was clunky and not reliably automatable through the existing page publisher.
- Saved-view links were technically possible but not useful enough for release-manager consumption.
- The setup created too much manual surface area for the value returned.

## Decision

Do not use Confluence databases as the primary release health dashboard/store for this workflow.

If release health snapshots need structured history later, prefer a small SQLite/Postgres-backed store with a real dashboard surface, while Confluence remains the narrative/status layer.

## Follow-Up

- Remove or archive the experimental Confluence database/dashboard pages manually.
- Do not merge the `shaynevandersloot/release-health-data-store` implementation branch as-is.
- Revisit release health structured storage only after there is a clear consumer workflow, dashboard requirement, and owner for operational upkeep.
