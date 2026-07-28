# Documentation Map

This is the persona-based router for the Agent Portfolio Workbench. It exists so anyone
arriving at the repo can reach the right depth of material in about 30 seconds — whether
they are a sponsor, a governance lead, an architect, or a developer.

It does not replace the operating contract. **`AGENTS.md` remains the single canonical
operating document** for how AI-assisted work is done here; the other front-door files
(`README.md`, `START-HERE.md`, `CLAUDE.md`) and this map are pointers into it, not
competing authorities.

## Route By Audience

Find your role, open the first link, and follow the "then read" trail.

| You are a… | You care about… | Start here | Then read |
| --- | --- | --- | --- |
| **Sponsor / Leader** | Why this exists, what it delivers, the ask | [research/executive-brief-2026-07.md](research/executive-brief-2026-07.md) | [Positioning & audience model](agent-portfolio-workbench-positioning.md) · [30/60/90 plan](research/roadmap-30-60-90-2026-07.md) |
| **Innovation / Governance Stakeholder** | How agents are governed, gated, and kept safe | [agent-governance-completeness-contract.md](agent-governance-completeness-contract.md) | [Operating-model research](research/enterprise-agent-governance-operating-model-2026-07.md) · [Pilot boundaries](stage-5-pilot-boundaries.md) · [Principles & values](principles-foundation.md) · [Roadmap](roadmap.md) |
| **Architect / Framework Designer** | The reference architecture, contracts, autonomy model | [research/architecture-diagram-2026-07.md](research/architecture-diagram-2026-07.md) | [Operating model](toolkit-operating-model.md) · [Governed backlog loop](governed-backlog-execution-loop.md) · [Loop state machine](loop-state-machine.md) · [Team-facing agent pattern](team-facing-agent-pattern.md) · [`schemas/`](../schemas) |
| **Developer / Contributor** | How to set up, work safely, and ship a slice | [../CONTRIBUTING.md](../CONTRIBUTING.md) | [START-HERE.md](../START-HERE.md) · [Operator guide](operator-guide.md) · [MCP setup](mcp-setup.md) · [CI minimum checks](ci-minimum-checks.md) · [`agent-portfolio-lab/`](../agent-portfolio-lab) |

New here and unsure? Read [`AGENTS.md`](../AGENTS.md) first (the operating contract), then
[`README.md`](../README.md) for the project overview.

## What Each Audience Is Looking For

### Sponsors & Leaders
The decision layer: the problem, why the approach is defensible, what it delivers, and
the near-term ask. The most leadership-ready material lives in
[`docs/research/`](research) — it is the least discoverable from the current front door,
so it is surfaced first here. Start with the
[executive brief](research/executive-brief-2026-07.md); the
[positioning doc](agent-portfolio-workbench-positioning.md) holds the canonical audience
model and executive message.

### Innovation & Governance Stakeholders
The controls layer: what makes a governed agent complete and safe to promote, the
lifecycle gates and risk tiers, and the boundaries a pilot must respect. Start with the
[completeness contract](agent-governance-completeness-contract.md) (the required-fields
contract, backed by [`schemas/agent-governance-record.schema.json`](../schemas)), then
the [operating-model research](research/enterprise-agent-governance-operating-model-2026-07.md)
for the full governance thesis.

### Architects & Framework Designers
The design layer: the reference architecture (intake → workbench → human-facing →
runtimes → approver), the source-of-truth hierarchy, the graduated-autonomy model, and
the machine-checkable contracts. Start with the
[architecture diagram](research/architecture-diagram-2026-07.md); the
[governed backlog loop](governed-backlog-execution-loop.md) and
[loop state machine](loop-state-machine.md) specify the autonomy machinery, and
[`schemas/`](../schemas) holds the output contracts.

### Developers & Contributors
The build layer: access model, safe workflow, validation checks, and where the reusable
patterns live. This audience is already well served by the existing front door —
[`CONTRIBUTING.md`](../CONTRIBUTING.md) → [`START-HERE.md`](../START-HERE.md) →
[operator guide](operator-guide.md). The [lab](../agent-portfolio-lab) is a parallel
workspace for reusable agent and automation patterns before manual transfer to Studio.

## Planning & Execution Surfaces

These are where active work is tracked (not this map, and not the root README):

- [`docs/next-slash-goals.md`](next-slash-goals.md) — the current actionable queue.
- [`docs/implementation-backlog.md`](implementation-backlog.md) — backlog sequencing.
- [`docs/roadmap.md`](roadmap.md) — longer-term direction.

## Evidence & Audit Collections

Large, browse-by-need collections rather than start-to-finish reading:

- [`docs/confluence-pages/`](confluence-pages) — repo-backed source drafts of human-facing
  Confluence pages, including per-agent page families. The intended human-facing portal
  content.
- [`docs/reports/`](reports) — dry-runs, readiness assessments, evaluations, and decision
  briefs (evidence store).
- [`docs/publish-history/`](publish-history) — dated audit records of approved Confluence
  publishes.
- [`docs/handoffs/`](handoffs) — dated work-handoff packets between sessions.

## Known Inconsistencies (Human-Owned To Resolve)

This map routes to existing documents; it does not silently reconcile governance
decisions. Two known drifts are called out here so readers know to defer to the
authoritative source rather than assume the docs agree:

1. **Two audience taxonomies.** The [positioning doc](agent-portfolio-workbench-positioning.md)
   defines six roles; [stage-5-agent-factory-start-here.md](stage-5-agent-factory-start-here.md)
   defines five. This map's four target audiences are a routing convenience layered over
   both, not a third canonical taxonomy. Treat the positioning doc as canonical for roles.
2. **Lifecycle model drift.** The 13-step / 8-stage / required-fields model in
   [toolkit-operating-model.md](toolkit-operating-model.md),
   [agent-governance-completeness-contract.md](agent-governance-completeness-contract.md),
   and [stage-5-agent-factory-start-here.md](stage-5-agent-factory-start-here.md) differs
   from the newer five-gate/risk-tier model proposed in
   [research/enterprise-agent-governance-operating-model-2026-07.md](research/enterprise-agent-governance-operating-model-2026-07.md).
   Which is authoritative is a human-owned governance decision (see `AGENTS.md` →
   Human-Owned Decisions).

## Documentation Conventions

For maintainers keeping this navigation coherent as the repo grows:

- **Hierarchy.** `AGENTS.md` (canonical operating contract) → front-door pointers
  (`README.md`, `START-HERE.md`, this map) → source docs in `docs/` → evidence/audit
  collections (`reports/`, `publish-history/`, `handoffs/`). Higher tiers stay thin and
  point down; they do not re-state lower-tier detail.
- **One router, not many landing pages.** This file is the single audience index.
  Route to existing docs by link rather than creating parallel section landing pages —
  the repo already tracks doc-sprawl risk, so prefer linking over duplicating.
- **Naming.** Lowercase, hyphenated, concept-named. Dated artifacts (research, reports,
  handoffs, publish-history) keep their `-YYYY-MM[-DD]` suffix; durable docs do not.
- **Cross-linking.** Doc-to-doc links are relative and survive clone/fork; when a doc's
  role or audience changes, update this map first.
- **Ownership.** Code ownership is defined in [`.github/CODEOWNERS`](../.github/CODEOWNERS)
  (currently `@svandersloot`, pending formalization to an approved team). Governance
  decisions — owner assignment, readiness, approval, taxonomy/lifecycle authority —
  remain human-owned per [`AGENTS.md`](../AGENTS.md).

## When You Add Or Move A Document

1. Decide the single primary audience → that determines where it is routed here.
2. Add it under the right audience row or collection above.
3. If it changes routing for an audience, update this map before merging.
4. Link to related concepts instead of re-stating them.
