# Principles Foundation For Collaborators

Use this page as the "why" behind the rules in `AGENTS.md`, `START-HERE.md`, and `docs/toolkit-operating-model.md`. Those files tell a collaborator *what* to do. This file explains *why* the repo behaves the way it does, so the operating model stays repeatable when a new person joins and the maintainer is not in the room.

This is a repo-facing collaborator document. It is not agent runtime content and is not a Confluence page. Keep the framing here work-safe and shared: it uses enterprise operating language, not sectarian or personal-belief phrasing.

## Two Layers: Personal Foundation And Shared Wording

The repo maintainer builds from a personal moral foundation. That is legitimate, but it is not the shared contract. For everything that could reach a teammate, a reviewer, a pilot user, or agent runtime, the repo uses **enterprise-safe shared wording** instead.

| Layer | Where it lives | Who it binds | Wording rule |
|---|---|---|---|
| Personal moral foundation | The maintainer's own judgment and private notes (kept out of Git, per `START-HERE.md`) | The individual, by choice | Personal vocabulary is fine in private space only |
| Enterprise-safe shared wording | This page, `AGENTS.md`, operating model, agent behavior rules | All collaborators and any agent runtime | Work-safe, non-sectarian, business-defensible language only |

Practical rule: if a value would not read cleanly in a governance review or inside an agent prompt at a regulated employer, translate it to the shared wording in the next section before writing it down. Do not put personal-belief phrasing into anything that could reach ROVO Studio, Confluence, Jira, or agent behavior rules.

## Primary Values (Enterprise-Safe)

These seven values are the primary layer. Each maps to concrete rules the repo already states. The "Repo status" column is an honest assessment, not a claim of perfect adherence (see the gap assessment below).

| Value | Work-safe meaning | Where the repo already applies it | Repo status |
|---|---|---|---|
| Truthfulness | Say only what is true; never claim a command, publish, Studio save, Jira action, or live verification happened unless it did; label evidence honestly | `AGENTS.md` Validation ("Do not claim ... unless it actually happened"); evidence labels in `docs/stage-5-contributor-helper-guide.md` | Strong, explicit |
| Stewardship | Treat Git-backed docs, schemas, scripts, and history as a durable audit trail; reuse before creating; keep the smallest coherent artifact set | Operating model source-of-truth order; duplicate-prevention workflow; "smallest reviewable slice" | Strong, explicit |
| Humility | State assumptions when evidence is incomplete; stop and report drift instead of guessing; the Design Agent may say "do not build" | `AGENTS.md` Operating Posture and Source Of Truth; intake "not ready" outcome | Strong, explicit |
| Service | Build for the people who use the work: pilot users should not need the repo; guidance should reduce live handoff burden | Stage 5 audience map; control-plane promise; start-here guides | Strong, mostly explicit |
| Justice / fairness | Consistent rules for all agents and ideas; required governance fields applied evenly; no favored shortcuts around review | Non-negotiable agent fields; lifecycle statuses; promotion stages | Moderate, partly implicit |
| Care for people | Protect people from harm: no unsafe or overconfident agent output, no leaking private or regulated data, escalate people-affecting decisions | Pilot boundaries escalation triggers; private-data handling; human-owned decisions | Strong on data/safety, thinner on explicit "people impact" naming |
| Accountability | Decisions that affect status, ownership, approval, visibility, or people stay human-owned; changes are reviewable and attributable | `AGENTS.md` Human-Owned Decisions; branch/commit slice pattern; publish-history records | Strong, explicit |

## Secondary Method: First-Principles Reasoning

Values decide *whether* and *why*. First-principles reasoning decides *how* to design the smallest correct thing. Use it as the design method once a value check says the work is worth doing.

1. **Define the actual problem.** Name the workflow pain or governance gap before naming a solution or an agent. (Mirrors Stage 5 step 1: "Name the workflow problem before naming an agent.")
2. **Identify source truth.** Establish which surface is authoritative — repo, Confluence, Studio, or Jira — using the source-of-truth order. If surfaces disagree, that is drift; stop and report it.
3. **Reduce scope.** Cut to the smallest reviewable slice with one observable outcome and explicit in/out-of-scope boundaries.
4. **Expose assumptions.** Write down what you are inferring and label it. Do not let a prompt, chat history, or unsanitized export silently become "truth."
5. **Test the smallest useful slice.** Prefer read-only-first and dry-run-first. Validate with the minimum truthful checks for the changed surface; say plainly when validation is partial or manual.
6. **Avoid unnecessary complexity.** Do not add automation, pages, tools, or write-back before the dry-run, history, and verification loops are reliable. Reuse over rebuild.

These six steps are already latent across `AGENTS.md`, the operating model, and the Stage 5 lifecycle. This page names them as one repeatable method so a new collaborator does not have to reverse-engineer them.

## Collaborator Checklist

Run this before calling a slice ready. It is meant to be actionable, not philosophical.

- [ ] **Truth before usefulness.** Would every claim in my output survive a "did this actually happen?" check? Have I avoided implying a publish, Studio save, Jira action, or approval that did not occur?
- [ ] **People-impact review.** Could this change affect a real person's work, record, readiness, standing, or private data? If yes, escalate or route to the human owner rather than deciding it.
- [ ] **Stewardship / reuse check.** Did I search the inventory and existing docs before creating something new? Is this the smallest coherent artifact set, or am I duplicating a page, agent, or script?
- [ ] **Smallest useful slice.** One observable outcome? Clear in/out-of-scope? Read-only-first or dry-run-first where a live surface is involved?
- [ ] **Explicit evidence labels.** Are assumptions and unknowns labeled `User-provided`, `Source-backed`, `Data Incomplete`, or `UNKNOWN` (per the contributor helper guide) rather than stated as fact?
- [ ] **Human-owned decisions untouched.** Did I avoid promoting or implying approval for `Active`/broadly `Ready`/pilot status, owner or backup assignment, retirement, Studio visibility/permissions, policy exceptions, or Jira write capability?
- [ ] **Source-failure behavior.** If a required source is missing, stale, or contradictory, did I stop and report drift and recommend the smallest reconciliation path, instead of guessing or silently picking one surface?

## Honest Gap Assessment

The repo already follows most of these principles in practice, but adherence is uneven and often implicit. This page does not claim perfect adherence anywhere.

| Area | Current state | Honest gap |
|---|---|---|
| Truthfulness | Explicit and repeated across `AGENTS.md` and helper guide | Strong; main risk is drift in ad-hoc chat work that never reaches these files |
| Stewardship / reuse | Duplicate-prevention and source-of-truth order are documented | Reuse discipline depends on the collaborator actually searching first; not enforced by tooling for docs |
| Humility / assumptions | "State assumptions" is stated; evidence labels exist | Assumption labeling is inconsistent outside Stage 5 artifacts; not all docs use the label vocabulary |
| Service | Audience separation is well designed in Stage 5 | Some older docs predate the audience map and do not point to it |
| Justice / fairness | Required fields and lifecycle are uniform on paper | Applied unevenly across agent page families; some families are missing expected child artifacts |
| Care for people | Data safety and escalation are strong | "People impact" is implied through data/escalation rules but rarely named as its own review step — this checklist is the first explicit statement |
| Accountability | Human-owned decisions and commit/branch discipline are explicit | Attribution depends on commit hygiene; not machine-verified |
| First-principles method | All six steps exist latently | They were never collected as one named method before this page (`Source-backed`: `AGENTS.md`, operating model, Stage 5 lifecycle) |

Evidence note: the "already applies it" and "current state" columns are `Source-backed` by the files listed under each row. The "Repo status" and "Honest gap" judgments are the author's assessment (`Data Incomplete` for anything not verified by a tool run); they are a starting read for reviewers, not an audited score.

## Follow-Ups (Out Of First Slice)

These are deliberately left for later so this first slice stays small and reviewable:

- Add explicit assumption/evidence labels to older docs that predate the Stage 5 evidence-label vocabulary.
- Add a "people-impact" prompt to the relevant handoff and review templates so care-for-people becomes a named step, not an implied one.
- Decide, under human governance, whether any work-safe subset of these values should inform agent behavior rules — and if so, keep the wording strictly non-sectarian and route it through the normal review and Studio-copy boundaries.

## Boundaries For This Page

- This is repo-facing guidance. It performs no Studio, Jira, or Confluence writes.
- Personal-belief or sectarian phrasing stays out of this page and out of anything that could reach agent runtime; only enterprise-safe shared wording is used here.
- Nothing here changes approval authority, ownership, readiness, or visibility. Human-owned decisions remain human-owned.
