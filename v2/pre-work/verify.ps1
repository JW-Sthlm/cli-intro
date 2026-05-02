#Requires -Version 7.0
<#
.SYNOPSIS
Checks whether this laptop is ready for the Copilot CLI intro workshop.

.DESCRIPTION
This script runs a friendly pre-work check for non-coders. It verifies the main command-line tools,
GitHub account setup, Azure login, and whether you are running from a sensible folder.

HOW TO RUN
From the folder where you cloned this repo:
  .\v2\pre-work\verify.ps1

If PowerShell blocks the script, run:
  pwsh -ExecutionPolicy Bypass -File .\v2\pre-work\verify.ps1

WHAT IT DOES NOT CHECK
- It does not install missing tools.
- It does not start login flows for GitHub or Azure.
- It does not verify MCP server installation yet.
#>

$GuidePath = "v2/pre-work/setup-guide.md"
$TroubleshootingPath = "v2/pre-work/setup-guide.md -> Troubleshooting"
$Separator = "─────────────────────────────────"
$Results = [System.Collections.Generic.List[object]]::new()

function New-CheckResult {
    param(
        [Parameter(Mandatory)] [string] $Name,
        [Parameter(Mandatory)] [ValidateSet("Pass", "Fail", "Warning")] [string] $Status,
        [Parameter(Mandatory)] [string] $Detail,
        [string] $Issue = "",
        [string] $Fix = ""
    )

    [pscustomobject]@{
        Name   = $Name
        Status = $Status
        Detail = $Detail
        Issue  = $Issue
        Fix    = $Fix
    }
}

function Write-CheckResult {
    param([Parameter(Mandatory)] $Result)

    switch ($Result.Status) {
        "Pass" {
            $symbol = "✓"
            $color = "Green"
        }
        "Fail" {
            $symbol = "✗"
            $color = "Red"
        }
        "Warning" {
            $symbol = "!"
            $color = "Yellow"
        }
    }

    Write-Host "[ $symbol ] $($Result.Name) — $($Result.Detail)" -ForegroundColor $color
}

function Add-CheckResult {
    param([Parameter(Mandatory)] $Result)

    $Results.Add($Result)
    Write-CheckResult -Result $Result
}

function Invoke-Tool {
    param(
        [Parameter(Mandatory)] [string] $Command,
        [string[]] $Arguments = @()
    )

    $tool = Get-Command $Command -ErrorAction SilentlyContinue
    if (-not $tool) {
        return [pscustomobject]@{
            Found    = $false
            ExitCode = $null
            Output   = ""
        }
    }

    try {
        $output = & $tool.Source @Arguments 2>&1 | Out-String
        $exitCode = if ($null -ne $LASTEXITCODE) { $LASTEXITCODE } else { 0 }

        return [pscustomobject]@{
            Found    = $true
            ExitCode = $exitCode
            Output   = $output.Trim()
        }
    }
    catch {
        return [pscustomobject]@{
            Found    = $true
            ExitCode = 1
            Output   = $_.Exception.Message
        }
    }
}

function Get-FirstLine {
    param([string] $Text)

    if ([string]::IsNullOrWhiteSpace($Text)) {
        return "no details returned"
    }

    return (($Text -split "`r?`n") | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -First 1).Trim()
}

function Test-PowerShellVersion {
    try {
        $version = $PSVersionTable.PSVersion
        if ($version.Major -ge 7) {
            return New-CheckResult -Name "PowerShell version" -Status "Pass" -Detail "PowerShell $version detected."
        }

        return New-CheckResult `
            -Name "PowerShell version" `
            -Status "Fail" `
            -Detail "PowerShell $version detected. This workshop needs PowerShell 7." `
            -Issue "PowerShell 7 is not installed or not open." `
            -Fix "Run 'winget install Microsoft.PowerShell', then re-open Windows Terminal. See $TroubleshootingPath."
    }
    catch {
        return New-CheckResult `
            -Name "PowerShell version" `
            -Status "Fail" `
            -Detail "PowerShell version could not be checked." `
            -Issue "PowerShell version could not be checked." `
            -Fix "Open PowerShell 7 and run this script again. See $TroubleshootingPath."
    }
}

function Test-Node {
    try {
        $node = Invoke-Tool -Command "node" -Arguments @("--version")
        if (-not $node.Found) {
            return New-CheckResult `
                -Name "Node.js" `
                -Status "Fail" `
                -Detail "Node.js was not found. Fix: install Node.js LTS from https://nodejs.org/." `
                -Issue "Node.js is missing." `
                -Fix "Install Node.js LTS from https://nodejs.org/, then re-open PowerShell. See $TroubleshootingPath."
        }

        $versionText = Get-FirstLine -Text $node.Output
        if ($versionText -match "v?(\d+)\.(\d+)\.(\d+)") {
            $major = [int]$Matches[1]
            if ($major -ge 18) {
                return New-CheckResult -Name "Node.js" -Status "Pass" -Detail "$versionText detected."
            }
        }

        return New-CheckResult `
            -Name "Node.js" `
            -Status "Fail" `
            -Detail "$versionText detected. This workshop needs Node.js 18 or newer." `
            -Issue "Node.js is too old." `
            -Fix "Install the current Node.js LTS from https://nodejs.org/, then re-open PowerShell. See $TroubleshootingPath."
    }
    catch {
        return New-CheckResult `
            -Name "Node.js" `
            -Status "Fail" `
            -Detail "Node.js could not be checked. Fix: install Node.js LTS from https://nodejs.org/." `
            -Issue "Node.js check failed." `
            -Fix "Install Node.js LTS from https://nodejs.org/. See $TroubleshootingPath."
    }
}

function Test-CopilotCli {
    try {
        $copilot = Invoke-Tool -Command "copilot" -Arguments @("--version")
        if (-not $copilot.Found -or $copilot.ExitCode -ne 0) {
            return New-CheckResult `
                -Name "Copilot CLI" `
                -Status "Fail" `
                -Detail "Copilot CLI was not found or did not return a version. Fix: see $GuidePath -> Step 1; run 'winget install GitHub.Copilot'." `
                -Issue "Copilot CLI is missing." `
                -Fix "See $GuidePath -> Step 1. Run 'winget install GitHub.Copilot', then re-open PowerShell."
        }

        return New-CheckResult -Name "Copilot CLI" -Status "Pass" -Detail "$(Get-FirstLine -Text $copilot.Output) detected."
    }
    catch {
        return New-CheckResult `
            -Name "Copilot CLI" `
            -Status "Fail" `
            -Detail "Copilot CLI could not be checked. Fix: see $GuidePath -> Step 1." `
            -Issue "Copilot CLI check failed." `
            -Fix "See $GuidePath -> Step 1. Run 'winget install GitHub.Copilot', then re-open PowerShell."
    }
}

function Test-GitHubCli {
    try {
        $gh = Invoke-Tool -Command "gh" -Arguments @("--version")
        if (-not $gh.Found -or $gh.ExitCode -ne 0) {
            return New-CheckResult `
                -Name "GitHub CLI" `
                -Status "Fail" `
                -Detail "GitHub CLI was not found. Fix: install it from https://cli.github.com/, then see $GuidePath -> 'Sign in to GitHub (both accounts)'." `
                -Issue "GitHub CLI is missing." `
                -Fix "Install GitHub CLI from https://cli.github.com/, then follow $GuidePath -> 'Sign in to GitHub (both accounts)'."
        }

        return New-CheckResult -Name "GitHub CLI" -Status "Pass" -Detail "$(Get-FirstLine -Text $gh.Output) detected."
    }
    catch {
        return New-CheckResult `
            -Name "GitHub CLI" `
            -Status "Fail" `
            -Detail "GitHub CLI could not be checked. Fix: install it from https://cli.github.com/." `
            -Issue "GitHub CLI check failed." `
            -Fix "Install GitHub CLI from https://cli.github.com/, then follow $GuidePath -> 'Sign in to GitHub (both accounts)'."
    }
}

function Test-GitHubAuth {
    try {
        $gh = Invoke-Tool -Command "gh" -Arguments @("auth", "status")
        if (-not $gh.Found) {
            return New-CheckResult `
                -Name "GitHub auth" `
                -Status "Fail" `
                -Detail "GitHub CLI is missing, so account status could not be checked." `
                -Issue "GitHub account status could not be checked." `
                -Fix "Install GitHub CLI, then follow $GuidePath -> 'Sign in to GitHub (both accounts)'."
        }

        # Match any line containing "Logged in to ... account NAME" or "Logged in as NAME".
        # The leading prefix is intentionally permissive: PowerShell's console codepage
        # mangles gh's '✓' glyph into 'Γ£ô' (or similar), and the original regex's
        # optional ✓ would not match the mangled version, returning 0 accounts.
        $accountMatches = [regex]::Matches($gh.Output, "(?im)^[^\r\n]*Logged in (?:to[^\r\n]*?account|as)\s+([A-Za-z0-9][A-Za-z0-9_-]*)")
        $accounts = @($accountMatches | ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique)

        if ($accounts.Count -eq 0) {
            return New-CheckResult `
                -Name "GitHub auth" `
                -Status "Fail" `
                -Detail "No logged-in GitHub accounts found. Fix: see $GuidePath -> 'Sign in to GitHub (both accounts)'." `
                -Issue "No GitHub accounts are logged in." `
                -Fix "See $GuidePath -> 'Sign in to GitHub (both accounts)'. You need a personal account and a Microsoft EMU account."
        }

        # Match account types by pattern, not by Johan's usernames, so this works for any participant.
        $microsoftAccounts = @($accounts | Where-Object { $_ -match "_microsoft$" })
        $personalAccounts = @($accounts | Where-Object { $_ -notmatch "_microsoft$" })

        if ($personalAccounts.Count -gt 0 -and $microsoftAccounts.Count -gt 0) {
            return New-CheckResult `
                -Name "GitHub auth" `
                -Status "Pass" `
                -Detail "personal account '$($personalAccounts[0])' and Microsoft EMU account '$($microsoftAccounts[0])' found."
        }

        $missing = [System.Collections.Generic.List[string]]::new()
        if ($personalAccounts.Count -eq 0) {
            $missing.Add("personal GitHub account")
        }
        if ($microsoftAccounts.Count -eq 0) {
            $missing.Add("Microsoft GitHub account (*_microsoft)")
        }

        $missingText = $missing -join " and "
        $issue = if ($microsoftAccounts.Count -eq 0) { "Microsoft GitHub account not logged in." } else { "Personal GitHub account not logged in." }

        return New-CheckResult `
            -Name "GitHub auth" `
            -Status "Fail" `
            -Detail "$missingText not logged in. Fix: see $GuidePath -> 'Sign in to GitHub (both accounts)'. PMX MCP needs the *_microsoft account." `
            -Issue $issue `
            -Fix "See $GuidePath -> 'Sign in to GitHub (both accounts)' and 'PMX install: switch accounts, then switch back'."
    }
    catch {
        return New-CheckResult `
            -Name "GitHub auth" `
            -Status "Fail" `
            -Detail "GitHub account status could not be checked. Fix: see $GuidePath -> 'Sign in to GitHub (both accounts)'." `
            -Issue "GitHub account status could not be checked." `
            -Fix "See $GuidePath -> 'Sign in to GitHub (both accounts)'."
    }
}

function Test-AzureCli {
    try {
        $az = Invoke-Tool -Command "az" -Arguments @("--version")
        if (-not $az.Found -or $az.ExitCode -ne 0) {
            return New-CheckResult `
                -Name "Azure CLI" `
                -Status "Fail" `
                -Detail "Azure CLI was not found. Fix: run 'winget install Microsoft.AzureCLI', then re-open PowerShell." `
                -Issue "Azure CLI is missing." `
                -Fix "Run 'winget install Microsoft.AzureCLI', re-open PowerShell, then see $GuidePath -> Step 4."
        }

        $account = Invoke-Tool -Command "az" -Arguments @("account", "show", "--output", "json")
        if ($account.ExitCode -ne 0) {
            return New-CheckResult `
                -Name "Azure CLI" `
                -Status "Fail" `
                -Detail "Azure CLI is installed, but you are not logged in. Fix: run 'az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47'." `
                -Issue "Azure CLI is not logged in." `
                -Fix "Run 'az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47'. See $GuidePath -> Step 4."
        }

        try {
            $accountJson = $account.Output | ConvertFrom-Json
            $userName = if ($accountJson.user.name) { $accountJson.user.name } else { "an Azure account" }
            return New-CheckResult -Name "Azure CLI" -Status "Pass" -Detail "logged in as $userName."
        }
        catch {
            return New-CheckResult -Name "Azure CLI" -Status "Pass" -Detail "installed and logged in."
        }
    }
    catch {
        return New-CheckResult `
            -Name "Azure CLI" `
            -Status "Fail" `
            -Detail "Azure CLI could not be checked. Fix: see $GuidePath -> Step 4." `
            -Issue "Azure CLI check failed." `
            -Fix "See $GuidePath -> Step 4. If needed, run 'winget install Microsoft.AzureCLI'."
    }
}

function Test-Git {
    try {
        $git = Invoke-Tool -Command "git" -Arguments @("--version")
        if (-not $git.Found -or $git.ExitCode -ne 0) {
            return New-CheckResult `
                -Name "Git" `
                -Status "Fail" `
                -Detail "Git was not found. Fix: install Git from https://git-scm.com/download/win." `
                -Issue "Git is missing." `
                -Fix "Install Git from https://git-scm.com/download/win, then re-open PowerShell. See $TroubleshootingPath."
        }

        return New-CheckResult -Name "Git" -Status "Pass" -Detail "$(Get-FirstLine -Text $git.Output) detected."
    }
    catch {
        return New-CheckResult `
            -Name "Git" `
            -Status "Fail" `
            -Detail "Git could not be checked. Fix: install Git from https://git-scm.com/download/win." `
            -Issue "Git check failed." `
            -Fix "Install Git from https://git-scm.com/download/win. See $TroubleshootingPath."
    }
}

function Test-WorkingDirectory {
    try {
        $currentPath = (Get-Location).Path
        if ($currentPath -match "(?i)^C:\\Windows(\\System32|\\SysWOW64)?") {
            return New-CheckResult `
                -Name "Working directory" `
                -Status "Warning" `
                -Detail "you are running from $currentPath. Fix: move to the folder where you cloned cli-intro, for example 'cd ~\projects'." `
                -Issue "Script is running from a Windows system folder." `
                -Fix "Run 'cd ~\projects' or open the folder where you cloned cli-intro, then run the script again."
        }

        return New-CheckResult -Name "Working directory" -Status "Pass" -Detail "running from $currentPath."
    }
    catch {
        return New-CheckResult `
            -Name "Working directory" `
            -Status "Warning" `
            -Detail "current folder could not be checked. Fix: run from the folder where you cloned cli-intro." `
            -Issue "Working directory could not be checked." `
            -Fix "Open the folder where you cloned cli-intro, then run the script again."
    }
}

function Write-Summary {
    $failures = @($Results | Where-Object { $_.Status -eq "Fail" })
    $warnings = @($Results | Where-Object { $_.Status -eq "Warning" })
    $passedCount = @($Results | Where-Object { $_.Status -ne "Fail" }).Count

    Write-Host $Separator -ForegroundColor DarkGray

    if ($failures.Count -eq 0 -and $warnings.Count -eq 0) {
        Write-Host "✓ All checks passed. You're ready for the workshop." -ForegroundColor Green
    }
    elseif ($failures.Count -eq 0) {
        Write-Host "Summary: $passedCount of $($Results.Count) checks passed, with $($warnings.Count) warning(s)." -ForegroundColor Yellow
        foreach ($warning in $warnings) {
            Write-Host "! $($warning.Issue)" -ForegroundColor Yellow
            Write-Host "  Fix: $($warning.Fix)" -ForegroundColor Yellow
        }
        Write-Host "✓ Your required tools look ready for the workshop." -ForegroundColor Green
    }
    else {
        Write-Host "Summary: $passedCount of $($Results.Count) checks passed." -ForegroundColor Red
        foreach ($failure in $failures) {
            Write-Host "✗ $($failure.Issue)" -ForegroundColor Red
            Write-Host "  Fix: $($failure.Fix)" -ForegroundColor Yellow
        }
    }

    Write-Host $Separator -ForegroundColor DarkGray
}

Write-Host "Copilot CLI workshop readiness check" -ForegroundColor Cyan
Write-Host "This only checks your setup. It will not install anything or start login flows." -ForegroundColor DarkGray
Write-Host ""

Add-CheckResult -Result (Test-PowerShellVersion)
Add-CheckResult -Result (Test-Node)
Add-CheckResult -Result (Test-CopilotCli)
Add-CheckResult -Result (Test-GitHubCli)
Add-CheckResult -Result (Test-GitHubAuth)
Add-CheckResult -Result (Test-AzureCli)
Add-CheckResult -Result (Test-Git)
Add-CheckResult -Result (Test-WorkingDirectory)

Write-Host ""
Write-Summary

# TODO: add MCP install verification once p10-validate-mcp-prompt is resolved
