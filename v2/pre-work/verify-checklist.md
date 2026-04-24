# Pre-Session Checklist

Run through these five checks before the session. If any fail, see the [Setup Guide](setup-guide.md) troubleshooting section.

💡 **For most of these checks, you can just ask Copilot CLI.** If a check has a technical command, that's for verification — but plain English works too.

---

## ✅ Check 1: Copilot CLI is installed

Open PowerShell and run:

```
copilot --version
```

**Pass:** You see a version number (e.g., `v1.0.x`)

---

## ✅ Check 2: You can log in

```
copilot
```

Then just ask it something:

```
Hello, what model are you using?
```

**Pass:** You get a response from the AI

---

## ✅ Check 3: Azure CLI is logged in

Inside Copilot CLI, ask:

```
Am I logged in to Azure? Which account am I using?
```

Or verify manually in PowerShell: `az account show`

**Pass:** Shows your Microsoft account name

---

## ✅ Check 4: MCP servers are connected

Inside Copilot CLI, ask:

```
What tools and MCP servers do I have available?
```

**Pass:** You see PMX, GitHub, and M365 mentioned

---

## ✅ Check 5: PMX data is accessible

Inside Copilot CLI, ask:

```
Show me my PMX projects
```

**Pass:** You see project names from D365 Partner Management

---

## All 5 passed?

You're ready for the session. See you there! 🎉

## Something not working?

Don't stress — we'll have 5 minutes at the start of the session to troubleshoot. But if you want to fix it now, check the [Setup Guide](setup-guide.md) troubleshooting table.
