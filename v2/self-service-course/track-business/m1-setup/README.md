# Module 1: Setup, the lazy way

> ⏱️ **Estimated time:** 15 min (Express path), 30 min (Manual path)
> 🎯 **You'll be able to:** open `copilot` in a terminal, talk to it, and have it answer.

---

## You don't need to read this whole module

📖 The lazy path is:

1. Go to [`v2/pre-work/setup-guide.md`](../../../pre-work/setup-guide.md).
2. Pick **Option A: Express** in Step 1.
3. Run [`pre-work/verify.ps1`](../../../pre-work/verify.ps1) at the end.

If verify reports all 8 checks pass, you're done. Skip to **Module 2**.

If something fails, read on.

---

<details>
<summary><strong>📖 "I've never opened PowerShell before"</strong>: the absolute basics, click to expand</summary>

That's fine. PowerShell is just a text window where you type commands and press Enter. Like a more powerful Notepad that talks back.

**To open it:**

1. Press the **Windows key** on your keyboard.
2. Type `powershell`.
3. You'll see "Windows PowerShell" or "PowerShell 7" in the search results. Click it.
4. A black or dark blue window opens. The first line looks something like:
   ```
   PS C:\Users\YourName>
   ```
   That's the **prompt**. It's saying "I'm ready, type something."
5. Type a command (any command, try `dir` and press Enter). Things will scroll past. That's the output.

**To close it:** type `exit` and press Enter. Or just close the window.

**You can't break your computer this way.** PowerShell asks for permission before doing anything dangerous. The commands in this course (`winget install`, `gh auth login`, `copilot`) are all safe and reversible.

**Tip:** keep PowerShell open in a separate window while you read this module. You'll switch back and forth.

</details>

<details>
<summary><strong>📖 "What's a terminal? What's a shell?"</strong>: words that all mean roughly the same thing</summary>

You'll hear these used interchangeably. They're not exactly the same, but for our purposes:

- **Terminal:** the window itself (the dark rectangle on your screen).
- **Shell:** the program inside the window that reads what you type and runs it. PowerShell is the shell on Windows.
- **Command line / CLI:** generic name for "this whole thing."
- **Prompt:** the cursor blinking next to `PS C:\Users\YourName>` waiting for input.

In this course we'll mostly say "PowerShell" or "the terminal." They mean the same thing here.

</details>

---

## What "setup" actually means

You need 5 tools and 2 logins.

<details>
<summary><strong>📖 What is each tool, and why do I need it?</strong>, click to expand</summary>

**Tools (handled by Express path or installed manually):**

1. **Node.js:** runtime. The Copilot CLI is written in JavaScript and needs Node.js to run. Like how a Word document needs Word installed to open.
2. **Git:** version control. Lets you copy code repositories to your machine. You probably have this already.
3. **GitHub CLI** (`gh`): for talking to GitHub from the terminal (logging in, cloning repos, opening PRs).
4. **Azure CLI** (`az`): for Azure logins. Some MCP servers (PMX) need an Azure login behind the scenes.
5. **GitHub Copilot CLI** (`copilot`): the actual thing this course is about.

**Logins (you do these manually after install):**

1. **GitHub:** sign in twice, with two accounts. Yes, two. (See "the two-GitHub-accounts dance" below.)
2. **Azure:** `az login --tenant <microsoft-tenant>`.

</details>

If you just want the names: Node.js, Git, GitHub CLI, Azure CLI, Copilot CLI. Five tools.

---

## ⚠️ The two-GitHub-accounts dance

This trips up everyone the first time. Read this once, then refer back as needed.

**You need two GitHub identities to make this work in Microsoft:**

- **Your personal GitHub username** (e.g., `jane-smith`). For general work, public repos, this course.
- **Your `*_microsoft` EMU account** (e.g., `jsmith_microsoft`). Microsoft Enterprise Managed User. Required for Microsoft-internal repos like PMX MCP. IT provisioned this when you joined.

**You must be logged into both** through `gh auth login`. The setup guide walks you through it.

⚠️ **The single most common workshop friction:** people install everything but only sign in to one GitHub account. Then PMX MCP fails to install because it needs the EMU account. Then they spend 30 min debugging.

If verify.ps1 says "Microsoft GitHub account not logged in", you're in this trap. Fix: re-run `gh auth login` and pick the EMU account.

<details>
<summary><strong>📖 "I don't know what my EMU account is"</strong>: how to find it</summary>

Easiest way: go to [github.com](https://github.com) in a browser, click your profile picture top right.

If you see a username ending in `_microsoft` (like `jwallquist_microsoft`), that's your EMU account. Note it down. You'll need it.

If you don't see one, you might not be enrolled yet. Open a Teams chat with your manager or your IT sponsor and ask "do I have a Microsoft GitHub EMU account?". They'll point you at the request form.

For most of this course (Track A, modules 0–4) you can survive with just your personal account. The EMU is only needed when you install PMX MCP in M4.

</details>

---

## The Express path (recommended)

📖 If you don't write code professionally, this is for you.

The setup guide includes a 25-line PowerShell script ([`express-setup.ps1`](../../../pre-work/express-setup.ps1)) that runs `winget install` 5 times. That's the whole script. You can read it in 30 seconds. It does *not* sign you into anything (logins stay manual, that's intentional).

**Why use it:** you don't have to remember 5 separate winget commands.
**Why we kept it transparent:** non-coders are correctly trained "don't run random PowerShell from the internet." This script lives in our repo, is short, is readable. Open it before running.

### Step by step

1. **Clone or download cli-intro.** If you already have it, skip. Otherwise, in PowerShell:
   ```powershell
   git clone https://github.com/JW-Sthlm/cli-intro.git $HOME\cli-intro
   ```
   (Replace the URL with whichever cli-intro repo you've been pointed at.)

2. **Move into the folder.** In PowerShell:
   ```powershell
   cd $HOME\cli-intro
   ```
   The prompt should now show `PS C:\Users\YourName\cli-intro>`. That's how you know you're in the right place.

3. **Run the express script.** In PowerShell:
   ```powershell
   .\v2\pre-work\express-setup.ps1
   ```
   Watch the output. Each `winget install` prints a few lines, asks for permission, and either says "Successfully installed" or "Already installed". Either is fine.

4. **Close PowerShell, open a fresh PowerShell window.** This is critical. The new tools won't be on your PATH until you reopen. (Skip this and you'll get "command not found" errors. Trust us.)

5. **Continue with the manual login steps below.**

<details>
<summary><strong>📖 "Is winget safe? Is it Microsoft-approved?"</strong>: short answer: yes</summary>

**Winget is the official Windows Package Manager from Microsoft.** It ships with Windows 11 by default. Microsoft signs and maintains it.

**Where do the packages come from?** By default, winget pulls from two sources:

- **`msstore`:** Microsoft Store. Microsoft-vetted apps.
- **`winget`** (community repository): vendor-submitted packages that pass automated validation. Most major tools (Node.js, Git, GitHub CLI, Azure CLI) live here, published by the vendors themselves.

**Are the 5 tools we install safe?** Yes. Each one is published by its official vendor:

| Tool | Publisher | Source |
|------|-----------|--------|
| Node.js | OpenJS Foundation | winget |
| Git | The Git project | winget |
| GitHub CLI | GitHub | winget |
| Azure CLI | Microsoft | winget |
| GitHub Copilot CLI | GitHub | winget |

**Want to verify a package before installing?** Run `winget show <id>`. It shows the publisher, version, source, and homepage URL. Example:
```powershell
winget show OpenJS.NodeJS.LTS
```

**What if my IT has restricted winget?** Some corporate Windows configs limit winget to `msstore` only or block it entirely. If `winget install` fails with a policy error, contact IT or use the Manual path below (which uses the same official installers, just downloaded by hand from the vendor sites).

**Bottom line:** winget is the safest way to install dev tools on Windows today. Safer than downloading installers from random websites. The CLI workshop assumes winget works in your environment because it does in 95%+ of corporate Windows installs.

</details>

<details>
<summary><strong>⚠️ "PowerShell says script execution is disabled"</strong>: fix for IT-managed laptops</summary>

If you see something like "running scripts is disabled on this system", run this once:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Then try the express script again. This is a per-user setting, not a security risk. It just lets you run scripts you authored or downloaded explicitly. IT-managed Windows often defaults to "Restricted" which blocks even safe scripts.

If your IT has set the policy at machine scope and locked it, ask in the Teams thread or use the Manual path below.

</details>

---

<details>
<summary><strong>🔧 The Manual path</strong>: for people who want to run each install themselves</summary>

If you prefer to know exactly what each step does, or your IT blocks running PowerShell scripts, follow [Step 1 Option B in the hosted setup guide](https://cli-intro-share.pages.dev/setup.html#step-1). Each install is one `winget install` line. ~10 minutes.

```powershell
winget install --id OpenJS.NodeJS.LTS
winget install --id Git.Git
winget install --id GitHub.cli
winget install --id Microsoft.AzureCLI
winget install --id GitHub.CopilotCLI
```

Run them one at a time. Reopen PowerShell when done. Result is identical to Express.

</details>

---

## Authentication walkthrough

After install, in this order:

1. **Open a fresh PowerShell.** (You did this after the express script, right?)
2. Type `copilot` and press Enter. Authorize the folder when prompted ("trust this folder once").
3. **Inside copilot, type `/login`.** Follow the device-code flow:
   - Copilot shows you a code (8 characters, like `ABCD-1234`).
   - It opens a browser tab automatically. (Or copy the URL it shows you.)
   - Paste the code, sign in with your **personal** GitHub account, click Authorize.
   - Come back to PowerShell. Copilot will say "Welcome, [your name]."
4. **Exit copilot:** type `/exit` and press Enter.
5. **Run `gh auth login`** in PowerShell. Pick GitHub.com → HTTPS → Login with browser. Sign in with your **personal** GitHub account.
6. **Run `gh auth login` *again*.** Same flow, but this time sign in with your `*_microsoft` EMU account. (Yes, you're now logged into two accounts at once. This is supposed to happen.)
7. **Run `az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47`.** A browser opens, sign in with your Microsoft account.
8. **Run `.\v2\pre-work\verify.ps1`.** All 8 checks should pass.

<details>
<summary><strong>🔧 What is a "device-code flow"?</strong>: for the curious</summary>

When a CLI tool needs to authenticate without storing your password, it uses device-code flow:

1. The CLI generates a short code.
2. You open a browser, log in normally, and paste the code.
3. The browser tells GitHub "yes, this CLI is authorized for this account."
4. The CLI gets a token. From now on it uses the token, not your password.

This is the same pattern Netflix uses to log into your TV. Safe, standard, and means you never type your password into a terminal.

</details>

<!-- PMX MCP install is covered in M4. The marketplace path (`copilot plugin marketplace add gim-home/pmx-mcp`) means PMX no longer goes through the "Where do you want to install this MCP server?" menu prompt. The menu still appears for GitHub and M365 MCP installs done via Copilot CLI's prompt-based flow, answer is "Copilot CLI" (option 2 in current builds), validation pending. -->

---

<details>
<summary><strong>📖 "What if I just want to try it without installing anything?"</strong>: Codespaces shortcut</summary>

**GitHub Codespaces** is the answer.

1. Open any repo on github.com.
2. Code → Codespaces → Create codespace on main.
3. In the Codespace terminal, run `copilot`.

Caveats:

- You won't have your local files, Outlook, or PMX access in there. Good for trying the CLI; bad for real partner work.
- Counts against your monthly Codespaces allowance.

So: try it in Codespaces if you want a 5-min taste, but install locally for real use.

</details>

---

<details>
<summary><strong>⚠️ Troubleshooting cheat sheet</strong>: click if something broke</summary>

| Symptom | Likely cause | Fix |
|---------|-------------|-----|
| `copilot: command not found` | Not on PATH yet | Close and reopen PowerShell |
| `/login` says "couldn't open browser" | Corporate browser policy | Copy the URL from the error, paste it into your default browser manually |
| verify.ps1 says GitHub auth failed but you're logged in | Old verify script | Pull the latest cli-intro. Known bug, fixed in p12. |
| `winget install` denied | IT policy | Use Manual path or contact IT |
| "Running scripts is disabled" | PowerShell execution policy | See the foldable in the Express section above |
| Anything else | (varies) | [troubleshooting.md](../../../reference/troubleshooting.md) |

</details>

---

## ✅ You're ready for M2 if

- `copilot` opens without errors
- You can type "say hello" inside copilot and get a response
- `verify.ps1` reports all 8 checks pass

---

## 👉 Next: [Module 2: Your first conversations](../m2-first-conversations/README.md)

