# Troubleshooting Guide

Common issues and fixes for Copilot CLI.

---

## Account & Login Issues

### Which GitHub account should I use?

You have two accounts: **EMU** (`yourname_microsoft`) and **personal**. For this session, use your **personal** account — it has unlimited code completions and its own premium request quota.

### Switching between accounts

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

## Login Issues

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

---

## MCP Server Issues

### MCP servers not showing

**First, try asking CLI:** Inside Copilot CLI, type:

```
My MCP servers aren't showing up. Can you help me diagnose and fix this?
```

CLI can often find the issue and walk you through fixing it.

**If that doesn't work:** Make sure you've restarted Copilot CLI after any config changes. If you set up MCP servers using the `/mcp` command or by asking CLI, they should be saved automatically.

### MCP server listed but tools not working

**Fix:** Some MCP servers need separate authentication. For PMX, ask CLI:

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

**Fix:** Your Azure login may have expired. Ask CLI:

```
Help me reconnect to Azure for PMX
```

Or re-run `az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47` in PowerShell, then restart Copilot CLI.

### "No projects found"

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
