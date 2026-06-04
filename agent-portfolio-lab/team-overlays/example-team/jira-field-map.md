# Jira Field Map

Example team-specific Jira mapping. Replace before real use.

| Field | Example Value | Notes |
| --- | --- | --- |
| Project | `[Jira project]` | Human confirms before draft bundle approval. |
| Fix version | `[fixVersion]` | Must be supplied or marked `UNKNOWN`. |
| Issue type options | Task, Bug, Story, Spike | Choose only when supported by context. |
| Component | `[component]` | Optional; do not infer from title alone. |
| Owner role | `[release owner]`, `[QA lead]`, `[dev lead]` | Role only, not a named person in reusable tests. |

Jira creation and comments remain human-owned.
