# ============================================================
# bootstrap.ps1 — OPTIONAL re-run shortcut
#
# DO NOT use this for the primary clean-test walkthrough.
# It bypasses Step 1 of setup-guide.md, which is exactly what
# we are trying to validate. See test-runbook.md.
#
# When this IS useful:
#   - Re-running Walk 3 (MCP matrix) — you've already validated
#     Step 1 elsewhere and just need the tools present
#   - Re-running Walk 4 (copilot-overview-plugin install)
#   - Spinning up a sandbox for a quick one-off check
#
# Runs automatically when sandbox launches via .wsb config.
# ============================================================

$ErrorActionPreference = 'Continue'
Set-Location C:\Test

function Section($title) {
    Write-Host ""
    Write-Host "===================================================" -ForegroundColor Cyan
    Write-Host $title -ForegroundColor Cyan
    Write-Host "===================================================" -ForegroundColor Cyan
}

function Try-Install($displayName, $wingetId) {
    Write-Host ""
    Write-Host "-> Installing $displayName ($wingetId)" -ForegroundColor Yellow
    try {
        winget install --id $wingetId --silent --accept-source-agreements --accept-package-agreements 2>&1 | Out-Host
        Write-Host "   $displayName install attempted." -ForegroundColor Green
    } catch {
        Write-Host "   $displayName install FAILED: $_" -ForegroundColor Red
    }
}

Section "Step 0 - sanity check"
Write-Host "Sandbox build: $((Get-CimInstance Win32_OperatingSystem).Version)"
Write-Host "Architecture: $env:PROCESSOR_ARCHITECTURE"
Write-Host "Test folder mounted at: C:\Test"
Get-ChildItem C:\Test | Select-Object Name | Format-Table -HideTableHeaders | Out-String | Write-Host

Section "Step 1 - check winget"
$winget = Get-Command winget -ErrorAction SilentlyContinue
if ($winget) {
    Write-Host "winget available at: $($winget.Source)" -ForegroundColor Green
} else {
    Write-Host "winget NOT available in this sandbox." -ForegroundColor Red
    Write-Host "Modern Win11 sandboxes include it. If yours doesn't, install App Installer from the Store, then re-run this script." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Stopping bootstrap. Manual install path:" -ForegroundColor Yellow
    Write-Host "  - Node:    https://nodejs.org/ (LTS)"
    Write-Host "  - Git:     https://git-scm.com/download/win"
    Write-Host "  - gh:      https://cli.github.com/"
    Write-Host "  - az:      https://learn.microsoft.com/cli/azure/install-azure-cli-windows"
    Write-Host "  - copilot: winget install GitHub.Copilot (after winget is available)"
    return
}

Section "Step 2 - install prerequisites"
Try-Install "PowerShell 7"     "Microsoft.PowerShell"
Try-Install "Node.js LTS"       "OpenJS.NodeJS.LTS"
Try-Install "Git"               "Git.Git"
Try-Install "GitHub CLI"        "GitHub.cli"
Try-Install "Azure CLI"         "Microsoft.AzureCLI"
Try-Install "Copilot CLI"       "GitHub.Copilot"

Section "Step 3 - refresh PATH"
$env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')

Section "Step 4 - quick version check"
$tools = @(
    @{ Name = 'Node.js';     Cmd = 'node --version' },
    @{ Name = 'Git';         Cmd = 'git --version' },
    @{ Name = 'GitHub CLI';  Cmd = 'gh --version' },
    @{ Name = 'Azure CLI';   Cmd = 'az --version' },
    @{ Name = 'Copilot CLI'; Cmd = 'copilot --version' }
)
foreach ($t in $tools) {
    try {
        $out = Invoke-Expression $t.Cmd 2>&1 | Select-Object -First 1
        Write-Host ("  [OK]  {0,-12} {1}" -f $t.Name, $out) -ForegroundColor Green
    } catch {
        Write-Host ("  [--]  {0,-12} not detected (may need new shell)" -f $t.Name) -ForegroundColor Yellow
    }
}

Section "Done - hand-off to tester"
Write-Host ""
Write-Host "Bootstrap complete." -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Read C:\Test\test-runbook.md and follow it."
Write-Host "  2. Track findings in your own copy of results-template.md (save outside the sandbox - this VM wipes on close)."
Write-Host ""
Write-Host "Open a NEW PowerShell window before running 'copilot' so the updated PATH is picked up." -ForegroundColor Yellow
Write-Host ""
