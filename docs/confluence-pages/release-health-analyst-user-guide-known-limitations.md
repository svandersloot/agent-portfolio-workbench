# Known Limitations and Caveats

This page is the honest accounting of what Release Health Analyst cannot do today, so users calibrate trust correctly. Update it as limitations are resolved or new ones are found.

## Current Platform Limitations

> **Caveat:** Confluence/Jira visibility boundaries. The agent can only see what the invoking user can see, and its knowledge is deliberately scoped rather than given broad Confluence/Jira access, to reduce hallucination risk. If a relevant page or ticket sits outside that scope, the agent will not know it exists.

> **Caveat:** Reliance on available source data. The agent cannot infer information that isn't written down anywhere it can read. See [Best Practices](release-health-analyst-user-guide-best-practices.md).

> **Caveat:** Update limitations when modifying existing pages. The agent is not yet reliable at editing an existing Confluence page in place; the current pattern is a new child page per run, relying on the Snapshot Log/Fingerprint to preserve continuity instead of in-place edits.

> **Caveat:** Dependence on linked evidence. A claim without a link (a comment saying "tested" with no test-run reference, for example) will be treated as a source-completeness gap, not a pass.

## Integration Limitations

> **Caveat:** Bitbucket visibility constraints. There is currently no direct connection from ROVO to Bitbucket. Because this program's code lives in an externally hosted (Guidewire) Bitbucket instance, a future connector may still not resolve full visibility.

> **Recommendation:** Workaround — have developers reference the PR or commit in the Jira ticket or subtask comment history. The agent can read that evidence even without direct Bitbucket access.

> **Caveat:** Need for PR references in ticket comments. Without this workaround, code evidence will show as a source-completeness gap even when the work was actually done and merged.

> **Caveat:** Need for linked evidence from development and QA processes. An Xray/QA connector is not yet in place; QA evidence must be linked manually in ticket comments in the meantime.

## Operational Caveats

> **Important:** Human validation is required for every assessment. Findings should be reviewed and confirmed before being acted on or repeated to stakeholders.

> **Caveat:** Release drift monitoring (detecting unauthorized changes or missing merges against the source-truth branch) is still being proven out and should be treated as an early-stage capability, not a fully validated safeguard.

## Future Enhancement

> **Future Enhancement:** Reliable in-place page editing, so reruns can update the canonical assessment page directly instead of accumulating child pages.

> **Future Enhancement:** Direct Bitbucket and Xray connectors to reduce dependence on manually linked evidence in ticket comments.

> **Future Enhancement:** More consistent trend-table maintenance across reruns (see [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md) for the open item).

## Feedback and Improvement Opportunities

Please submit agent improvement suggestions, false positives, missing findings, new reporting requirements, and automation enhancement ideas to the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md).
