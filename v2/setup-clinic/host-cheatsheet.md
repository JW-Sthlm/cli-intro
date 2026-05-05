# Host Cheatsheet

One-page command and troubleshooting reference for the Setup Clinic.

Use this while people are sharing their verification output in chat.

Keep the group moving. Ask for the summary line and first failed item only.

**🔧 Going deeper (optional)** — Use the commands below when you need to verify the exact tool, account, or tenant state.

---

## Core flow

Start here when someone is unsure whether setup worked.

This checks the participant's setup.

```powershell
.\v2\pre-work\verify.ps1
```

If PowerShell blocks the script, run it with execution policy bypass for this one command.

```powershell
pwsh -ExecutionPolicy Bypass -File .\v2\pre-work\verify.ps1
```

This opens Copilot CLI for the first smoke test.

```powershell
copilot
```

This checks which GitHub accounts are authenticated.

```powershell
gh auth status
```

This checks whether Azure CLI is logged in.

```powershell
az account show
```

This logs in to Azure with the Microsoft tenant used by PMX.

```powershell
az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47
```

---

## Top failure modes and quick fixes

### 1. PowerShell is 5.x

**Symptom:** the readiness script refuses to run or says PowerShell 7 is required.

**What to say:** "You have the old Windows PowerShell open. We need PowerShell 7. This is common."

This installs PowerShell 7.

```powershell
winget install Microsoft.PowerShell
```

Then ask the participant to close all terminal windows and open PowerShell 7.

**⚠️ Common trap** — If they do not have install rights, capture this as an admin-help action and move on.

---

### 2. npm not found

**Symptom:** setup or MCP install says npm is not recognized.

**What to say:** "Node.js is missing or Terminal has not picked it up yet. Install Node, then restart Terminal."

Install Node.js LTS from the official site:

```text
https://nodejs.org/
```

This checks whether Node is visible after restart.

```powershell
node --version
```

This checks whether npm is visible after restart.

```powershell
npm --version
```

**⚠️ Common trap** — If Node was just installed and still fails, close all terminal windows and reopen them. If it still fails, restart the laptop.

---

### 3. GitHub login opens the wrong browser profile

**Symptom:** GitHub CLI login opens a browser profile that is already signed in as the wrong account.

**What to say:** "Use the web code flow. You can copy the code into the right browser profile manually."

This starts GitHub login with a manual browser code.

```powershell
gh auth login --web
```

Use this twice if needed: once for the personal account and once for the Microsoft EMU account.

This checks the result.

```powershell
gh auth status
```

**⚠️ Common trap** — If the wrong account is active later, switch instead of creating a token.

This switches GitHub CLI to the account you name.

```powershell
gh auth switch --user <account-name>
```

---

### 4. Azure login shows a subscription picker

**⚠️ Common trap** — This blocked people in the workshop. The fix is simply to press Enter.

**Symptom:** Azure CLI lists subscriptions and asks the participant to choose one.

**What to say:** "Press Enter. For this workshop we only need a valid login, not a specific subscription."

This logs in again if needed.

```powershell
az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47
```

This confirms Azure login works.

```powershell
az account show
```

---

### 5. PMX MCP install asks for a PAT

**⚠️ Common trap** — This usually means EMU vs personal account mismatch, not that the participant needs a token.

**Symptom:** GitHub asks for a Personal Access Token while installing or cloning PMX MCP.

**What to say:** "Stop. Do not create a token. This usually means GitHub is using the wrong account."

This switches to the Microsoft EMU account for PMX install.

```powershell
gh auth switch --user <yourname>_microsoft
```

After PMX install, this switches back to the personal account.

```powershell
gh auth switch --user <your-personal-username>
```

This verifies the active account.

```powershell
gh auth status
```

See [Troubleshooting](../reference/troubleshooting.md) for the full explanation.

---

### 6. MCP install location prompt

**⚠️ Common trap** — Do not choose Copilot Cloud Agent for local CLI setup.

**Symptom:** Copilot CLI asks where to configure MCP servers, and the participant is unsure which option to pick.

**What to say:** "Do not pick Copilot Cloud Agent. We want the local user/global option so it works from any folder on this machine."

Open question: the exact menu label still needs validation under plan item `p10-validate-mcp-prompt`. Johan needs to confirm this with Taras before the next session.

Until confirmed, guide participants toward the user/global local option, not workspace-only and not Copilot Cloud Agent.

Ask Copilot CLI to explain the prompt if needed.

```text
Which MCP configuration location should I choose for local Copilot CLI use on this machine?
```

---

## Triage rule

If more than two people are stuck on the same issue, pause the group and fix it together.

If one person is stuck on laptop permissions, capture the action and keep the group moving.
