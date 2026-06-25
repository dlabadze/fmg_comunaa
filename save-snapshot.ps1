# FMG Community - save final snapshot (ASCII only)
$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$prototype = Join-Path $root 'prototype'
$templates = Join-Path $root 'save-templates'
$indexPath = Join-Path $prototype 'index.html'
$themePath = Join-Path $prototype 'theme.css'

if (-not (Test-Path $indexPath)) {
    Write-Host 'ERROR: prototype\index.html not found' -ForegroundColor Red
    exit 1
}

function Read-Utf8([string]$Path) {
    return [System.IO.File]::ReadAllText($Path, [System.Text.Encoding]::UTF8)
}

function Write-Utf8([string]$Path, [string]$Content) {
    $utf8 = New-Object System.Text.UTF8Encoding $true
    [System.IO.File]::WriteAllText($Path, $Content, $utf8)
}

function Apply-Template([string]$Name, [hashtable]$Vars) {
    $path = Join-Path $templates $Name
    $text = Read-Utf8 $path
    foreach ($key in $Vars.Keys) {
        $text = $text.Replace("{{$key}}", [string]$Vars[$key])
    }
    return $text.TrimStart()
}

function Get-MaxVersion([string]$BasePath) {
    $max = 0
    Get-ChildItem -Path $BasePath -Directory -ErrorAction SilentlyContinue | ForEach-Object {
        if ($_.Name -match '^prototype-v(\d+)-final$') {
            $max = [Math]::Max($max, [int]$Matches[1])
        }
    }
    $proto = Join-Path $BasePath 'prototype'
    if (Test-Path $proto) {
        Get-ChildItem -Path $proto -Filter 'index-v*-final.html' -ErrorAction SilentlyContinue | ForEach-Object {
            if ($_.Name -match '^index-v(\d+)-final\.html$') {
                $max = [Math]::Max($max, [int]$Matches[1])
            }
        }
    }
    return $max
}

$prevNum = Get-MaxVersion -BasePath $root
$nextNum = $prevNum + 1
$ver = "v$nextNum-final"
$prevVer = if ($prevNum -gt 0) { "v$prevNum-final" } else { '' }
$dst = Join-Path $root "prototype-$ver"
$indexSnap = Join-Path $prototype "index-$ver.html"
$themeSnap = Join-Path $prototype "theme-$ver.css"
$date = Get-Date -Format 'yyyy-MM-dd'
$namePrefix = Read-Utf8 (Join-Path $templates 'filename-prefix.txt').Trim()
$folderMarkerName = Read-Utf8 (Join-Path $templates 'filename-folder-marker.txt').Trim()

Write-Host ''
Write-Host "Saving $ver ($date) ..." -ForegroundColor Cyan
Write-Host ''

if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
Copy-Item $prototype $dst -Recurse -Force
Copy-Item $indexPath $indexSnap -Force
if (Test-Path $themePath) { Copy-Item $themePath $themeSnap -Force }
Copy-Item $indexPath (Join-Path $dst "index-$ver.html") -Force
if (Test-Path $themeSnap) { Copy-Item $themeSnap (Join-Path $dst "theme-$ver.css") -Force }

$vars = @{ VER = $ver; DATE = $date }
Write-Utf8 (Join-Path $prototype ($namePrefix + $ver + '.txt')) (Apply-Template 'marker-prototype.txt' $vars)
Write-Utf8 (Join-Path $dst $folderMarkerName) (Apply-Template 'marker-folder.txt' $vars)

if ($prevVer) {
    $prevVars = @{ PREV_VER = $prevVer }
    Write-Utf8 (Join-Path $dst ($namePrefix + $prevVer + '.txt')) (Apply-Template 'marker-prev.txt' $prevVars)
}

Get-ChildItem -Path $prototype -Filter '*.bat' -ErrorAction SilentlyContinue | ForEach-Object {
    if ($_.Name -eq 'save-here.bat') { return }
    $bat = Read-Utf8 $_.FullName
    if ($bat -match 'v\d+-final') {
        $bat = [regex]::Replace($bat, 'v\d+-final', $ver)
        Write-Utf8 $_.FullName $bat
    }
}

Get-ChildItem -Path $dst -Filter '*.bat' -ErrorAction SilentlyContinue | ForEach-Object {
    $bat = Read-Utf8 $_.FullName
    if ($bat -match 'v\d+-final') {
        $bat = [regex]::Replace($bat, 'v\d+-final', $ver)
        $bat = [regex]::Replace($bat, 'W2 APP\\prototype-v\d+-final', "W2 APP\prototype-$ver")
        $bat = [regex]::Replace($bat, 'W2 APP\\prototype"', "W2 APP\prototype-$ver`"")
        Write-Utf8 $_.FullName $bat
    }
}

$prevRow = ''
if ($prevVer) {
    $prevRow = "| ``prototype/index-$prevVer.html`` | წინა snapshot |`r`n"
}

$historyTail = ''
$versionMd = Join-Path $root 'VERSION.md'
if (Test-Path $versionMd) {
    $old = Read-Utf8 $versionMd
    if ($old -match '(?s)## .+\r?\n\r?\n\|[^\r\n]+\|\r?\n\|[-| ]+\|\r?\n(.*)') {
        $lines = ($Matches[1] -split '\r?\n') | Where-Object {
            $_ -match '^\| v\d+' -and $_ -notmatch [regex]::Escape($ver)
        }
        if ($lines) { $historyTail = ($lines -join "`r`n").TrimEnd() + "`r`n" }
    }
}

$versionVars = @{
    VER = $ver
    DATE = $date
    PREV_ROW = $prevRow
    HISTORY_TAIL = $historyTail
}
Write-Utf8 $versionMd (Apply-Template 'VERSION.template.md' $versionVars)

Write-Host 'Done:' -ForegroundColor Green
Write-Host "  prototype\index-$ver.html"
Write-Host "  prototype\theme-$ver.css"
Write-Host "  prototype-$ver\"
Write-Host '  VERSION.md updated'
Write-Host ''
Write-Host 'Work file: prototype\index.html' -ForegroundColor Yellow
Write-Host ''

exit 0
