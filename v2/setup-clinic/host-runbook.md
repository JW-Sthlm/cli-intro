# Setup Clinic Host Runbook

Minute-by-minute script for a 30-45 minute Setup Clinic.

Goal: every participant leaves with Copilot CLI working, both GitHub accounts authenticated, Azure CLI logged in, and the readiness check passing or with a clear fix.

No slides. No code. No judgement.

Keep participants moving through copy-paste steps. They do not need to understand every command to succeed.

**🔧 Going deeper (optional)** — Host-only explanations sit beside commands so engineers know what is being checked without derailing the clinic.

---

## Before the session

Open these files before people join:

- [Setup Guide](../pre-work/setup-guide.md)
- [Verify Checklist](../pre-work/verify-checklist.md)
- [verify.ps1](../pre-work/verify.ps1)
- [Troubleshooting](../reference/troubleshooting.md)
- [Host Cheatsheet](host-cheatsheet.md)

Start in the repo root folder if you have it cloned locally.

**🔧 Going deeper (optional)** — This moves PowerShell to the repo root on Johan's machine. Adapt the path if you run from another folder.

```powershell
cd C:\Users\jwallquist\projects\cli-intro
```

---

## 0-5 min: Frame the session

### What the host says

"This session exists because setup got in the way last time. That is normal. Copilot CLI is powerful, but the first install has a few moving parts: GitHub accounts, Azure login, and MCP connectors.

The goal is that you leave with a working setup. No code, no slides, no judgement.

If something fails, that is useful information. We either fix it now or identify the exact admin help you need."

### What the host does on screen

Show the [Setup Clinic README](README.md) and point to the outcome list.

### What participants do

- Open PowerShell or Windows Terminal
- Keep the Teams chat open
- Be ready to paste the verification summary line later

### What to watch for

- People opening Windows PowerShell 5.x instead of PowerShell 7
- People apologizing for not being technical
- People starting side quests before the group flow begins

Reassure them early: this is a setup clinic, not a coding test.

---

## 5-10 min: Show the verify script output

### What the host says

"Before we install anything, I want to show what success looks like. This script does not change your laptop. It only checks the setup and prints what passed or failed."

### What the host does on screen

Run the readiness script.

Participants should look for the final pass/fail summary, not debug every line.

**🔧 Going deeper (optional)** — This checks the laptop setup and prints a pass/fail summary.

```powershell
.\v2\pre-work\verify.ps1
```

If PowerShell blocks the script, show the bypass version.

This runs the same readiness script with a one-time execution policy bypass.

```powershell
pwsh -ExecutionPolicy Bypass -File .\v2\pre-work\verify.ps1
```

Name the gates the group will clear together:

- PowerShell 7
- Node.js and npm
- Copilot CLI
- GitHub CLI and both GitHub accounts
- Azure CLI login
- Git
- MCP server setup

### What participants do

Watch first. Do not run the script yet unless they are already comfortable.

### What to watch for

- The script currently checks core tooling and auth. MCP verification is still partly manual until the MCP location prompt is validated.
- If your own machine fails, narrate calmly. It proves the script is doing its job.

---

## 10-25 min: Co-install

Work through the [Setup Guide](../pre-work/setup-guide.md) in order. Move as a group. Pause after each gate.

### Gate 1: PowerShell 7

#### What the host says

"PowerShell is just the text window we use to talk to the computer. We need the modern version."

#### What the host does on screen

Check the PowerShell version.

**🔧 Going deeper (optional)** — This shows the PowerShell version currently running.

```powershell
$PSVersionTable.PSVersion
```

If it is version 5.x, install PowerShell 7.

This installs PowerShell 7.

```powershell
winget install Microsoft.PowerShell
```

#### What participants do

- Check their PowerShell version
- Install PowerShell 7 if needed
- Reopen Terminal after install

#### What to watch for

**⚠️ Common trap** — Some laptops block install without admin rights. If that happens, note the person's name and exact blocked install.

---

### Gate 2: Node.js and npm

#### What the host says

"Node is a runtime some MCP installers need. You do not need to learn it. We only need it installed."

#### What the host does on screen

Check Node.js.

**🔧 Going deeper (optional)** — This checks whether Node.js is installed.

```powershell
node --version
```

Check npm.

This checks whether npm is installed.

```powershell
npm --version
```

If either command fails, point participants to the Node.js LTS installer.

Open the official Node.js download page.

```text
https://nodejs.org/
```

#### What participants do

- Run both checks
- Install Node.js LTS if missing
- Restart Terminal after install

#### What to watch for

**⚠️ Common trap** — The most common issue is installing Node but not restarting Terminal. Ask them to close every terminal window and reopen.

---

### Gate 3: Copilot CLI

#### What the host says

"This is the tool we will actually use in the workshop. Once it opens, you can talk to it in plain English."

#### What the host does on screen

Install Copilot CLI if needed.

This is the main tool participants will open and talk to.

**🔧 Going deeper (optional)** — This installs GitHub Copilot CLI.

```powershell
winget install GitHub.Copilot
```

Check Copilot CLI.

This checks that Copilot CLI is visible from PowerShell.

```powershell
copilot --version
```

Open Copilot CLI.

This starts a Copilot CLI session.

```powershell
copilot
```

Inside Copilot CLI, show login if needed.

This starts the Copilot CLI login flow.

```text
/login
```

#### What participants do

- Install Copilot CLI if missing
- Run the version check
- Open Copilot CLI
- Login with their personal GitHub account unless instructed otherwise

#### What to watch for

- **⚠️ Common trap** — Browser opens the wrong GitHub profile
- **⚠️ Common trap** — Participant logs in with EMU only and has no Copilot entitlement
- Corporate network or VPN blocks login

Use [Troubleshooting](../reference/troubleshooting.md) if login fails.

---

### Gate 4: GitHub authentication

#### What the host says

"Most of you have two GitHub accounts. Personal is the default for this workshop. Microsoft EMU is needed for Microsoft-internal repos like PMX MCP."

#### What the host does on screen

Check GitHub authentication.

This shows which GitHub accounts are logged in and which one is active.

```powershell
gh auth status
```

If login is needed, use the web flow.

This starts GitHub CLI login with a browser code.

```powershell
gh auth login --web
```

If the wrong account is active, switch accounts.

This switches GitHub CLI to the account you name.

```powershell
gh auth switch --user <account-name>
```

#### What participants do

- Confirm both accounts are visible if they have both
- Confirm personal account is active after PMX setup is complete
- Do not create a Personal Access Token

#### What to watch for

**⚠️ Common trap** — If PMX install asks for a PAT, stop. Switch to the EMU account instead.

---

### Gate 5: Azure login

#### What the host says

"Azure login is needed so the PMX connector can reach D365. If you see a subscription picker, press Enter. The subscription choice does not matter for this workshop."

#### What the host does on screen

Log in to Azure with the Microsoft tenant.

This signs Azure CLI in to the Microsoft tenant used by PMX.

```powershell
az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47
```

Check Azure login.

This confirms Azure CLI can see an active account.

```powershell
az account show
```

#### What participants do

- Run the login command
- Complete the browser login
- Press Enter if Azure asks for a subscription

#### What to watch for

- Browser opens the wrong account
- **⚠️ Common trap** — Participant waits at subscription picker
- Azure CLI is not installed

If Azure CLI is missing, install it.

This installs Azure CLI.

```powershell
winget install Microsoft.AzureCLI
```

---

### Gate 6: MCP setup

#### What the host says

"MCP servers are connectors. Think Power Automate connectors, but for Copilot CLI. We want PMX, GitHub, and M365 connected. PMX is the only one that needs the EMU account dance — it lives in a private Microsoft org. The other two install with your personal account."

#### What the host does on screen

**Install PMX via the plugin marketplace** (4 commands, no prompts):

Switch to the Microsoft EMU account so `gh` can reach the private repo.

```powershell
gh auth switch --user <yourname>_microsoft
```

Add the marketplace and install the plugin.

```powershell
copilot plugin marketplace add gim-home/pmx-mcp
copilot plugin install pmx-mcp@pmx-mcp
```

Switch back to the personal account.

```powershell
gh auth switch --user <your-personal-username>
```

Launch Copilot CLI to install GitHub and M365 connectors.

```powershell
copilot
```

Ask Copilot CLI to set up the remaining connectors.

```text
I need to set up MCP servers for GitHub and M365. Help me configure them.
```

#### What participants do

- Follow the same account switching pattern
- Do not choose Copilot Cloud Agent when asked for MCP location
- Ask Copilot CLI to explain if a prompt is unclear

#### What to watch for

**⚠️ Common trap** — MCP install location prompt is still an open validation item. Default to the local user/global option, not Copilot Cloud Agent. Johan needs to confirm the exact label with Taras before the next session.

---

## 25-35 min: Each participant runs verify.ps1

### What the host says

"Now everyone runs the checker. Please paste only the final summary line in chat. If it is red, paste the first failed item too."

### What the host does on screen

Run the readiness script again.

This checks the setup and prints the summary participants should paste.

```powershell
.\v2\pre-work\verify.ps1
```

Keep [Host Cheatsheet](host-cheatsheet.md) open.

### What participants do

- Run the readiness script
- Paste the summary line in Teams chat
- If something fails, paste the first failed item and wait for triage

### What to watch for

- Same failure repeated by many people: pause and fix as a group
- One-off install rights issue: capture and move on
- People pasting large output: ask for only the summary line and first failed item

---

## 35-40 min: First conversation

### What the host says

"The setup is not real until the model answers. Now we do the smallest possible first conversation."

### What the host does on screen

Open Copilot CLI.

This starts a Copilot CLI session.

```powershell
copilot
```

Send a simple first prompt.

This is the first "just talk to it" moment. Let people write their own version if they want.

```text
Hello. In one sentence, explain what Copilot CLI can help me do in my partner-facing role.
```

Optional PMX smoke test if PMX is configured.

```text
Show me my PMX projects.
```

### What participants do

- Open Copilot CLI
- Send the same first prompt or write their own
- Confirm they get a response

### What to watch for

- Login expired between install and first run
- Participant still in a failed MCP install flow
- Model responds, but tool calls fail. That is still useful: core CLI works, connector needs follow-up.

---

## 40-45 min: Wrap

### What the host says

"The main workshop assumes setup is done. If your checker passed, you are ready. If one item failed, you now know the exact thing to fix.

Before the workshop, keep the setup guide, troubleshooting page, and exercises folder handy. During the workshop, remember the main pattern: just talk to it. If you do not know the command, ask Copilot CLI what to do."

### What the host does on screen

Show these links:

- [Setup Guide](../pre-work/setup-guide.md)
- [Verify Checklist](../pre-work/verify-checklist.md)
- [Exercises](../exercises/)
- [Troubleshooting](../reference/troubleshooting.md)

### What participants do

- Save the links
- Fix any remaining red item before the main workshop
- Ask in the Teams thread if they need help

### What to watch for

- People leaving with vague failures. Push for a clear owner and next step.
- MCP uncertainty. Flag the MCP prompt label as the remaining open item, not a participant failure.

---

## After the session

Send [post-clinic-followup.md](post-clinic-followup.md) in the Teams thread or Outlook invite.

If any participant still has a failed check, follow up before the main workshop. The main workshop should start with usage, not installation.
