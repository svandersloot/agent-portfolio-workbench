# Topic Mastery: AI Agents — Building, Governance & Teaching

> **Learner:** Shayne | **Role:** Agent framework architect + educator | **Started:** 2026-06-26

---

## Current Understanding

- Understands the core distinction between chatbots and agents: agents **take actions** (modify files, run code, automate workflows) vs. chatbots that only return responses.
- Knows agents operate within a **reasoning loop** — iterating until a goal is met.
- Has intuition that **constraints and guardrails** improve output quality and reduce unpredictable behavior.
- Aware of **multi-agent patterns** — agents can delegate to other specialist agents and synthesize results.
- Knows tools can come from the local machine (PowerShell, Python) or via **MCP servers**, and that permissions matter.
- Has working knowledge of **Python, Java, C++** and is actively building agentic systems.
- Is designing a **governance layer** for his company's AI agent usage.
- Understands the tool call cycle: model outputs a structured tool call → runtime executes → result injected back into context → model continues.
- Understands that unconstrained retry loops are a safety risk — **goal fixation** can cause agents to bypass guardrails.
- Correctly identified that silent tool failures can produce hallucinated outputs that erode trust.
- Identified **observability (audit logs)** and **evaluator agents** as the two systemic mechanisms for catching agent failures at scale.
- Understands that trust in agent systems comes from **architectural design**, not model perfection.

---

## Knowledge Gaps

- [x] **Tool call mechanics** — understands the full cycle: model → structured tool call → runtime executes → result injected into context → model continues.
- [x] **MCP (Model Context Protocol)** — understands it as a standardized protocol (like USB-C) for connecting agents to tools. Two sides: MCP server (exposes tools) and MCP client (agent runtime). Enables vendor-agnostic governance at the protocol layer.
- [ ] **Agent loop internals** — the precise sequence: perceive → think → act → observe → repeat, and what controls each phase.
- [x] **Stopping conditions** — understands goal fixation risk, retry limits, and silent failure as key stopping-condition failure modes.
- [x] **Orchestrator vs. subagent patterns** — understands orchestrators plan and delegate; subagents specialize and execute. Drew the analogy to separation of duties / four-eyes principle in human organizations.
- [x] **Context window management** — understands context grows with each step; oldest content (including system prompt/guardrails) gets dropped when full. Mitigations: system prompt pinning, context budget limits, periodic re-injection.
- [x] **System prompt design** — already practicing role definition, operating contract, guardrails, scoped access, and calibrated uncertainty. Gaps filled: output format specification and priority ordering for conflicting instructions.
- [ ] **Safety and trust mechanisms** — beyond guardrails, what makes an agent system trustworthy at an architectural level.
- [ ] **Escalation paths** — uncertainty and failure need defined routes (to human, senior agent, or log), not agent-decided behavior.

---

## Misconceptions

| Misconception | Correction |
|---|---|
| "Broader scope causes more hallucinations" | Broader scope primarily causes **unpredictable behavior and scope creep**. Hallucinations are a separate issue (model generating false content). Narrow scope reduces *decision errors*, not necessarily *hallucinations*. |

---

## Key Concepts

| Term | Definition |
|---|---|
| **AI Agent** | A system that perceives input, reasons about it, takes actions (via tools), and iterates toward a goal — as opposed to a system that only responds. |
| **Tool** | A capability the agent can invoke: a function, API, shell command, file operation, or another agent. |
| **Agent Loop** | The repeating cycle: receive input → reason → decide action → execute tool → observe result → reason again → repeat until done. |
| **Guardrails** | Constraints on what an agent can do, say, or access. Defined in system prompts, permissions, and architectural controls. |
| **MCP (Model Context Protocol)** | An open protocol (open-sourced by Anthropic, 2024) for connecting AI agents to tools and data sources in a standardized, vendor-agnostic way. Defines how tools are described, how calls are structured, how results are returned, and how permissions are negotiated. |
| **MCP Server** | Exposes tools, data, or capabilities (e.g., file system, Jira, web search) via the MCP protocol. |
| **MCP Client** | The agent runtime that connects to MCP servers and invokes their tools. |
| **Runtime Observability** | Logging and monitoring what an agent actually does at runtime — every tool call, MCP connection, and result — to detect policy violations after the fact. |
| **Define / Prevent / Detect** | A three-layer governance model: define policy (approved list), prevent violations (allowlist enforcement), detect breaches (runtime audit logs vs. policy). |
| **Goal Fixation** | When an agent becomes so focused on completing a goal that it bypasses guardrails or makes increasingly risky decisions trying to succeed. |
| **Orchestrator** | An agent that plans, coordinates, and delegates subtasks to other agents. Does not execute directly — it routes. |
| **Subagent** | A specialist agent that receives a scoped task from an orchestrator, executes it, and returns results. |
| **Prompt Injection** | An attack where malicious instructions are hidden inside data an agent reads (emails, documents, web pages) — causing the agent to follow the attacker's instructions instead of its own. |
| **Least Privilege** | Scoping an agent's tool permissions to the minimum required for its task. The most effective defense against prompt injection — if the agent can't do it, injected instructions can't make it happen. |
| **Separation of Duties** | No single agent (or human) should both execute a task and review their own work. Requires independent agents for checks and audits. |
| **System Prompt Pinning** | Marking the system prompt as protected in the runtime so it is never dropped when the context window fills. |
| **Context Budget** | A hard cap on the number of turns or tool calls per task, forcing a summarize-and-reset or human escalation before the window fills. |
| **Calibrated Uncertainty** | Designing agents to explicitly flag low-confidence responses instead of proceeding silently. Turns silent failures into visible ones. |
| **Escalation Path** | A defined route for uncertainty or failure — to a human, a senior agent, or an audit log. Must be specified in architecture, not left to the agent's discretion. |
| **Output Format Specification** | Defining the exact structure of an agent's response (fields, format, examples) to ensure consistent, parseable outputs for downstream systems. |
| **Priority Ordering** | Explicit rules in the system prompt for what wins when instructions conflict. Guardrails should always outrank user instructions. |
| **Orchestrator** | An agent that plans and delegates subtasks to other agents. |
| **Subagent** | An agent that receives a specific task from an orchestrator, executes it, and returns a result. |
| **Context Window** | The total amount of text (instructions, history, tool results) an AI model can "see" at one time. |

---

## Questions Asked

1. **"When you hear 'AI agent,' what does that mean to you?"**
   → Described a spectrum from chatbot to autonomous coding assistant. Good breadth, needed precision.

2. **"What's the difference between a chatbot and an autonomous agent?"**
   → Correctly identified action-taking (file modification, workflow automation) as the key differentiator.

3. **"How does an agent figure out its next step, and know when it's done?"**
   → Responded with goals and guardrails; connected broad scope to hallucinations (partially accurate — noted as misconception to refine).

4. **"What's the cycle that happens between goal and completion?"**
   → Correctly described a reasoning loop with delegation to specialist agents and reassessment against goals.

5. **"What's a tool, and how does an agent use one?"**
   → Correctly identified tools as local capabilities (PowerShell, Python) and MCP servers; raised permissions/authorization.

6. **"Walk me through what happens mechanically when an agent uses a tool."**
   → Honest: "I don't know enough about this." — Key gap identified.

7. **"What's your role — building, configuring, or teaching?"**
   → All three: architect of company governance framework + educator for colleagues.

8. **"What's your technical background?"**
   → C++, Java, Python. Learning agentic AI development. Focus on responsible, secure, trustworthy systems.

---

## Learning Plan

### Goal
Be able to build a trustworthy agent governance framework AND teach both users and builders how agents work from first principles.

### Milestones

#### 🟢 Foundation (Do First)
1. **The tool call cycle** — exactly what happens when an agent invokes a tool (model → tool call → runtime → result → model)
2. **The agent loop in detail** — the full perceive → think → act → observe cycle, with real examples
3. **MCP deep dive** — what it is, how servers work, what the protocol does
4. **Stopping conditions** — max turns, goal evaluation, error states, human-in-the-loop

#### 🟡 Architecture (Do Second)
5. **Orchestrator / subagent patterns** — when to split work, how agents hand off tasks
6. **Context window management** — what fits, what gets dropped, strategies for long tasks
7. **System prompt design** — writing effective agent instructions, persona, constraints
8. **Memory types** — in-context, external (RAG), episodic, procedural

#### 🔴 Governance & Trust (Do Third — Your Core Domain)
9. **Agent safety architecture** — guardrails, sandboxing, permission scopes, audit trails
10. **Human-in-the-loop design** — when to pause for approval, confirmation patterns
11. **Trust levels** — how to classify what agents can do autonomously vs. what requires oversight
12. **Teaching frameworks** — how to explain agents to non-technical stakeholders

### What to Skip or Skim
- Deep model training / fine-tuning theory (not needed for your role)
- Specific LLM benchmarks (useful context but not core)
- Most vendor-specific UI tooling (focus on protocol/architecture level)

### How You'll Know You Understand
- You can draw the agent loop on a whiteboard from memory
- You can explain what happens during a tool call without notes
- You can describe your governance framework's trust model to a non-technical executive
- A colleague can follow your teaching and build a simple agent correctly

---

## Practice Tasks

### Exercise 1 — Agent System Design (Foundation)
**Scenario:** Your company wants an agent that reads support tickets, categorizes them, and drafts responses for a human to review before sending.

Design the agent system. Answer these questions:
1. How many agents do you need, and what is each one's single responsibility?
2. What tools does each agent need access to? (Apply least privilege — no more than required.)
3. Where does a human-in-the-loop checkpoint sit, and why there specifically?
4. What does your audit log record for each step?
5. What's the prompt injection risk, and how do you mitigate it?

*Write your answers as if briefing a junior developer who will build it.*

---

## Connections to Other Topics

- **This connects to security architecture** because agents with tool access are essentially automated actors with permissions — the threat model is similar to service account security.
- **This connects to systems design** because multi-agent systems behave like distributed systems: failure modes, retries, timeouts, and consistency matter.
- **This connects to prompt engineering** because how you write an agent's instructions directly shapes its behavior, just as a well-designed API contract shapes a system.
- **This connects to governance/compliance** because agents that take actions leave audit trails — or don't, which is a risk.

---

## Session Log

| Date | Topic Covered | Status |
|---|---|---|
| 2026-06-26 | Interview & knowledge assessment | ✅ Complete |
| 2026-06-26 | Tool call mechanics & the agent loop | ✅ Complete |
| 2026-06-26 | Stopping conditions & goal fixation | ✅ Complete |
| 2026-06-26 | Silent failure, observability, evaluator agents | ✅ Complete |
| 2026-06-26 | MCP — protocol, servers, clients | ✅ Complete |
| 2026-06-26 | MCP governance — Define / Prevent / Detect | ✅ Complete |
| 2026-06-26 | Multi-agent patterns — orchestrator / subagent | ✅ Complete |
| 2026-06-26 | Prompt injection & least privilege | ✅ Complete |
| 2026-06-26 | Exercise 1 — support ticket system design | ✅ Complete |
| 2026-06-26 | Context window management & failure modes | ✅ Complete |
| 2026-06-26 | System prompt design — best practices | ✅ Complete |
| — | Memory types (in-context, RAG, episodic) | 🔜 |
| — | Trust levels & agent classification | 🔜 |
| — | Teaching framework for non-technical stakeholders | 🔜 |
