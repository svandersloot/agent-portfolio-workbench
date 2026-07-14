# QA Test Case Architect v2 — Session-2 Decisions & Data Extract (2026-07)

| Field | Value |
|---|---|
| Authored | 2026-07-14 |
| Source | Working session "Agent Generated Test Case CSV work for Xray Import" (transcribed meeting + meeting chat). Extracted via Copilot; content limited to what was explicitly discussed. |
| Author | Governance workbench (Claude Code), read-only-first |
| Review type | Evidence extraction for improvement; no live-system change |
| Related | Session 1: `qa-test-case-architect-v2-session-review-2026-07-10.md`; follow-up plan: `qa-test-case-architect-v2-session-review-followups-2026-07-10.md`; contract-diff: `qa-test-case-architect-v2-csv-contract-diff-2026-07.md` |
| Boundary | Repo evidence only. No ROVO Studio / Jira / XRAY / Confluence writes. Records decisions and taxonomies; each contract or behavior change is applied only through its own reviewed slice. |

> **Sanitization note:** Speakers are role-labeled (SME/Agent Owner, QA SME, QA leadership, Facilitator). The functional Test Type and execution-mode values below are generic Xray/testing taxonomy and are reproduced in full. The **Application List** picklist contains internal application/platform names; per the owner's decision, the full list is **held out of this repo pending a sanitization/owner-approval pass** — only `CAS` (already used in existing repo fixtures) is reproduced here. No customer data, PII, secrets, or real Jira keys are recorded.

---

## 1. Purpose

Capture the durable decisions and controlled-value taxonomies raised in Session 2 so the follow-up slices (Priority re-add, S7 test-type/Application-List validation, S5 step quality) have a reviewable provenance record. Tags: `DECISION` (agreed), `OPINION` (one view), `OPEN` (unresolved), `MISSING` (not discussed).

## 2. Column-contract decisions

| Item | Detail | Tag |
|---|---|---|
| **Priority column re-added** | "We need to add a column for priority … it's actually required." Import may succeed without it, but downstream **workflow completion fails** unless Priority is populated. | DECISION |
| **Priority default = Low** | "Priority should always be low." Bake it in; QA can raise it later. (SME + QA SME agreement.) | DECISION |
| Dual Test Type columns | One Test Type = execution mode, always **Manual** for this team; the second = functional type, inferred from context and chosen from the approved list. | DECISION |
| Application List field | Agent determines Application List from supporting context/project, constrained to an approved picklist (see §3). | DECISION |
| Direct downloadable CSV | "Generate the full CSV file that we just download and import. No more Copilot in the middle." | DECISION (capability — see §6) |
| Naming convention | "The story ID should be the name of the sheet and the … document." | DECISION |
| TC-ID convention | "Test case IDs will start with the ID dash a sequence number for each test case." (Consistent with the merged S4 `{ProjectPrefix}-{StoryNumber}-{Seq}`.) | DECISION (confirms S4) |
| Regression flag logic | How the agent decides whether a test is regression was questioned, not resolved. | OPEN |
| Sprint field | Not discussed. | MISSING |
| Exact final column **order, header names, and Priority index** | Not confirmed in the recording. | MISSING |

**Drift to note:** re-adding Priority reverses merged slice **S3** (which removed Priority) and conflicts with the committed golden import (which has no Priority column). The recording reconciles this: the golden was import-focused; Priority is a downstream-workflow requirement. Applying it is a new reviewed slice; the exact column placement/header should be confirmed against a real Priority-bearing import.

## 3. Controlled-value taxonomies (for S7)

The team's direction is to **reduce non-determinism** by constraining these fields to approved values; the agent should infer, present its selection for review, and **not guess** — flagging for human review when a value cannot be confidently determined. Source: values extracted from Jira/Xray configuration and posted in the meeting chat.

### 3.1 Execution-mode Test Type (first Test Type column)
Approved values: **Manual**, **Generic**, **Cucumber**. This team uses **Manual** only. `DECISION`

### 3.2 Functional Test Type (second Test Type column)
Approved values (extracted from the Jira/Xray custom field): `DECISION`

```
Batch, Certification, Container - Security Test, DAST - Security Test, Database, E2E,
ETL, Functional, IaC - Security Test, IAST - Security Test, Integration, Performance,
Production, RASP - Security Test, Regression, SAST - Security Test, SCA - Security Test,
Security, Security Test – Container, Security Test – DAST, Security Test – IaC,
Security Test – IAST, Security Test – RASP, Security Test – SAST, Security Test – SCA,
User Acceptance
```

### 3.3 Application List (third controlled picklist)
An authoritative Application List picklist was extracted from Jira/Xray configuration and posted in the meeting chat. It contains **many approved internal application/platform values**. Per the sanitization decision, the **full list is held out of this repo pending sanitization and owner approval**; the only value reproduced here is **`CAS`** (already present in existing repo fixtures). `DECISION` (that a controlled list exists and must be used) / `OPEN` (full sanitized list to be captured before enforcement)

SME guidance on inference: choose the application that matches the work context (e.g., CAS work → the CAS value; a payments story → the payments application), constrained to approved values; flag for review if it cannot be determined.

### 3.4 Still open for the taxonomies
| Question | Tag |
|---|---|
| Are the values identical across all teams, or per-team? | OPEN |
| Is more than one Application List value ever allowed, and if so what delimiter? | MISSING |
| Formal ownership/governance authority for the lists (Jira admins mentioned) | OPINION / OPEN |
| Full sanitized Application List | OPEN (pending capture) |

## 4. Test-step quality (S5) — still blocked

| Item | Detail | Tag |
|---|---|---|
| Steps live in Action + Expected Result | "Look at the Action and Expected Result fields … that is the test steps." | DECISION |
| Desired model | Sequenced tests (`-1`, `-2`, `-3`) with explicit Action/Expected pairs. | DECISION |
| Use examples as patterns, not copies | Agent should learn style/patterns, not duplicate wording. | DECISION |
| Missing info → TBD | Mark missing setup as TBD rather than inventing content. | DECISION |
| Preconditions (login, claim/exposure setup, reusable preconditions) | **Not discussed** this session. | MISSING |
| Sanitized historical examples | Requested; **none provided/committed** this session. | OPEN |

**S5 remains blocked** on the two inputs from the prior handoff: sanitized SME historical test cases, and the precondition/prerequisite patterns. The step-quality model is now clearer, but the core defect (executable prerequisites) was not addressed.

## 5. Other improvements raised
| Item | Tag |
|---|---|
| Auto-generate/update evaluation datasets whenever instructions change | DECISION (process) |
| Restrict Application List and Test Type to approved values (schema constraints) | DECISION (→ S7) |
| Ensure exported CSV uses UTF encoding to avoid import/formatting problems | OPINION / RECOMMENDATION |
| Future Xray connector to inspect existing tests and avoid duplicates | OPINION / FUTURE |

## 6. Impact on the board (decisions taken 2026-07-14)
- **Priority re-add (default Low):** owner-approved to proceed as a new reviewed slice that re-adds Priority to the enforced contract, golden-copy template, and Category 4 eval. Exact column placement/header pending confirmation against a real Priority-bearing import.
- **S7:** build the infer → show → confirm → refuse/flag behavior now against the confirmed execution-mode and functional Test Type lists (§3.1, §3.2); **stage** Application List validation (§3.3) until the full sanitized list and the open questions (§3.4) are resolved.
- **S5:** stays blocked (§4).
- **Direct downloadable CSV (§2):** a runtime capability change (ROVO could not emit a file in Session 1). Treated as a separate capability decision, not a repo-doc change; the S10 manual-conversion plan remains the documented flow until a governed capability exists.

## 7. What this session does not establish
- It does not confirm the exact final CSV column order, header names, or Priority index.
- It does not provide the full sanitized Application List, the multi-value delimiter, cross-team scope, or the formal list owner.
- It does not provide sanitized historical test examples or precondition patterns (S5).
- It does not authorize any ROVO Studio, Jira, XRAY, or Confluence write, nor any promotion of the agent's readiness, ownership, or approval status.
