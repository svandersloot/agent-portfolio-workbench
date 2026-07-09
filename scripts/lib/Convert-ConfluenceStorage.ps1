# Convert-ConfluenceStorage.ps1
# Markdown -> Confluence storage (XHTML) converter, extracted from
# Publish-ConfluencePages.ps1 so it can be unit-tested and kept XML-safe
# for the Confluence v2 API. Dot-sourced by the publisher.

function ConvertTo-ConfluenceStorage {
    param([Parameter(Mandatory = $true)][string] $Markdown)

    function Encode-Html {
        param([AllowNull()][string] $Text)

        if ($null -eq $Text) { return "" }
        # Explicit XML-safe encoding for the Confluence v2 storage representation.
        # Emits only the five XML built-in entities; all other characters (including
        # non-breaking spaces, arrows, and dashes) are left as literal UTF-8, which
        # Confluence storage accepts. This is equivalent in XML-safety to the previous
        # WebUtility.HtmlEncode (which emits numeric entities, not named ones) but is
        # kept explicit so the output is auditable and guaranteed free of named
        # entities. Ampersand must be replaced first.
        $encoded = $Text -replace '&', '&amp;'
        $encoded = $encoded -replace '<', '&lt;'
        $encoded = $encoded -replace '>', '&gt;'
        $encoded = $encoded -replace '"', '&quot;'
        return $encoded
    }

    function Convert-InlineMarkdown {
        param([AllowNull()][string] $Text)

        $encoded = Encode-Html -Text $Text
        $encoded = $encoded -replace '`([^`]+)`', '<code>$1</code>'
        return $encoded
    }

    $lines = $Markdown -split "`r?`n"
    $html = New-Object System.Collections.Generic.List[string]
    $paragraph = New-Object System.Collections.Generic.List[string]
    $inList = $false
    $inCode = $false
    $codeLines = New-Object System.Collections.Generic.List[string]

    function Flush-Paragraph {
        if ($paragraph.Count -gt 0) {
            $html.Add("<p>$((($paragraph | ForEach-Object { Convert-InlineMarkdown $_ }) -join ' '))</p>")
            $paragraph.Clear()
        }
    }

    function Close-List {
        if ($inList) {
            $html.Add("</ul>")
            Set-Variable -Name inList -Value $false -Scope 1
        }
    }

    for ($index = 0; $index -lt $lines.Count; $index++) {
        $line = $lines[$index]
        $trimmed = $line.Trim()

        if ($trimmed.StartsWith('```')) {
            if ($inCode) {
                $joinedCode = $codeLines -join [Environment]::NewLine
                $encodedCode = Encode-Html -Text $joinedCode
                $html.Add("<pre><code>$encodedCode</code></pre>")
                $codeLines.Clear()
                $inCode = $false
            }
            else {
                Flush-Paragraph
                Close-List
                $inCode = $true
            }
            continue
        }

        if ($inCode) {
            $codeLines.Add($line)
            continue
        }

        if ([string]::IsNullOrWhiteSpace($trimmed)) {
            Flush-Paragraph
            Close-List
            continue
        }

        if ($trimmed -match "^(#{1,6})\s+(.+)$") {
            Flush-Paragraph
            Close-List
            $level = $Matches[1].Length
            $text = Convert-InlineMarkdown $Matches[2]
            $html.Add("<h$level>$text</h$level>")
            continue
        }

        if ($trimmed -match "^- (.+)$") {
            Flush-Paragraph
            if (-not $inList) {
                $html.Add("<ul>")
                $inList = $true
            }
            $html.Add("<li>$(Convert-InlineMarkdown $Matches[1])</li>")
            continue
        }

        if ($trimmed.StartsWith("|") -and $trimmed.EndsWith("|")) {
            Flush-Paragraph
            Close-List
            $tableRows = New-Object System.Collections.Generic.List[string]
            while ($index -lt $lines.Count) {
                $tableLine = $lines[$index].Trim()
                if (-not ($tableLine.StartsWith("|") -and $tableLine.EndsWith("|"))) {
                    $index -= 1
                    break
                }
                $tableRows.Add($tableLine)
                $index += 1
            }

            $html.Add("<table><tbody>")
            for ($rowIndex = 0; $rowIndex -lt $tableRows.Count; $rowIndex++) {
                $row = $tableRows[$rowIndex]
                if ($row -match "^\|\s*-+\s*(\|\s*-+\s*)+\|$") { continue }
                $cells = $row.Trim("|").Split("|") | ForEach-Object { $_.Trim() }
                $tag = if ($rowIndex -eq 0) { "th" } else { "td" }
                $html.Add("<tr>")
                foreach ($cell in $cells) {
                    $html.Add("<$tag>$(Convert-InlineMarkdown $cell)</$tag>")
                }
                $html.Add("</tr>")
            }
            $html.Add("</tbody></table>")
            continue
        }

        $paragraph.Add($trimmed)
    }

    Flush-Paragraph
    Close-List

    if ($inCode) {
        $joinedCode = $codeLines -join [Environment]::NewLine
        $encodedCode = Encode-Html -Text $joinedCode
        $html.Add("<pre><code>$encodedCode</code></pre>")
    }

    return ($html -join "`n")
}
