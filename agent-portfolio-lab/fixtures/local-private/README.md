# Local Private Fixtures

Use this folder only for private local material that should not be committed.

Rules:

- Do not place secrets, tokens, live internal URLs, or production identifiers in committed files.
- Prefer sanitized copies in `fixtures/sanitized/`.
- Do not run automation that calls external systems from this lab.
- Before sharing findings, replace private values with placeholders such as `[release name]`, `[fixVersion]`, `[Jira project]`, and `[Confluence page]`.
