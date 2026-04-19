# Pre-Session Checklist

Run through these five checks before the session. If any fail, see the [Setup Guide](setup-guide.md) troubleshooting section.

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

Then type `/login` if prompted, or just ask it something:

```
Hello, what model are you using?
```

**Pass:** You get a response from the AI

---

## ✅ Check 3: Azure CLI is logged in

```
az account show --query "{name:name, user:user.name}" -o table
```

**Pass:** Shows your Microsoft account name and subscription

---

## ✅ Check 4: MCP servers are configured

Inside Copilot CLI, type:

```
/env
```

**Pass:** You see PMX, GitHub, and M365 listed under MCP servers

---

## ✅ Check 5: PMX data is accessible

Inside Copilot CLI, type:

```
Show me my PMX projects
```

**Pass:** You see project names from D365 Partner Management

---

## All 5 passed?

You're ready for the session. See you there! 🎉

## Something not working?

Don't stress — we'll have 5 minutes at the start of the session to troubleshoot. But if you want to fix it now, check the [Setup Guide](setup-guide.md) troubleshooting table.
