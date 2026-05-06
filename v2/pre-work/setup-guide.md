# Setup Guide — Copilot CLI Intro Session

> **The canonical setup guide is the hosted page:**
> 👉 **https://cli-intro-share.pages.dev/setup.html**
>
> This markdown file is now a thin pointer. The hosted version has foldouts, command blocks with shell labels, copy buttons, and an anchored ToC. It is the single source of truth and the only version that gets iterated against workshop walkthroughs.

---

## Quick links into the hosted guide

| Step | What | Link |
|------|------|------|
| 0 | Get your GitHub account ready (EMU vs personal) | [Step 0](https://cli-intro-share.pages.dev/setup.html#step-0) |
| 1 | Install command-line tools (Express or Manual) | [Step 1](https://cli-intro-share.pages.dev/setup.html#step-1) |
| 2 | Log in to all your accounts (gh personal, gh EMU, Copilot CLI, Azure CLI) | [Step 2](https://cli-intro-share.pages.dev/setup.html#step-2) |
| 3 | Connect your tools (M365 + PMX MCP install) | [Step 3](https://cli-intro-share.pages.dev/setup.html#step-3) |
| 4 | Verify everything | [Step 4](https://cli-intro-share.pages.dev/setup.html#verify) |
| - | Troubleshooting | [Common issues](https://cli-intro-share.pages.dev/setup.html#troubleshooting) |

---

## Time and outcome

- **Time:** 30–45 minutes the first time on a clean machine. About 10 minutes if you've installed similar tooling before.
- **What you end up with:** a working Copilot CLI with the M365 and PMX MCP servers connected, plus the built-in GitHub MCP.

## Why hosted-only

`setup.html` carries features markdown can't:

- **Foldout sections** for "I've never opened PowerShell" walkthroughs and manual fallbacks.
- **Command blocks with shell labels** (PowerShell vs ✦ Copilot CLI) and per-block Copy buttons.
- **In-page anchors** so we can deep-link from internal docs, runbooks, and verify scripts.

A perfect markdown mirror would always be the lesser version. Maintaining both means they drift after every walk-through. So this file points; the hosted page does the work.

## Need an offline copy?

Open the hosted page in your browser and use **Save as PDF** (Ctrl+P → "Save as PDF"). That gives you a self-contained printable copy that includes all the foldouts expanded.

## For internal facilitators

If you maintain a doc that links back here, you can keep the link to `setup-guide.md` (this file) for stability, or update it to point straight at the hosted page or a specific anchor. Both work.
