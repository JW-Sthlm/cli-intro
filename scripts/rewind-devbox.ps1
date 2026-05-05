# rewind-devbox.ps1
# Resets Copilot CLI + gh state on a Dev Box so you can re-walk the workshop
# setup from Step 2a without resetting the entire Dev Box.
#
# Run between test passes. Safe — only touches Copilot/gh state.
# Does NOT uninstall winget packages (Node, gh, Copilot CLI itself).
#
# Usage:
#   .\rewind-devbox.ps1                # default: reset gh, PMX, mcp-config.json
#   .\rewind-devbox.ps1 -KeepGitHub    # leave gh logins intact
#   .\rewind-devbox.ps1 -Full          # also clear ~/.copilot session-state + installed-plugins

[CmdletBinding()]
param(
    [switch]$KeepGitHub,
    [switch]$Full
)

Write-Host "Rewinding Copilot CLI state..." -ForegroundColor Cyan

# 1. Log out gh accounts ----------------------------------------------------
if (-not $KeepGitHub) {
    Write-Host "`n[1/4] Logging out gh accounts..." -ForegroundColor Yellow
    $statusOutput = gh auth status 2>&1 | Out-String
    $matches = [regex]::Matches($statusOutput, 'account (\S+)')
    if ($matches.Count -gt 0) {
        foreach ($m in $matches) {
            $user = $m.Groups[1].Value
            Write-Host "  Logging out $user..." -ForegroundColor DarkGray
            gh auth logout --hostname github.com --user $user 2>&1 | Out-Null
        }
    } else {
        Write-Host "  No gh accounts logged in" -ForegroundColor DarkGray
    }
} else {
    Write-Host "`n[1/4] Skipping gh logout (-KeepGitHub)" -ForegroundColor DarkGray
}

# 2. Uninstall PMX plugin ---------------------------------------------------
Write-Host "`n[2/4] Removing PMX plugin..." -ForegroundColor Yellow
copilot plugin uninstall pmx-mcp 2>&1 | Out-Null
copilot plugin marketplace remove gim-home/pmx-mcp 2>&1 | Out-Null
Write-Host "  Done (errors above are normal if plugin wasn't installed)" -ForegroundColor DarkGray

# 3. Reset MCP config -------------------------------------------------------
Write-Host "`n[3/4] Resetting mcp-config.json..." -ForegroundColor Yellow
$mcpPath = Join-Path $HOME ".copilot\mcp-config.json"
if (Test-Path $mcpPath) {
    $backup = "$mcpPath.bak.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    Copy-Item $mcpPath $backup
    Set-Content -Path $mcpPath -Value '{ "mcpServers": {} }' -Encoding utf8
    Write-Host "  Backed up to $backup" -ForegroundColor DarkGray
} else {
    Write-Host "  No mcp-config.json found" -ForegroundColor DarkGray
}

# 4. Optional full clean ----------------------------------------------------
if ($Full) {
    Write-Host "`n[4/4] Full clean: clearing session-state + installed-plugins..." -ForegroundColor Yellow
    Remove-Item "$HOME\.copilot\session-state\*" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "$HOME\.copilot\installed-plugins\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  Done" -ForegroundColor DarkGray
} else {
    Write-Host "`n[4/4] Skipping full clean (use -Full for deeper reset)" -ForegroundColor DarkGray
}

Write-Host "`nRewind complete. Verify and re-test from Step 2a:" -ForegroundColor Green
Write-Host "  gh auth status        # should show: not logged in" -ForegroundColor DarkGray
Write-Host "  copilot plugin list   # should not list pmx-mcp" -ForegroundColor DarkGray
