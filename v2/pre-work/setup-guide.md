# Setup Guide — Copilot CLI Intro Session

> **Time needed:** 30–45 minutes the first time on a clean machine. About 10 minutes if you've installed similar tooling before.
> **What you'll end up with:** A working Copilot CLI with three MCP servers connected (PMX, GitHub, M365)

---

## Before You Start: Understand Your GitHub Accounts

As a Microsoft employee, you have access to GitHub Copilot at no cost to you — Microsoft provides the entitlement. But you need to make sure your account is connected to that entitlement.

You likely have **two** GitHub accounts:

| Account type | What it is | Username format |
|-------------|-----------|----------------|
| **EMU** (Enterprise Managed User) | Your Microsoft corporate account on GitHub | `yourname_microsoft` |
| **Personal** | Your own GitHub account | Whatever you chose |

**The key step:** Connect your **personal** GitHub account to the Microsoft Copilot entitlement. This gives your personal account full Copilot access — paid for by Microsoft, not you. Verify and connect at:

👉 **https://copilot.github.microsoft.com/**

This portal shows your entitlement status and walks you through connecting your personal account if it's not already linked.

**Which account should I use?**

- For **95% of Copilot CLI work**, use your **personal account**. That is the right default for this session.
- For installing the **PMX MCP server specifically**, temporarily use your **EMU account**. The PMX server lives in `gim-home/pmx-mcp`, which is in a Microsoft GitHub organization, so your personal account usually cannot clone it.
- The pattern is simple: **switch to EMU → install or clone PMX MCP → switch back to personal**.

If the guide tells you to switch accounts, copy this into PowerShell and replace `<account-name>`.

```
gh auth switch --user <account-name>
```

> **⚠️ Common trap** — If Copilot or `git` ever asks you for a Personal Access Token (PAT), stop.
> Don't generate one. Switch accounts instead with `gh auth switch --user <other-account>` and try again. PATs are not the right path for this workshop.

**Internal resources:**
- **Copilot portal:** https://copilot.github.microsoft.com/ — verify entitlement, connect accounts, check setup
- **Copilot guidelines:** https://eng.ms/docs/initiatives/ai-guidance-for-microsoft-developers/governance/github-copilot-guidelines
- **Quick Start guide:** Search "GitHub Copilot QuickStart" on the R&I SharePoint site — it has a verification function that checks your setup automatically
- **Agency / GitOps:** https://eng.ms/docs/coreai/devdiv/one-engineering-system-1es/1es-jacekcz/startrightgitops/agency

---

## How to use this guide

Each step has commands inside code blocks like this:

```
copilot --version
```

**Copying commands:** when you view this guide on GitHub or the published site, every code block has a small **Copy** button in its top-right corner — hover over the block to see it. That's the safest way to grab the exact command.

**The `>` at the end of a line in your terminal** is the *prompt* — it just means PowerShell is waiting for you to type. The full prompt usually looks like `PS C:\Users\YourName>`. None of that is part of any command — don't copy it.

**Pasting multiple lines into PowerShell:** when a code block has more than one line, PowerShell sometimes runs only the first line and beeps or warns about the rest. If that happens, paste the lines **one at a time** — wait for the prompt (`>`) to come back before pasting the next one.

**You'll be in two different "modes" during setup:**

- **PowerShell** — the regular Windows terminal, prompt looks like `PS C:\Users\YourName>`.
- **Copilot CLI** — runs *inside* the same window after you type `copilot`, prompt looks different (banner + a `❯` or `>` arrow). Type `/exit` to leave Copilot CLI and go back to PowerShell.

The guide will say "in PowerShell" or "in Copilot CLI" before each command so you know which mode you should be in.

**Installer pop-ups are normal:** during Step 1, when you run `winget install ...` commands, Windows will show pop-up windows — a security prompt asking *"Do you want to allow this app to make changes?"*, and sometimes an installer wizard for the tool itself (Git is the most common). **Click Yes / Accept / Next to allow the install.** This is expected — winget is downloading and running the official installer for each tool. Just accept the defaults and let it finish before running the next command.

---

## Step 1: Install command-line tools

CLI stands for **Command Line Interface** — meaning your interaction with Copilot happens entirely in a window where you type instructions and read responses, instead of clicking buttons in a UI. The "command line" is that typing-and-reading window itself.

To make Copilot CLI work, you need 5 small tools on your machine: Node.js, Git, GitHub CLI, Azure CLI, and Copilot CLI itself. None of them have buttons or windows of their own — they sit underneath, ready to be called from your command line.

There are two ways to install them. Both end at the same place. Auth (Steps 2–5) is manual either way.

| Path | Time | Best for |
|------|------|----------|
| **Express** — one script installs all 5 | 2–3 min | You want to skip the boring clicking |
| **Manual** — 5 separate winget commands | 10–15 min | You want to learn what's on your machine, or your IT blocks scripts |

### 1a. Open PowerShell 7

Both paths use **PowerShell 7** (also called `pwsh`), not the older "Windows PowerShell" that ships with Windows by default. PowerShell 7 is the modern version and what every command in this guide expects.

1. Press the Windows key, type `PowerShell`
2. Click the result that says **PowerShell 7** or **pwsh**
3. If you only see "Windows PowerShell" in the results, run this once in that window, then close it and look again:

   ```
   winget install Microsoft.PowerShell
   ```

You should now have a window with a prompt that ends in `>`. Leave it open — you'll use it for the rest of setup.

### 1b. Get the workshop files

The Express script and the `verify.ps1` check live in this repo. You need a local copy.

Run these **one at a time** (paste, press Enter, wait, then paste the next):

```
winget install Git.Git
```

```
git clone https://github.com/JW-Sthlm/cli-intro.git $HOME\cli-intro
```

```
cd $HOME\cli-intro
```

What each line does:

- **`winget install Git.Git`** installs Git itself. (If you already have it, winget will say so and skip — safe to run anyway.)
- **`git clone …`** copies the workshop folder from GitHub onto your machine. It lands at `C:\Users\YourName\cli-intro` (because `$HOME` is PowerShell shorthand for your user folder, `C:\Users\YourName`).
- **`cd $HOME\cli-intro`** moves you *into* that folder. `cd` stands for "change directory". After this, every command you run will look in that folder first.

You can tell it worked because your prompt will change. Before the `cd`, it looks something like:

```
PS C:\Users\YourName>
```

After the `cd`, it should look like:

```
PS C:\Users\YourName\cli-intro>
```

The path inside `PS …>` always tells you which folder you're "inside" right now.

### 1c. Install the rest of the tools

Pick **Option A** or **Option B**.

#### Option A: Express path (recommended)

Open `v2\pre-work\express-setup.ps1` in any text editor first if you want to see what it does — it's about 10 lines, all winget commands, no surprises.

From inside the `cli-intro` folder (your prompt should still read `PS C:\Users\YourName\cli-intro>`), run:

```
.\v2\pre-work\express-setup.ps1
```

The leading `.\` means "in this current folder" — it tells PowerShell to look for the script right where you are, not somewhere else on the system.

When the script finishes, **close that PowerShell window**, **open a new PowerShell 7 window** the same way you did in step 1a, then `cd` back into the workshop folder before continuing to Step 2:

```
cd $HOME\cli-intro
```

(The fresh window is needed because some installs only become available to *new* PowerShell sessions, not the one that did the installing.)

> **⚠️ Common trap** — If your corporate IT or Defender policy blocks the script, use Option B instead.

#### Option B: Manual path

Run these one at a time. Wait for each to finish before starting the next.

```
winget install OpenJS.NodeJS.LTS
```

```
winget install GitHub.cli
```

```
winget install Microsoft.AzureCLI
```

```
winget install GitHub.Copilot
```

(Git was already installed in step 1b, so it's not in this list.)

When all four are done, **close that PowerShell window and open a new PowerShell 7 window**, then go back into the workshop folder:

```
cd $HOME\cli-intro
```

Then verify Copilot CLI is reachable:

```
copilot --version
```

You should see a version number. If you get an error, close PowerShell, open a new window, and try again.

---

## Step 2: Log In

**In PowerShell** — start Copilot CLI by typing `copilot` and pressing Enter:

```
copilot
```

When the Copilot banner appears, the prompt changes — you're now **inside Copilot CLI**.

**Inside Copilot CLI** — type `/login` and press Enter:

```
/login
```

Follow the on-screen instructions — it will open a browser window where you authenticate with your **personal** GitHub account (recommended for this session).

> **Note:** You need an active Copilot subscription on the account you log in with. Verify at https://copilot.github.microsoft.com/ or https://github.com/settings/copilot.

When login finishes, you're still **inside Copilot CLI**. To run the next step you need to be back in PowerShell — same window, just step out of Copilot:

**Inside Copilot CLI** — type `/exit` and press Enter:

```
/exit
```

The Copilot banner disappears and you're back at the PowerShell prompt (`PS C:\Users\YourName\cli-intro>`). Same window — you do **not** open a new one.

---

## Step 3: Verify It Works

**In PowerShell** — from the `cli-intro` folder, run the automatic pre-check:

```
.\v2\pre-work\verify.ps1
```

(If your prompt isn't `PS C:\Users\YourName\cli-intro>`, run `cd $HOME\cli-intro` first.)

The script will tell you what's installed, what's logged in, and what's still missing.

Then launch Copilot CLI again and ask one simple question to confirm the model is answering:

```
copilot
```

**Inside Copilot CLI** — type a question and press Enter:

```
What day is it today?
```

If you get an answer, you're in business. Type `/exit` and press Enter to return to PowerShell.

---

## Step 4: Log In to Azure (for PMX)

The PMX MCP server needs an Azure login to talk to Dynamics 365. Azure CLI was already installed in Step 1, so this is just the sign-in.

**In PowerShell** — run:

```
az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47
```

A browser window will open. Sign in with your Microsoft account. Once it says "You have logged in", you're done.

> **⚠️ Common trap** — If `az login` shows a list of subscriptions and asks you to choose one, just press Enter.
> It doesn't matter which one for this workshop — we only need a valid Azure session, not a specific subscription.

---

## Step 5: Connect Your Tools (MCP Servers)

MCP servers are connectors that let Copilot CLI talk to external tools — think of them like Power Automate connectors. We need three:

1. **PMX** — your partner management data in D365
2. **GitHub** — repos, issues, pull requests
3. **M365** — email, calendar, Teams

The easiest way is to ask Copilot CLI itself to do the configuration.

1. **In PowerShell**, type `copilot` and press Enter.

   ```
   copilot
   ```

   You'll see the Copilot CLI banner appear. The prompt will change — instead of `PS C:\Users\YourName\cli-intro>` you'll see something like a `❯` or `>` arrow on its own line. That means you're now **inside Copilot CLI**, not PowerShell.

2. **Inside Copilot CLI**, type this prompt and press Enter:

   ```
   I need to set up MCP servers for PMX, GitHub, and M365. Help me configure them.
   ```

3. Copilot will walk you through it step by step. Answer in plain language — no syntax memorization needed.

4. When you're done with the MCP setup, **type `/exit` and press Enter** to leave Copilot CLI and return to PowerShell.

> **⚠️ Common trap** — When CLI asks "Where should I configure these MCP servers?"
> Pick **`<TODO: confirm exact menu label — likely "VS Code (user)" or the global/user-scope option>`**.
> This makes the servers available in any folder on your machine.
> **Do NOT pick "Copilot Cloud Agent"** — that's for cloud-hosted agents, not your local CLI.
>
> _This answer is being validated — see plan todo `p10-validate-mcp-prompt`._

### PMX install: switch accounts, then switch back

PMX is the one special case. Its MCP server is stored in `gim-home/pmx-mcp`, which requires your Microsoft EMU account. So you need to switch accounts before the install, do the install, then switch back.

You'll be jumping **between PowerShell and Copilot CLI in the same window**. Watch the prompt to know which mode you're in:

- `PS C:\Users\YourName\cli-intro>` → you're in PowerShell.
- A banner with a `❯` or `>` arrow → you're inside Copilot CLI.

If you're inside Copilot CLI when a step says "in PowerShell", type `/exit` and press Enter first.

1. **In PowerShell** — switch to your EMU account:

   ```
   gh auth switch --user <yourname>_microsoft
   ```

2. **In PowerShell** — launch Copilot CLI:

   ```
   copilot
   ```

3. **Inside Copilot CLI** — ask it to install the PMX MCP server:

   ```
   Install the PMX MCP server from gim-home/pmx-mcp and configure it for this machine.
   ```

4. **Inside Copilot CLI** — when PMX is installed, leave Copilot CLI:

   ```
   /exit
   ```

5. **Back in PowerShell** — switch back to your personal account:

   ```
   gh auth switch --user <your-personal-username>
   ```

6. **In PowerShell** — verify your personal account is active again:

   ```
   gh auth status
   ```

For GitHub and M365 MCP setup, keep using your personal account unless Copilot tells you otherwise.

You can also use the built-in command `/mcp` (inside Copilot CLI) to browse and add servers from a menu.

> **Having trouble?** MCP setup depends on your environment and permissions. If it doesn't work, don't worry — we'll troubleshoot together at the start of the session. Just make sure Steps 1–4 are done.

---

## Step 6: Verify MCP Servers

**In PowerShell** — launch Copilot CLI:

```
copilot
```

**Inside Copilot CLI** — type `/env` and press Enter to see the runtime environment and connected MCP servers:

```
/env
```

Look for the MCP servers section. You should see entries for PMX, GitHub, and M365 tools. If any are missing, double-check your config file path and contents.

**Inside Copilot CLI** — try a quick PMX smoke test:

```
Show me my PMX projects
```

If you see project data from D365, everything is connected. Type `/exit` and press Enter to return to PowerShell.

---

## Troubleshooting

If you'd rather run a one-shot check, use `verify.ps1` (added in `pre-work/`) — it'll tell you exactly what's missing and how to fix it.

| Problem | Fix |
|---------|-----|
| `winget` not found | Install it from the Microsoft Store (search "App Installer") |
| `copilot` command not found after install | Close and reopen PowerShell. If still missing, check your PATH |
| `/login` fails or times out | Make sure you're on the corporate network or VPN |
| Asked for a Personal Access Token | Stop. Don't create one. Switch accounts with `gh auth switch --user <other-account>` and try again |
| `az login` fails | Run `winget install Microsoft.AzureCLI` first, restart PowerShell |
| Stuck on the Azure subscription picker | Press Enter. The subscription choice does not matter for this workshop |
| PMX returns errors | Re-run `az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47` |
| MCP prompt unclear which to pick | See Step 5 placeholder. Default to the user/global option, do not choose Copilot Cloud Agent, and verify with Taras |
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
