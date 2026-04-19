# Setup Guide — Copilot CLI Intro Session

> **Time needed:** ~15 minutes  
> **What you'll end up with:** A working Copilot CLI with three MCP servers connected (PMX, GitHub, M365)

---

## Before You Start: Understand Your GitHub Accounts

As a Microsoft employee, you have access to GitHub Copilot at no cost to you — Microsoft provides the entitlement. But you need to make sure your account is connected to that entitlement.

You likely have **two** GitHub accounts:

| Account type | What it is | Username format |
|-------------|-----------|----------------|
| **EMU** (Enterprise Managed User) | Your Microsoft corporate account on `github.com/ms-copilot` | `yourname_microsoft` |
| **Personal** | Your own GitHub account | Whatever you chose |

**The key step:** Connect your **personal** GitHub account to the Microsoft Copilot entitlement. This gives your personal account full Copilot access — paid for by Microsoft, not you. Verify and connect at:

👉 **https://copilot.github.microsoft.com/**

This portal shows your entitlement status and walks you through connecting your personal account if it's not already linked.

**Which account to use for Copilot CLI?**

- **Personal account is recommended for this session.** Once connected to the entitlement, it has full Copilot access. It works with any public repo and your own repos.
- **EMU account** is required only for Microsoft-internal repos (e.g., the `ms-copilot` org). Use it when you need to access internal code.
- You can switch between accounts: `gh auth switch --user <account>`

**Internal resources:**
- **Copilot portal:** https://copilot.github.microsoft.com/ — verify entitlement, connect accounts, check setup
- **Copilot guidelines:** https://eng.ms/docs/initiatives/ai-guidance-for-microsoft-developers/governance/github-copilot-guidelines
- **Quick Start guide:** Search "GitHub Copilot QuickStart" on the R&I SharePoint site — it has a verification function that checks your setup automatically
- **Agency / GitOps:** https://eng.ms/docs/coreai/devdiv/one-engineering-system-1es/1es-jacekcz/startrightgitops/agency

---

## Step 1: Install Copilot CLI

Open **PowerShell** (search for "PowerShell" in the Start menu — make sure it says "PowerShell 7" or "pwsh", not "Windows PowerShell").

Run this command:

```
winget install GitHub.Copilot
```

Wait for it to finish. Then close and reopen PowerShell.

Verify it installed:

```
copilot --version
```

You should see a version number. If you get an error, restart your terminal and try again.

---

## Step 2: Log In

Launch Copilot CLI:

```
copilot
```

You'll see an animated banner. Type:

```
/login
```

Follow the on-screen instructions — it will open a browser window where you authenticate with your **personal** GitHub account (recommended for this session).

> **Note:** You need an active Copilot subscription on the account you log in with. Verify at https://copilot.github.microsoft.com/ or https://github.com/settings/copilot.

---

## Step 3: Verify It Works

Once logged in, type a simple prompt to test:

```
What day is it today?
```

If you get an answer, you're in business. Type `/exit` to leave for now.

---

## Step 4: Log In to Azure (for PMX)

The PMX MCP server needs an Azure login to talk to Dynamics 365. Open PowerShell and run:

```
az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47
```

A browser window will open. Sign in with your Microsoft account. Once it says "You have logged in", you're done.

> **Don't have `az` installed?** Run `winget install Microsoft.AzureCLI` first, then restart PowerShell.

---

## Step 5: Configure MCP Servers

MCP servers are what let Copilot CLI talk to external tools — think of them as connectors. We'll set up three:

1. **PMX** — your partner management data in D365
2. **GitHub** — repos, issues, pull requests
3. **M365** — email, calendar, Teams

### Option A: Copy the config file (easiest)

Your session facilitator will share a pre-made config file. Save it to:

```
C:\Users\<your-username>\.copilot\mcp-config.json
```

Replace `<your-username>` with your actual Windows username.

### Option B: Use the /mcp command

Launch `copilot` and use the built-in command:

```
/mcp
```

This opens an interactive menu where you can add MCP servers. Your facilitator will walk you through this if needed.

---

## Step 6: Verify MCP Servers

Launch Copilot CLI:

```
copilot
```

Type:

```
/env
```

Look for the MCP servers section. You should see entries for PMX, GitHub, and M365 tools. If any are missing, double-check your config file path and contents.

Try a quick test:

```
Show me my PMX projects
```

If you see project data from D365, everything is connected.

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `winget` not found | Install it from the Microsoft Store (search "App Installer") |
| `copilot` command not found after install | Close and reopen PowerShell. If still missing, check your PATH |
| `/login` fails or times out | Make sure you're on the corporate network or VPN |
| `az login` fails | Run `winget install Microsoft.AzureCLI` first, restart PowerShell |
| PMX returns errors | Re-run `az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47` |
| MCP servers not showing in `/env` | Check that `mcp-config.json` is in the right folder and is valid JSON |

---

## What to Bring to the Session

- A laptop with everything above working
- PowerShell open and ready
- Curiosity — no coding skills needed

## After the Session

For self-paced deep dives, check out the official beginner course:
- **Course:** https://jamesmontemagno.github.io/copilot-cli-for-beginners/ (~2 hours)
- **Repo:** https://github.com/github/copilot-cli-for-beginners (Codespaces-ready)
