# Release Drift Monitor Prompt Library

## Scope Drift Review

```text
Compare the supplied planned scope, Jira issue excerpts, branch notes, deployment notes, and release notes for [release name]. Triage drift before recommendations and label all evidence.
```

## Missing Evidence Review

```text
Identify which required release evidence is missing for [release name] and [fixVersion]. Return a short table with evidence label, impact, and one question per missing item.
```

## Drift to Health

```text
Convert these drift signals into the Drift to Health handoff contract. Include severity, readiness question, and any human-owned decision needed.
```

## Notes Candidate Route

```text
From these drift findings, identify only user-facing release-note candidates. Do not draft final notes; produce a Health or Drift to Notes handoff.
```

## Daily Drift Report

```text
Using the supplied current snapshot and prior daily drift report, produce a daily drift report for [release name]. Apply freshness and delta rules, classify findings as New, Still Open, Resolved, Changed, or Data Incomplete, and do not publish or accept exceptions.
```
