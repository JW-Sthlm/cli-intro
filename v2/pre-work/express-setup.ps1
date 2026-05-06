# express-setup.ps1
# ----------------------------------------------------------------------
# WHAT THIS DOES
#   Installs the five command-line tools you need for the Copilot CLI
#   workshop. All from official sources via winget (Microsoft's package
#   manager, ships with Windows 11).
#
# WHAT THIS DOES NOT DO
#   - Sign you in anywhere
#   - Configure any MCP servers
#   - Touch any of your data
#   You'll do those steps manually next, with full visibility.
#
# WHY YOU CAN RUN THIS
#   - It is short. Read it before running. Every line is visible.
#   - It only calls winget. No downloads from random URLs.
#   - It is safe to re-run. winget skips packages already installed.
#
# AFTER IT FINISHES
#   Close PowerShell, open a new window, and continue with
#   the hosted setup guide from Step 2 (Log in to all your accounts):
#   https://cli-intro-share.pages.dev/setup.html#step-2
# ----------------------------------------------------------------------

$packages = @(
    @{ Name = 'Node.js LTS'; Id = 'OpenJS.NodeJS.LTS'  },
    @{ Name = 'Git';         Id = 'Git.Git'            },
    @{ Name = 'GitHub CLI';  Id = 'GitHub.cli'         },
    @{ Name = 'Azure CLI';   Id = 'Microsoft.AzureCLI' },
    @{ Name = 'Copilot CLI'; Id = 'GitHub.Copilot'     }
)

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host ""
    Write-Host "winget is not available on this machine." -ForegroundColor Red
    Write-Host "Install 'App Installer' from the Microsoft Store, then re-run this script." -ForegroundColor Yellow
    Write-Host ""
    return
}

Write-Host ""
Write-Host "Installing 5 command-line tools via winget. This takes 2-3 minutes." -ForegroundColor Cyan
Write-Host ""

foreach ($p in $packages) {
    Write-Host ("--> {0} ({1})" -f $p.Name, $p.Id) -ForegroundColor Cyan
    winget install --id $p.Id --silent --accept-source-agreements --accept-package-agreements
    Write-Host ""
}

Write-Host "============================================================" -ForegroundColor Green
Write-Host "Done." -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Close this PowerShell window."
Write-Host "  2. Open a NEW PowerShell window (so the updated PATH is picked up)."
Write-Host "  3. Continue with Step 2 of the hosted setup guide:"
Write-Host "     https://cli-intro-share.pages.dev/setup.html#step-2"
Write-Host ""
