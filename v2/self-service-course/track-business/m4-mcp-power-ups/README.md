# Module 4: MCP power-ups: PMX, M365, GitHub

> ⏱️ **Estimated time:** 20 min
> 🎯 **You'll be able to:** install MCP servers, connect Copilot CLI to your inbox, calendar, projects, and repos, and have it pull real data into your work.

---

<details>
<summary><strong>📖 "What MCP is, in plain English"</strong>: concept + table, click to expand</summary>

📖 An **MCP server** is a small program that gives Copilot access to a system. Instead of you copy-pasting from Outlook into the CLI, an MCP server lets the CLI **read your inbox directly** when you ask.

Think of it as a translator between Copilot and a system.

| MCP server | Gives Copilot access to | Why you care |
|------------|------------------------|--------------|
| **GitHub MCP** | Issues, PRs, repos | Pull issues from a repo into a status update |
| **PMX MCP** | Your projects, opportunities, partners | Generate vTeam updates without clicking through PMX |
| **M365 MCP** | Your inbox, calendar, files in OneDrive | "What's on my calendar tomorrow with Contoso?" |

You don't write the MCP server. Other people do. You just install and use them.

</details>

---

## ⚠️ The install prompt that confuses everyone

When you install an MCP server, Copilot CLI asks:

> Where do you want to configure these MCP servers?

You'll see a numbered menu. **Pick option 2: Copilot CLI.**

```text
Where do you want to configure these MCP servers?

  1. VS Code (Copilot Chat)
❯ 2. Copilot CLI
  3. GitHub Copilot Coding Agent (copilot-setup-steps.yml)
  4. Other
  5. Other (type your answer)
```

The other options install the MCP somewhere Copilot CLI can't find it (VS Code workspace, GitHub-side runners, etc.) and it silently fails.

If you pick the wrong one and your MCP is missing later, just re-run the install and pick option 2 this time.

---

## 🚀 Install your first MCP server: GitHub MCP

📖 GitHub MCP is the easiest one to start with. Most permissive, no special accounts needed beyond what you already have.

In a Copilot CLI session:

```
> Install the GitHub MCP server.
```

Follow the prompts. When asked where to install, pick the option above.

**Verify it worked:**

```text
> /mcp

Configured MCP servers:
  github   ✓ connected   (47 tools)

Type a prompt to use them.
```

You should see `github` in the list.

**Try it:**

```
> Show me my last 5 GitHub issues across all my repos.
```

Real data. From your real GitHub. No copy-paste.

---

## 🚀 PMX MCP (Microsoft-internal)

🔧 / 📖 PMX is Microsoft's Partner Management Experience, your projects, opportunities, partner accounts. Lives in Dataverse.

**Prereq:** you must be logged into your `*_microsoft` EMU account (see M1).

There are two ways to install it.

### Option 1: Plugin marketplace (recommended)

Four commands, no clone, no `npm install`. The repo ships a manifest and Copilot CLI handles the rest.

```powershell
# Switch to your EMU account (PMX is private to gim-home org)
gh auth switch --user <your-microsoft-username>

# Install via the marketplace
copilot plugin marketplace add gim-home/pmx-mcp
copilot plugin install pmx-mcp@pmx-mcp

# Switch back to personal
gh auth switch --user <your-personal-username>
```

Then relaunch Copilot CLI (`copilot` again, or `/restart` if you're already in) so the PMX tools register.

<details>
<summary><strong>🔧 "Option 2: Direct install via Copilot prompt (legacy fallback)"</strong>, click to expand</summary>

🔧 Use this if you want the source on disk or the marketplace flow fails for any reason. Same account dance, but you ask Copilot CLI to clone and wire it up.

```powershell
# Switch to your EMU account
gh auth switch --user <your-microsoft-username>

# Now ask Copilot CLI to install
copilot
> Install the PMX MCP server. Use the gim-home/pmx-mcp repo.
```

Follow prompts. When asked where to configure the server, pick option 2 (Copilot CLI).

</details>

### Verify

Once installed (either option):

```text
> /mcp

Configured MCP servers:
  github   ✓ connected   (47 tools)
  pmx      ✓ connected   (38 tools)

> Show me my open PMX projects.

  Fetching from PMX (Dataverse)...

  3 open projects:
  • Contoso, AI Foundry pilot     (status: In Progress, last update 4 days ago)
  • Fabrikam, Fabric POC          (status: In Progress, last update 12 days ago)
  • Acme, Discovery Cards workshop (status: Not Started, due Q3)
```

You should get a real list of your projects from PMX.

**Switch back to personal:**

```powershell
gh auth switch --user <your-personal-username>
```

⚠️ **You only need to be on EMU for the *install*.** After that, the MCP runs with whatever credentials it has cached. Switch back to personal so other tools work normally.

---

## 🚀 M365 MCP (your inbox + calendar + files)

📖 M365 MCP unlocks the most "wow" use cases for non-technical roles.

```
> Install the M365 MCP server.
```

After install, try:

```
> What's on my calendar tomorrow?
> Summarize emails I got from Contoso this week.
> Find the most recent file I worked on with the word "QBR" in it.
```

⚠️ **First-time consent.** Microsoft will ask you to consent to the MCP reading your inbox. Read the consent screen, it'll list permissions like `Mail.Read`, `Calendars.Read`. These are read-only by default. Don't grant write permissions you don't need.

---

<details>
<summary><strong>📖 "Combining MCP servers in one prompt"</strong>: the magic moment, click to expand</summary>

📖 Once you have multiple MCPs installed, the magic happens:

```text
> Look at my PMX projects with status "in progress" that haven't had an update in 2 weeks.
> Then check my email for any recent activity with those partners.
> Draft a 1-line update for each project based on what you find.
```

That's three systems queried, one prompt, one draft output. Try it. It feels like the future.

</details>

---

<details>
<summary><strong>🆘 "When MCP doesn't work"</strong>: troubleshooting, click to expand</summary>

| Symptom | Cause | Fix |
|---------|-------|-----|
| MCP not in `/mcp` list | Installed in wrong location | Reinstall, pick option 2 (Copilot CLI) |
| PMX returns auth error | Wrong GitHub account | `gh auth switch` to `*_microsoft`. Retry. |
| M365 says "no permissions" | Consent screen was declined | Reinstall, accept consent |
| Slow / hangs | First-time auth bouncing through browser | Be patient, ~10 sec on slow networks |
| "Tool not available" | MCP not running | Restart Copilot CLI |

For deeper issues: [troubleshooting.md](../../../reference/troubleshooting.md).

</details>

---

## 🎯 Real-work test: a partner update from MCP

📖 Pick a partner you have an active project with. In Copilot CLI:

```
> Look at my PMX project for <partner name>. Then check my email for emails I've exchanged with anyone @ <partner domain> in the last 30 days. Draft a 5-bullet update for my manager: status, last meeting, blockers, next step, ask.
```

If this works (and it should), you just compressed 30 minutes of clicking into one prompt.

---

## ✅ You're done with Track A 📖

If you can:

- Install an MCP server and verify it shows in `/mcp`
- Pull real data from at least one MCP
- Combine MCP data with prompt context to produce a useful artefact

**…then you've achieved the productivity bar.** You can drive Copilot CLI for partner work end-to-end.

**Track A graduates: stop here, ship some real work, come back if you want more.**

🔧 **Track B continues with:** custom AI agents, reusable skills, and end-to-end pipelines.

---

## 👉 Track A: [Back to course home](../../README.md)
## 👉 Track B continues: [Module 5: Custom AI agents](../../track-technical/m5-custom-agents/README.md)
