# Clean-machine validation kit

Internal kit used to validate that `v2/pre-work/setup-guide.md` actually works for a non-coder on a fresh Windows. **Not workshop content.**

## What we test

**The setup-guide.md walkthrough.** A real human, on a real fresh machine, opens the setup guide and follows it step by step. We document what's clear, what breaks, and where attendees would get stuck.

This is **not** a test of installer scripts. It's a test of the **instructions**.

## How it works

Two ways to get a fresh Windows:

| Option | When to use |
|--------|-------------|
| **Microsoft Dev Box** ⭐ recommended | Default. Fresh Windows 11, cloud-managed, no virtualization issues. Just connect and walk the guide. |
| **Windows Sandbox** | When your host supports it and you want instant disposability per run. **WARNING:** known to cause hypervisor-level lockup on ARM64 + corporate-managed Windows — use Dev Box instead in that case. |

Either way, the test is: open [setup-guide.md](../../pre-work/setup-guide.md), follow it as written, document findings using [results-template.md](results-template.md).

## Files in this kit

| File | Purpose |
|------|---------|
| [test-runbook.md](test-runbook.md) | **Primary path.** Step-by-step manual test. Read this first. |
| [results-template.md](results-template.md) | Pre-formatted results — copy and fill in as you go |
| [launch.cmd](launch.cmd) | Optional: starts Windows Sandbox if your host supports it |
| [sandbox-config.wsb](sandbox-config.wsb) | Sandbox config (mounts this folder read-only) |
| [bootstrap.ps1](bootstrap.ps1) | **Optional shortcut** for re-runs. Auto-installs the 5 prereqs. **Do NOT use for the primary test** — it bypasses the very thing we're validating. |
| [enable-sandbox.md](enable-sandbox.md) | One-time host setup for Windows Sandbox |
| [fallback-codespace.md](fallback-codespace.md) | Linux Codespace alternative — different OS, only useful for non-Windows-specific issues |

## When to re-run

- After any change to `v2/pre-work/setup-guide.md`
- After any change to `v2/pre-work/express-setup.ps1`
- When a new version of Copilot CLI ships
- When the recommended MCP server set changes
- Before any new workshop session that will have first-time attendees
