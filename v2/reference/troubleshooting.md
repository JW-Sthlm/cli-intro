# Troubleshooting Guide

Common issues and fixes for Copilot CLI.

---

## Account & Auth Traps

### ⚠️ Common trap: I was asked for a Personal Access Token

Stop there. Do not create a Personal Access Token for this workshop. It usually means GitHub is using the wrong account.

Run this in PowerShell instead:

```
gh auth switch --user <other-account>
```

Then retry the step that failed.

**🔧 Going deeper (optional)** — A Personal Access Token is a manual GitHub password replacement. It can work, but it creates a side quest: scopes, expiry, copy/paste, and security warnings. For this workshop, account switching is the clean answer.

### ⚠️ Common trap: PMX MCP install fails / says repo not found / 403

PMX is the exception to the personal-account rule. The PMX MCP server lives in `gim-home/pmx-mcp`, a Microsoft GitHub organization. Use your EMU account for that install, then switch back.

**The clean path is the prompt-orchestrated install in [Setup Guide → Step 3b](https://cli-intro-share.pages.dev/setup.html#step-3)**. Copilot handles the switch-install-switch sequence itself, so there's nothing to misplace.

**If you're doing it manually**, run them one at a time. Find your EMU username first:

```
gh auth status
```

The EMU is the line ending in `_microsoft`. Copy the exact name, then:

```
gh auth switch --user YOUR_EMU_USERNAME
gh auth status
```

The second `gh auth status` should show `Active account: true` on the `_microsoft` line. If not, re-run the switch. Only when the EMU is confirmed active:

```
copilot plugin marketplace add gim-home/pmx-mcp
copilot plugin install pmx-mcp@pmx-mcp
```

Then switch back:

```
gh auth switch --user YOUR_PERSONAL_USERNAME
```

Relaunch Copilot CLI (`/exit` and run `copilot` again) so the new tools register. If your Azure session expired, also re-run `az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47`.

> **⚠️ Switch the EMU account FIRST, and verify the switch took.** The `marketplace add` step uses your active `gh` credentials to fetch the manifest. Two failure modes: `404 repo not found` (EMU not logged in at all) or `403 Write access not granted` (EMU logged in but personal still active). Both are fixable by re-running the switch and verifying with `gh auth status` before retrying the marketplace command.

**🔧 Going deeper (optional)** — `repo not found` and `403` both mean "your active credentials can't read this repo". 404 is "no token at all for that org"; 403 is "wrong token". Switching to EMU gives `git`, `gh`, and the `marketplace add` fetch the right credentials for the `gim-home` repo.

### Which account am I on right now?

Ask GitHub CLI directly:

```
gh auth status
```

Look for the account marked as active. Example:

```
github.com
  ✓ Logged in to github.com account JW-Sthlm
  - Active account: true
```

If the wrong account is active, switch:

```
gh auth switch --user <account-name>
```

---

## Account & Login Issues

### Which GitHub account should I use?

Use your **personal** account for normal Copilot CLI work. Use your **EMU** account only when you need Microsoft-internal GitHub access, such as installing `gim-home/pmx-mcp`. Then switch back to personal.

### Switching between accounts

Use this whenever the active GitHub account is wrong.

```
gh auth switch --user <account-name>
```

### `/login` fails or times out

**Possible causes:**
1. Not on corporate network or VPN
2. Browser pop-up blocked
3. Copilot subscription not active

**Fix:** 
- Make sure you're on VPN
- Check your browser didn't block the pop-up
- Verify your Copilot subscription at https://copilot.github.microsoft.com/ or https://github.com/settings/copilot

### "You don't have access to Copilot"

**Fix:** Your organization may need to enable Copilot CLI. Check with your team lead or admin. See: https://docs.github.com/copilot/managing-copilot

### Verify your setup using the internal portal

Go to https://copilot.github.microsoft.com/ — it has a verification function that checks your Copilot entitlement and setup status. The R&I SharePoint QuickStart page also has an automated setup checker.

---

## Installation Issues

### `winget` not found

**Fix:** Install "App Installer" from the Microsoft Store. It includes `winget`.

### `copilot` command not found after install

**Fix:** Close ALL PowerShell/terminal windows and reopen. If still missing, try reinstalling with `winget install GitHub.Copilot`. As a last resort, restart your computer.

---

## MCP Server Issues

### MCP servers not showing

First, try asking CLI: Inside Copilot CLI, type:

```
My MCP servers aren't showing up. Can you help me diagnose and fix this?
```

CLI can often find the issue and walk you through fixing it.

**If that doesn't work:** Make sure you've restarted Copilot CLI after any config changes. If you set up MCP servers using the `/mcp` command or by asking CLI, they should be saved automatically.

### MCP server listed but tools not working

**🔧 Going deeper (optional)** — Some MCP servers need separate authentication. For PMX, ask CLI:

```
PMX is not working. Can you help me reconnect to Azure for the PMX MCP server?
```

Or re-authenticate manually in PowerShell:

```
az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47
```

---

## PMX Issues

### "Failed to retrieve" or authentication errors

**⚠️ Common trap** — Your Azure login may have expired. Ask CLI:

```
Help me reconnect to Azure for PMX
```

Or re-run `az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47` in PowerShell, then restart Copilot CLI.

### "No projects found"

This may be a data access issue, not a prompt issue.

**Possible causes:**
1. You're not assigned to any projects in D365
2. The login token expired

**Fix:** Ask CLI: `Am I connected to Azure? Which tenant am I on?` — it can verify for you.

### PMX returns partial or unexpected data

**Tip:** PMX queries depend on your D365 permissions. You can only see data you have access to. If data looks incomplete, it might be a permissions issue, not a Copilot issue.

---

## M365 Issues

### Calendar/email not working

**Fix:** Ask CLI: `Why can't I access my calendar?` — it can often diagnose the issue. If that doesn't help:
1. Make sure the M365 MCP server is connected (ask: `What MCP servers do I have?`)
2. Try a simple query first: `What time is it?`
3. If that works but calendar doesn't, the M365 tools may need consent. Follow any prompts.

---

## General Issues

### ⚠️ Common trap: a new session keeps crashing

Do not spend the workshop debugging a broken live session. Start a fresh terminal, try `copilot` once, and if it still crashes switch to the backup/demo path and ask for help after.

**🔧 Going deeper (optional)** — Hosts should capture the exact error, model, and first prompt. Then use `/feedback` or the CLI issue path after the session, not during the live exercise.



### Copilot gives wrong or irrelevant answers

**Tips:**
- Be more specific: "In my PMX projects with Contoso..." not just "Show me projects"
- Ask it to try again: "That's not what I meant. I want..." — it understands corrections
- If the conversation has been going long, ask: `Can you summarize what we've discussed so far?` or use `/compact`

### Copilot is slow

**Possible causes:**
- Complex queries that need multiple tool calls
- Network latency

**Fix:** Ask CLI: `Can you use a faster model for this?` or use `/model` to switch manually.

### "Rate limit exceeded"

**Fix:** Wait a minute and try again. Each prompt uses one premium request from your quota.

---

## Still Stuck?

1. **Ask CLI first** — type `I'm having trouble with [describe the problem]` — it can often help
2. Ask the session facilitator or post in the Teams channel
3. Use `/feedback` in Copilot CLI to report a bug
4. Check the docs: https://docs.github.com/copilot/concepts/agents/about-copilot-cli
