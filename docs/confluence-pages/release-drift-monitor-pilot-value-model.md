# Release Drift Monitor Pilot Value Model

## Purpose

Release Drift Monitor is being piloted to make missing or conflicting release evidence visible earlier in the release cycle.

The goal is not to punish teams for incomplete evidence. The goal is to make missing evidence visible early enough that teams can fix it while there is still time.

Early pilot runs may look noisy. That is expected. The first runs create a baseline for story hygiene, source completeness, branch evidence, QA evidence, and accepted-exception documentation. As teams see the same evidence gaps earlier and more consistently, the release record should become cleaner over time.

## What This Pilot Is Testing

| Question | What We Want To Learn |
|---|---|
| Can release evidence gaps be found before code freeze? | Whether Jira, branch, PR, test, QA, and Confluence evidence gaps can be identified while teams can still correct them. |
| Are findings actionable? | Whether the pulse points to a clear owner, source gap, or next action instead of producing broad noise. |
| Does the trend improve? | Whether repeated pulses reduce unresolved `WARN`, `BLOCK`, and `UNKNOWN` items before code freeze. |
| Does the handoff help Release Health Analyst? | Whether the code-freeze handoff creates a cleaner intake for final readiness assessment. |
| Which checks are too noisy? | Which rules need better team mapping, better accepted-exception handling, or removal from the pilot. |

## What The Monitor Looks For

Release Drift Monitor compares release scope against available source evidence. It focuses on drift between what the release appears to contain and what the evidence proves.

| Evidence Area | Example Drift Signal |
|---|---|
| Jira scope | Items are in the target fixVersion but status, owner, or release impact is unclear. |
| Code evidence | A code-required item lacks branch, PR, merge, or commit evidence. |
| Source-truth branch | Code evidence exists but appears to target the wrong branch for the release stage. |
| QA and testing | Test-required work lacks accepted test evidence, QA run evidence, or validation notes. |
| Deployment and change | Release-impacting work lacks deployment, rollback, or change evidence where expected. |
| Accepted exceptions | A risk is being treated as accepted, but the accepting owner, residual risk, or revisit condition is unclear. |
| Source freshness | Evidence exists but may be stale, inaccessible, or not current enough for the release stage. |

The monitor uses `PASS`, `WARN`, `BLOCK`, and `UNKNOWN` as evidence states. These are not final release decisions.

## How To Interpret A Noisy First Run

A noisy first run does not mean the release process failed.

It means the pilot found places where release evidence is not yet easy to verify. That may include missing Jira comments, incomplete QA links, branch ambiguity, incomplete PR evidence, stale Confluence pages, or undocumented accepted exceptions.

For the pilot, noise is useful when it helps answer:

- Which evidence gaps are common?
- Which findings are real risks?
- Which findings are false positives caused by missing source mapping?
- Which team practices should be documented better?
- Which checks should be tightened, softened, or removed?

The first release may require more coaching because not everyone knows what evidence the monitor expects. Later releases should get cleaner if teams start updating stories, QA evidence, branch references, and accepted-exception notes earlier.

## How Teams Should Respond

When a drift pulse flags an item, teams should update the source system rather than only explaining the issue in chat.

| Finding Type | Preferred Response |
|---|---|
| Missing Jira evidence | Add a clear Jira comment, field update, or link that explains the release state. |
| Missing PR or branch evidence | Link the PR, branch, commit, or documented no-code reason. |
| Missing QA evidence | Link the test plan, QA run, validation page, or approved testing note. |
| Accepted exception unclear | Record who accepted it, why, residual risk, and when it should be revisited. |
| False positive | Identify the source mapping gap so the pilot rule can be adjusted. |
| `UNKNOWN` source | Clarify access, freshness, or source ownership. |

The best outcome is not a perfect pulse. The best outcome is a pulse that causes the right source record to become clearer before code freeze.

## How This Helps Release Health Analyst

Release Drift Monitor owns the pre-freeze evidence drift story. Release Health Analyst owns final readiness support.

The clean handoff point is code freeze:

```text
Daily Release Drift pulses
-> Code-freeze Release Drift Handoff
-> Initial Release Health Analyst assessment
-> Release Health Analyst reruns
```

At code freeze, the Release Drift Handoff should summarize:

- exact release identity,
- source-truth branch,
- unresolved `BLOCK`, `WARN`, and `UNKNOWN` findings,
- accepted exceptions,
- trend history,
- source freshness,
- source completeness gaps,
- evidence that improved before freeze.

Release Health Analyst should use that handoff as source evidence for the initial readiness assessment. After that, Release Health Analyst owns the post-freeze readiness record and should treat the handoff as code-freeze baseline evidence, not as a replacement for newer Jira, QA, deployment, release-note, owner, or Confluence evidence.

## Signals Of Improvement

The pilot is working if later pulses show fewer unresolved evidence gaps and fewer late surprises.

| Signal | Why It Matters |
|---|---|
| `UNKNOWN` count decreases before code freeze | Source access, freshness, and evidence ownership are getting clearer. |
| Missing QA evidence is closed earlier | QA readiness is visible before final release review. |
| Branch or PR ambiguity is resolved earlier | Code readiness can be checked before freeze pressure. |
| Accepted exceptions become explicit | Human-owned caveats are visible instead of implied. |
| Carryover risks are visible across pulses | Release owners can tell whether risk is improving or stagnating. |
| New blockers are found before code freeze | Teams have time to fix, defer, or document the issue. |
| Release Health Analyst starts with cleaner evidence | Final readiness assessment spends less time reconstructing history. |

## Example Pilot Metrics

| Metric | How To Use It |
|---|---|
| Total `WARN`, `BLOCK`, and `UNKNOWN` count by pulse | Shows whether evidence quality is improving or worsening. |
| Count of unresolved `UNKNOWN` items at handoff | Measures remaining source incompleteness at code freeze. |
| Missing QA evidence closed before freeze | Shows whether the pulse helped move validation evidence earlier. |
| Branch or PR ambiguity resolved before freeze | Shows whether code evidence became easier to verify. |
| Accepted exceptions documented before readiness review | Shows whether human-owned caveats are explicit. |
| Findings first discovered before freeze instead of during final approval | Shows whether the monitor reduced late surprises. |
| False-positive themes | Shows which checks need tuning before broader rollout. |

## What This Is Not

Release Drift Monitor is not:

- a final go/no-go decision maker,
- a replacement for release owner judgment,
- a replacement for QA signoff,
- a tool for Jira transitions, PR approvals, merges, or deployment approvals,
- a reason to treat every warning as a blocker,
- a real-time alerting system before pilot thresholds are trusted.

## Pilot Communication Guidance

Use this language when explaining the pilot:

```text
We are using Release Drift Monitor to make release evidence gaps visible earlier. Early runs may be noisy because teams are still learning what evidence needs to be documented and where. The goal is to improve release evidence before code freeze, not to punish teams. Over time, we expect the drift pulses and code-freeze handoff to become cleaner as story, QA, branch, PR, and accepted-exception evidence improves.
```

## Review Questions

- Which findings helped a team fix or document something before code freeze?
- Which findings were noisy or unactionable?
- Which source gaps should become team guidance?
- Which evidence should be required before code freeze?
- Did the Release Drift Handoff make the Release Health Analyst assessment easier to create?
- Did any risk get caught earlier than it would have without the monitor?
