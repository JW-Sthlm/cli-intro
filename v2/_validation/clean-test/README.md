# Clean-machine validation kit

Internal kit used to validate that `v2/pre-work/setup-guide.md` actually works for a non-coder on a fresh Windows. **Not workshop content.**

## What we test

**The setup-guide.md walkthrough.** A real human, on a real fresh machine, opens the setup guide and follows it step by step. We document what's clear, what breaks, and where attendees would get stuck.

This is **not** a test of installer scripts. It's a test of the **instructions**.

## How it works

Three ways to get a fresh Windows, in priority order:

| Option | When to use |
|--------|-------------|
| **Microsoft Dev Box** (plain) ⭐ default | The path that actually works in our tenant today. Connect and walk. Use [`reset-devbox.ps1`](reset-devbox.ps1) between walks 2-N to avoid the ~15-min redeploy. |
| **Sandbox in Dev Box** | Aspirational — currently blocked by Dev Box pool policy (Containers-DisposableClientVM disabled). Doc kept for future tenants. See [sandbox-in-devbox.md](sandbox-in-devbox.md). |
| **Windows Sandbox** (local) | When your laptop supports it and you don't have Dev Box access. Instant disposability per run. **WARNING:** known to cause hypervisor-level lockup on ARM64 + corporate-managed Windows. |

The canonical artifact under test is the **hosted [setup.html](https://cli-intro-share.pages.dev/setup.html)**, not the markdown mirror. Open it, follow it, log findings in [results-template.md](results-template.md).

## Files in this kit

| File | Purpose |
|------|---------|
| [test-runbook.md](test-runbook.md) | **Primary path.** Step-by-step manual test. Read this first. |
| [results-template.md](results-template.md) | Pre-formatted results — copy and fill in as you go |
| [reset-devbox.ps1](reset-devbox.ps1) | **Repeat-walk reset.** Soft mode wipes auth/config/repos in ~30s. Hard mode adds winget uninstall (best-effort, NOT pristine — redeploy for true clean). Always runs a verifier at the end. |
| [sandbox-in-devbox.md](sandbox-in-devbox.md) | Aspirational Sandbox-in-Dev-Box workflow. Currently blocked by tenant pool policy — kept as reference. |
| [launch.cmd](launch.cmd) | Starts Windows Sandbox (works inside Dev Box too once enabled) |
| [sandbox-config.wsb](sandbox-config.wsb) | Sandbox config (mounts this folder read-only) |
| [bootstrap.ps1](bootstrap.ps1) | **Optional shortcut** for re-runs. Auto-installs the 5 prereqs. **Do NOT use for the primary test** — it bypasses the very thing we're validating. |
| [enable-sandbox.md](enable-sandbox.md) | One-time host setup for Windows Sandbox (local laptop) |
| [fallback-codespace.md](fallback-codespace.md) | Linux Codespace alternative — different OS, only useful for non-Windows-specific issues |

## When to re-run

- After any change to `v2/pre-work/setup-guide.md`
- After any change to `v2/pre-work/express-setup.ps1`
- When a new version of Copilot CLI ships
- When the recommended MCP server set changes
- Before any new workshop session that will have first-time attendees
