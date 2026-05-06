# Walk back your Dev Box

Use this when your Dev Box already has auth, config, or test scripts on it from a previous session, and you need to get back to a clean enough state to run the test runbook or the self-service course without leftover state polluting the result.

This page assumes:
- You're on a Microsoft Dev Box (not your local machine).
- The reset script lives next to this file: [`reset-devbox.ps1`](reset-devbox.ps1).

If the dev box is freshly redeployed, skip this page. You're already clean.

---

## TLDR

```powershell
cd ~\projects\cli-intro\v2\_validation\clean-test
.\reset-devbox.ps1 -WhatIf      # preview, change nothing
.\reset-devbox.ps1              # Soft reset (~30 sec)
```

If anything looks off, scroll down. Otherwise: read the verifier output at the end, follow what the script tells you to do next.

---

## Step 1: Get this folder onto the Dev Box

If you've already cloned `cli-intro` on this box, skip ahead.

```powershell
# Sign in to GitHub if you haven't yet
gh auth login

# Clone somewhere outside $HOME root so the Soft reset can't touch it
git clone https://github.com/JW-Sthlm/cli-intro.git ~\projects\cli-intro

# Move into the clean-test folder
cd ~\projects\cli-intro\v2\_validation\clean-test
```

> Why `~\projects\cli-intro` and not `~\cli-intro`? Soft mode removes `$HOME\cli-intro` directly so a fresh test walk doesn't see leftover course content. A subfolder like `~\projects\` is preserved on purpose so this script and runbook stay accessible across walks.

You should now see `reset-devbox.ps1`, `test-runbook.md`, and this file.

## Step 2: Pick a reset mode

| Mode | What it does | When to use | Time |
|------|--------------|-------------|------|
| **Soft** (default) | Clears auth (`gh`, `az`, Copilot CLI), clears config dirs (`~/.copilot`, `~/.azure`, gh config), removes `cli-intro` and `pmx-mcp` cloned in `$HOME`. Tools stay installed. | Most cases. You want to retest Step 2 onward without redoing the install path. | ~30 sec |
| **Hard** | Soft, plus winget uninstall of the 6 tooling packages. NOT pristine (winget leaves PATH entries, registry, and `%APPDATA%` state). | Retesting Step 1 (the install path itself). | ~5 min |
| **Redeploy** | Don't run the script. Go to [devbox.microsoft.com](https://devbox.microsoft.com), redeploy your box. | First walk on a new course version, or when the result needs to be authoritative. This is the only true pristine state. | ~15 min |

Default to Soft. Only go Hard if you specifically need to retest the install commands.

## Step 3: Preview before destroying anything

Always run with `-WhatIf` first:

```powershell
.\reset-devbox.ps1 -WhatIf
```

The script prints every path it would remove, every process it would kill, every auth surface it would clear, then a `Preview summary` at the end. Read the list. If anything in there is data you care about (a repo you forgot to push, a Copilot config you customized), stop and back it up first.

`-WhatIf` skips the post-reset verifier on purpose. Nothing was deleted, so a "state still present" report would be noise.

## Step 4: Run the reset

```powershell
# Soft (default)
.\reset-devbox.ps1

# Hard (only if retesting install path)
.\reset-devbox.ps1 -Mode Hard
```

You'll get a confirmation prompt for each destructive action. To run unattended:

```powershell
.\reset-devbox.ps1 -Yes
```

## Step 5: Read the verifier

The script ends with two sections worth reading:

**`Verifier, what state remains`** lists every state path / binary / auth surface it checked. After Soft, you should see:

```
  [OK] Copilot config gone
  [OK] gh config (APPDATA) gone
  [OK] gh config (.config) gone
  [OK] az config gone
  [OK] cli-intro repo gone
  [OK] pmx-mcp repo gone
  [OK] gh binary present              ← tools stay installed
  [OK] az binary present
  [OK] copilot binary present
  [OK] gh auth status: not logged in
  [OK] az account show: not logged in
```

**`Summary`** prints what to do next:

- After Soft: "Open a new PowerShell window and start Walk A from Step 2 (Log In)."
- After Hard: "Open a new PowerShell window and start Walk A from Step 1 (Install command-line tools)."

## Step 6: If the verifier shows warnings

| Symptom | Fix |
|---------|-----|
| `[FAIL]` removing `~/.copilot` | Close any open Copilot CLI windows, re-run. |
| `[FAIL]` removing `~/.azure` | Close any open `az` windows, re-run. |
| `gh auth status: still authenticated` | Run `gh auth logout --hostname github.com` manually, then re-run the verifier section. |
| `az account show: still authenticated` | Run `az logout` manually. |
| Tools still on PATH after Hard reset | Expected. winget uninstall leaves leftovers. If you need true pristine, redeploy the Dev Box. |
| `[WARN]` on `cli-intro repo still present` | Soft removes `$HOME\cli-intro` only. If you cloned to `~\projects\cli-intro` (recommended), that location is preserved on purpose so this script and runbook stay accessible. |

## Step 7: Now run the new instructions

You're ready. Open a fresh PowerShell window so the reset state takes effect, then pick what you're testing:

- **Setup-guide test** → open https://cli-intro-share.pages.dev/setup.html, follow [test-runbook.md](test-runbook.md) Walk A.
- **Self-service course** → open `v2/self-service-course/README.md` (browse on github.com), follow the modules as a learner would.
- **Just the PMX install path** → setup.html Step 3b, then [test-runbook.md](test-runbook.md) Walk A1.

---

## FAQ

**I already ran some scripts on this box. Is Soft enough?**
Yes, if those scripts only changed auth, Copilot config, or cloned repos in `$HOME`. If they installed extra tools or wrote files outside `$HOME`, go Hard or redeploy.

**How do I know the reset really worked?**
The verifier reports it. If every state row says `[OK] gone` and both auth checks say `[OK] not logged in`, you're clean.

**Can I skip the reset and push through?**
Sometimes. For a docs change that doesn't touch auth, leftover auth is fine. For an end-to-end setup.html walk, no, leftover auth defeats the test.

**I'm not on a Dev Box, will this script work?**
Yes on any Windows machine. But pristine isn't achievable without redeploying. On a personal Windows box, the alternative is a Windows Sandbox VM (see [enable-sandbox.md](enable-sandbox.md)).

**I want to keep my GitHub auth, just clear Copilot CLI.**
Don't use this script for that. Run the surgical commands by hand:

```powershell
Get-Process copilot -ErrorAction SilentlyContinue | Stop-Process -Force
Remove-Item "$HOME\.copilot" -Recurse -Force
```

Then `copilot /login` next time you launch.
