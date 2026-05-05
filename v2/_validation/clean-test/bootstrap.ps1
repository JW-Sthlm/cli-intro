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
        # --source winget pins to public winget source; skips msstore which
        # is unreachable from Sandbox (REST API error 0x8a15003b)
        winget install --id $wingetId --source winget --silent --accept-source-agreements --accept-package-agreements 2>&1 | Out-Host
        if ($LASTEXITCODE -eq 0) {
            Write-Host "   $displayName installed." -ForegroundColor Green
        } else {
            Write-Host "   $displayName winget exit code: $LASTEXITCODE (may already be installed)" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "   $displayName install FAILED: $_" -ForegroundColor Red
    }
}

Section "Step 0 - sanity check"
Write-Host "Sandbox build: $((Get-CimInstance Win32_OperatingSystem).Version)"
Write-Host "Architecture: $env:PROCESSOR_ARCHITECTURE"
Write-Host "Test folder mounted at: C:\Test"
Get-ChildItem C:\Test | Select-Object Name | Format-Table -HideTableHeaders | Out-String | Write-Host

Section "Step 1 - check winget (auto-bootstrap if missing)"
$winget = Get-Command winget -ErrorAction SilentlyContinue
if ($winget) {
    Write-Host "winget available at: $($winget.Source)" -ForegroundColor Green
} else {
    Write-Host "winget NOT available - bootstrapping it now..." -ForegroundColor Yellow
    Write-Host "(Expected in fresh Sandbox 24H2. Downloads ~250 MB; allow 3-5 min on Sandbox networking.)" -ForegroundColor Yellow

    $tmp     = "$env:TEMP\winget-bootstrap"
    $bundle  = Join-Path $tmp 'winget.msixbundle'
    $deps    = Join-Path $tmp 'deps.zip'
    $depsDir = Join-Path $tmp 'deps'
    New-Item -ItemType Directory -Force -Path $tmp | Out-Null

    $bundleUrl = 'https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
    $depsUrl   = 'https://github.com/microsoft/winget-cli/releases/latest/download/DesktopAppInstaller_Dependencies.zip'

    Write-Host "  -> downloading winget bundle..." -ForegroundColor Yellow
    & curl.exe -L --fail -o $bundle $bundleUrl
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $bundle)) {
        Write-Host "Bundle download FAILED. Use Codespaces or a real Dev Box instead." -ForegroundColor Red
        return
    }

    Write-Host "  -> downloading framework deps zip..." -ForegroundColor Yellow
    & curl.exe -L --fail -o $deps $depsUrl
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $deps)) {
        Write-Host "Deps zip download FAILED. Use Codespaces or a real Dev Box instead." -ForegroundColor Red
        return
    }

    Write-Host "  -> extracting deps..." -ForegroundColor Yellow
    Expand-Archive -Path $deps -DestinationPath $depsDir -Force

    Write-Host "  -> installing x64 framework packages..." -ForegroundColor Yellow
    Get-ChildItem -Path $depsDir -Recurse -Include *.appx,*.msix |
        Where-Object { $_.FullName -match '\\x64\\' } |
        ForEach-Object {
            Write-Host "       $($_.Name)" -ForegroundColor DarkGray
            Add-AppxPackage -Path $_.FullName -ErrorAction Continue
        }

    Write-Host "  -> installing winget bundle..." -ForegroundColor Yellow
    Add-AppxPackage -Path $bundle -ErrorAction Continue

    $env:Path = [System.Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [System.Environment]::GetEnvironmentVariable('Path','User')
    $winget = Get-Command winget -ErrorAction SilentlyContinue
    if ($winget) {
        Write-Host "winget bootstrapped successfully at: $($winget.Source)" -ForegroundColor Green
    } else {
        Write-Host "winget bootstrap FAILED. Fallbacks:" -ForegroundColor Red
        Write-Host "  - Open https://github.com/JW-Sthlm/cli-intro in Codespaces"
        Write-Host "  - Use a real Dev Box (winget pre-installed)"
        return
    }
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
