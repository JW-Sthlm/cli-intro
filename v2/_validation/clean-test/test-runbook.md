# Clean-test runbook

What we're testing: **does `v2/pre-work/setup-guide.md` actually work end-to-end for a non-coder on a fresh Windows?**

We're not testing scripts. We're testing instructions.

## Pick your fresh machine

| Option | When to use |
|--------|-------------|
| **Sandbox in Dev Box** ⭐ gold standard | Cloud-managed Windows 11 host + disposable Sandbox per walk. No local virtualization, no redeploy cost. See [sandbox-in-devbox.md](sandbox-in-devbox.md). |
| **Microsoft Dev Box** (plain) | Falls back here when the pool blocks Sandbox. Just connect and go — but dirty after walk 1. |
| **Windows Sandbox** (local) | When you don't have Dev Box access. Skip on ARM64 + corporate-managed Windows — known hypervisor lockup. See [launch.cmd](launch.cmd) and [enable-sandbox.md](enable-sandbox.md). |

All three deliver the same test surface. Sandbox-in-Dev-Box is the only one that's both clean and reset-in-seconds.

### ⚠️ Plain Dev Box gets "dirty" after one walk

If you can't run Sandbox-in-Dev-Box (pool blocks the feature) and have to use plain Dev Box: once you've installed the prereqs, it's no longer a clean machine. For a true second walk:

1. **Redeploy the Dev Box** — go to [devbox.microsoft.com](https://devbox.microsoft.com), select your Dev Box, click **... → Redeploy**. Wipes back to factory image. Takes ~15 min.
2. **Spin up a second Dev Box** if your pool allows it.
3. **Accept that subsequent walks only validate deltas** — if you only changed one paragraph, walk that section, not the whole guide.

This whole problem goes away with Sandbox-in-Dev-Box. Worth the one-time enable.

## How the test relates to user instructions

📌 **Important:** the test IS following the user instructions. There is no separate "tester walkthrough." You open `setup-guide.md` and follow it as if you were an attendee.

The runbook below adds two things on top of that:

1. **Don't fix silently.** When something breaks, log it as a finding instead of working around it.
2. **Log findings in a structured place.** [`results-template.md`](results-template.md) has the sections.

That's the whole "kit." It's the user instructions plus a notebook beside you.

## Before you start

Open [results-template.md](results-template.md) in a text editor on your **host** (not the test machine). You'll fill it in as you go. The sandbox wipes on close; the Dev Box is fine but external notes are tidier.

Pretend you're a non-coder PSA who has never used a CLI. Read the guide literally. Don't fix anything as you go — note the breakage.

---

## Walk 1 — setup-guide.md, Express path ⭐

Goal: validate the Express install path in `setup-guide.md` Step 1, then the auth/MCP steps.

1. On the fresh machine, get the cli-intro repo:
   ```powershell
   git clone https://github.com/JW-Sthlm/cli-intro.git C:\Test\cli-intro
   cd C:\Test\cli-intro
   ```
   (If git isn't even installed yet, that's a finding — note it, `winget install Git.Git`, then continue.)

2. Open `v2\pre-work\setup-guide.md` in any text viewer (Notepad, VS Code, browser preview).

3. Follow it from the top — every section, in order:
   - **Before You Start** (account dance)
   - **Step 1** — pick the **Express** sub-path → run `.\v2\pre-work\express-setup.ps1`
   - **Step 2** — Log In
   - **Step 3** — Verify
   - **Step 4** — Azure login
   - **Step 5** — MCP setup ⚠️ this is the open question
   - **Step 6** — Verify MCP servers

4. As you go, capture in [results-template.md](results-template.md) under **Walk 1**:
   - Every step where the wording was unclear
   - Every prompt that didn't match the guide's prediction
   - Every command that errored
   - Every place a non-coder would have stopped and asked for help

5. **Step 5 is the high-value finding.** Document the exact menu options offered. Use the matrix in **Walk 3** below to test multiple.

---

## Walk 2 — setup-guide.md, Manual path (optional)

Goal: validate the Manual install path produces the same end state as Express.

1. Reset to clean (close & reopen Sandbox, OR provision a second Dev Box, OR uninstall the 5 tools and re-run).
2. Repeat Walk 1 but pick the **Manual** sub-path in Step 1 (the 5 separate winget commands).
3. Note any difference in friction, errors, or end state.

If Walk 1 was clean, Walk 2 is nice-to-have. If Walk 1 was rough, Walk 2 helps narrow down whether the issue is in the script or the manual list.

---

## Walk 3 — MCP install location matrix ⭐ (the open question)

This is the test that justifies the whole kit. Treat it as a controlled experiment.

Once you have a working `copilot` (after Walks 1 or 2), trigger the MCP install:

```
copilot
```
Inside CLI:
```
I need to set up the GitHub MCP server. Help me configure it.
```

When the install-location menu appears, pick **one option per test session**, then verify with `/mcp` and a tool call. Reset between sessions (close Sandbox / fresh Dev Box / uninstall and re-run).

| Option | Install completes? | Visible in `/mcp`? | Tool call works? | Notes |
|--------|---|---|---|---|
| VS Code (user)        | | | | |
| VS Code (workspace)   | | | | |
| Copilot Cloud Agent   | | | | |
| Other / global / user | | | | |

**Tip:** if reset cost is high (Dev Box re-provision is slow), this is where the optional `bootstrap.ps1` earns its keep — use it to skip the install steps and jump straight to MCP testing in a fresh sandbox.

Record under **Walk 3** in results template. The winning option becomes the answer for `setup-guide.md` Step 5.

### PMX MCP variant

After confirming the right answer for the GitHub MCP, repeat once with PMX:

1. `gh auth switch --user <yourname>_microsoft`
2. In Copilot CLI: `Install the PMX MCP server from gim-home/pmx-mcp.`
3. Use the install-location answer that worked above.
4. Verify with `/mcp`.
5. Switch back: `gh auth switch --user <your-personal-username>`
6. Test: `Show me my PMX projects`.

Record under **Walk 3 — PMX variant**.

---

## Walk 4 — copilot-overview-plugin install

Goal: validate the Exercise 3 reference plugin actually installs and runs end-to-end on a clean machine.

1. ```powershell
   git clone https://github.com/JW-Sthlm/copilot-overview C:\Test\copilot-overview
   ```
2. Read `C:\Test\copilot-overview\INSTALL.md` and follow it exactly. Don't deviate. Don't fix anything as you go — note the breakage.
3. After install, in a fresh `copilot` session:
   ```
   Generate my copilot overview.
   ```
4. Record under **Walk 4**:
   - Did the install complete without manual fixes?
   - Did the trigger phrase work?
   - Was the dashboard generated?
   - List every step where INSTALL.md was unclear, missing, or wrong.

---

## After the run

1. Save the filled `results-template.md` somewhere persistent.
2. Apply findings:
   - **Walk 3 winner** → replace the `<TODO: confirm exact menu label>` placeholder in `v2/pre-work/setup-guide.md` Step 5.
   - **Walk 1/2 friction** → update setup-guide.md or troubleshooting.md.
   - **Walk 4 issues** → file as todos against `copilot-overview-plugin` repo.
   - Mark `p10-validate-mcp-prompt` done in `plan.md`.

## Time budget

| Phase | Realistic time |
|-------|----------------|
| Set up fresh machine | 5–10 min (Dev Box: just connect; Sandbox: launch.cmd) |
| Walk 1 (Express path, full guide) | 20–30 min — first time on a clean machine |
| Walk 2 (Manual path) | 15 min — optional |
| Walk 3 (MCP matrix, ~4 sessions) | 15–20 min |
| Walk 4 (overview plugin) | 5–10 min |
| Documenting findings | 5–10 min |
| **Total for first-time full run** | **~60–90 min** |

Re-runs after fixes are much faster — focus on the walk that changed.

---

## Notes about `bootstrap.ps1`

**Don't use it for the primary test.** It bypasses Step 1 of `setup-guide.md`, which is exactly what we're trying to validate.

When `bootstrap.ps1` IS useful:
- Re-running Walk 3 (MCP matrix) — you've already validated Step 1 elsewhere
- Re-running Walk 4 (overview plugin install)
- Spinning up a sandbox quickly for a one-off check that requires the tools to be present
