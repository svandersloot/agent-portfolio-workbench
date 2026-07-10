# Agent Working-Session Transcript Analysis Prompt Pack

Status: Reusable draft

Use this prompt pack after a working session with any governed or candidate agent. It extracts evidence from the transcript, identifies improvement opportunities, and turns useful observations into evaluation and governance follow-ups without treating one session as proof of readiness.

## Recommended workflow

Use two passes when possible:

1. **Transcript extraction** in Copilot or another transcript-local assistant. Keep this pass evidence-focused and tool-neutral.
2. **Repo-aware synthesis** in Claude Code. Give it the full transcript or sanitized extraction plus the relevant agent artifacts so it can compare findings with the current prompt, evaluation suite, measurement plan, and governance status.

If only one pass is available, use the repo-aware prompt in Claude Code. Do not use a compressed Copilot summary as the sole source for changing an agent prompt.

The output should be a report or design packet first. Prompt changes, Studio copy packets, and durable governance updates come only after review and evaluation design.

## Fill-in context block

Provide this block before either prompt:

```text
Agent name: [AGENT_NAME]
Agent type or role: [AGENT_TYPE]
Primary workflow: [SHORT_WORKFLOW_DESCRIPTION]
Known status: [STATUS_OR_UNKNOWN]
Known owner and backup owner: [OWNER_OR_UNKNOWN]
Transcript date: [DATE_OR_UNKNOWN]
Transcript source: [SOURCE_AND_ACCESS_CONTEXT]
Relevant repo artifacts: [FILES_OR_DIRECTORIES]
Desired outcome: [IMPROVE_AGENT | EXTRACT_SHARED_PATTERN | TRIAGE_FOLLOW_UPS | OTHER]
```

Do not include secrets, tokens, cookies, private URLs, unsanitized exports, customer data, or raw attachments in the context block.

## Pass 1 - transcript-only extraction

Use this with Copilot when the transcript is available there, or with any assistant that should not inspect the repository yet.

```text
Analyze the working-session transcript below for [AGENT_NAME].

Your task is evidence extraction, not agent redesign. Do not recommend prompt changes yet and do not infer approval, readiness, ownership, ROI, production safety, or successful agent usage beyond what the transcript directly shows.

Label every finding as exactly one of:
- Observed: directly demonstrated in the transcript
- User-reported: stated by a participant but not independently demonstrated
- Inferred: a reasonable interpretation, clearly marked
- Unknown: unresolved or requiring confirmation

Extract:
1. The user's goals and intended workflow
2. Inputs and source context supplied to the agent
3. Agent behaviors and decisions observed
4. Outputs that were useful or accepted
5. Errors, omissions, unsupported assumptions, or hallucinations
6. User corrections, repairs, or follow-up requests
7. Clarifications the agent should have asked
8. Traceability, coverage, formatting, or import-readiness signals
9. Hard-coded defaults, personal assumptions, or unsafe actions
10. Candidate regression-test scenarios
11. Potentially reusable lessons for other agents
12. Questions that require an owner, domain expert, or governance decision

Return Markdown with:
- A five-sentence session summary
- A chronological session map
- An evidence ledger with columns: ID, turn/speaker, sanitized excerpt or paraphrase, label, confidence, implication
- A preserve / modify / add / reject / unknown behavior table
- A list of candidate evaluation tests
- A list of unresolved questions
- A final section titled "What this transcript does not prove"

Use short excerpts only. Redact names, ticket IDs, policy numbers, private URLs, customer data, credentials, and attachment contents unless already sanitized and essential to understanding the behavior.

Transcript:
[PASTE_TRANSCRIPT_OR_REFERENCE_IT_HERE]
```

## Pass 2 - repo-aware synthesis

Use this in Claude Code from the repository root. Replace the bracketed context, then attach the full transcript or the Pass 1 extraction.

```text
Analyze the working-session transcript for [AGENT_NAME] using the repository as the governance source of truth.

Goal:
Extract useful evidence for improving the agent, identify lessons that may apply to other agents, and produce a bounded follow-up packet. Do not directly modify ROVO Studio, Jira, Confluence, or any live agent configuration.

Before analysis, read:
- AGENTS.md
- README.md
- START-HERE.md
- docs/toolkit-operating-model.md
- the agent's Project Brain or design record
- the agent's Studio configuration or setup page
- the agent's evaluation page and existing evaluation data
- the agent's measurement plan and change log
- any task-specific handoff or report named in the context block

Treat the transcript as evidence, not authority. Treat repo artifacts as the current local governance record. If they disagree in a way that affects status, readiness, ownership, approval, visibility, or runtime behavior, report the drift rather than choosing silently.

Classify every finding as exactly one of:
- Observed: directly demonstrated in the transcript
- User-reported: stated by a participant but not independently demonstrated
- Inferred: a reasonable interpretation, clearly marked
- Proposed: a recommended future change
- Unknown: unresolved or requiring confirmation

Separate domain-specific behavior from reusable agent-design patterns. Do not promote a pattern to shared guidance merely because it appeared once.

Produce a Markdown report with these sections:

1. Executive summary
   - What happened
   - What was valuable
   - What failed or caused friction
   - Three highest-value improvement candidates

2. Session map
   - User intent
   - Inputs and source evidence
   - Agent actions and outputs
   - User corrections or acceptance
   - Final outcome

3. Evidence ledger
   Table columns: Evidence ID, transcript turn or speaker, short sanitized excerpt/paraphrase, classification, confidence, what it proves, possible implication.

4. Behavior inventory
   For each behavior classify it as Preserve, Modify, Add, Remove/Reject, or Unknown. Include transcript evidence and whether the behavior is agent-specific, team-specific, or potentially reusable.

5. Failure and friction analysis
   Cover missing inputs, ambiguity, unsupported assumptions, hallucinations, coverage gaps, traceability problems, output-format problems, excessive verbosity, clarification failures, and unsafe or unauthorized actions.

6. Proposed agent improvements
   For each proposal provide:
   - Current behavior
   - Evidence
   - Proposed behavior
   - Why it matters
   - Risk or tradeoff
   - Required source or owner decision
   - Acceptance test
   - Status: candidate, needs decision, or rejected

7. Evaluation additions
   Create concrete regression-test prompts. For each include:
   - Test name
   - Purpose
   - Input fixture or source packet needed
   - Expected behavior
   - Pass criteria
   - Partial-pass criteria
   - Fail criteria
   - Whether it is domain-specific or reusable

8. Lessons for other agents
   Separate:
   - General interaction patterns
   - Patterns that belong in shared templates or governance guidance
   - Patterns specific to [AGENT_NAME]
   - Patterns that should not be generalized

9. Follow-up backlog
   Rank each item P0, P1, or P2. Include action, artifact to update, owner type needed, dependency, validation method, and whether human approval is required.

10. Decision gates and unknowns
   State what cannot safely be concluded and what evidence or human decision is needed.

11. Smallest implementation slice
   Recommend the smallest repo-only change that tests the highest-value improvement before any live-system or Studio change.

12. What this transcript does not prove
   Explicitly list conclusions that would require more sessions, controlled evaluations, owner review, pilot evidence, or live-system confirmation.

Rules:
- Keep observed evidence separate from recommendations.
- Do not infer approval, readiness, ownership, ROI, or production safety.
- Do not copy hard-coded people, project keys, priorities, environments, or private defaults into reusable behavior without source authority.
- Preserve human ownership of agent status, visibility, permissions, owners, retirement, and live-system writes.
- Do not update canonical agent instructions until the report and evaluation additions have been reviewed.
- Do not create or modify live-system configuration.
- Redact secrets, tokens, cookies, private URLs, customer data, raw attachments, and unsanitized exports.

Context:
[PASTE_CONTEXT_BLOCK_HERE]

Transcript or Pass 1 extraction:
[PASTE_OR_REFERENCE_INPUT_HERE]
```

## Optional agent-specific profile

Append a short profile when a workflow has special quality criteria. Keep it separate from the reusable prompt so the core analysis does not become overfit to one agent.

Example for QA Test Case Architect:

```text
Agent-specific checks:
- Requirement and acceptance-criteria traceability
- Positive and negative test pairing
- Missing-data, TBD, and conflict logging
- Deterministic test-case IDs
- XRAY/import-ready output shape
- Clarification before generation when source context is incomplete
- Source-derived or configurable defaults instead of hard-coded people/projects
- No Jira, XRAY, Confluence, or Studio writes
```

## Expected downstream artifacts

The analysis normally produces only the smallest coherent set:

- A sanitized transcript-analysis report or integration design packet.
- Evaluation prompts or regression fixtures when a behavior needs proof.
- A measurement-plan addition only when a durable measure is genuinely introduced.
- A Studio copy packet only after evaluation evidence supports a draft change and a human will apply it.
- A change-log entry when canonical agent documentation changes.
- A handoff when the next step is owned by another person or tool.

Do not update inventory status, owner fields, readiness, visibility, or approval records from transcript analysis alone.

## Validation and privacy checklist

Before handoff:

- Confirm the transcript is not committed in raw or unsanitized form.
- Confirm evidence labels are present and consistent.
- Confirm no finding implies a human-owned decision was made.
- Confirm proposed behavior has an acceptance test or is marked unknown.
- Run `git status --short`.
- Run `git diff --check`.
- Run `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\Test-PrivateDataScan.ps1` when files are being staged or committed.
- Run the relevant agent page-family consistency check if governed Confluence source pages changed.
- State clearly when validation was manual-only.

## Maintenance rule

When this prompt pack changes, keep the general prompt agent-agnostic. Add domain-specific rules under an agent-specific profile, evaluation page, or handoff instead of changing the shared extraction contract for one agent.
