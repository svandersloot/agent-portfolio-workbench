# Publish History - Release Health Analyst Automation Workflow Prep

## Summary

| Field | Value |
|---|---|
| Date | 2026-06-02 |
| Workflow | Release Health Analyst Confluence Automation |
| Release focus | Mobilitas 2026.06.12 first-run draft workflow; Mobilitas 2026.07.10 drift-evidence-ready variant |
| Studio writes | None |
| Confluence Automation writes | None from Codex |
| Jira writes | None |
| Raw automation exports committed | None |

## Prepared Artifacts

| Artifact | Purpose |
|---|---|
| `docs/reports/release-health-analyst-automation-workflow-setup-2026-06-02.md` | Human setup guide for the manual first-run rule, first-run confirmation checklist, July-ready variant, and export handling. |
| `docs/reports/release-health-analyst-automation-rule-sanitized-template-2026-06-02.json` | Commit-safe sanitized target shape for a future exported Confluence Automation rule. |
| `docs/reports/release-health-analyst-automation-rule-sanitized-2026-06-02.json` | Sanitized capture of the exported June Release Health Analyst Confluence Automation rule. |

## Decisions Captured

- Use a manual trigger from the current June assessment page for the first Release Health Analyst automation run.
- Keep the Release Health Analyst Rovo agent write-disabled with `allowAgentToExecuteActions` false.
- Use deterministic Confluence Automation `Publish new page` to create the draft child page.
- Use `{{agentResponse}}` as the page body smart value.
- Keep the canonical assessment page human-curated; the automation creates a child draft for review.
- Prepare a July variant that can consume Release Drift Monitor output as source evidence only after verifying release identity, branch, source freshness, unresolved `BLOCK`/`WARN`/`UNKNOWN` findings, and accepted exceptions.
- Do not commit raw Confluence Automation exports. Commit only sanitized captures with live Atlassian IDs, ARIs, private URLs, page IDs, space IDs, rule IDs, component IDs, connection IDs, and checksums redacted.

## Export Capture

Captured and sanitized `Release_Health_Analyst_June_Automation.json` from the user's Downloads folder. The raw export was not copied into the repo.

Sanitized export findings:

- Rule name: `June '26 Release Health`.
- Rule state: `ENABLED`.
- Trigger: scheduled.
- Agent action: `Release Health Analyst v2`.
- Agent write execution: disabled (`allowAgentToExecuteActions` false).
- Publish action: creates a child page under `Release Health Analyst Assessment: Mobilitas 2026.06.12 v2`.
- Page body uses `{{agentResponse}}`.
- Prompt includes carryover versus new-scope classification instructions.
- Prompt prohibits Confluence edits/appends/creates/updates by the agent.
- Prompt keeps final readiness human-owned.

Schedule note:

- The export contains both `cronExpression` and `rRule` schedule representations.
- The RRULE indicates daily 11:00 America/Phoenix through `2026-06-23`.
- The exported cron expression is not identical to the RRULE representation, so the Confluence UI-displayed schedule should be treated as authoritative after every schedule edit.

## Validation

- The setup guide was derived from the handoff packet, Release Health Analyst Studio configuration, assessment template, prompt library, remediation plan, and sanitized Release Drift Monitor automation reference.
- Sanitized JSON template validation command:

```powershell
python -m json.tool docs\reports\release-health-analyst-automation-rule-sanitized-template-2026-06-02.json
```

- Sanitized exported-rule validation command:

```powershell
python -m json.tool docs\reports\release-health-analyst-automation-rule-sanitized-2026-06-02.json
```

- Raw export scan command:

```powershell
rg --files --no-ignore -g "automation-rule-*.json"
```

## Remaining Live Verification

The first-run workflow is not complete until the live Confluence Automation run proves:

- The rule contains only the intended manual trigger, `Use agent`, and `Publish new page` steps.
- The agent action keeps write execution disabled.
- The parent page is the current June Mobilitas Release Health Analyst assessment page.
- The run creates a child draft page.
- The parent page version does not change during the automation run.
- The child page contains a complete copy-ready Release Health Analyst assessment.
