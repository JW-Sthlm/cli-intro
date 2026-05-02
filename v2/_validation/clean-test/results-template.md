# Clean-test results

**Date:** YYYY-MM-DD
**Tester:** _________
**Test machine:** Dev Box / Sandbox / other: _________
**OS build:** _________
**Architecture:** x64 / ARM64
**cli-intro commit:** _________

---

## Walk log — live (2026-05-02, Johan on Dev Box)

Live findings during the show-and-tell walkthrough. Each entry: what was unclear/broken → what was changed.

### Step 1c Express path — script wasn't on GitHub

- **Express path didn't end with a `copilot --version` check.** Option B (Manual) does verify Copilot CLI is reachable, but Option A skipped straight to Step 2. Same risk applies to both — fresh PowerShell window not picking up PATH, install silently failing, etc. → Added the same `copilot --version` verification block to Option A right after the `cd $HOME\cli-intro`. Both paths now end identically.

- **Neither path told the reader where to go next.** After running install commands, options A and B just trailed off — no "go to Step 2" pointer. Easy to lose your place in a long guide. → Added a `✅ Done with Option A/B. Continue to Step 2: Log In below.` line at the end of each path. Same pattern.

- **Running `.\v2\pre-work\express-setup.ps1` on the Dev Box failed: "the term '.\v2\pre-work\express-setup.ps1' is not recognized as a name of a cmdlet, function, script file, or executable program."**Root cause: `express-setup.ps1` and `verify.ps1` were created locally on the laptop but **never committed and pushed** to `JW-Sthlm/cli-intro`. So when the Dev Box ran `git clone`, the scripts didn't come with it. → Committed both scripts plus the setup-guide.md live-walk fixes and pushed to `main` (commit `30b565f`). Future clones get the files. On the Dev Box: `git pull` brings them in.

- **Lesson for the guide itself:** the troubleshooting table needs a row for *"the term '.\\v2\\pre-work\\...' is not recognized"* → "Run `git pull` to make sure your local copy is up to date — these scripts may have been added after you originally cloned." Worth adding once the dust settles.

### Setup guide structural

- **`📖 Business roles` labels everywhere felt wrong.** This guide is already only for the workshop audience — calling out a single role inside it just adds noise. → Removed all `📖 Business roles` and `🔧 Technical deep dive` prefix labels (16 + 1 instances). Sentences read as plain instructions now.

- **No warning that winget installs trigger Windows pop-ups.** During `winget install ...` Windows shows a UAC "Do you want to allow this app to make changes?" prompt, and tools like Git also open their own installer wizard. Non-tech users would assume something went wrong and might cancel. → Added a callout at the end of the "How to use this guide" section: pop-ups are expected, click Yes / Accept / Next, accept the defaults, let it finish before running the next command.

### Step 1 — Install command-line tools

- **"Install command-line tools" jumps straight to "you need 5 tools" with no explanation of what command-line tools even are.** Non-tech readers don't know that "command line" is the **L** in CLI — i.e., the actual interface they're about to use. → Added an opening paragraph that connects "command line" to the L in CLI and explains the 5 tools sit underneath the surface.

- **Option A (Express) said "open PowerShell" without saying *which* PowerShell, and assumed the user is already inside the cli-intro folder.** No prior step clones the repo. Where does the folder come from? → Restructured Step 1 into three clear sub-steps:
  - **1a. Open PowerShell 7** (one-time, applies to both options, with explicit Win11 default fallback `winget install Microsoft.PowerShell`)
  - **1b. Get the workshop files** (winget Git.Git → `git clone https://github.com/JW-Sthlm/cli-intro.git $HOME\cli-intro` → `cd $HOME\cli-intro`, with what-each-line-does explanation and a "your prompt should now look like `PS C:\Users\YourName\cli-intro>`" cue)
  - **1c. Install the rest** — Option A or Option B (Express script vs 4 separate winget commands; Git is already in 1b so it dropped from Option B)

- **PowerShell 7 vs Windows PowerShell — was the same requirement for both options?** Express path didn't repeat the warning so it was unclear. → Yes, both paths require PS7. Now stated once in 1a; both options inherit it.

### Step 1 — second pass (post-restructure)

- **The Step 1 opener said "the L in CLI stands for Line" — wrong.** CLI = **Command Line Interface**. → Reframed the opener to lead with "Command Line Interface" and explain that the "command line" is the typing-and-reading window, not just one letter.

- **Multi-line commands paste-fail.** When non-coders paste `winget install Git.Git\ngit clone …\ncd …` as a single block, PowerShell sometimes only runs the first line and warns. → Added a top-of-guide "How to use this guide" section that explains: paste lines one at a time, watch for the prompt to come back, the `>` symbol is the prompt (don't copy it), every code block on GitHub has a Copy button. Also broke step 1b's three commands into three separate code blocks so each gets its own Copy button.

- **"From inside the cli-intro folder" was vague.** Users didn't know what their prompt should look like or what `.\` means. → Added explicit before/after prompt mock-ups:
    ```
    PS C:\Users\YourName>          ← before cd
    PS C:\Users\YourName\cli-intro> ← after cd
    ```
  And added a one-line explanation: `.\` means "in this current folder". Plus an explanation of `cd` ("change directory") and `$HOME` ("PowerShell shorthand for your user folder").

- **"Close PowerShell, open a new window" — open a new *PowerShell* window?** Yes, but the original wording was ambiguous. → Now reads "close that PowerShell window, open a new PowerShell 7 window the same way you did in step 1a", with a parenthetical reminder that fresh installs only register in *new* PowerShell sessions.

- **`cd $HOME\cli-intro` looked like noise to a non-coder.** → Wrapped in an instruction that explains what it does in context: "go back into the workshop folder".

- **Copy buttons.** Every fenced code block already gets an automatic Copy button when rendered on GitHub.com or in the published mkdocs site. The new "How to use this guide" intro explicitly tells users to look for it. (Native markdown doesn't have copy buttons; we're relying on the renderer.)

- **Screenshots / terminal mockups.** Added inline mockups for the 1b prompt-change moment. More mockups can be added at later checkpoints (after `winget install`, after `verify.ps1`, after Copilot banner appears) — flagged for a screenshot pass once the guide stabilises.

### Step 5 — MCP install

- **Copilot CLI installed the WRONG "PMX" — Proxmox virtualization MCP.** When asked to install PMX while signed in as personal account, the agent couldn't find `gim-home/pmx-mcp` (private), so it picked the closest public match: `Galvill/pmx-mcp`, a Proxmox MCP server (12 read-only Proxmox tools — totally unrelated). Cloned to `~/pmx-mcp`, registered as "pmx" in `~/.copilot/mcp.json` on a Streamable HTTP endpoint. Even falsely claimed `gim-home/pmx-mcp` "doesn't exist". → Added a critical callout at the top of Step 5b: switch the account FIRST, never trust the AI to disambiguate "PMX". Recovery for users who hit this: tell Copilot to delete `~/pmx-mcp` and remove the "pmx" entry from `~/.copilot/mcp.json`, then verify in PowerShell with `Test-Path` and `Get-Content`.

- **Git Credential Manager popup ambush during PMX clone.** After `gh auth switch` is missed and Copilot CLI auto-retries the clone, Windows pops up a separate "Connect to GitHub" GCM dialog because git is still using personal credentials. Adds a layer of confusion on top of the wrong-account problem. → Added `gh auth setup-git` to Step 5b — it tells `git` to use `gh`'s stored credentials directly so GCM doesn't prompt. Also added a `gh repo view gim-home/pmx-mcp` sanity check after the switch to confirm the EMU account can actually see the repo *before* Copilot tries the clone — fail fast with a clear error rather than 404 deep inside the agent.

- **PMX in the first batch failed because EMU account wasn't active yet.**With the original prompt asking Copilot to install all three (PMX + GitHub + M365) at once, Copilot tried to clone `gim-home/pmx-mcp` while the active gh account was personal — got "not found". → Restructured Step 5 into **5a. Install GitHub and M365 (personal account)** and **5b. Install PMX (Microsoft EMU account)**. Order changed: public MCPs first, then switch accounts and do PMX last. Step 5a's prompt no longer mentions PMX. Step 5b prompt is the existing "switch accounts" flow. Cleaner mental model: do what works with your default account, then do the one thing that needs the special account.

- **Copilot CLI doesn't know what "PMX" is.**When asked to set up "PMX, GitHub, M365" with the original generic prompt, Copilot CLI replied "Can you clarify what PMX refers to? Is it a specific MCP server or tool you have in mind?" → Updated the setup-guide prompt to include the repo URL (`github.com/gim-home/pmx-mcp`), the install method (clone, build, register), and explicit "use official public MCP servers" for GitHub and M365. Self-sufficient prompt → no clarification round-trip.

- **MCP target prompt validated.**When Copilot CLI asks "Where do you want to configure these MCP servers?" the right answer is option **2. Copilot CLI**. Other options shown: 1. VS Code (Copilot Chat), 3. GitHub Copilot Coding Agent (copilot-setup-steps.yml), 4. Other, 5. Other (type your answer). Replaced the TODO placeholder in setup-guide.md with the confirmed answer. Closed plan todo `p10-validate-mcp-prompt`.

### Step 2 → Step 3 — bridge between modes

- **EMU sign-in passkey failure on Dev Box.** During `gh auth login` for the Microsoft account, the browser hit "We couldn't sign you in. If you're using a passkey from your Android Work Profile, please use the camera app in that profile." The default Microsoft sign-in path tries to use a phone-registered passkey that the Dev Box browser can't reach. → Added a callout in 2b telling users to click **Sign in another way** and pick **Microsoft Authenticator** (push to phone) or text/call. Documents that no new passkey registration on the Dev Box is needed.

- **EMU sign-in fully blocked on Dev Box (no PIN/Authenticator option, only USB security key).** Some corp tenants enforce phishing-resistant MFA and only register a phone passkey. Dev Boxes have no Bluetooth → phone passkey can't be reached → "Use security key" is the only option, and the user has no USB key. Walk-time decision: this is environment-specific (Dev Box without Bluetooth) and not relevant to most workshop participants on their corporate laptops. **Do not put Dev Box troubleshooting in the participant setup guide.** Keep the general "Sign in another way → Authenticator" callout (useful for anyone), drop the Dev Box / mysignins / passkey-registration content. For Johan's own Dev Box: skip EMU, run with personal account only, do PMX install from laptop instead.

- **`gh auth login` was missing entirely from the guide.**`verify.ps1` checks `gh auth status` and expects two accounts (personal + Microsoft EMU). The `/login` flow in Step 2 only signs into **Copilot CLI** — `gh` is a separate credential store. So Johan ran verify.ps1, all five tool checks passed, and **GitHub auth** failed even though he'd just successfully completed the browser login. → Restructured Step 2 with two sub-steps: **2a. Sign in to Copilot CLI** (existing `/login` flow) and **2b. Sign in to GitHub CLI (`gh`)** (new — `gh auth login` twice, once per account, with the four prompt answers spelled out, fallback note for non-EMU users, and `gh auth switch` at the end to set personal as active default). Step 2 opener now explains both logins exist.

- **Browser-side `/login` flow had no walkthrough.**After typing `/login` the browser opens 3 screens (GitHub sign-in → 2FA → SSO authorize). Most participants will hit a "Single sign-on to your organization — Microsoft" screen and not know whether to click Authorize. → Captured the 3 actual screenshots from Johan's run, saved them to `v2/images/pre-work/login-01..03.png`, and embedded them inline in Step 2 with what-to-do guidance for each screen. Specifically called out: click **Authorize** next to Microsoft (or any org you recognize), then **Continue**. Explained why: without it, Copilot CLI hits "resource not accessible by integration" errors against org-internal repos.

- **`/login` account-type prompt wasn't documented.**Pops up "What account do you want to log into? 1. GitHub.com / 2. GitHub Enterprise Cloud with data residency". No guidance. → Added: pick option **1. GitHub.com**. Option 2 is for enterprise data-residency setups, not relevant here.

- **Folder trust prompt wasn't documented.**First launch of `copilot` shows a "Confirm folder trust" screen with three numbered options. Non-tech users hit it with no guidance and freeze. → Added to Step 2 right after `copilot`: arrow-key navigate to option **2. Yes, and remember this folder for future sessions**, press Enter, and explain that picking option 2 means they won't be asked again.

- **Step 2 ends inside Copilot CLI (after `/login`); Step 3 starts "In PowerShell" with no transition.**Non-tech users wouldn't know whether to open another PowerShell window or step out of Copilot first. → Added an explicit bridge at the end of Step 2: "When login finishes, you're still **inside Copilot CLI**. To run the next step you need to be back in PowerShell — same window, just step out of Copilot." Followed by `/exit`, then "Same window — you do **not** open a new one." Also gave Step 4's first command the consistent `**In PowerShell**` marker for parity with the rest.

### Step 2 — Log In

- **"Start Copilot CLI" was implicit about *where* and *how*.**→ Now reads "**In PowerShell** — start Copilot CLI by typing `copilot` and pressing Enter", with explicit "the prompt changes — you're now inside Copilot CLI" cue. Same pattern for `/login`: marked as "**Inside Copilot CLI** — type `/login` and press Enter".

### Step 3 — Verify

- **"If you cloned the repo" was a stale conditional.** Step 1b now always clones, so this conditional was confusing. → Rewrote to "**In PowerShell** — from the `cli-intro` folder, run the automatic pre-check" with a fallback `cd $HOME\cli-intro` if they're not in the right folder.

- **"Then ask one simple question" jumped straight to the question without launching Copilot CLI again.** → Added explicit `copilot` launch step, then "**Inside Copilot CLI** — type a question and press Enter".

### Step 4 — Azure login

- **"Don't have `az` installed?" line was dead code.** Step 1c installs Azure CLI in both Express and Manual paths. Telling users it might not be installed makes it sound expected/normal that they could have skipped it. → Removed that fallback line. Replaced opening with a one-liner reminder: "Azure CLI was already installed in Step 1, so this is just the sign-in." Marked the command as "In PowerShell".

### Step 5 — MCP setup

- **"Launch `copilot` and type this. Let CLI guide you." skipped the entry and exit ritual.** Non-tech users needed to know exactly when they enter and leave Copilot CLI. → Restructured as a 4-step numbered list with explicit `**In PowerShell**` / `**Inside Copilot CLI**` markers. Added the "prompt changes — you're now inside Copilot CLI" cue. Added explicit `/exit` step at the end.

- **PMX install switching — one PowerShell window or two?** It was ambiguous. → Confirmed: **one PowerShell window**, jumping between PowerShell mode and Copilot CLI mode. Added a callout above the numbered steps:
  > You'll be jumping between PowerShell and Copilot CLI in the same window. Watch the prompt to know which mode you're in:
  > - `PS C:\Users\YourName\cli-intro>` → PowerShell
  > - A banner with a `❯` or `>` arrow → inside Copilot CLI
  > If you're inside Copilot CLI when a step says "in PowerShell", type `/exit` and press Enter first.
  
  Then rewrote the 6 numbered steps with explicit mode markers on every single line: "In PowerShell — switch to EMU", "In PowerShell — launch Copilot CLI", "Inside Copilot CLI — install PMX", "Inside Copilot CLI — `/exit`", "Back in PowerShell — switch back", "In PowerShell — verify".

### Step 6 — Verify MCP

- **Same issue as Step 5: implicit context switches.** → Added "**In PowerShell** — launch Copilot CLI" and "**Inside Copilot CLI** — type `/env`" markers. Added explicit `/exit` at end.

### Open question still on the table

- **Real screenshots vs. ASCII mockups.** Currently only have one mockup (the prompt change in step 1b). Should we do a screenshot pass once the guide stabilises? Most-valuable shots: PowerShell 7 in Start menu (1a), prompt after `cd` (1b), Copilot banner appearing (Step 2), `/env` output showing MCP servers (Step 6).

---

## Walk 1 — setup-guide.md, Express path

### Before You Start (account dance section)

- [ ] Wording was clear about EMU vs personal accounts
- [ ] The "switch to EMU → install PMX → switch back" pattern made sense
- [ ] I knew where to find my EMU username

Confusion / friction:

> _none_

### Step 1 — Install command-line tools (Express)

- [ ] Found `express-setup.ps1`
- [ ] Read it before running, understood what it would do
- [ ] Script ran without errors
- [ ] All 5 tools installed
- [ ] After reopening PowerShell, all 5 commands work (`node --version`, `git --version`, etc.)

Friction / errors:

> _none_

### Step 2 — Log In

- [ ] `copilot` launched
- [ ] `/login` device-code flow worked
- [ ] Browser sign-in completed
- [ ] No surprising prompts (terms, telemetry, model picker)

Friction:

> _none_

### Step 3 — Verify

- [ ] `verify.ps1` ran from the repo
- [ ] Test prompt got an answer
- [ ] Verify script reported correctly

> _verify.ps1 known bug (p12): may report GitHub auth not found even when logged in. Note actual output here._

### Step 4 — Azure login

- [ ] `az login --tenant ...` worked
- [ ] Subscription picker appeared
- [ ] Pressing Enter without choosing worked
- [ ] `az account show` returns valid session

Friction:

> _none_

### Step 5 — MCP setup ⚠️

- [ ] Talked-to-it install was triggered
- [ ] The install-location prompt appeared

**Exact menu options offered (copy-paste):**

```
<paste menu here>
```

**Option I picked first time:** _________
**Did it work end-to-end?** yes / no
**What did the failure mode look like (if any)?**

> _none_

### Step 6 — Verify MCP servers

- [ ] `/env` or `/mcp` shows installed servers
- [ ] PMX, GitHub, M365 all visible (or noted which were skipped)
- [ ] PMX smoke test (`Show me my PMX projects`) returned data

Friction:

> _none_

### Walk 1 overall verdict

Would a non-coder PSA make it through this guide unaided? **yes / no — with caveats: _________**

Top 3 friction points to fix in setup-guide.md:

1. _________
2. _________
3. _________

---

## Walk 2 — setup-guide.md, Manual path (optional)

Did Manual path produce the same end state as Express? **yes / no**

Notable differences vs Express:

> _none_

Friction unique to Manual path:

> _none_

---

## Walk 3 — MCP install location matrix

### GitHub MCP

| Option | Install completed | Visible in /mcp | Tool call works | Notes |
|--------|------------------|-----------------|-----------------|-------|
| VS Code (user)        | | | | |
| VS Code (workspace)   | | | | |
| Copilot Cloud Agent   | | | | |
| Other / global / user | | | | |

**Winner option (use this in setup-guide.md Step 5):** _________

**Why the others failed:**

> _none_

### PMX MCP variant

- [ ] `gh auth switch` to EMU worked
- [ ] PMX install completed using the winning option
- [ ] `/mcp` shows PMX
- [ ] `Show me my PMX projects` returns data
- [ ] `gh auth switch` back to personal worked

PMX-specific issues:

> _none_

---

## Walk 4 — copilot-overview-plugin

- [ ] Clone worked from public URL
- [ ] INSTALL.md was clear and complete
- [ ] No manual fixes needed
- [ ] Trigger phrase activated the skill
- [ ] Dashboard rendered correctly

Gaps in INSTALL.md:

> _none_

Plugin gaps to fix before relying on it in workshop:

> _none_

---

## Other observations

Anything else that broke, surprised you, or should be flagged for `troubleshooting.md`:

> _none_

---

## Decisions to take back

- [ ] `setup-guide.md` Step 5 placeholder → replace with: _________
- [ ] `setup-guide.md` Step 1 (Express vs Manual) → any changes needed?
- [ ] `troubleshooting.md` → add new rows: _________
- [ ] `verify.ps1` → fix bugs / add MCP check: _________
- [ ] `copilot-overview-plugin` README/INSTALL → file issues: _________
- [ ] `plan.md` → mark `p10-validate-mcp-prompt` done

## Recommendation for next workshop

Ready to ship? **yes / no — with caveats: _________**
