<#
.SYNOPSIS
  craft-ui installer for Windows: copies the skill into the skills folder of each coding agent.
.EXAMPLE
  .\install.ps1                          # every agent detected on this machine
  .\install.ps1 -Agent claude,codex,trae # specific agents
  .\install.ps1 -Project -Agent trae     # current project only
  .\install.ps1 -Uninstall -Agent all
  .\install.ps1 -List
#>
param(
  [string[]]$Agent = @(),
  [switch]$Project,
  [string]$Path = "",
  [switch]$Link,
  [switch]$Uninstall,
  [switch]$List
)
$ErrorActionPreference = "Stop"
$Skill = "craft-ui"
$RepoUrl = "https://github.com/Fast4gc/craft-ui.git"
$H = $env:USERPROFILE

# name, user skills dir, project skills dir, detect dir
$Agents = @(
  @("claude",      "$H\.claude\skills",                  ".claude\skills",  "$H\.claude"),
  @("codex",       "$H\.codex\skills",                   ".agents\skills",  "$H\.codex"),
  @("trae",        "$H\.trae\skills",                    ".trae\skills",    "$H\.trae"),
  @("cursor",      "$H\.cursor\skills",                  ".cursor\skills",  "$H\.cursor"),
  @("gemini",      "$H\.gemini\skills",                  ".gemini\skills",  "$H\.gemini"),
  @("antigravity", "$H\.gemini\antigravity\skills",      ".agent\skills",   "$H\.gemini\antigravity"),
  @("opencode",    "$H\.config\opencode\skills",         ".opencode\skills","$H\.config\opencode"),
  @("kiro",        "$H\.kiro\skills",                    ".kiro\skills",    "$H\.kiro"),
  @("copilot",     "$H\.copilot\skills",                 ".github\skills",  "$H\.copilot"),
  @("cline",       "$H\.cline\skills",                   ".cline\skills",   "$H\.cline"),
  @("universal",   "$H\.agents\skills",                  ".agents\skills",  "$H\.agents")
)

if ($List) {
  $Agents | ForEach-Object { "{0,-12} {1,-48} {2}" -f $_[0], $_[1], $_[2] }
  return
}

# Locate sources: next to this script, or clone to a temp folder.
$here = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }
$src = Join-Path $here "skills\$Skill"
$tmp = $null
if (-not (Test-Path (Join-Path $src "SKILL.md")) -and -not $Uninstall) {
  if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw "git is required to download craft-ui." }
  $tmp = Join-Path ([IO.Path]::GetTempPath()) ("craft-ui-" + [guid]::NewGuid())
  git clone --depth 1 $RepoUrl "$tmp\repo" 2>&1 | Out-Null
  $src = "$tmp\repo\skills\$Skill"
  $Link = $false
}

$targets = @()
if ($Path) {
  $targets += ,@("custom", $Path)
} else {
  $want = ($Agent -join ",").Split(",") | Where-Object { $_ }
  foreach ($a in $Agents) {
    $dir = if ($Project) { Join-Path (Get-Location).Path $a[2] } else { $a[1] }
    if ($want.Count -eq 0) {
      if ($a[0] -ne "universal" -and (Test-Path $a[3])) { $targets += ,@($a[0], $dir) }
    } elseif ($want -contains "all" -or $want -contains $a[0]) {
      $targets += ,@($a[0], $dir)
    }
  }
}
if ($targets.Count -eq 0) { throw "No supported agent detected. Use -Agent (see -List) or -Path DIR." }

foreach ($t in $targets) {
  $dest = Join-Path $t[1] $Skill
  if ($Uninstall) {
    if (Test-Path $dest) { Remove-Item -Recurse -Force $dest; "removed   {0}  {1}" -f $t[0], $dest }
    else { "not found {0}  {1}" -f $t[0], $dest }
    continue
  }
  New-Item -ItemType Directory -Force -Path $t[1] | Out-Null
  if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
  if ($Link) { New-Item -ItemType SymbolicLink -Path $dest -Target $src | Out-Null; $mode = "linked   " }
  else { Copy-Item -Recurse -Force $src $dest; $mode = "installed" }
  "{0} {1}  {2}" -f $mode, $t[0], $dest
}
if ($tmp -and (Test-Path $tmp)) { Remove-Item -Recurse -Force $tmp }
if (-not $Uninstall) { "Done. Restart your agent (or start a new session), then ask for a layout in the style of a reference image." }
