# Clean-machine validation kit

Internal kit used to validate that the hosted [setup.html](https://cli-intro-share.pages.dev/setup.html) actually works for a non-coder on a fresh Windows. **Not workshop content.**

## What we test

**The setup.html walkthrough.** A real human, on a real fresh machine, opens the hosted setup guide and follows it step by step. We document what's clear, what breaks, and where attendees would get stuck.

This is **not** a test of installer scripts. It's a test of the **instructions**.

## How it works

**Use a Microsoft Dev Box.** That's the path. Reset between walks with [`reset-devbox.ps1`](reset-devbox.ps1) (~30 sec soft mode). Full redeploy (~15 min) when the soft reset can't recover.

The canonical artifact under test is the **hosted [setup.html](https://cli-intro-share.pages.dev/setup.html)**, not the markdown mirror. Open it, follow it, log findings in [results-template.md](results-template.md).

### Dead-end paths (don't go here)

| Option | Why we don't use it |
|--------|---------------------|
| **Sandbox in Dev Box** | `Containers-DisposableClientVM` is disabled on the Dev Box pool image, and tenant policy blocks enabling it. See [sandbox-in-devbox.md](sandbox-in-devbox.md) for the full write-up so nobody re-discovers this. |
| **Windows Sandbox (local)** | Hypervisor-level lockup on ARM64 plus corporate-managed Windows. The files `launch.cmd`, `sandbox-config.wsb`, and `enable-sandbox.md` are kept for non-corporate machines but are not part of our flow. |

### When Dev Box isn't an option

Use a Linux Codespace via [fallback-codespace.md](fallback-codespace.md). Different OS, so it only validates non-Windows-specific issues. PowerShell, winget, and EMU sign-in flows are out of scope on Codespaces.

## Files in this kit

| File | Purpose |
|------|---------|
| [test-runbook.md](test-runbook.md) | **Primary path.** Step-by-step manual test. Read this first. |
| [results-template.md](results-template.md) | Pre-formatted results — copy and fill in as you go |
| [reset-devbox.ps1](reset-devbox.ps1) | **Repeat-walk reset.** Soft mode wipes auth/config/repos in ~30s. Hard mode adds winget uninstall (best-effort, NOT pristine — redeploy for true clean). Always runs a verifier at the end. |
| [sandbox-in-devbox.md](sandbox-in-devbox.md) | **Dead-end report.** Why Sandbox-in-Dev-Box doesn't work in our tenant. Kept so nobody re-discovers it. |
| [launch.cmd](launch.cmd) | Starts Windows Sandbox (kept for non-corporate machines; not part of our flow) |
| [sandbox-config.wsb](sandbox-config.wsb) | Sandbox config (mounts this folder read-only; only relevant outside our flow) |
| [bootstrap.ps1](bootstrap.ps1) | **Optional shortcut** for re-runs. Auto-installs the 5 prereqs. **Do NOT use for the primary test** — it bypasses the very thing we're validating. |
| [enable-sandbox.md](enable-sandbox.md) | One-time host setup for Windows Sandbox (only relevant on a personal/non-corporate Windows machine; not used in our Dev Box flow) |
| [fallback-codespace.md](fallback-codespace.md) | Linux Codespace alternative when Dev Box isn't available. Different OS, so only validates non-Windows-specific issues. |

## When to re-run

- After any change to the hosted `setup.html` (in the `cli-intro-share` repo)
- After any change to `v2/pre-work/express-setup.ps1`
- When a new version of Copilot CLI ships
- When the recommended MCP server set changes
- Before any new workshop session that will have first-time attendees
