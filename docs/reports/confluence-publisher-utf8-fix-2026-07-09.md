# Confluence Publisher UTF-8 / Encoding Fix

Report date: 2026-07-09

Status: Code + test + dry-run only. No live Confluence apply was performed in this slice.
No publish-history was written. No page-by-page apply probing.

## Captured evidence — the real 400

The API error-body surfacing added in the prior slice (PR #23) captured the actual Confluence
rejection during the gated apply of the pending pages:

```text
Confluence update failed for page 5404590084 (Evaluation - QA Test Strategy Planner): HTTP 400
{"errors":[{"status":400,"code":"INVALID_MESSAGE","title":"Invalid message",
  "detail":"Invalid UTF-8 middle byte 0x3f\n at [Source: UNKNOWN; line: 6, column: 24062]
  (through reference chain: ...PageUpdateRequestModel[\"body\"]->...[\"value\"])"}]}
```

`0x3f` is `?`. The request body contained a byte that is not valid UTF-8 — a multibyte
character was mangled to `?` on the wire.

Net state of that gated apply: **0 of the 9 pending pages changed** (verified by a read-only
re-dry-run). No new live drift from the failed attempt.

## Root cause — two encoding defects on the publish path

1. **Request body not sent as UTF-8.** `Invoke-RestMethod -Body $json` sent the JSON string
   without forcing UTF-8, so non-ASCII characters in page content (arrows `→`, ellipses `…`,
   `≈`, en/em dashes, curly quotes) were corrupted to `0x3f` → invalid UTF-8 → HTTP 400. This
   was exposed by the prior slice's "XML-safe" encoder, which left those characters as literal
   UTF-8 (the earlier `WebUtility.HtmlEncode` had turned them into ASCII numeric entities and
   so accidentally dodged the transport bug).

2. **Source markdown read without UTF-8.** `Get-Content -LiteralPath $sourcePath -Raw` used
   the Windows PowerShell default (ANSI) encoding, so UTF-8 source files were misdecoded into
   mojibake (e.g. `→` became `â€™`-style sequences) *before* conversion. Left unfixed, the
   publish would have avoided the 400 but rendered garbled characters in Confluence.

Honesty note: this "Invalid UTF-8" 400 was most likely **introduced** by the safer XML encoder
in PR #23 (literal UTF-8), not the *original* 400 observed earlier (which ran with the
numeric-entity encoder and an ASCII body, so it could not have been this error). The original
cause was never captured before error-surfacing existed. These fixes correct the whole encoding
path; if any residual/original cause remains, the error-surfacing will report it on the next
approved apply.

## Fixes in this slice

| Area | Change |
|---|---|
| Encoder (`scripts/lib/Convert-ConfluenceStorage.ps1`) | ASCII-safe: escape the five XML specials, then convert every non-ASCII character to a numeric XML entity (`→` → `&#8594;`, `…` → `&#8230;`, nbsp → `&#160;`). Keeps the body pure ASCII and free of named entities. Surrogate pairs handled via `ConvertToUtf32`. |
| Transport (`New-`/`Update-`/`Add-Confluence*`) | Send the body as UTF-8 bytes (`[Text.Encoding]::UTF8.GetBytes`) and declare `Content-Type: application/json; charset=utf-8`. Defense-in-depth even though the encoder now emits ASCII. |
| Source read (publish loop) | `Get-Content ... -Raw -Encoding UTF8` for both create and update paths, so UTF-8 source is read faithfully (no mojibake). |
| Diagnostics (from PR #23) | `Get-ConfluenceErrorDetail` surfaces the Confluence response body on any create/update failure. |

## Verification (offline / read-only)

- `scripts/Test-ConfluenceStorageConversion.ps1` passes: every fixture and every
  `qa-test-strategy-planner-*.md` page produces well-formed XML, no undeclared named entities,
  and **ASCII-only** output. New fixture `unicode-punctuation` covers arrows, ellipsis, approx
  sign, en/em dashes, and curly quotes; `non-breaking-space` covers nbsp.
- UTF-8 read spot-check on the Evaluation page: `…` → `&#8230;` (correct), zero non-ASCII in
  output, and no mojibake sequences (`&#226;`/`&#8224;`).
- Dry-run for the 9 pending slugs is clean: 8 updates + 1 create (`Team Overlay - Payment
  Ninjas`), all existing pages resolved by title. No `-Apply` was run.

## Current live state (unchanged by this slice)

Published earlier (do not unwind): project-brain v6, agent-design-record v2, subagent-settings
v2, studio-setup v8, change-log v10.

Pending (the exact 9-slug list, awaiting approved apply): knowledge-source-plan,
runtime-contract, evaluation, measurement-plan, prompt-library, team-overlays,
team-overlay-mobi-rangers, team-overlay-mobilizers-m26, team-overlay-payment-ninjas.

## Not done (awaiting explicit approval)

- No live Confluence apply.
- No publish-history record.
- No page-by-page apply probing.
