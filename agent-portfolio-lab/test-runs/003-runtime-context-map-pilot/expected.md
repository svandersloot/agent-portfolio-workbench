# Expected Result

Both pilot agents should show artifact-level improvement:

- Jira Work Item Assistant routes Deployment Notes, normal ticket drafting, MOBRM overlay resolution, status comments, and readiness/gap requests to the correct first source.
- Release Notes Manager routes deployment work packages, technical release notes, release-note synchronization, business summaries, and readiness questions to the correct first source.
- Both agents explicitly reject adjacent substitutes such as Jira hygiene pages for Deployment Notes behavior.
- Both agents define safe fallback behavior instead of relying on Studio memory or guessing.
- Both agents have smoke prompts that can be run after manual Studio setup.
- Studio setup pages state that the maps are not live until manually configured and verified.

The lab should not claim live behavior improved unless a manual ROVO Studio run supplies output evidence.
