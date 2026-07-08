# Enterprise AI Agent Governance Operating Model — Research Report

| Field | Value |
|---|---|
| Date | 2026-07-08 |
| Status | Research deliverable for review; no live-system action authorized |
| Method | Five-angle web research fan-out plus adversarial verification of the ten load-bearing claims (all confirmed) |
| Evidence labels | `Source-backed` = verified against cited source. `Recommendation` = author/analyst judgment. `UNCONFIRMED` = could not verify. |
| Companion files | `executive-brief-2026-07.md`, `architecture-diagram-2026-07.md`, `roadmap-30-60-90-2026-07.md`, and a positioning/growth file intended for `docs/private-overlays/` |

This report deliberately separates sourced platform/regulatory facts from recommendations. Nothing here marks any agent Active, Ready, or approved; human-owned decisions remain human-owned per `AGENTS.md`.

---

## 1. Executive Thesis

### The problem this workbench solves (`Recommendation`, built on sourced facts)

Every major platform now ships governance features *inside its own walls* — Microsoft has an Agent Registry and Entra Agent ID, OpenAI launched Frontier and Workspace Agents, Atlassian added creation permissions, verified agents, and evaluations. None of them governs across platforms, none of them holds your evidence of *why* an agent was approved, and the least mature one (Rovo Studio) still has no config API, no shipped version history, and no group-based access control. The durable gap is a **platform-neutral governance record**: who owns each agent, what it was approved to do, what evidence supported that approval, what changed since, and what should be reused before anything new is built. That is exactly what a Git-backed workbench provides, and no vendor roadmap item replaces it.

### Why this grows in value (`Source-backed` facts, `Recommendation` framing)

- Gartner predicts over 40% of agentic AI projects will be canceled by end of 2027 due to cost, unclear value, or inadequate risk controls ([Gartner, June 2025](https://www.gartner.com/en/newsroom/press-releases/2025-06-25-gartner-predicts-over-40-percent-of-agentic-ai-projects-will-be-canceled-by-end-of-2027)). Organizations that can show value evidence and risk controls are the ones whose projects survive.
- IBM's 2025 Cost of a Data Breach report: 13% of organizations reported breaches of AI models/apps; 97% of those lacked proper AI access controls; shadow-AI breaches cost ~$670K more than average ([IBM, July 2025](https://newsroom.ibm.com/2025-07-30-ibm-report-13-of-organizations-reported-breaches-of-ai-models-or-applications,-97-of-which-reported-lacking-proper-ai-access-controls)).
- The MIT NANDA "GenAI Divide" report found ~95% of enterprise GenAI pilots showed no measurable P&L return — methodology was criticized, so treat as directional — with workflow-integration failure, not model quality, as the root cause ([Fortune, Aug 2025](https://fortune.com/2025/08/18/mit-report-95-percent-generative-ai-pilots-at-companies-failing-cfo/)).
- For a US insurer specifically: the NAIC Model Bulletin (adopted Dec 2023; Wisconsin became the 24th adopting state in March 2025) requires a written AI Systems program with governance accountability, **an inventory of AI systems**, documentation, and third-party AI oversight ([NAIC](https://content.naic.org/insurance-topics/artificial-intelligence)). California relies on CDI Bulletin 2022-5 instead, asserting authority to audit insurers' algorithms. A governed agent inventory is not optional hygiene at an insurer — it is the regulatory expectation. `Recommendation`: position the workbench as the mechanism that satisfies the inventory/documentation portion of an AIS program for agent-class systems; confirm with compliance before claiming it does.
- The industry has independently converged on the pattern this repo already implements: registry/inventory → agent identity with a named human sponsor (Entra Agent ID makes a human Sponsor/Owner mandatory per agent) → config-as-code with eval gates → human-in-the-loop on writes → drift monitoring → behavioral value metrics. `Source-backed` across [Microsoft Entra Agent ID](https://learn.microsoft.com/en-us/entra/agent-id/what-is-microsoft-entra-agent-id), [GitHub agent control plane GA](https://github.blog/changelog/2026-02-26-enterprise-ai-controls-agent-control-plane-now-generally-available/), and practitioner GitOps-for-agents writing. Your posture was not idiosyncratic caution; it anticipated the market.

### Why a forward deployment engineer owns this space (`Source-backed` + `Recommendation`)

FDE is the role vendors created for exactly this work: embed with the customer, ship working agent deployments against real data, and feed governance/product gaps back. Anthropic's own FDE posting lists deliverables — MCP servers, sub-agents, Agent Skills shipped into customer production workflows — that are precisely the artifact types an internal governance program must inventory ([Anthropic job posting](https://job-boards.greenhouse.io/anthropic/jobs/4985877008)). FDE postings grew several hundred percent through 2025 (recruiter-sourced figures vary; treat exact numbers as `UNCONFIRMED`), and both OpenAI and Anthropic launched large deployment ventures in May 2026 (press-reported, `UNCONFIRMED` details). `Recommendation`: the internal version of this role — pain discovery, governed prototype, measured pilot, safe promotion — is the highest-leverage framing for your position because it pairs the two things organizations currently lack: people who can build agents and people who can prove they are safe and worth keeping.

---

## 2. Reference Architecture

### Durable layers (`Recommendation`)

These six layers survive platform churn. Individual products change; the layers do not.

| Layer | Job | Today's implementation | Platform-native overlap to adopt when mature |
|---|---|---|---|
| 1. Registry of record | One row per governed agent: identity, owner, backup owner, status, risk tier, platform, last review | Structured inventory file + `agent-governance-record.schema.json` | M365 Agent Registry, Entra Agent ID, Rovo "Agent Sprawl Management" (coming soon) |
| 2. Spec and knowledge | What the agent is for, its runtime contract, context map, knowledge source plan | Project Brain page families | None cross-platform; keep |
| 3. Evaluation | Prompt packs, pass/partial/fail criteria, regression evidence | `*-evaluation.md` regression prompt packs | Rovo Agent Evaluations (CSV ≤50 prompts, LLM judge), Copilot Studio test cases (preview), Azure AI Foundry evaluators |
| 4. Runtime | The actual configured agent | Rovo Studio (manual copy), later Copilot Studio etc. | Always platform-native |
| 5. Evidence and audit | What changed, who approved, capture/parity, publish history | Git history, publish-history records, normalized captures | Purview audit, Atlassian audit log, Claude/OpenAI Compliance APIs — feed summaries in, do not replace Git record |
| 6. Measurement | Usage, acceptance/edit/reject, incidents, reuse | Feedback tracker, monthly snapshot | Rovo usage analytics, Copilot Studio analytics |

### Source-of-truth hierarchy (`Recommendation`, extends current `AGENTS.md` order)

1. **Git** — governance record of intent and evidence (specs, approvals, evals, history). Authoritative for "what was approved and why."
2. **Runtime (Studio et al.)** — authoritative for "what actually runs." Never assume; capture and parity-check. When Git and runtime disagree, that is drift: report it, reconcile via human action.
3. **Confluence/SharePoint** — human-facing approved copies, published dry-run-first from Git sources.
4. **Jira/ADO** — work tracking and intake context, never governance authority.

The key subtlety: Git is source of truth for *intent*, the runtime is ground truth for *behavior*, and the parity check is the bridge. This mirrors GitOps drift reconciliation, except reconciliation is a human Studio action where no supported write API exists.

### System interactions

```text
Intake (chat/Jira) ──► Workbench (Git): fit triage, dedupe, spec, evals
Workbench ──dry-run+approval──► Confluence (human-facing pages)
Workbench ──copy packet──► Human ──manual save──► Runtime (Rovo Studio)
Runtime ──capture/normalize──► Workbench (parity check, drift diff)
Runtime analytics + feedback ──► Workbench measurement ──► Leadership snapshot
```

### Manual vs. automatable vs. never-automate (`Recommendation`)

| Category | Items |
|---|---|
| Automate now (read-only or approval-gated) | Capture normalization; drift diffs; report/snapshot generation; schema linting; eval execution where the platform supports it (Rovo Evaluations CSV, Copilot test cases); Confluence publish with dry-run + explicit approval; stale-doc and private-data scans |
| Keep manual (until supported APIs exist) | Rovo Studio configuration (no public config API — community-confirmed gap ROVO-516); ownership assignment; pilot user selection; feedback interpretation |
| Automate later (supported APIs exist; adopt per platform) | Copilot Studio ALM: solutions + Dataverse Git integration to Azure DevOps is official and human-readable ([Microsoft Learn](https://learn.microsoft.com/en-us/power-platform/alm/git-integration/overview)) — on that platform, config-as-code is the *native* path, and the workbench becomes a pipeline gate rather than a copy-packet generator |
| Never automate without explicit human approval | Status promotion (Active/Ready/pilot); visibility or permission changes; retirement/merge; policy exceptions; any Jira write; any write action by an agent that is irreversible or people-affecting (OWASP "excessive agency" mitigation: least-privilege tools + human-in-the-loop on consequential actions) |

---

## 3. Agent Lifecycle

`Recommendation`: your existing Stage 5 thirteen-step lifecycle is directionally right and matches the field's convergence. The refinement below keeps every step but groups them under **five human gates**, so process weight scales with risk tier instead of applying the full ceremony to everything. (See Section 9 for why this matters.)

| Gate | Steps within (existing Stage 5 steps) | Exit decision | Depth by risk tier |
|---|---|---|---|
| G1 Fit | Intake; fit triage: prompt / automation / existing-agent extension / template / new agent / not ready; duplicate & reuse check (reuse > improve > merge > reject > new) | Route chosen; duplicate decision recorded | All tiers. One-page intake maximum. |
| G2 Design | Spec/Project Brain; runtime context map; knowledge source plan; risk tier + data classification assigned | Draft complete or Not Ready | Tier 1 (personal, read-only): thin contract + smoke check only. Tier 2-3: full package. |
| G3 Build & verify | Evaluation prompt pack; manual configuration (copy packet); capture; parity check | Parity confirmed or remediate | Eval pack size scales with tier; run through platform-native evals where available so packs are executable, not just documents |
| G4 Pilot & measure | Named pilot users; feedback tracker; usage/acceptance/edit/reject; incident log | Promote / continue / remediate / stop | Tier 1 skips formal pilot; Tier 3 requires security/compliance sign-off |
| G5 Operate & retire | Scheduled review (last-reviewed date); drift re-capture; remediation; deprecation with replacement guidance; retirement preserving history | Keep / remediate / deprecate / retire | Review cadence by tier: T1 annual, T2 semiannual, T3 quarterly + access review |

Lifecycle facts worth anchoring to (`Source-backed`):

- Anthropic's agent-evals guidance distinguishes *tasks* (test case + success criteria) from *trials* (stochastic runs) and grades outcomes separately from trajectories — your pass/partial/fail prompt packs map cleanly; add trial counts for flaky cases ([Anthropic engineering](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)).
- Entra ID Governance applies access reviews and expiry to agent identities and mandates a human Sponsor — adopt the *pattern* (scheduled re-review, expiring approvals) even where the platform doesn't enforce it ([Microsoft Learn](https://learn.microsoft.com/en-us/entra/id-governance/agent-id-governance-overview)).
- ChatGPT Enterprise auto-transfers GPT ownership to a workspace owner when the owner is deactivated and flags it "unassigned" ([OpenAI help](https://help.openai.com/en/articles/8555535-managing-gpt-access-in-enterprise-and-edu-workspaces)) — your backup-owner field is the manual equivalent; keep it non-negotiable.

---

## 4. Governance Controls

### Required fields (`Recommendation`; current contract + additions)

Keep the existing twelve (name, owner, backup owner, status, purpose, audience, knowledge sources, tools/skills, measurement plan, readiness status, Project Brain link, last reviewed). Add four, each justified by an external anchor:

| New field | Why |
|---|---|
| Risk tier (1-3) | NIST AI RMF GOVERN function requires inventorying and resourcing AI systems *by risk*; proportionate controls are the NAIC bulletin's core principle |
| Data classification touched | Insurance regulatory expectation; drives tier |
| Platform + runtime identity | Cross-platform future; Entra Agent ID treats agents as directory identities — record the runtime identity/ID once one exists |
| Write capability (none / confirm-gated / autonomous) | OWASP LLM06 "excessive agency" is the top agentic risk class; write capability is the single best one-field risk proxy |

### Risk tiers (`Recommendation`)

- **Tier 1 — Personal/read-only**: builder-only audience, no writes, no sensitive data. Lightweight package (your existing lightweight variant).
- **Tier 2 — Team-facing/read-mostly**: others rely on output; confirm-gated writes at most. Full ten-element package.
- **Tier 3 — Consequential**: touches regulated processes (underwriting, claims, HR), sensitive data, or autonomous writes. Full package + security/compliance review + quarterly access review. At CSAA, anything nearing rate/underwriting/claims decisions likely triggers NAIC/CDI scrutiny — escalate before build.

### Approval gates, human-owned decisions, visibility

Unchanged from `AGENTS.md` — the research validated rather than weakened them. Two sourced additions: (a) Rovo cannot restrict agent *access* to groups (individuals only — [Atlassian docs](https://support.atlassian.com/rovo/docs/rovo-agent-permissions-and-governance/)), so treat "restricted" Rovo agents as soft-restricted and never rely on Studio visibility as a security control; (b) use org-admin **verified agent** marking as the user-facing signal of governance approval — it is the one native Rovo primitive that maps to your promotion decision.

### Audit/history, privacy, drift

- Git history + publish-history records remain the audit spine. Feed platform audit into it, don't replace it: Atlassian org audit log records Agent Created/Updated/Deleted; Purview logs Copilot interactions; Claude Enterprise exports 180-day audit logs and has a Compliance API; OpenAI's Compliance API covers GPT/agent configs. (All `Source-backed`, links in Section 10.)
- Privacy/secrets boundaries unchanged: no tokens, raw exports, HARs in Git; scans before commit.
- Drift detection (`Recommendation`): scheduled re-capture + normalize + diff per governed agent, at review cadence per tier and after any platform announcement of agent-model changes. Watch two more drift classes the field flags: **knowledge staleness** (stale sources silently degrade retrieval; add source freshness to the review checklist) and **model-version drift** (platform model swaps change behavior with zero config change — rerun the eval pack when Atlassian announces model updates).

---

## 5. Platform Comparison

All rows `Source-backed` except the last two, which are `Recommendation`. As of July 2026.

| Dimension | Atlassian Rovo | Copilot Studio / M365 agents | Claude Enterprise | ChatGPT Enterprise | Custom internal |
|---|---|---|---|---|---|
| Config source of truth | Studio UI only; no public config API, no export/import (gap ROVO-516); versioning/drafts "coming soon" as of Apr 2026; Forge `rovo:agent` is the only code path | Dataverse solutions; native Git integration to Azure DevOps (human-readable); pipelines for dev/test/prod; some settings not solution-aware | No agent config surface per se; skills/MCP/managed settings (`managed-settings.json`) are the config objects | Workspace Agents (Apr 2026, research preview, GPT successor); configs visible via Compliance API | Whatever you build; Git-native by default |
| Permission model | Creation restrictable to ≤10 groups; agent access individual-users-only (no groups/teams); owner/editor/manager roles; acts with invoking user's permissions | Environment + Managed Environment sharing limits; DLP policies; M365 admin block/approve; Entra Agent ID identities; IP firewall caveat | RBAC incl. custom roles; org-wide connector tool-level permissions; managed MCP allowlists | RBAC incl. custom roles; GPT create/share scoping; Actions domain allowlist; apps disabled by default | Your IAM; agent identity is your problem (Entra Agent ID supports third-party via federation) |
| Knowledge handling | Confluence/Jira + Teamwork Graph connectors + third-party MCP; respects user permissions | Graph + connectors; DLP can restrict knowledge sources; SharePoint agents "no new privileges" | Projects, connectors/MCP governed org-wide | Apps/connectors per-app enablement; Connector Registry | Fully yours; staleness management is fully yours too |
| Eval support | Agent Evaluations shipped ~Mar 2026: CSV ≤50 prompts, LLM judge, accuracy/resolution, export | Test panel + test-case evaluation (preview); Azure AI Foundry agent evaluators (intent, task adherence, tool accuracy) | None native for chat agents; strong external ecosystem | Evals product/API; promptfoo acquired Mar 2026 → folding into Frontier | promptfoo/LangSmith/Braintrust; eval-gated CI is the norm |
| Auditability | Org audit log (agent CRUD, chat started); usage analytics per agent | Purview audit (interactions + maker actions); Copilot Control System reporting | 180-day audit logs; Compliance API; SIEM integrations | Compliance API incl. agent configs/runs; IP allowlisting | Build it or lose it |
| Deployment/promotion controls | None: no staging, no environment separation, no draft/publish (yet); "verified agent" marking is the promotion primitive | Strongest: environments, pipelines, approval-gated agent store publishing, quarantine API | Skill/connector provisioning is the deployment act | Admin approval scoping for agents/GPTs; Frontier adds full IAM | CI/CD; GitHub agent control plane GA Feb 2026 |
| Biggest governance risk | Sprawl + drift: open creation by default, individual-only access control, no version history, no API — runtime truth is fragile | Complexity: agents span PPAC, M365 admin, Purview, Entra; non-solution-aware settings silently diverge across environments | Shadow usage outside admin view; agent-like behavior via skills without registry | GPT/agent sprawl during Workspace Agents transition; action allowlist gaps | Everything: no guardrails you didn't build |
| Workbench opportunity | **Highest.** The workbench IS the missing version control, registry, and promotion evidence | Medium: adopt native ALM; workbench holds evidence, evals, and cross-platform registry row | Medium: registry row + eval packs + managed-settings/skills as reviewed artifacts | Medium: registry row + Compliance API pulls | High: workbench pattern becomes the CI template |

`Recommendation` — the portfolio play: Rovo is where the workbench substitutes for missing platform features; Copilot is where it must *integrate* with native features or look redundant; Claude/ChatGPT are where it provides the only cross-cutting inventory. Design the registry schema so one row describes an agent on any of the four, with platform-specific extension blocks.

---

## 6. Measurement Model

### Principles (`Source-backed` rationale, `Recommendation` design)

McKinsey's State of AI finds only ~39% of adopters attribute any EBIT impact to AI; BCG's 10-20-70 finding attributes 70% of AI success to people/process change. The credible posture is behavioral evidence over dollarized claims — which your field-level, no-percentage-score stance already embodies.

| Metric family | Measure | Honest form |
|---|---|---|
| Adoption | Sessions/user, repeat usage, active pilot users | Counts from platform analytics; never extrapolated |
| Quality | Accepted / edited / rejected outputs; eval pass rates over time | The single best assistive-agent value proxy per current practice |
| Time saved | Self-reported estimate per accepted output, stated as a range | Label "self-reported estimate"; never convert to dollars without finance sign-off |
| Reuse / avoided duplication | Intake decisions routed to reuse/improve/merge; duplicate builds prevented | Count of decisions with links to the records |
| Risk reduction | Governed agents with complete fields (present/total); incidents; unsafe outputs caught in eval vs. production; drift found and reconciled | Field-level, exactly as your completeness contract already does |
| Cost | Platform credit consumption (Rovo credits, Copilot Credits) per agent | Direct from billing surfaces |

### Evidence thresholds (`Recommendation`)

| Stage | Enough evidence looks like |
|---|---|
| Pilot approval | Complete required fields; passing eval pack (platform-executed where possible); parity check; named users + feedback channel |
| Team promotion | ≥3-4 weeks pilot; majority of outputs accepted or lightly edited; zero unresolved unsafe outputs; owner attests source freshness; pilot users would object to losing it (ask them) |
| Broader rollout | Two+ teams with consistent acceptance; incident + remediation history demonstrating the loop works; support/ownership model that doesn't route through one person; cost per active user known |

### Leadership dashboard (monthly snapshot, one page)

Portfolio counts by lifecycle status and risk tier; governance coverage (agents with complete fields, present/total); adoption and acceptance trend for piloted agents; reuse decisions and duplicates prevented; incidents/unsafe outputs and their resolution; top 3 asks needing human decision. Nothing percentage-scored, nothing dollarized without finance.

---

## 7. Build Roadmap

See `roadmap-30-60-90-2026-07.md` (companion file) for the full 30/60/90, top 10 build items, and top 10 risks.

## 8. Forward Deployment Engineer Growth Plan

Positioning, skills roadmap, and portfolio are in the companion positioning file (intended for `docs/private-overlays/`, per repo rule keeping personal career material out of shared truth).

---

## 9. Challenging Your Assumptions

Direct, as requested. Each critique names the risk and the simplification that preserves safety and auditability.

**1. The process is heavier than the portfolio it governs.** A 13-step lifecycle, 8 promotion stages, a 10-element package, and 12+ required fields currently govern roughly two pilot agents. That ratio reads as governance theater to a skeptical manager and as friction to a builder. *Simplify:* collapse to the five gates (Section 3); apply full depth only at Tier 2+. Measure your own overhead: if intake-to-pilot takes longer than building the agent, builders will route around you — and IBM's data says shadow routes are the expensive ones.

**2. Bus factor of one, and too local.** The repo lives on your machine, in PowerShell, on Windows, with capture via a DevTools console snippet. No teammate could run it tomorrow; no org system depends on it. It is currently a personal practice, not an internal capability. *Simplify/fix:* get it into org-hosted Git with a second maintainer as the explicit 60-day goal; make the checks runnable in CI (pwsh on runners) rather than on your laptop. An unreviewed control plane is itself an ungoverned system.

**3. The capture workflow is the most fragile link and may be obsoleted.** DevTools capture of undocumented GraphQL responses breaks on any Studio refactor, and Atlassian lists agent versioning/drafts and sprawl management as "coming soon" (Apr 2026 update). *Plan for it:* treat capture as a disposable adapter behind the normalized schema. When Atlassian ships versioning, celebrate, delete your workaround, and keep the governance record — the registry, evals, and evidence remain yours. Same logic when Rovo Evaluations or group-based access mature: **native feature adoption should be a roadmap event, not a threat.**

**4. Too Rovo-shaped.** The schema, page families, and scripts assume Studio's vocabulary. Your stated goal is cross-platform. *Fix:* extract a platform-neutral core record (the ~16 fields) with platform extension blocks; prove it by registering one Copilot or Claude-side agent in the same inventory within 90 days — even a trivial one. One real second-platform row is worth more than any amount of generalization in prose.

**5. Manual measurement will decay.** Feedback trackers filled in by hand stop being filled in about three weeks after novelty fades. *Fix:* pull adoption numbers from platform analytics (Rovo usage analytics exist) and reserve human effort for accepted/edited/rejected sampling — small samples honestly labeled beat exhaustive logs nobody maintains.

**6. Documentation sprawl inside the governance repo.** The repo now has enough overlapping operating documents (AGENTS, START-HERE, operating model, Stage 5, team-facing pattern, principles, backlog, roadmap) that drift between them is a real risk — the exact disease it treats in Confluence. *Fix:* declare one canonical operating document; make others thin pointers; let the consistency checks you already wrote police your own docs.

**7. Governance-first framing may cap adoption.** Teams do not adopt governance; they adopt useful agents that happen to be governed. If the pitch leads with controls, you become the compliance desk. *Fix:* lead every conversation with a pain point solved and time given back; the governance record is how you *keep* the win, not the win itself. The paved road must be faster than the dirt path: intake in ten minutes, reuse answer same day, pilot in days.

**8. Approval bottleneck risk.** Every gate currently converges on you and a small steward group. At any real volume this becomes the queue everyone resents. *Fix:* tier-1 agents should be self-service against a checklist; your review effort should concentrate on Tier 2-3 and on auditing samples of Tier 1 after the fact.

---

## 10. Source Register

Official platform documentation: [Rovo agent permissions & governance](https://support.atlassian.com/rovo/docs/rovo-agent-permissions-and-governance/) · [Manage who can create in Studio](https://support.atlassian.com/studio/docs/manage-who-can-create-in-studio/) · [Rovo Agent Evaluations](https://support.atlassian.com/rovo/docs/evaluate-the-performance-of-your-rovo-agent/) · [Verified Rovo agents](https://support.atlassian.com/rovo/docs/whats-a-verified-rovo-agent/) · [Rovo usage analytics](https://support.atlassian.com/rovo/docs/track-how-often-a-rovo-agent-is-used/) · [Atlassian audit log activities](https://support.atlassian.com/security-and-access-policies/docs/audit-log-activities-database/) · [Forge rovo:agent module](https://developer.atlassian.com/platform/forge/manifest-reference/modules/rovo-agent/) · [Rovo bi-monthly update Apr 2026](https://community.atlassian.com/forums/Rovo-articles/What-s-New-in-Rovo-Agents-Your-Bi-Monthly-Update/ba-p/3214108) · [Copilot Studio ALM](https://learn.microsoft.com/en-us/microsoft-copilot-studio/guidance/alm) · [Dataverse Git integration](https://learn.microsoft.com/en-us/power-platform/alm/git-integration/overview) · [M365 Agent Registry](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/agent-registry?view=o365-worldwide) · [Agent actions](https://learn.microsoft.com/en-us/microsoft-365/admin/manage/agent-actions?view=o365-worldwide) · [Copilot Studio DLP](https://learn.microsoft.com/en-us/microsoft-copilot-studio/admin-data-loss-prevention) · [Purview audit for Copilot](https://learn.microsoft.com/en-us/purview/audit-copilot) · [Copilot Control System](https://learn.microsoft.com/en-us/copilot/microsoft-365/copilot-control-system/overview) · [Entra Agent ID](https://learn.microsoft.com/en-us/entra/agent-id/what-is-microsoft-entra-agent-id) · [Agent ID governance](https://learn.microsoft.com/en-us/entra/id-governance/agent-id-governance-overview) · [Azure AI Foundry agent evaluators](https://learn.microsoft.com/en-us/azure/foundry/concepts/evaluation-evaluators/agent-evaluators) · [Claude Enterprise](https://www.anthropic.com/product/enterprise) · [Claude audit logs](https://support.claude.com/en/articles/9970975-access-audit-logs) · [Claude Compliance API](https://platform.claude.com/docs/en/manage-claude/compliance-api) · [Claude Code managed settings](https://docs.claude.com/en/docs/claude-code/settings) · [Managed MCP](https://code.claude.com/docs/en/managed-mcp) · [Org connector authorization](https://support.claude.com/en/articles/15537633-authorize-mcp-connectors-for-your-entire-organization) · [Skills provisioning](https://support.claude.com/en/articles/13119606-provision-and-manage-skills-for-your-organization) · [Managing GPT access](https://help.openai.com/en/articles/8555535-managing-gpt-access-in-enterprise-and-edu-workspaces) · [OpenAI Compliance Platform](https://help.openai.com/en/articles/9261474-openai-compliance-platform-for-enterprise-and-edu-customers) · [OpenAI enterprise privacy](https://openai.com/enterprise-privacy/) · [Workspace Agents](https://openai.com/index/introducing-workspace-agents-in-chatgpt/) · [OpenAI Frontier](https://openai.com/index/introducing-openai-frontier/) · [OpenAI–promptfoo](https://openai.com/index/openai-to-acquire-promptfoo/)

Frameworks and regulation: [NIST AI RMF](https://www.nist.gov/itl/ai-risk-management-framework) · [NIST GenAI Profile AI-600-1](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf) · [NIST COSAiS agent overlays](https://csrc.nist.gov/projects/cosais) · [ISO/IEC 42001](https://www.iso.org/standard/42001) · [EU AI Act timeline](https://ai-act-service-desk.ec.europa.eu/en/ai-act/timeline/timeline-implementation-eu-ai-act) · [OWASP GenAI/LLM Top 10 & Agentic](https://genai.owasp.org/) · [NAIC AI topic + model bulletin](https://content.naic.org/insurance-topics/artificial-intelligence) · [24th state adoption](https://www.insurereinsure.com/2025/03/19/wisconsin-becomes-the-24th-state-to-adopt-the-naic-model-bulletin-on-the-use-of-ais-in-insurance/)

Practice and market: [Anthropic: Demystifying evals for AI agents](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents) · [Gartner agentic cancellations](https://www.gartner.com/en/newsroom/press-releases/2025-06-25-gartner-predicts-over-40-percent-of-agentic-ai-projects-will-be-canceled-by-end-of-2027) · [IBM Cost of a Data Breach 2025](https://newsroom.ibm.com/2025-07-30-ibm-report-13-of-organizations-reported-breaches-of-ai-models-or-applications,-97-of-which-reported-lacking-proper-ai-access-controls) · [MIT NANDA coverage](https://fortune.com/2025/08/18/mit-report-95-percent-generative-ai-pilots-at-companies-failing-cfo/) · [McKinsey State of AI](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai) · [BCG AI impact gap](https://www.bcg.com/publications/2025/closing-the-ai-impact-gap) · [GitHub agent control plane GA](https://github.blog/changelog/2026-02-26-enterprise-ai-controls-agent-control-plane-now-generally-available/) · [LangChain HITL](https://docs.langchain.com/oss/python/langchain/human-in-the-loop) · [Anthropic FDE posting](https://job-boards.greenhouse.io/anthropic/jobs/4985877008) · [Palantir AI FDE](https://www.palantir.com/docs/foundry/ai-fde/overview)

Known UNCONFIRMED items: whether Rovo agent versioning/drafts, batch evals, or sprawl management shipped by July 2026 (all "coming soon" as of Apr 2026); exact Guard tier for Rovo audit events; FDE market-growth percentages and vendor JV details (press-only); NAIC adoption count beyond 24 (early-2025 verified figure); Copilot Studio test-case evaluation GA status.
