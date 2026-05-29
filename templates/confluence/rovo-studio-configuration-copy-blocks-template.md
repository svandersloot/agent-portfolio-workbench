# ROVO Studio Configuration - [Agent Name]

This page provides copy/paste fields for manually configuring [Agent Name] in ROVO Studio. It does not change Studio by itself.

Instructions and triggers are in fenced code blocks for easy copy/paste. Names, descriptions, and other short fields use inline code.

Golden formatting reference: `ROVO > ROVO Studio Configuration - Release Drift Monitor`, page ID `5318770794`, version `3` as of 2026-05-27.

## Parent Agent

### Name

Copy into the parent agent name field:

`[Agent Name]`

### Description

Copy into the parent agent description field:

`[One-sentence Studio description.]`

### Instructions

Copy into the parent agent instructions field:

```markdown
# Role

[Who the agent is and what outcome it supports.]

# Required Intake

Start every run by confirming:

1. [Required input one.]
2. [Required input two.]
3. [Required input three.]

# Operating Rules

- [Rule one.]
- [Rule two.]
- [Rule three.]

# Output Format

Return:

1. [Output section one.]
2. [Output section two.]
3. [Output section three.]

# Guardrails

Do not:

- [Disallowed action one.]
- [Disallowed action two.]
- [Disallowed action three.]
```

## Parent Conversation Starters

Copy each starter into a parent conversation starter field:

```text
[Starter one.]
```

```text
[Starter two.]
```

```text
[Starter three.]
```

## Subagent 1: [Subagent Name]

### Name

`[Subagent Name]`

### Trigger

Copy into the subagent trigger field:

```markdown
Use this subagent when [routing condition].

Common trigger phrases:

- "[Example phrase one.]"
- "[Example phrase two.]"
- "[Example phrase three.]"
```

### Instructions

Copy into the subagent instructions field:

```markdown
# Role

[Subagent responsibility.]

# Rules

1. [Rule one.]
2. [Rule two.]
3. [Rule three.]

# Return

Return:

- [Expected output one.]
- [Expected output two.]
- [Expected output three.]
```

## Knowledge Source Checklist

Copy into the knowledge/source setup notes if Studio provides a place for implementation notes:

```markdown
Before pilot:

- Confirm [source one].
- Confirm [source two].
- Confirm [source three].
```

## Tool And Skill Stance

Copy into tool guidance or retain as implementation notes:

```markdown
Use read-only tools unless a governed write workflow is approved.

Do not enable:

- [Write action one.]
- [Write action two.]
- [Write action three.]
```
