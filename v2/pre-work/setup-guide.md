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

When the script finishes, **close that PowerShell window**, **open a new PowerShell 7 window** the same way you did in step 1a, then `cd` back into the workshop folder:

```
cd $HOME\cli-intro
```

Then verify Copilot CLI is reachable:

```
copilot --version
```

You should see a version number. If you get an error, close PowerShell, open a new window, and try again.

(The fresh window is needed because some installs only become available to *new* PowerShell sessions, not the one that did the installing.)

✅ **Done with Option A.** Continue to **Step 2: Log In** below.

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

✅ **Done with Option B.** Continue to **Step 2: Log In** below.

---

## Step 2: Log In

You'll log into two different things: **Copilot CLI** itself (so it can talk to the AI model), and **GitHub CLI** (so other tools and scripts in the workshop can talk to GitHub on your behalf).

### 2a. Sign in to Copilot CLI

**In PowerShell** — start Copilot CLI by typing `copilot` and pressing Enter:

```
copilot
```

The first time you launch Copilot CLI in this folder, it shows a **"Confirm folder trust"** prompt asking whether to allow it to read and execute code in `C:\Users\YourName\cli-intro`. Use the arrow keys to select option **2. Yes, and remember this folder for future sessions**, then press Enter. (Picking option 2 means you won't be asked again next time you launch Copilot CLI here.)

When the Copilot banner appears, the prompt changes — you're now **inside Copilot CLI**.

**Inside Copilot CLI** — type `/login` and press Enter:

```
/login
```

You'll see a prompt asking *"What account do you want to log into?"* with two options. Pick option **1. GitHub.com** and press Enter. (Option 2 is for enterprise customers with a custom GitHub data-residency setup — not what you want here.)

Follow the on-screen instructions — it will open a browser window where you authenticate with your **personal** GitHub account (recommended for this session).

You'll go through three browser screens. Here's what to do at each:

**1. Sign in to GitHub** — enter your personal GitHub username and password.

![GitHub sign-in screen](../images/pre-work/login-01-github-signin.png)

**2. Two-factor authentication** — confirm using whatever method you have set up (passkey, GitHub Mobile, or authenticator app).

![GitHub 2FA screen](../images/pre-work/login-02-2fa-passkey.png)

**3. Single sign-on to your organization** — if your personal GitHub account is also a member of an organization that requires SSO (most Microsoft employees will see **Microsoft** here), click the green **Authorize** button next to the organization, then click **Continue**.

![Single sign-on authorize Microsoft](../images/pre-work/login-03-microsoft-sso.png)

> **Why authorize?** Authorizing extends your GitHub session so Copilot CLI can read repos and resources inside that org. It's safe and expected — without it, you'll hit "resource not accessible by integration" errors later when working with org-internal repos. If you don't recognize the org name, click **Continue** without authorizing.

> **Note:** You need an active Copilot subscription on the account you log in with. Verify at https://copilot.github.microsoft.com/ or https://github.com/settings/copilot.

When login finishes, you're still **inside Copilot CLI**. To run the next step you need to be back in PowerShell — same window, just step out of Copilot:

**Inside Copilot CLI** — type `/exit` and press Enter:

```
/exit
```

The Copilot banner disappears and you're back at the PowerShell prompt (`PS C:\Users\YourName\cli-intro>`). Same window — you do **not** open a new one.

### 2b. Sign in to GitHub CLI (`gh`)

The `/login` step above signed you into **Copilot CLI**. There's a separate tool — **GitHub CLI** (`gh`) — that some later steps use to talk to GitHub on your behalf (the verify script in Step 3, and the PMX MCP install in Step 5). It has its own login. Sign in here with your **personal** account; you'll add your EMU account later in Step 5b when PMX needs it.

**In PowerShell** — run:

```
gh auth login
```

It will ask you several questions one at a time. Use the arrow keys to pick the answer, then press Enter:

- *What account do you want to log into?* → **GitHub.com**
- *What is your preferred protocol for Git operations?* → **HTTPS**
- *Authenticate Git with your GitHub credentials?* → **Yes**
- *How would you like to authenticate GitHub CLI?* → **Login with a web browser**

It shows a one-time code and opens a browser tab. Paste the code in the browser, sign in with your **personal** GitHub account, and authorize. When the browser says "Congratulations, you're all set!", come back to PowerShell — it should now print `✓ Logged in as <your-personal-username>`.

> **Stuck on "We couldn't sign you in" with a passkey error?** This is common when your phone is the registered passkey holder. Click **Sign in another way** in the dialog and pick **Microsoft Authenticator** (push to phone) or text/call.

> **No `_microsoft` EMU account?** Skip Step 5b too — only PMX needs the EMU, and we can demo PMX together at the session.

Confirm:

```
gh auth status
```

Your personal account should be listed with `Active account: true`.

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

## Step 5: Connect Your Tools (MCP Servers and Plugins)

MCP servers and plugins are connectors that let Copilot CLI talk to external systems — like Power Automate connectors, but for CLI. We'll connect three:

1. **GitHub** — repos, issues, pull requests *(built into Copilot CLI — no install needed)*
2. **M365** — email, calendar, Teams *(installed as plugins in 5a)*
3. **PMX** — your partner management data in D365 *(installed as an MCP server in 5b, Microsoft-internal)*

We do this in two passes because **PMX requires your Microsoft EMU account** to be the active GitHub account, while M365 works fine with your personal one. Set up M365 first, then switch accounts and install PMX.

### 5a. Set up M365 (personal account)

Make sure your personal account is the active GitHub account:

**In PowerShell** — run:

```
gh auth status
```

Your personal account should show `Active account: true`. If not, run `gh auth switch --user <your-personal-username>` first.

Then launch Copilot CLI:

```
copilot
```

You'll see the Copilot CLI banner appear. The prompt will change — instead of `PS C:\Users\YourName\cli-intro>` you'll see something like a `❯` or `>` arrow on its own line. That means you're now **inside Copilot CLI**, not PowerShell.

**Inside Copilot CLI** — type this prompt and press Enter:

```
Set up M365 capabilities (Outlook, Teams, Calendar, SharePoint) in my Copilot CLI. If anything is already installed, just confirm it. Then run a quick test — fetch my next calendar meeting and one of my recent GitHub repos.
```

Copilot will install whatever's missing, then run the tests. The GitHub test confirms the built-in GitHub MCP server is working too.

> **⚠️ Common trap** — If Copilot asks **"Where do you want to configure these MCP servers?"** and shows a numbered menu, pick **2. Copilot CLI**. The other options configure MCP for VS Code's Copilot Chat, GitHub Copilot Coding Agent, or other tools — not your local CLI session.

✅ **Pass:** Copilot returns your next meeting and a GitHub repo. Both M365 and GitHub are alive.

When done, **type `/exit` and press Enter** to leave Copilot CLI and return to PowerShell.

### 5b. Install PMX (Microsoft EMU account)

PMX is the special case. Its server lives in `gim-home/pmx-mcp`, which only your Microsoft EMU (`yourname_microsoft`) account can access. The flow: log into `gh` as your EMU as well (you already logged in as personal in Step 2b), then let Copilot CLI orchestrate the install for you.

#### First: log in to gh as your EMU

In Step 2b you ran `gh auth login` as your **personal** account. Run it again — same four answers — but this time sign in as your `_microsoft` EMU when the browser opens.

**In PowerShell** — run:

```
gh auth login
```

Same answers as before:

- *What account do you want to log into?* → **GitHub.com**
- *What is your preferred protocol for Git operations?* → **HTTPS**
- *Authenticate Git with your GitHub credentials?* → **Yes**
- *How would you like to authenticate GitHub CLI?* → **Login with a web browser**

When the browser opens, sign in with your `_microsoft` EMU account (Microsoft sign-in, not your personal GitHub).

Then verify both accounts are now known to `gh`:

```
gh auth status
```

You should see **two** entries — your personal account and your `_microsoft` EMU. Both must be present before continuing. (Either one can be active right now; the prompt below will set it.)

> **⚠️ Both accounts must be logged in before the next step.** The Copilot prompt switches between them — it does not create them. If `gh auth status` only shows one account, run `gh auth login` for the missing one first.

#### Then: let Copilot install PMX

**In PowerShell** — launch Copilot CLI:

```
copilot
```

**Inside Copilot CLI** — paste this prompt and press Enter:

```
Install the PMX MCP server for me. I have two GitHub accounts known to `gh` — my personal one and my Microsoft EMU (username ends in `_microsoft`).

1. Run `gh auth status` to confirm both accounts are present and note their usernames.
2. Switch the active gh account to the `_microsoft` EMU.
3. Run `copilot plugin marketplace add gim-home/pmx-mcp`.
4. Run `copilot plugin install pmx-mcp@pmx-mcp`.
5. Switch the active gh account back to my personal one.
6. Run `gh auth status` again to confirm my personal account is now active.

If any step fails, stop and tell me what went wrong — don't continue. When everything succeeds, tell me to type /exit and run copilot again so the new MCP server registers.
```

Copilot will run each shell command in order, switching the active `gh` account as it goes. When it finishes, it will tell you to relaunch.

**Inside Copilot CLI** — type `/exit`:

```
/exit
```

**In PowerShell** — start Copilot CLI again so the new MCP server registers:

```
copilot
```

Skip to Step 6 to verify everything is connected.

#### Manual fallback — if the Copilot prompt fails

If Copilot can't run shell commands or the prompt misfires, do it yourself. Run them **one at a time**.

**1. Find your EMU username.** Run:

```
gh auth status
```

Look at both account lines. Your EMU username is the one ending in `_microsoft` (e.g. `jeghammer_microsoft`). Copy that exact name — you'll need it next.

**2. Switch the active account to your EMU.** Replace `YOUR_EMU_USERNAME` with the name you copied above:

```
gh auth switch --user YOUR_EMU_USERNAME
```

**3. Confirm the switch worked.** Run `gh auth status` again and check that the line marked *"Active account: true"* is on your `_microsoft` entry. If it's still on your personal account, step 2 didn't take — re-run it.

```
gh auth status
```

**4. Install PMX.** With the EMU active, run these in order:

```
copilot plugin marketplace add gim-home/pmx-mcp
```

```
copilot plugin install pmx-mcp@pmx-mcp
```

**5. Switch back to your personal account.** Replace `YOUR_PERSONAL_USERNAME` with your personal GitHub username:

```
gh auth switch --user YOUR_PERSONAL_USERNAME
```

> **⚠️ Got `403 Write access to repository not granted`?** Your personal account is still active. The `marketplace add` command is using personal creds against a Microsoft-internal repo. Re-run step 2 (the `gh auth switch`), verify with `gh auth status` that the EMU is active, then re-run the marketplace command.

Same end state as the prompt path. The EMU must be the active account when `marketplace add` runs — that command fetches the manifest using your active `gh` credentials. Personal account → 403 or 404, no auto-recovery.

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

You should see **PMX listed under MCP servers**, and **Outlook / Teams / Calendar / SharePoint listed under plugins**. (The GitHub MCP server is built into Copilot CLI, so it doesn't appear in either list.) If anything is missing, double-check your config file path and contents.

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
| MCP prompt asks "Where do you want to configure these MCP servers?" | Pick **2. Copilot CLI**. Other options target VS Code Chat, GitHub Coding Agent, or other tools — not your local CLI |
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
