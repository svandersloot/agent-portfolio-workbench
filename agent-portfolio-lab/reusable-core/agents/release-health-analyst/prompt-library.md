# Release Health Analyst Prompt Library

## Readiness Snapshot

```text
Using only supplied context, create a release health snapshot for [release name]. Triage before summarizing, label evidence everywhere, and separate human-owned decisions from recommended next actions.
```

## Route Findings

```text
Classify these findings using the portfolio routing matrix. Return the target agent, handoff contract, evidence label, and one next action per finding.
```

## Health to Work Item

```text
Convert this readiness gap into the Health to Work Item handoff contract. Use UNKNOWN for missing Jira values and include questions before drafting.
```

## Health to Notes

```text
Identify release-note candidates in this health summary and produce a Health or Drift to Notes handoff. Do not publish or approve notes.
```

## Daily Health Report

```text
Using the supplied health evidence, daily drift report, and [approval workflow], produce a daily health report for [release name]. Include top actions, evidence gaps, and human-owned decisions. Do not mark the release ready or make a go/no-go decision.
```
