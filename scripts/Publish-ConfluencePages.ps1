[CmdletBinding()]
param(
    [string] $EnvPath = ".\.env",
    [string] $ConfigPath = ".\config\confluence-pages.yml",
    [switch] $Apply
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Read-DotEnv {
    param([Parameter(Mandatory = $true)][string] $Path)

    $resolvedPath = Resolve-Path -LiteralPath $Path
    $config = @{}
    foreach ($line in Get-Content -LiteralPath $resolvedPath) {
        if ($line -match "^\s*#" -or [string]::IsNullOrWhiteSpace($line)) { continue }
        if ($line -match "^\s*([A-Za-z_][A-Za-z0-9_]*)\s*=\s*(.*)\s*$") {
            $config[$Matches[1]] = $Matches[2].Trim().Trim('"').Trim("'")
        }
    }

    return $config
}

function Read-ConfluencePageConfig {
    param([Parameter(Mandatory = $true)][string] $Path)

    $resolvedPath = Resolve-Path -LiteralPath $Path
    $spaceKey = $null
    $pages = @()
    $current = $null
    $currentList = $null

    foreach ($line in Get-Content -LiteralPath $resolvedPath) {
        $trimmed = $line.Trim()
        if ([string]::IsNullOrWhiteSpace($trimmed) -or $trimmed.StartsWith("#")) { continue }

        if ($trimmed -match "^spaceKey:\s*(.+)$") {
            $spaceKey = $Matches[1].Trim().Trim('"')
            continue
        }

        if ($trimmed -eq "pages:") { continue }

        if ($line -match "^\s{2}-\s+slug:\s*(.+)$") {
            if ($null -ne $current) { $pages += [pscustomobject] $current }
            $current = [ordered]@{
                slug = $Matches[1].Trim().Trim('"')
                labels = @()
            }
            $currentList = $null
            continue
        }

        if ($null -eq $current) { continue }

        if ($line -match "^\s{4}([A-Za-z][A-Za-z0-9]*):\s*(.*)$") {
            $key = $Matches[1]
            $value = $Matches[2].Trim()
            $currentList = $null
            if ($value -eq "null") { $current[$key] = $null }
            elseif ($value -eq "") {
                $current[$key] = if ($key -eq "labels") { @() } else { $null }
                $currentList = $key
            }
            else {
                $current[$key] = $value.Trim('"')
            }
            continue
        }

        if ($line -match "^\s{6}-\s+(.+)$" -and $currentList) {
            $current[$currentList] = @($current[$currentList]) + $Matches[1].Trim().Trim('"')
        }
    }

    if ($null -ne $current) { $pages += [pscustomobject] $current }

    if ([string]::IsNullOrWhiteSpace($spaceKey)) {
        throw "Missing spaceKey in $Path"
    }

    return [pscustomobject]@{
        spaceKey = $spaceKey
        pages = @($pages)
    }
}

function ConvertTo-ConfluenceStorage {
    param([Parameter(Mandatory = $true)][string] $Markdown)

    function Encode-Html {
        param([AllowNull()][string] $Text)

        if ($null -eq $Text) { return "" }
        return [System.Net.WebUtility]::HtmlEncode($Text)
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

function New-ConfluenceHeaders {
    param([Parameter(Mandatory = $true)] $Config)

    foreach ($key in @("CONFLUENCE_API_BASE", "ATLASSIAN_EMAIL", "ATLASSIAN_API_TOKEN")) {
        if (-not $Config.ContainsKey($key) -or [string]::IsNullOrWhiteSpace($Config[$key])) {
            throw "Missing required .env value: $key"
        }
    }

    $pair = "$($Config["ATLASSIAN_EMAIL"]):$($Config["ATLASSIAN_API_TOKEN"])"
    $auth = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($pair))
    return @{
        Authorization = "Basic $auth"
        Accept = "application/json"
        "Content-Type" = "application/json"
    }
}

function Find-ConfluencePageByTitle {
    param(
        [Parameter(Mandatory = $true)][string] $BaseUrl,
        [Parameter(Mandatory = $true)][hashtable] $Headers,
        [Parameter(Mandatory = $true)][string] $SpaceKey,
        [Parameter(Mandatory = $true)][string] $Title
    )

    $cql = [uri]::EscapeDataString("space = `"$SpaceKey`" and title = `"$Title`"")
    $uri = "$BaseUrl/rest/api/content/search?cql=$cql&limit=5&expand=ancestors,version"
    return Invoke-RestMethod -Method Get -Uri $uri -Headers $Headers
}

function New-ConfluencePage {
    param(
        [Parameter(Mandatory = $true)][string] $BaseUrl,
        [Parameter(Mandatory = $true)][hashtable] $Headers,
        [Parameter(Mandatory = $true)][string] $SpaceKey,
        [Parameter(Mandatory = $true)] $Page,
        [Parameter(Mandatory = $true)][string] $StorageValue,
        [AllowNull()][string] $ParentPageId
    )

    $body = [ordered]@{
        type = "page"
        title = $Page.title
        space = @{ key = $SpaceKey }
        body = @{
            storage = @{
                value = $StorageValue
                representation = "storage"
            }
        }
    }

    if (-not [string]::IsNullOrWhiteSpace($ParentPageId)) {
        $body.ancestors = @(@{ id = $ParentPageId })
    }

    $json = $body | ConvertTo-Json -Depth 100
    return Invoke-RestMethod -Method Post -Uri "$BaseUrl/rest/api/content" -Headers $Headers -Body $json
}

function Add-ConfluenceLabels {
    param(
        [Parameter(Mandatory = $true)][string] $BaseUrl,
        [Parameter(Mandatory = $true)][hashtable] $Headers,
        [Parameter(Mandatory = $true)][string] $PageId,
        [Parameter(Mandatory = $true)][string[]] $Labels
    )

    if (@($Labels).Count -eq 0) { return $null }
    $body = @($Labels | ForEach-Object { @{ prefix = "global"; name = $_ } }) | ConvertTo-Json -Depth 10
    return Invoke-RestMethod -Method Post -Uri "$BaseUrl/rest/api/content/$PageId/label" -Headers $Headers -Body $body
}

function Write-LocalPageIds {
    param(
        [Parameter(Mandatory = $true)][string] $ConfigPath,
        [Parameter(Mandatory = $true)] $Pages
    )

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add("# Local Confluence page publishing targets. This file is ignored by Git.")
    $lines.Add("spaceKey: ROVO")
    $lines.Add("pages:")
    foreach ($page in $Pages) {
        $lines.Add("  - slug: $($page.slug)")
        $lines.Add("    title: $($page.title)")
        $lines.Add("    sourcePath: $($page.sourcePath)")
        if ($page.PSObject.Properties["parentSlug"] -and -not [string]::IsNullOrWhiteSpace($page.parentSlug)) {
            $lines.Add("    parentSlug: $($page.parentSlug)")
        }
        $lines.Add("    labels:")
        foreach ($label in @($page.labels)) {
            $lines.Add("      - $label")
        }
        $pageId = if ([string]::IsNullOrWhiteSpace($page.pageId)) { "null" } else { '"' + $page.pageId + '"' }
        $parentPageId = if ([string]::IsNullOrWhiteSpace($page.parentPageId)) { "null" } else { '"' + $page.parentPageId + '"' }
        $lines.Add("    pageId: $pageId")
        $lines.Add("    parentPageId: $parentPageId")
    }

    Set-Content -LiteralPath $ConfigPath -Value $lines -Encoding UTF8
}

$envConfig = Read-DotEnv -Path $EnvPath
$pageConfig = Read-ConfluencePageConfig -Path $ConfigPath
$baseUrl = $envConfig["CONFLUENCE_API_BASE"].TrimEnd("/")
$headers = New-ConfluenceHeaders -Config $envConfig

$createdOrPlanned = @()
$pageBySlug = @{}
foreach ($page in $pageConfig.pages) {
    $pageBySlug[$page.slug] = $page
}

foreach ($page in $pageConfig.pages) {
    if (-not (Test-Path -LiteralPath $page.sourcePath)) {
        throw "Missing sourcePath for $($page.slug): $($page.sourcePath)"
    }

    $existing = Find-ConfluencePageByTitle -BaseUrl $baseUrl -Headers $headers -SpaceKey $pageConfig.spaceKey -Title $page.title
    if ($existing.size -gt 0) {
        $page.pageId = [string] $existing.results[0].id
    }

    $parentPageId = $page.parentPageId
    if ([string]::IsNullOrWhiteSpace($parentPageId) -and $page.PSObject.Properties["parentSlug"] -and -not [string]::IsNullOrWhiteSpace($page.parentSlug)) {
        if (-not $pageBySlug.ContainsKey($page.parentSlug)) {
            throw "Unknown parentSlug '$($page.parentSlug)' for page '$($page.slug)'"
        }
        $parentPageId = $pageBySlug[$page.parentSlug].pageId
    }

    $action = if ([string]::IsNullOrWhiteSpace($page.pageId)) { "create" } else { "exists" }
    $createdPageId = $page.pageId
    if ($Apply -and $action -eq "create") {
        if ($page.PSObject.Properties["parentSlug"] -and -not [string]::IsNullOrWhiteSpace($page.parentSlug) -and [string]::IsNullOrWhiteSpace($parentPageId)) {
            throw "Cannot create '$($page.title)' because parent '$($page.parentSlug)' has no pageId yet."
        }
        $markdown = Get-Content -LiteralPath $page.sourcePath -Raw
        $storage = ConvertTo-ConfluenceStorage -Markdown $markdown
        $created = New-ConfluencePage -BaseUrl $baseUrl -Headers $headers -SpaceKey $pageConfig.spaceKey -Page $page -StorageValue $storage -ParentPageId $parentPageId
        $createdPageId = [string] $created.id
        $page.pageId = $createdPageId
        if (@($page.labels).Count -gt 0) {
            Add-ConfluenceLabels -BaseUrl $baseUrl -Headers $headers -PageId $createdPageId -Labels @($page.labels) | Out-Null
        }
    }

    $createdOrPlanned += [pscustomobject]@{
        slug = $page.slug
        title = $page.title
        action = $action
        pageId = $createdPageId
        parentPageId = $parentPageId
        sourcePath = $page.sourcePath
        labels = @($page.labels)
    }
}

if ($Apply) {
    Write-LocalPageIds -ConfigPath $ConfigPath -Pages $pageConfig.pages
}

[pscustomobject]@{
    mode = if ($Apply) { "apply" } else { "dry-run" }
    spaceKey = $pageConfig.spaceKey
    pageCount = @($createdOrPlanned).Count
    pages = @($createdOrPlanned)
} | ConvertTo-Json -Depth 20
