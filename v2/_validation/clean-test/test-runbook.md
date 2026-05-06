# Clean-test runbook

What we're testing: **does the current hosted setup guide actually work end-to-end for a non-coder on a fresh Windows?**

We're not testing scripts. We're testing instructions.

The canonical artifact is now **the hosted [`setup.html`](https://cli-intro-share.pages.dev/setup.html)** (Cloudflare Pages, fed from `cli-intro-share`). The markdown copy at `v2/pre-work/setup-guide.md` should match — but the hosted page is what real beta users see. **Test the hosted page first.**

---

## Pick your fresh machine

| Option | When to use |
|--------|-------------|
| **Microsoft Dev Box** ⭐ default | The path that actually works in our tenant. Just connect and go. After walk 1, run [`reset-devbox.ps1`](reset-devbox.ps1) to reuse the same box for walks 2-N. See "Repeat walks on the same Dev Box" below. |
| **Sandbox in Dev Box** | Aspirational — Containers-DisposableClientVM is blocked by current Dev Box pool policy, so this path is a dead end on our tenant today. Doc kept for future tenants where it's allowed. See [sandbox-in-devbox.md](sandbox-in-devbox.md). |
| **Windows Sandbox** (local) | When you don't have Dev Box access. Skip on ARM64 + corporate-managed Windows — known hypervisor lockup. See [launch.cmd](launch.cmd) and [enable-sandbox.md](enable-sandbox.md). |

The realistic flow today is: connect to a Dev Box, walk through setup.html once on a freshly-deployed (pristine) box, then `reset-devbox.ps1` between subsequent walks.

### Repeat walks on the same Dev Box

Redeploying the Dev Box between every walk costs ~15 min. The reset script is the cheaper option for walks 2-N:

```powershell
# Soft (default) — clears auth + config + cloned repos. Tools stay installed.
# Use this between Walk A1 reruns where you don't need to retest Step 1.
.\reset-devbox.ps1

# Hard — Soft + winget uninstall the 6 packages.
# Use this when you want to retest Step 1. NOT a pristine reset (winget
# leaves PATH/registry/state behind). For a true pristine machine, redeploy.
.\reset-devbox.ps1 -Mode Hard

# Preview without changing anything
.\reset-devbox.ps1 -WhatIf
```

The script ends with a verifier that lists what's still present, so you know what the reset actually cleared. **The first walk on a redeployed box is always the most authoritative test** — use the reset script for everything after that.

## How the test relates to user instructions

📌 **The test IS following the user instructions.** There is no separate "tester walkthrough." Open the hosted setup.html and follow it as if you were a workshop attendee.

The runbook below adds two things on top:

1. **Don't fix silently.** When something breaks, log it as a finding instead of working around it.
2. **Log findings in a structured place.** [`results-template.md`](results-template.md) has the sections.

That's the whole "kit." It's the user instructions plus a notebook beside you.

## Before you start

1. Open [results-template.md](results-template.md) on your **host** (not the test machine). Add a new `## Walk N — YYYY-MM-DD` section at the top of the walk log. The template's structured checklist sits at the bottom — copy that into your new section to fill in.
2. Pretend you're a non-coder PSA who has never used a CLI. Read the guide literally. Don't fix anything as you go — note the breakage.
3. Have your two GitHub accounts ready: personal (workshop default) and EMU (`*_microsoft`, for PMX install).
4. Have your Microsoft tenant credentials ready (for `az login`).

---

## Walk A — Hosted setup.html, full path ⭐

This is the primary walk. ~45 min for a full clean run.

1. On the fresh machine, open a browser and go to the hosted setup guide:
   - https://cli-intro-share.pages.dev/setup.html
   - (Bookmark it. You'll come back to it during the walk.)

2. Follow it from the top — every section, in order:
   - **Intro foldout** (M365 Copilot vs Copilot CLI) — does it read cleanly? Does the librarian/contractor analogy land? Is the multi-MCP example believable? **Log a finding if anything reads as marketing fluff or confusing.**
   - **Step 0 — GitHub account ready** — EMU vs personal explanation clear? Both accounts straight in your head before Step 1?
   - **Step 1 — Install command-line tools** — PowerShell 7 install, then the five `winget install` commands. UAC pop-ups expected? Did the prompt change correctly? Did all five tools install?
   - **Step 2a — GitHub CLI (personal)** — `gh auth login`. Browser flow + SSO authorize. Pass: `✓ Logged in as <personal>`.
   - **Step 2b — GitHub CLI (EMU)** — `gh auth login` again, sign in as `_microsoft`. Then `gh auth switch --user <personal>` to make personal active again. Pass: `gh auth status` shows both, personal marked `Active account: true`.
   - **Step 2c — Copilot CLI** — `copilot` → folder trust → `/login` → device code → browser. Smoke-test "What day is it today?".
   - **Step 2d — Azure CLI** — `az login --tenant ...`. **Subscription picker shows up — does the "just press Enter" note land?** Did `az account show` work afterward?
   - **Step 3a — M365 install** — prompt-orchestrated, runs WorkIQ.
   - **Step 3b — PMX install** ⚠️ **THE HIGH-VALUE TEST** — see Walk A1 below.
   - **Step 4 — Verify everything** — five checklist items, all using styled command blocks. Did every Copy button work? Did each command return what the guide predicts?
   - **Troubleshooting** — skim only; don't trigger on purpose unless time allows (see Walk B).

3. As you go, capture in [results-template.md](results-template.md):
   - Every step where the wording was unclear
   - Every prompt that didn't match the guide's prediction
   - Every command that errored
   - Every place a non-coder would have stopped and asked for help

### Walk A1 — Step 3b PMX prompt-orchestrated install ⭐

**This is the test that justifies this whole iteration.** The PMX install was rewritten to a single Copilot CLI prompt that orchestrates the switch-install-switch sequence itself. We need to know: does it actually work clean?

Inside Copilot CLI, paste the prompt block from setup.html Step 3b verbatim. Then watch:

- [ ] Did Copilot run `gh auth status` to find the EMU username?
- [ ] Did it run `gh auth switch --user <yourname>_microsoft` correctly?
- [ ] Did it verify the switch took before running `marketplace add`?
- [ ] Did `copilot plugin marketplace add gim-home/pmx-mcp` succeed without 403 or 404?
- [ ] Did `copilot plugin install pmx-mcp@pmx-mcp` succeed?
- [ ] Did Copilot switch back to personal at the end?
- [ ] After `/exit` and re-launching `copilot`, are PMX tools actually registered (try `Show me my PMX projects`)?

**If any of those fail**, log the exact transcript verbatim — it's the most useful artifact this kit will ever produce. Then drop into Walk B (manual fallback) to confirm the recovery path works.

### Walk A2 — Verify checklist styling (UX check)

This isn't a functional test, just a visual one. While you're on Step 4, confirm:

- [ ] Every command in the verify checklist sits inside a dark `cmd-wrap` block with a shell label (POWERSHELL or ✦ Copilot CLI) and a working Copy button.
- [ ] No raw `<span class="check-cmd">` artifacts showing up as inline grey text.
- [ ] Checks #2/#4/#5 (which need you to launch Copilot then type a prompt) clearly show two separate blocks with hint text between them.

If any look wrong, capture a screenshot and log under "Step 4 — Verify".

---

## Walk B — Manual fallback foldout (PMX)

Only run this if **Walk A1 failed** or if you specifically want to validate the manual recovery path.

1. Reset the test machine (run `.\reset-devbox.ps1` from this folder for the standard repeat-walk path, OR redeploy the Dev Box for a true pristine state, OR `gh auth switch` back to personal-only and `copilot plugin uninstall pmx-mcp` if it got partially installed).
2. On setup.html Step 3b, expand the **"If the prompt path didn't work"** foldout.
3. Follow the five numbered steps verbatim:
   - Step 1: Find your EMU username via `gh auth status`
   - Step 2: `gh auth switch --user YOUR_EMU_USERNAME` (replace with your actual EMU name)
   - Step 3: `gh auth status` again — confirm `Active account: true` is on the `_microsoft` line
   - Step 4: `marketplace add` + `plugin install`
   - Step 5: Switch back to personal
4. Pay specific attention:
   - [ ] Was the `YOUR_EMU_USERNAME` placeholder convention obvious (vs the old `<yourname>_microsoft` that pasted literally)?
   - [ ] Did the verify-the-switch step in #3 catch any silent-failure case?
   - [ ] Did the inline 403 callout match what you saw if anything went wrong?

Log under "Step 3b — Manual fallback".

---

## Walk C — 403 reproduction (optional, time-permitting)

Only run if you want to confirm the troubleshooting table row is accurate. Costs ~5 min.

1. Make sure you're logged into both accounts (`gh auth status` shows both, personal active).
2. Run `copilot plugin marketplace add gim-home/pmx-mcp` **without switching accounts first**.
3. Confirm you get exactly: `remote: Write access to repository not granted. fatal: ... 403`.
4. Open setup.html Troubleshooting (Common issues) and confirm the 403 row in the troubleshooting table matches what you saw and the fix points back to Walk B.

Log under "Walk C — 403 repro" with the exact error string.

---

## Walk D — copilot-overview-plugin install (optional, separate scope)

Only run if you have time and want to validate the Exercise 3 reference plugin still installs cleanly on a fresh machine. ~10 min.

1. ```powershell
   git clone https://github.com/JW-Sthlm/copilot-overview C:\Test\copilot-overview
   ```
2. Read `C:\Test\copilot-overview\INSTALL.md` and follow it exactly.
3. After install, in a fresh `copilot` session:
   ```
   Generate my copilot overview.
   ```
4. Record under **Walk D**:
   - Did the install complete without manual fixes?
   - Did the trigger phrase work?
   - Was the dashboard generated?

This is independent of the setup.html test — log findings against the `copilot-overview-plugin` repo, not against cli-intro.

---

## After the run

1. Save the filled `results-template.md` somewhere persistent (commit it to the repo if it's a clean walk worth keeping as a record).
2. Apply findings:
   - **Walk A friction** → update `setup.html` (canonical) and `setup-guide.md` (mirror) and `troubleshooting.md`.
   - **Walk A1 prompt-orchestration failures** → tighten the Step 3b prompt language (or fall back to the manual sequence as primary if the prompt is too unreliable).
   - **Walk B manual-fallback failures** → re-harden the foldout. The whole point of the recent rewrite was to be bulletproof.
   - **Walk C drift** → fix the troubleshooting row.
   - **Walk D issues** → file as todos against the `copilot-overview-plugin` repo.

## Time budget

| Phase | Realistic time |
|-------|----------------|
| Set up fresh machine | 5 min (Sandbox-in-Dev-Box: just launch.cmd; Dev Box: just connect) |
| Walk A (full setup.html, Express path) | 30–45 min — first time on a clean machine |
| Walk A1 (PMX prompt-orchestrated install — the high-value test) | inside Walk A, ~5 min if it works |
| Walk B (manual fallback) | 10 min — only if Walk A1 failed |
| Walk C (403 repro) | 5 min — optional |
| Walk D (overview plugin) | 10 min — optional |
| Documenting findings | 10 min |
| **Total for first-time full run** | **~60–75 min** |

Re-runs after fixes are much faster — focus on the walk that changed.

---

## Notes about `bootstrap.ps1`

**Don't use it for the primary test.** It bypasses Step 1 of `setup.html`, which is exactly what we're trying to validate.

When `bootstrap.ps1` IS useful:
- Re-running Walk A1 (prompt-orchestrated install) — you've already validated Step 1 elsewhere
- Re-running Walk D (overview plugin install)
- Spinning up a sandbox quickly for a one-off check that requires the tools to be present
