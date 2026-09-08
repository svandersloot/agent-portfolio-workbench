# Handoff - QA Test Adequacy Critic Publish + Enhancement Plan Continuation - 2026-08-25

Use this packet to start a fresh conversation continuing the QA Test Case Architect v2 enhancement work. The immediate task is publishing the new QA Test Adequacy Critic agent family to Confluence via the Atlassian MCP connector, then continuing the rest of the approved enhancement plan. Keep the work dry-run-first for any live-system action; do not write to Jira, XRAY, or ROVO Studio.

## Start Here Prompt

```text
We are continuing QA Test Case Architect v2 (QATCA v2) enhancement work in the Agent Portfolio Workbench.

Current branch: shaynevandersloot/qa-test-adequacy-critic-agent (uncommitted changes — check git status first).

Context:
- A large enhancement plan was approved on 2026-08-25, covering a new ISTQB-aligned "QA Test Adequacy Critic"
  agent (P1), product/state coverage rules for QATCA v2 (P1), a ticket-pack-removal + search-scope rewrite (P2),
  a governance-scope update for real Jira/XRAY usage by named teams (P2), a team-overlay CSV-column confirmation
  step (P2), an XRAY schema correction reversing v0.17's Priority column (P2), and confirmed assignee-handling
  guidance (P3). The full plan with all decisions is saved at:
  C:\Users\guhxbol\.claude\plans\wild-mapping-adleman.md — read this first, it is the source of truth for
  what was decided and why.

What's done so far (slice 1 of the plan, uncommitted on the current branch):
- New pages:
  - docs/confluence-pages/qa-test-adequacy-critic-project-brain.md
  - docs/confluence-pages/qa-test-adequacy-critic-agent-design-record.md
  - docs/confluence-pages/qa-test-adequacy-critic-runtime-contract.md
  - docs/confluence-pages/qa-test-adequacy-critic-rovo-studio-configuration.md
  - docs/confluence-pages/qa-test-adequacy-critic-studio-setup.md
  - docs/confluence-pages/qa-test-adequacy-critic-subagent-settings.md
  - docs/confluence-pages/qa-test-adequacy-critic-evaluation.md
  - docs/confluence-pages/qa-test-adequacy-critic-change-log.md
- Manifest entries added to config/confluence-pages.example.yml for the new family.
- agent-inventory.md: added inventory row + reuse-check bullet for QA Test Adequacy Critic.
- QATCA v2 side (minimal, routing only): one new Routing Rules row in
  docs/confluence-pages/qa-test-case-architect-v2-runtime-contract.md, a hand-off note in
  docs/confluence-pages/qa-test-case-architect-v2-subagent-settings.md, and a new v0.28 change-log row in
  docs/confluence-pages/qa-test-case-architect-v2-change-log.md.
- Validation already run and clean: git status --short, git diff --check, Test-ConfluencePageFamilyConsistency.ps1
  (0 errors, 2 expected warnings — no Knowledge Source Plan / Measurement Plan for the new agent yet, logged as
  open gates in its own change log), Test-PrivateDataScan.ps1 (0 findings).
- Owner manually reviewed and approved this slice's content and asked to publish it to live Confluence.

Immediate blocker to resolve first:
- Publishing needs either (a) the Atlassian MCP connector's tools available in this session, or (b) the private
  .env + config/confluence-pages.yml files (not tracked in git) present locally for the PowerShell fallback
  (scripts/Publish-ConfluencePages.ps1). Neither was available in the prior session. The owner connected the
  Atlassian MCP server in a separate terminal ("atlassian - connected - 40 tools") but the VSCode-extension
  session did not pick it up — MCP state did not carry over without a restart. This new session should have
  picked up the current MCP state on launch.

First action in this new session:
1. Use ToolSearch (query like "+atlassian confluence create page") to confirm the Atlassian MCP tools are now
   visible. If yes, proceed to a focused dry-run before any write, per AGENTS.md's Confluence live-system
   boundary (dry-run + explicit approval required for every publish/update/move/archive action).
2. If the MCP tools still aren't visible, tell the owner plainly rather than falling back silently — the
   PowerShell path still needs the private .env/config files, which were not present as of this handoff.
3. Confirm the publish placement for the new agent family before creating live pages: the plan recommends the
   same Confluence parent used for QATCA v2 / QA Test Strategy Planner ("Agent Project Brains > QA and Testing
   Agents"), but this was still flagged open pending explicit confirmation in the plan file.
4. Publish is page-by-page, dry-run first, then apply only with explicit per-action approval — do not batch-apply
   without checking in given this creates 8 new live pages plus edits to 3 existing QATCA v2 pages.

After publish is resolved, the plan's remaining sequence (§11 in the plan file, using the plan's own section
numbers) continues with:
- §2: product/state coverage instruction update to QATCA v2 (one test per product/state/variant combination).
- §3 + §10: the ticket-pack-removal/search-scope rewrite bundled with the XRAY schema correction (removes the
  Priority column, reverses v0.17; simplifies the deterministic ID fallback; refines search scope to home
  project + one linked-project hop + Confluence, using epic rollup as the relatedness signal).
- §4: governance-scope record update (approved real-usage teams: Payment Ninjas/PN, Breaking Backlogs/BB26,
  404 Errors/FOURFOUR26; evaluation stays synthetic-only).
- §5: team-overlay CSV-column confirmation step (confirm 14 columns; log requested additions as a governance
  change request rather than deviating on the spot).
- §6: assignee handling — already confirmed as drafted, no further change needed.
- §7.3: BB26 team overlay — still blocked on sourcing two Confluence pages
  (wiki/spaces/BB1/overview and wiki/spaces/MO/.../Team+Standards+Breaking+Backlogs+BB26); now that the
  Atlassian MCP may be connected, this may be unblocked — check first.
- §7.4-§7.6: F9 production-conflict policy, EVAL-031 source isolation, and pilot-survey-template tightening.

Also still pending, separate from the plan: committing this slice's changes (git commit was not yet requested
by the owner as of this handoff — confirm before committing) and deciding whether/when to record the governance
drift noted in the plan's §0/§4 (real Jira IDs and live Xray imports observed in the pilot survey, dated after
the 2026-07-21 Controlled QA checkpoint).
```

## Key Files To Read First (in the new session)

- `AGENTS.md`, `CLAUDE.md`
- `C:\Users\guhxbol\.claude\plans\wild-mapping-adleman.md` (the full approved plan — authoritative)
- `docs/confluence-pages/qa-test-case-architect-v2-change-log.md` (v0.27, v0.28 rows)
- `docs/confluence-pages/qa-test-adequacy-critic-change-log.md` (v0.1 row and pending gates)
- `docs/reports/atlassian-mcp-integration-2026-07-09.md` (if it documents the Atlassian MCP connector setup/scope)

## Do Not

- Do not claim a Confluence publish happened unless a dry-run and an explicit `-Apply` (or MCP write) actually ran and was verified.
- Do not commit repo changes unless the owner explicitly asks.
- Do not write to Jira, XRAY, or ROVO Studio from this workbench.
- Do not batch-publish all 8 new pages plus 3 edits without a per-page or per-batch check-in, given this is the first live publish of a brand-new agent family.
