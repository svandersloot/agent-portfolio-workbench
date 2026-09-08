# Running a Manual Release Assessment

Use this page to run a Release Health Analyst assessment on demand, outside of the scheduled automation. See [Release Health Automation Setup](release-health-analyst-user-guide-automation-setup.md) for the scheduled version of this same workflow.

## Step-By-Step Checklist

- [ ] **1. Navigate to the release Confluence page.** Open the release-specific page (for example, the current release's home page) so the agent has release context available.
- [ ] **2. Launch Release Health Analyst.** Open the agent from that page, or start a fresh conversation and paste the release page link. Launching from the release page lets the agent pick it up as priority context.
- [ ] **3. Verify the fixed version selection.** The agent may infer the fixVersion from the page context or a prior run. Cross-check it against the team's Release filter/JQL (for example, the "Release Story Cards All" filter) before proceeding. If the agent proposes the wrong version, correct it explicitly — do not let an inferred value pass unverified.
- [ ] **4. Review the generated health assessment.** Read the Executive Summary and Issue Classification first.
- [ ] **5. Validate release metadata.** Confirm the code freeze date, release stage, and source-truth branch shown in the Assessment Fingerprint are correct for this release.
- [ ] **6. Review identified risks and blockers.** Read the P1 Blockers and P2/P3 Risks sections; confirm each cited evidence link actually supports the finding.
- [ ] **7. Review the release owner questions.** These are the specific things a human needs to answer or confirm before the final decision.
- [ ] **8. Review the recommendations.** Confirm each recommendation is evidence-backed and assigned to a plausible owner.
- [ ] **9. Create the assessment page.** Ask the agent to create the page; review the preview it shows before confirming.
- [ ] **10. Publish the assessment.** Confirm explicitly when prompted. Specify that the page should be created **as a child page** of the canonical assessment location to reduce the chance it lands at the bottom of the space instead of nested where it belongs.

> **Important:** Steps 9 and 10 require explicit human confirmation by design — the agent will show a preview and wait. Do not treat a drafted page as published until you have confirmed it.

## Expected Outputs

| Section | What you should see |
| --- | --- |
| Assessment Fingerprint | Run date/time, release identity, release stage, code freeze date, source-truth branch, evidence sources, and P1/P2-P3/exception/unknown counts. |
| Executive Summary | One of `Ready with caveats`, `At risk`, `Blocked`, or `Unknown / Data Incomplete`, with a plain-language reason. |
| Issue Classification | P1-P5 counts with key issue references. |
| P1 Blockers | Active blockers only, or an explicit `None identified from current evidence`. |
| Questions For Release Owner | Only the questions needed for the human decision — not a dump of every open item. |
| Next Assessment Instructions | What evidence to add before the next rerun. |

Full section-by-section detail is in [Understanding the Assessment Output](release-health-analyst-user-guide-assessment-output.md).

## Validation Guidance

> **Important:** Never accept an inferred fixed version without checking it against the Release filter. A wrong fixVersion silently invalidates the entire assessment.

> **Recommendation:** Run a preview assessment about one week before code freeze in addition to the code-freeze-day run, to surface likely carryover early.

> **Caveat:** If the page is not created as a child of the intended parent, you may need to manually drag it into place afterward. See [Troubleshooting Guide](release-health-analyst-user-guide-troubleshooting.md#page-published-in-unexpected-location).

## Feedback and Improvement Opportunities

Please submit agent improvement suggestions, false positives, missing findings, new reporting requirements, and automation enhancement ideas to the [Continuous Improvement Backlog](release-health-analyst-user-guide-improvement-backlog.md).
