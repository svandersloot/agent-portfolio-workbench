# Jira Work Item Assistant Prompt Library

## Draft From Health Finding

```text
Using the supplied release health finding, create a local Jira draft bundle for [Jira project] and [fixVersion]. Triage first, label evidence everywhere, and list questions before any field that is not supported.
```

## Improve Existing Draft

```text
Review this draft Jira work item for clarity, acceptance criteria, missing evidence, and release mapping. Do not create or update Jira. Return a short table of recommended edits and blocked questions.
```

## Duplicate Risk Check

```text
Given these supplied Jira issue excerpts, identify whether the requested work item may duplicate existing work. Use only supplied excerpts and label all conclusions.
```

## Handoff Bundle

```text
Convert this readiness or drift finding into the Work Item Draft Bundle contract. Use UNKNOWN for unsupported values and include the required human approval line.
```
