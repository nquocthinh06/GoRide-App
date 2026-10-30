param(
  [string]$Owner = "nquocthinh06",
  [string]$Repo = "GoRide-App"
)
$ErrorActionPreference = "Stop"
$FullName = "$Owner/$Repo"
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw "Cần cài GitHub CLI: https://cli.github.com/" }
gh auth status | Out-Null
if ($LASTEXITCODE -ne 0) { throw "Chạy gh auth login trước." }
gh repo view $FullName | Out-Null
if ($LASTEXITCODE -ne 0) { throw "Chưa tạo hoặc không có quyền truy cập $FullName. Hãy tạo repository Public trước." }

Write-Host "== Labels =="
Import-Csv (Join-Path $PSScriptRoot "labels.csv") | ForEach-Object {
  gh label create $_.name --repo $FullName --color $_.color --description $_.description --force
  if ($LASTEXITCODE -ne 0) { throw "Không tạo được label $($_.name)" }
}

Write-Host "== Milestones =="
$existing = gh api --paginate "repos/$FullName/milestones?state=all&per_page=100" | ConvertFrom-Json
$milestoneTitles = @{}
foreach ($m in (Import-Csv (Join-Path $PSScriptRoot "milestones.csv"))) {
  $found = $existing | Where-Object { $_.title -eq $m.title } | Select-Object -First 1
  if (-not $found) {
    $created = gh api --method POST "repos/$FullName/milestones" -f "title=$($m.title)" -f "due_on=$($m.due_on_utc)" -f "description=$($m.description)" | ConvertFrom-Json
    $milestoneTitles[$m.title] = $true
    Write-Host "Created $($m.title)"
  } else {
    $milestoneTitles[$m.title] = $true
    Write-Host "Exists $($m.title)"
  }
}

Write-Host "== Issues =="
$manifest = Import-Csv (Join-Path $PSScriptRoot "issue-manifest.csv")
Get-ChildItem (Join-Path $PSScriptRoot "issues") -Filter "GOR-*.md" | Sort-Object Name | ForEach-Object {
  $file = $_
  $code = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
  $already = gh issue list --repo $FullName --state all --search "$code in:title" --json title --jq '.[].title'
  if ($already -match [regex]::Escape($code)) { Write-Host "Skip existing $code"; return }
  $body = Get-Content $file.FullName -Raw -Encoding UTF8
  $titleLine = ($body -split "`r?`n" | Where-Object { $_ -match '^# GOR-\d+ — ' } | Select-Object -First 1)
  $title = "[$code] " + ($titleLine -replace '^# GOR-\d+ — ', '')
  $row = $manifest | Where-Object { $_.code -eq $code } | Select-Object -First 1
  $args = @("issue","create","--repo",$FullName,"--title",$title,"--body-file",$file.FullName,"--label",$row.labels)
  $milestoneLine = ($body -split "`r?`n" | Where-Object { $_ -match '^\*\*Milestone:\*\* ' } | Select-Object -First 1)
  $milestone = $milestoneLine -replace '^\*\*Milestone:\*\* ', ''
  if ($milestoneTitles.ContainsKey($milestone)) { $args += @("--milestone",$milestone) }
  if ($row.assignee -eq "nquocthinh06") { $args += @("--assignee","nquocthinh06") }
  & gh @args
  if ($LASTEXITCODE -ne 0) { throw "Không tạo được $code" }
}
Write-Host "Bootstrap complete. Tạo GitHub Project board và mời thành viên thứ hai."
