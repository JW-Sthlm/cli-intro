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

**Fix:** Close ALL PowerShell/terminal windows and reopen. The PATH needs to refresh. If still missing:

```
$env:PATH -split ';' | Select-String -Pattern 'copilot'
```

If no results, the install path wasn't added to PATH. Try reinstalling with `winget install GitHub.Copilot`.

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

### MCP servers not showing in `/env`

**Check 1:** Is the config file in the right place?

```
Get-Content "$HOME\.copilot\mcp-config.json"
```

Should output valid JSON. If file not found, you need to create it.

**Check 2:** Is the JSON valid? Common mistake: trailing commas or missing quotes.

**Check 3:** Restart Copilot CLI after editing the config file. Changes aren't picked up automatically.

### MCP server listed but tools not working

**Fix:** Some MCP servers need separate authentication. For PMX, you need Azure CLI login:

```
az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47
```

---

## PMX Issues

### "Failed to retrieve" or authentication errors

**Fix:** Re-authenticate Azure:

```
az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47
```

Then restart Copilot CLI.

### "No projects found"

**Possible causes:**
1. You're not assigned to any projects in D365
2. The login token expired
3. Wrong tenant

**Fix:** Check `az account show` to verify you're on the right tenant. Try `az login` again.

### PMX returns partial or unexpected data

**Tip:** PMX queries depend on your D365 permissions. You can only see data you have access to. If data looks incomplete, it might be a permissions issue, not a Copilot issue.

---

## M365 Issues

### Calendar/email not working

**Fix:** The M365 MCP server uses your GitHub authentication to connect. If calendar or email queries fail:
1. Make sure the M365 MCP server is listed in `/env`
2. Try a simple query first: `What time is it?`
3. If that works but calendar doesn't, the M365 tools may need consent. Follow any prompts.

---

## General Issues

### Copilot gives wrong or irrelevant answers

**Tips:**
- Be more specific in your prompt
- Provide context: "In my PMX projects..." not just "Show me projects"
- Use `/compact` if the conversation has been going long — context can get cluttered

### Copilot is slow

**Possible causes:**
- Complex queries that need multiple MCP calls
- Network latency
- Large context window

**Fix:** Try `/model` to switch to a faster model. Use `/compact` to trim conversation history.

### "Rate limit exceeded"

**Fix:** Wait a minute and try again. Each prompt uses one premium request from your Copilot quota. Heavy use can hit limits.

---

## Still Stuck?

1. Type `/feedback` in Copilot CLI to report an issue
2. Ask the session facilitator
3. Check the GitHub Copilot CLI docs: https://docs.github.com/copilot/concepts/agents/about-copilot-cli
