# ============================================================
# reset-devbox.ps1: clean-test reset script for a Dev Box
#
# Used between walks of the setup-guide validation kit when
# Sandbox-in-Dev-Box is unavailable (corporate pool blocks the
# feature). Lets you do multiple test passes on the same Dev Box
# without paying the ~15-min redeploy cost between each one.
#
# Two modes:
#
#   -Mode Soft (default)
#     Clears all auth + Copilot config + cloned repos.
#     Tools stay installed. ~30s. Use to re-run Walk A1 (PMX
#     install) without redoing Step 1.
#
#   -Mode Hard
#     Soft + uninstalls all 6 winget packages. ~5 min. NOT a
#     pristine reset, winget leaves PATH entries, registry
#     leftovers, %APPDATA% state. For a true pristine machine,
#     redeploy the Dev Box (~15 min). Hard mode is "best-effort
#     reinstall reset" only.
#
# Other flags:
#   -WhatIf    Preview what would happen, change nothing.
#   -Yes       Skip confirmations. Useful for unattended re-runs.
#
# Always runs a post-reset verifier and exits non-zero if any
# required step failed.
# ============================================================

[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
param(
    [ValidateSet('Soft','Hard')]
    [string]$Mode = 'Soft',
    [switch]$Yes
)

$ErrorActionPreference = 'Continue'
$script:steps = @()

function Section($title) {
    Write-Host ""
    Write-Host "===================================================" -ForegroundColor Cyan
    Write-Host $title -ForegroundColor Cyan
    Write-Host "===================================================" -ForegroundColor Cyan
}

function Track($name, $result, $detail = '') {
    $script:steps += [pscustomobject]@{
        Name   = $name
        Result = $result
        Detail = $detail
    }
    $color = switch ($result) {
        'OK'      { 'Green' }
        'SKIP'    { 'Yellow' }
        'WARN'    { 'Yellow' }
        'FAIL'    { 'Red' }
        default   { 'Gray' }
    }
    $marker = switch ($result) {
        'OK'   { '[OK]  ' }
        'SKIP' { '[SKIP]' }
        'WARN' { '[WARN]' }
        'FAIL' { '[FAIL]' }
    }
    Write-Host ("  {0} {1}" -f $marker, $name) -ForegroundColor $color
    if ($detail) {
        Write-Host ("        {0}" -f $detail) -ForegroundColor DarkGray
    }
}

function Confirm-Or-Yes($message) {
    if ($Yes) { return $true }
    if ($PSCmdlet.ShouldProcess($message, 'Reset')) { return $true }
    return $false
}

function Remove-PathSafe($path) {
    if (-not (Test-Path $path)) { return 'SKIP', 'not present' }
    if ($PSCmdlet.ShouldProcess($path, 'Remove-Item -Recurse -Force')) {
        try {
            Remove-Item $path -Recurse -Force -ErrorAction Stop
            return 'OK', "removed $path"
        } catch {
            return 'FAIL', $_.Exception.Message
        }
    }
    return 'SKIP', 'WhatIf'
}

# ============================================================
# Sanity preamble
# ============================================================
Section "Reset-Devbox preamble"
Write-Host "Mode:           $Mode"
Write-Host "WhatIf:         $($WhatIfPreference -or $PSCmdlet.WhatIfPreference)"
Write-Host "User:           $env:USERNAME"
Write-Host "Home:           $HOME"
Write-Host "Running shell:  $($PSVersionTable.PSEdition) $($PSVersionTable.PSVersion)"
Write-Host ""
if ($Mode -eq 'Hard') {
    Write-Host "⚠️  Hard mode is NOT a pristine reset. winget uninstall leaves" -ForegroundColor Yellow
    Write-Host "    PATH entries, registry artifacts, and per-user state behind." -ForegroundColor Yellow
    Write-Host "    For a true pristine Dev Box, redeploy from devbox.microsoft.com." -ForegroundColor Yellow
    Write-Host ""
    if (-not $Yes -and -not $WhatIfPreference) {
        $reply = Read-Host "Proceed with Hard reset? [y/N]"
        if ($reply -notmatch '^[yY]') {
            Write-Host "Aborted." -ForegroundColor Yellow
            exit 2
        }
    }
}

# ============================================================
# Soft mode, clear state. Always runs (Hard = Soft + more).
# ============================================================
Section "Clearing application state (Soft)"

# 1. Copilot CLI: kill running processes, drop the config tree.
#    The auth token lives in Windows Credential Manager under a
#    target name we don't fully document, leaving it intact is
#    the safer call. Next `copilot /login` overwrites it cleanly.
$copilotProcs = Get-Process copilot -ErrorAction SilentlyContinue
if ($copilotProcs) {
    if ($PSCmdlet.ShouldProcess('copilot processes', 'Stop-Process')) {
        try {
            $copilotProcs | Stop-Process -Force -ErrorAction Stop
            Track 'Copilot CLI processes' 'OK' "killed $($copilotProcs.Count)"
        } catch {
            Track 'Copilot CLI processes' 'FAIL' $_.Exception.Message
        }
    } else {
        Track 'Copilot CLI processes' 'SKIP' 'WhatIf'
    }
} else {
    Track 'Copilot CLI processes' 'SKIP' 'none running'
}

$copilotDir = Join-Path $HOME '.copilot'
$r, $d = Remove-PathSafe $copilotDir
Track 'Copilot CLI config (~/.copilot)' $r $d

# 2. GitHub CLI: logout each authenticated host then drop the dir.
#    `gh auth logout` also removes the matching Git Credential
#    Manager entries that gh planted, which is the right cleanup
#    surface, we don't touch GCM directly.
$gh = Get-Command gh -ErrorAction SilentlyContinue
if ($gh) {
    try {
        $authStatus = & gh auth status 2>&1
        $accounts = $authStatus | Select-String -Pattern '^- Active account:|^- account ' -AllMatches
        # Logout each known host, suppressing prompts.
        $hosts = & gh auth status 2>&1 | Select-String -Pattern '^([a-zA-Z0-9.-]+)$' | ForEach-Object { $_.Matches[0].Groups[1].Value } | Select-Object -Unique
        if (-not $hosts -or $hosts.Count -eq 0) {
            $hosts = @('github.com')
        }
        $loggedOut = 0
        foreach ($h in $hosts) {
            if ($PSCmdlet.ShouldProcess("gh ($h)", 'auth logout')) {
                & gh auth logout --hostname $h 2>&1 | Out-Null
                if ($LASTEXITCODE -eq 0) { $loggedOut++ }
            }
        }
        Track 'gh auth logout' 'OK' "host(s) attempted: $($hosts -join ', '); succeeded: $loggedOut"
    } catch {
        Track 'gh auth logout' 'WARN' "non-fatal: $($_.Exception.Message)"
    }
} else {
    Track 'gh auth logout' 'SKIP' 'gh not on PATH'
}

$ghDir = Join-Path $env:APPDATA 'GitHub CLI'
$r, $d = Remove-PathSafe $ghDir
Track 'gh config (%APPDATA%\GitHub CLI)' $r $d

$ghDirAlt = Join-Path $HOME '.config\gh'
$r, $d = Remove-PathSafe $ghDirAlt
Track 'gh config (~/.config/gh)' $r $d

# 3. Azure CLI: az logout drops the active session; ~/.azure
#    contains cache and config worth wiping for a real reset.
$az = Get-Command az -ErrorAction SilentlyContinue
if ($az) {
    if ($PSCmdlet.ShouldProcess('az', 'logout')) {
        try {
            & az logout 2>&1 | Out-Null
            Track 'az logout' 'OK' ''
        } catch {
            Track 'az logout' 'WARN' "non-fatal: $($_.Exception.Message)"
        }
    } else {
        Track 'az logout' 'SKIP' 'WhatIf'
    }
} else {
    Track 'az logout' 'SKIP' 'az not on PATH'
}

$azDir = Join-Path $HOME '.azure'
$r, $d = Remove-PathSafe $azDir
Track 'az config (~/.azure)' $r $d

# 4. Cloned repos in $HOME left over from prior walks.
foreach ($repo in @('cli-intro', 'pmx-mcp', 'copilot-overview')) {
    $p = Join-Path $HOME $repo
    $r, $d = Remove-PathSafe $p
    Track "repo (~/$repo)" $r $d
}

# ============================================================
# Hard mode, uninstall winget packages. Best-effort only.
# ============================================================
if ($Mode -eq 'Hard') {
    Section "Uninstalling tools (Hard)"

    # Self-uninstall trap: refuse to remove the PowerShell that's
    # hosting this script. It would corrupt the running process.
    $isPwsh7 = $PSVersionTable.PSEdition -eq 'Core'

    $packages = @(
        @{ Id = 'GitHub.Copilot';        Name = 'Copilot CLI' }
        @{ Id = 'GitHub.cli';            Name = 'GitHub CLI' }
        @{ Id = 'Microsoft.AzureCLI';    Name = 'Azure CLI' }
        @{ Id = 'OpenJS.NodeJS.LTS';     Name = 'Node.js LTS' }
        @{ Id = 'Git.Git';               Name = 'Git' }
        @{ Id = 'Microsoft.PowerShell';  Name = 'PowerShell 7' }
    )

    foreach ($p in $packages) {
        if ($p.Id -eq 'Microsoft.PowerShell' -and $isPwsh7) {
            Track "winget uninstall $($p.Name)" 'SKIP' 'cannot uninstall the shell hosting this script, re-run from Windows PowerShell 5.1 (powershell.exe) to remove it'
            continue
        }
        if ($PSCmdlet.ShouldProcess($p.Id, 'winget uninstall')) {
            try {
                & winget uninstall --id $p.Id --silent --accept-source-agreements 2>&1 | Out-Null
                if ($LASTEXITCODE -eq 0) {
                    Track "winget uninstall $($p.Name)" 'OK' $p.Id
                } elseif ($LASTEXITCODE -eq -1978335212) {
                    # 0x8A150014, no installed package found
                    Track "winget uninstall $($p.Name)" 'SKIP' 'not installed'
                } else {
                    Track "winget uninstall $($p.Name)" 'WARN' "winget exit code: $LASTEXITCODE"
                }
            } catch {
                Track "winget uninstall $($p.Name)" 'FAIL' $_.Exception.Message
            }
        } else {
            Track "winget uninstall $($p.Name)" 'SKIP' 'WhatIf'
        }
    }

    Write-Host ""
    Write-Host "⚠️  Hard mode complete. Reminder: this is NOT a pristine reset." -ForegroundColor Yellow
    Write-Host "    Leftover state likely includes: PATH entries (until next sign-out)," -ForegroundColor Yellow
    Write-Host "    Program Files\PowerShell\7 folder, %APPDATA%\npm, ProgramData\chocolatey," -ForegroundColor Yellow
    Write-Host "    HKCU\Software registry keys for installed tools." -ForegroundColor Yellow
    Write-Host "    For a true clean Dev Box, redeploy at devbox.microsoft.com." -ForegroundColor Yellow
}

# ============================================================
# Preview-mode short-circuit
# ============================================================
# When -WhatIf is used, nothing was actually deleted. Running the
# verifier would just report 6+ [WARN] rows ("state still present")
# which is correct but alarming. Skip it. Print a clear preview
# summary and exit.
# ============================================================
if ($WhatIfPreference) {
    Section "Preview summary (no changes were made)"
    Write-Host "  -WhatIf was specified. Nothing was deleted."
    Write-Host "  Each '[SKIP] ... WhatIf' line above is a path or process the"
    Write-Host "  real run would touch."
    Write-Host ""
    Write-Host "  Mode: $Mode"
    if ($Mode -eq 'Soft') {
        Write-Host "  Soft mode would clear:" -ForegroundColor Yellow
        Write-Host "    - Copilot config (~/.copilot)" -ForegroundColor Yellow
        Write-Host "    - gh config (APPDATA + ~/.config/gh) and gh auth" -ForegroundColor Yellow
        Write-Host "    - az config (~/.azure) and az auth" -ForegroundColor Yellow
        Write-Host "    - cloned repos in `$HOME (cli-intro, pmx-mcp, copilot-overview)" -ForegroundColor Yellow
        Write-Host "  Tools (gh, az, node, git, copilot) stay installed." -ForegroundColor Yellow
    } else {
        Write-Host "  Hard mode would do everything Soft does, plus winget uninstall" -ForegroundColor Yellow
        Write-Host "  of GitHub.cli, Microsoft.AzureCLI, OpenJS.NodeJS.LTS, Git.Git," -ForegroundColor Yellow
        Write-Host "  and GitHub.cli.Copilot. Best-effort. NOT a pristine reset." -ForegroundColor Yellow
    }
    Write-Host ""
    Write-Host "👉 To actually reset, re-run without -WhatIf:" -ForegroundColor Cyan
    Write-Host "     .\reset-devbox.ps1 -Mode $Mode" -ForegroundColor Cyan
    Write-Host ""
    exit 0
}

# ============================================================
# Post-reset verifier, what's actually gone vs still present.
# ============================================================
Section "Verifier: what state remains"

$remaining = @()

function Check-Absent($label, $path) {
    if (Test-Path $path) {
        $script:remaining += $label
        Track "$label still present" 'WARN' $path
    } else {
        Track "$label gone" 'OK' ''
    }
}

function Check-Cmd-Status($label, $cmdName, $expectGone) {
    $cmd = Get-Command $cmdName -ErrorAction SilentlyContinue
    if ($cmd) {
        if ($expectGone) {
            $script:remaining += "$label binary"
            Track "$label binary still on PATH" 'WARN' $cmd.Source
        } else {
            Track "$label binary present" 'OK' $cmd.Source
        }
    } else {
        if ($expectGone) {
            Track "$label binary gone" 'OK' ''
        } else {
            Track "$label binary missing" 'WARN' 'unexpected after Soft reset'
        }
    }
}

# State dirs should always be gone after either mode.
Check-Absent 'Copilot config'   (Join-Path $HOME '.copilot')
Check-Absent 'gh config (APPDATA)' (Join-Path $env:APPDATA 'GitHub CLI')
Check-Absent 'gh config (.config)' (Join-Path $HOME '.config\gh')
Check-Absent 'az config'        (Join-Path $HOME '.azure')
Check-Absent 'cli-intro repo'   (Join-Path $HOME 'cli-intro')
Check-Absent 'pmx-mcp repo'     (Join-Path $HOME 'pmx-mcp')

# Binaries: Soft mode keeps them, Hard mode wipes them.
$expectBinariesGone = ($Mode -eq 'Hard')
Check-Cmd-Status 'gh'      'gh'      $expectBinariesGone
Check-Cmd-Status 'az'      'az'      $expectBinariesGone
Check-Cmd-Status 'node'    'node'    $expectBinariesGone
Check-Cmd-Status 'git'     'git'     $expectBinariesGone
Check-Cmd-Status 'copilot' 'copilot' $expectBinariesGone

# Auth surface (only if binaries are still around)
if (-not $expectBinariesGone) {
    if (Get-Command gh -ErrorAction SilentlyContinue) {
        $ghOut = & gh auth status 2>&1
        if ($ghOut -match 'You are not logged in' -or $LASTEXITCODE -ne 0) {
            Track 'gh auth status: not logged in' 'OK' ''
        } else {
            Track 'gh auth status: still authenticated' 'WARN' 'gh auth logout did not fully clear'
            $script:remaining += 'gh auth'
        }
    }
    if (Get-Command az -ErrorAction SilentlyContinue) {
        $azOut = & az account show 2>&1
        if ($LASTEXITCODE -ne 0) {
            Track 'az account show: not logged in' 'OK' ''
        } else {
            Track 'az account show: still authenticated' 'WARN' 'az logout did not fully clear'
            $script:remaining += 'az auth'
        }
    }
}

# ============================================================
# Summary
# ============================================================
Section "Summary"

$counts = @{
    OK   = ($script:steps | Where-Object Result -eq 'OK').Count
    SKIP = ($script:steps | Where-Object Result -eq 'SKIP').Count
    WARN = ($script:steps | Where-Object Result -eq 'WARN').Count
    FAIL = ($script:steps | Where-Object Result -eq 'FAIL').Count
}

Write-Host ("  Steps: {0} OK, {1} skipped, {2} warned, {3} failed" -f `
    $counts.OK, $counts.SKIP, $counts.WARN, $counts.FAIL)

if ($script:remaining.Count -gt 0) {
    Write-Host ""
    Write-Host "Things still present after reset:" -ForegroundColor Yellow
    $script:remaining | Sort-Object -Unique | ForEach-Object { Write-Host "  - $_" -ForegroundColor Yellow }
}

Write-Host ""
if ($counts.FAIL -gt 0) {
    Write-Host "❌ Reset finished with failures. See [FAIL] rows above." -ForegroundColor Red
    Write-Host "   Common cause: a lock on a file in ~/.copilot or ~/.azure (close Copilot CLI / az windows first)." -ForegroundColor Red
    exit 1
}

if ($Mode -eq 'Soft') {
    Write-Host "✅ Soft reset complete. Tools still installed. Auth and config cleared." -ForegroundColor Green
    Write-Host "   Open a new PowerShell window and start Walk A from Step 2 (Log In)." -ForegroundColor Green
} else {
    Write-Host "✅ Hard reset complete (best-effort)." -ForegroundColor Green
    Write-Host "   Open a new PowerShell window and start Walk A from Step 1 (Install command-line tools)." -ForegroundColor Green
    Write-Host "   For a true pristine Dev Box, redeploy at devbox.microsoft.com." -ForegroundColor Yellow
}
exit 0
