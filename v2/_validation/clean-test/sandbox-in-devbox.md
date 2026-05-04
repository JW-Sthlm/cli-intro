# Sandbox in Dev Box ⭐ (gold-standard validation host)

The combo that makes this kit worth running. Microsoft Dev Box gives you a clean cloud-managed Windows 11 host. Windows Sandbox gives you a disposable VM per walk. Run Sandbox **inside** the Dev Box and you get both: no local virtualization issues, no admin-on-request dance on your laptop, and no 15-minute Dev Box redeploy between runs.

## Why this beats every other option

| Concern | Local Sandbox | Plain Dev Box | Sandbox-in-Dev-Box |
|---|---|---|---|
| Hypervisor lockup on ARM64 + corporate Windows | ❌ known issue | ✅ N/A (cloud) | ✅ N/A (cloud) |
| Need admin-on-request to enable feature | ❌ yes | ❌ yes (on the Dev Box) | ⚠️ once on the Dev Box |
| Clean machine per walk | ✅ yes | ❌ dirty after walk 1 | ✅ yes |
| Reset cost between walks | seconds (close window) | ~15 min (redeploy) | seconds (close window) |
| Tests true Windows install path | ✅ yes | ✅ yes | ✅ yes |
| Validates `verify.ps1`, `winget`, MCP prompts | ✅ yes | ✅ yes | ✅ yes |

This is the path you want for any iteration cycle where you'll run the setup guide more than once.

## One-time setup on the Dev Box

You do this once on the Dev Box host. After that, every subsequent Sandbox launch is instant.

1. Connect to your Dev Box via [devbox.microsoft.com](https://devbox.microsoft.com) (or the Windows App).
2. Open PowerShell **as Administrator**. On Dev Box you usually have admin out of the box — if not, request elevation through the Dev Box admin tools.
3. Enable the Sandbox feature:
   ```powershell
   Enable-WindowsOptionalFeature -Online -FeatureName "Containers-DisposableClientVM" -All -NoRestart
   ```
4. Reboot the Dev Box:
   ```powershell
   Restart-Computer
   ```
5. Reconnect. Verify:
   ```powershell
   Get-Command WindowsSandbox
   ```
   If it returns a path, you're done.

> **If the enable command fails on Dev Box:** the Dev Box pool image may not allow it. Check `winver` (Pro/Enterprise/Education only) and confirm with the Dev Box admin that the pool isn't policy-locked. If blocked, fall back to plain Dev Box (with redeploy between walks) or local Sandbox.

## Per-walk loop

Once enabled, the loop is:

1. On the Dev Box, double-click [`launch.cmd`](launch.cmd) (or run [`sandbox-config.wsb`](sandbox-config.wsb) directly). This opens a fresh Sandbox window with the kit folder mounted read-only.
2. Inside the Sandbox, follow [test-runbook.md](test-runbook.md) — Walk 1 / 2 / 3 / 4 as needed.
3. Capture findings in [results-template.md](results-template.md) **on the Dev Box host**, not inside the Sandbox (the Sandbox wipes on close).
4. Close the Sandbox window. State gone.
5. For the next walk, launch again from step 1. Fresh every time.

## What about the Dev Box host itself?

The Dev Box host accumulates state too — anything you do on it (browsing, installs, files in `C:\`) persists between sessions. Keep the host clean by:

- Doing all setup-guide walks inside the Sandbox, never on the host directly.
- Using the Dev Box host only for: launching Sandbox, running git operations against this kit repo, and writing up findings.
- If the host genuinely gets dirty (you accidentally installed Copilot CLI on the host, etc.), redeploy it. That's the 15-min option, but you should rarely need it once you're in the Sandbox-in-Dev-Box rhythm.

## When this stops being the right answer

- **You don't have a Dev Box.** Then it's local Sandbox (if your laptop allows), or plain Codespaces fallback.
- **The Dev Box pool blocks Sandbox.** Plain Dev Box with redeploy works, just slower.
- **You need to test something Windows-Sandbox-specific.** Sandbox-in-Dev-Box still validates this — the inner Sandbox is real Windows Sandbox.
- **You're testing host-level features (BIOS, drivers, hardware).** Use a real machine. Neither layer here applies.

For everything else — the standard "does setup-guide.md work for a non-coder?" question this kit exists to answer — Sandbox-in-Dev-Box is the path.
