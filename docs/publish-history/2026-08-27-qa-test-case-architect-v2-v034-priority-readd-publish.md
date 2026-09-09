# Publish History — QA Test Case Architect v2 v0.34 Priority Re-Add Republish (retroactive record)

| Field | Value |
|---|---|
| Date | 2026-08-27 (approximate — the publish occurred at or near the v0.34 decision date; the exact timestamp was not captured at publish time) |
| Space | ROVO (`csaaig.atlassian.net`) — inferred from the same page family's prior publishes in this history; not independently re-verified for this record |
| Mechanism | Atlassian MCP, used directly from the owner's separate interactive console session — not the governed `scripts/Publish-ConfluencePages.ps1` dry-run/apply flow used for the prior publishes in this history |
| Source | This branch's working-tree state for the v0.34 Priority re-add correction (Runtime Contract, ROVO Studio Configuration, Studio Setup, Evaluation, Knowledge Source Plan, both team overlays, golden-copy XRAY CSV fixture) |
| Approval | Owner instruction, relayed across two sessions: "Yes, I had to add priority back after feedback ... I used them myself," and, on request for confirmation, "Yes, I see them. You can consider my visual as confirmation." |
| Boundary | No Jira, XRAY, or ROVO Studio configuration action. Neither this session nor the reviewing session had a working Atlassian MCP connection; confirmation is the owner's direct visual read of the live Confluence pages, not an MCP read-back. |

## Pages republished

| Slug | Page ID | Version | Verification |
|---|---|---|---|
| qa-test-case-architect-v2-runtime-contract | not captured | not captured | Owner visual confirmation only |
| qa-test-case-architect-v2-rovo-studio-configuration | not captured | not captured | Owner visual confirmation only |
| qa-test-case-architect-v2-studio-setup | not captured | not captured | Owner visual confirmation only |
| qa-test-case-architect-v2-evaluation | not captured | not captured | Owner visual confirmation only |
| qa-test-case-architect-v2-knowledge-source-plan | not captured | not captured | Owner visual confirmation only |
| qa-test-case-architect-v2-team-overlay-payment-ninjas | not captured | not captured | Owner visual confirmation only |
| qa-test-case-architect-v2-team-overlay-breaking-backlogs | not captured | not captured | Owner visual confirmation only |

Page IDs, versions, and exact timestamps are unavailable because no session that authored this record had a working Atlassian MCP connection; the publish was performed and verified entirely in a separate console session outside this record's direct visibility.

## Change published

Re-added the `Priority` column to the XRAY CSV contract (14→15 columns, positioned after `Functionality`, default `Low` unless source evidence indicates otherwise), reversing the v0.29 removal made two days earlier (2026-08-25). Continuation-row leading-blank count corrected back 12→13. Reason: `Priority` is required to close the underlying Jira ticket downstream; v0.29's removal, made on golden-copy/production evidence that Priority wasn't present in real output at the time, is now understood to have broken that downstream close step. See `qa-test-case-architect-v2-change-log.md` v0.34 for the full repo-side decision record.

## Notes

- This record is retroactive and lighter-weight than the usual entry in this history: it was written after the fact from the repo-side session, based on the owner's account and visual confirmation, without direct MCP access to confirm page IDs, versions, or exact publish timestamps.
- A follow-up MCP-verified read-back (from a session with a working Atlassian connection) is recommended to backfill the page ID/version table above, consistent with this history's normal standard of evidence.

## Remaining human-owned

- Backfill page IDs/versions/timestamps once a session with Atlassian MCP access is available.
- QATCA-EVAL-043 (Priority always populated) still needs live/synthetic evaluation evidence, same as the other v0.30–v0.33 rules awaiting evaluation.
