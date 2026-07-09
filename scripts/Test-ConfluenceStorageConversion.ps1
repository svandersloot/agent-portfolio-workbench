<#
.SYNOPSIS
Read-only regression test for the markdown -> Confluence storage converter.

.DESCRIPTION
Verifies that ConvertTo-ConfluenceStorage (scripts/lib/Convert-ConfluenceStorage.ps1)
emits storage XHTML that is well-formed XML and free of undeclared named entities
(for example &nbsp;), which the Confluence v2 API would reject as undeclared XML
entities.

Runs synthetic fixtures for the tricky constructs (XML specials, non-breaking space,
inline code, tables, code fences) and also validates every tracked
qa-test-strategy-planner-*.md page as a real-content regression. No network, no writes.
#>
[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$here = $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($here)) { $here = Split-Path -Parent $MyInvocation.MyCommand.Path }
. "$here/lib/Convert-ConfluenceStorage.ps1"
$repoRoot = Split-Path -Parent $here

$failures = New-Object System.Collections.Generic.List[string]

function Test-StorageXml {
    param([string] $Name, [string] $Markdown)

    $storage = ConvertTo-ConfluenceStorage -Markdown $Markdown

    # 1. No undeclared named entities (only the five XML built-ins are legal).
    $named = [regex]::Matches($storage, '&(?!amp;|lt;|gt;|quot;|apos;|#)[a-zA-Z][a-zA-Z0-9]*;')
    if ($named.Count -gt 0) {
        $script:failures.Add("[$Name] emitted undeclared named entity: $($named[0].Value)")
    }

    # 2. Well-formed XML (Confluence storage must parse as XML).
    try { [void][xml]("<root>$storage</root>") }
    catch { $script:failures.Add("[$Name] not well-formed XML: $($_.Exception.Message)") }

    # 3. ASCII-only: every non-ASCII char must be a numeric entity so the request
    #    body stays pure ASCII (guards against the "Invalid UTF-8 middle byte" 400).
    $nonAscii = [regex]::Matches($storage, '[^\x00-\x7F]')
    if ($nonAscii.Count -gt 0) {
        $sample = [int][char]$nonAscii[0].Value
        $script:failures.Add("[$Name] emitted a non-ASCII character (U+{0:X4}); expected a numeric entity." -f $sample)
    }
}

# --- Synthetic fixtures (the constructs most likely to break XML-safety / UTF-8 transport) ---
$nbsp = [char]0x00A0
Test-StorageXml -Name "xml-specials" -Markdown "A & B < C > D `"quoted`" and R&D pipeline."
Test-StorageXml -Name "non-breaking-space" -Markdown "Value:${nbsp}pending${nbsp}confirmation."

# Non-ASCII punctuation that previously produced "Invalid UTF-8 middle byte 0x3f":
# arrows, ellipsis, approx sign, en/em dashes, and curly quotes.
$arrow  = [char]0x2192  # ->
$ellip  = [char]0x2026  # ...
$approx = [char]0x2248  # ~=
$endash = [char]0x2013
$emdash = [char]0x2014
$ldq    = [char]0x201C
$rdq    = [char]0x201D
$lsq    = [char]0x2018
$rsq    = [char]0x2019
$unicodeMd = "Epic $arrow Feature $arrow Story. Cases PN-OV-001$($ellip)012. Readiness $approx 5.5/10. Range 4$($endash)6 hrs $emdash pending. $($ldq)quoted$($rdq) and it$($rsq)s fine."
Test-StorageXml -Name "unicode-punctuation" -Markdown $unicodeMd
Test-StorageXml -Name "inline-code" -Markdown "Use the ``interface{}`` header and ``a < b`` check."
Test-StorageXml -Name "table-with-specials" -Markdown @"
| Field | Value |
|---|---|
| Range | v5 -> v6 & up |
| Code | ``TP-<KEY>`` |
"@
Test-StorageXml -Name "code-fence-xml" -Markdown @"
Header line.

``````text
Story ID,TC ID <Execution> & "Type"
``````

Trailing paragraph.
"@

# --- Real-content regression: every QATSP page ---
$pagesDir = Join-Path $repoRoot "docs/confluence-pages"
Get-ChildItem -LiteralPath $pagesDir -Filter "qa-test-strategy-planner-*.md" -File | ForEach-Object {
    $md = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8
    Test-StorageXml -Name $_.BaseName -Markdown $md
}

Write-Output "# Confluence Storage Conversion Test"
Write-Output ""
if ($failures.Count -eq 0) {
    Write-Output "All storage-conversion checks passed (well-formed XML, no undeclared named entities)."
    exit 0
}
else {
    Write-Output "Failures: $($failures.Count)"
    foreach ($f in $failures) { Write-Output "- $f" }
    exit 1
}
