# Demo Prep Checklist

**📖 Business roles** — This checklist protects the audience experience. If the live path is unsafe, use the backup.

Run this 15–30 minutes before the session. The goal is not to prove you can debug under pressure. The goal is to know, early, whether the live demo is safe to run.

## T-30 minutes — environment

- [ ] Run `verify.ps1` from the repo root, if it has shipped.
- [ ] If `verify.ps1` is not available yet, run the same checks manually: `gh auth status`, `az account show`, `copilot --version`, and one PMX smoke test.
- [ ] Confirm `gh auth status` shows the right GitHub account for this demo.
- [ ] Confirm `az account show` shows the Microsoft tenant.
- [ ] Confirm `copilot --version` works.
- [ ] Quick test in Copilot CLI: `Show me my PMX projects`.
- [ ] Confirm the PMX projects response returns real data in less than 30 seconds.

## T-15 minutes — clean session

**⚠️ Common trap** — Do not open the demo by saying a new session is crashing. Verify the session privately first, or switch to backup.

- [ ] Close all old Copilot CLI sessions and terminal tabs.
- [ ] Open one fresh Windows Terminal window.
- [ ] Make the Windows Terminal window full screen.
- [ ] Set font size for projection with `Ctrl+=` a few times.
- [ ] Go to the workspace the demo runs in: `cd C:\Users\jwallquist\projects\cli-intro`.
- [ ] Launch Copilot CLI with `copilot`.
- [ ] Run `/model`.
- [ ] Pre-select the model you will demo with, typically a fast one for visible flow.
- [ ] Run `/exit`.
- [ ] Re-launch Copilot CLI with `copilot`.
- [ ] Confirm the model selection persisted.
- [ ] If using YOLO mode, decide deliberately before the session starts.
- [ ] **🔧 Technical deep dive** — If using YOLO mode, be ready to explain the trade-off: faster demo flow, but scarier for non-coders because the tool acts with fewer pauses.

## T-5 minutes — content

**🔧 Technical deep dive** — Keep only the windows and files needed for the live flow. Reduce accidental data exposure.

- [ ] Open the demo script in a side window: `demo-01-partner-briefing.md`.
- [ ] Confirm the partner name in the script matches a real partner you have data for.
- [ ] Open the slide deck in presenter mode.
- [ ] Have the backup recording link ready from `_demo-failsafe.md`.
- [ ] Close email, Teams, and browser tabs that are not needed.
- [ ] Remove anything from the screen share area that could distract the audience or expose private previews.

## T-0 — share screen

- [ ] Share the Windows Terminal window only, not the full screen.
- [ ] Verify the terminal zoom level is readable on a small participant screen.
- [ ] Take a breath. You've done this before.

> **If anything fails this checklist:** switch to the backup recording immediately. Don't try to fix it live.

## See also

- `_demo-failsafe.md` — what to do if the demo breaks during the session
- `demo-01-partner-briefing.md` — primary demo script
