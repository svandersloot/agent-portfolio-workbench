# QA Test Case Architect v2 — CSV-to-File Flow + XRAY Import Round-Trip Verification Plan (2026-07)

| Field | Value |
|---|---|
| Date | 2026-07-13 |
| Author | Governance workbench (Claude Code), read-only-first |
| Related | GitHub issue #13 (Slice S10); `qa-test-case-architect-v2-session-review-2026-07-10.md`; `qa-test-case-architect-v2-session-review-followups-2026-07-10.md` |
| Purpose | Document the manual CSV-to-file conversion flow observed in Session 1 and define a plan to verify the XRAY import round-trip, which was explicitly **not** verified in-session. |
| Boundary | Repo documentation only. No ROVO Studio, Jira, XRAY, or Confluence write. The import dry-run itself is a gated follow-up session action, not performed by this repo. |

> **Status note (2026-07-14):** Per the Session-2 decision ("Generate the full CSV file that we just download and import. No more Copilot in the middle." — `qa-test-case-architect-v2-session-2-csv-import-decisions-2026-07.md`, §2/§6), the agent is now instructed to generate the finalized, validation-passing TestSuite CSV directly as a downloadable UTF-8 `.csv` file when the runtime supports file emission. The manual Copilot conversion step in §2 below is superseded as the intended path under that condition and is retained as the **fallback path** for runtimes that cannot emit a file. The manual XRAY import and the round-trip verification in §3 remain the gated follow-up (human action; no XRAY write from this repo).

---

## 1. Current state (Session 1)

- ROVO cannot emit a file. The agent returns **CSV as chat text** by design; a human must convert it to an actual `.csv` file (session review E1).
- In-session, the group ran the CSV text through a manual Copilot copy-paste-convert step to produce a downloadable file, then discussed importing it back into the story.
- The **import back into XRAY was not completed or verified** in-session (session review E21). This is an open validation gate, not a proven capability.

This flow is consistent with the governance boundary: the agent produces review-ready text; all writes into XRAY/Jira remain manual and human-driven until an approved connector exists.

## 2. Documented CSV-to-file conversion flow (manual — fallback path)

The steps below describe the observed manual path. They are a **description of the current manual process**, not an automation this repo performs.

1. Run the agent (raw-CSV-only mode) to produce the TestSuite CSV as chat text.
2. Copy the CSV text block from the chat output.
3. Paste it into the approved manual conversion step (in-session: Copilot) to produce a `.csv` file.
4. Save the `.csv` file locally per the team's data-handling rules (no unsanitized customer/PII data).
5. Perform the XRAY import manually through the normal XRAY import UI.

**Notes / risks for the flow:**
- Encoding and delimiter fidelity must survive the copy/convert step (curly quotes, non-breaking hyphens, and embedded newlines in step text can corrupt columns). The team golden fixture shows multi-line cell values, so the converter must preserve quoted multi-line fields.
- The `.csv` must match the confirmed column contract (see [contract diff](qa-test-case-architect-v2-csv-contract-diff-2026-07.md) and S2/S3). A mismatch is the most likely import failure mode.
- No repo script converts or uploads the file. This stays a human step.

## 3. XRAY import round-trip verification plan (follow-up session)

**Objective:** Prove that an agent-produced TestSuite CSV, after the manual conversion step, imports cleanly into XRAY and produces the expected test cases with correct traceability — or capture the exact failure so it can be reconciled.

**Preconditions (gates — human-owned):**
- Confirmed, current column contract in repo source (S2 decision recorded + S3 reconciliation applied).
- A sanitized or synthetic source story suitable for a real import test.
- Import dry-run explicitly scheduled and approved for a follow-up session.
- A non-production / test XRAY target or an agreed safe import location.

**Procedure:**
1. Generate a TestSuite CSV from a known synthetic story using the confirmed contract.
2. Convert to `.csv` via the manual step (§2).
3. Import into the agreed XRAY target through the normal XRAY import UI (human action).
4. Record the result.

**What to capture (evidence — sanitized):**
- Import accepted vs rejected, and any XRAY validation errors verbatim (structural only; no customer data).
- Column-mapping behavior: did XRAY map every column, or drop/misread any?
- Dual `Test Type` column handling on import (first = Manual/Automated, second = functional category).
- Continuation-row handling: did multi-step cases import as one test with multiple steps, or split incorrectly?
- Final XRAY keys assigned vs the agent's draft TC-IDs (confirming the agent never claims final keys).
- Round-trip fidelity: do imported test cases match the generated summary/description/steps?

**Pass / partial / fail:**
- **Pass:** CSV imports with no manual column fix-ups; every test case and step lands correctly; traceability preserved.
- **Partial:** Imports after minor manual mapping/fix-ups; note each fix-up as a contract follow-up.
- **Fail:** Import rejected, columns dropped/misread, or steps/cases split incorrectly. Capture the error and route to a contract/format reconciliation slice.

## 4. Boundaries and open gates

| Item | Status | Owner |
|---|---|---|
| Manual CSV-to-file flow documented | Done (this report) | — |
| Import round-trip verified | **Open** — unverified as of Session 1 (E21) | Agent owner + QA owner |
| Import dry-run scheduled | **Open** — gated to a follow-up session | Agent owner |
| Safe XRAY import target confirmed | **Open** | QA/XRAY owner |
| Approved automated connector for file/import | **Not in scope** — remains manual until a governed connector is approved | Governance |

Nothing in this plan authorizes an automated write to ROVO Studio, Jira, XRAY, or Confluence. The import step is a human action performed in a follow-up session.
