# What Is This Repo? (And What Is a Repo?)

> If you're new to or need a refresher to GitHub, start here. This page explains everything in plain language.

---

## The short version

This repo contains all materials for the **Copilot CLI intro session** — slides, exercise prompts, cheat sheets, and setup guides. You're here to grab exercise prompts during the session and reference materials after.

**Your journey through these materials:**

> 📖 **You are here** → [Setup Guide](pre-work/setup-guide.md) → [Verify Checklist](pre-work/verify-checklist.md) → **Session day!** → [Exercise 1](exercises/exercise-01-build-your-briefing.md) → [Exercise 2](exercises/exercise-02-pick-your-scenario.md) → [Cheat Sheet](reference/cheat-sheet.md) → [After-Session Resources](reference/after-session-resources.md)

---

## Wait — what's a "repo"?

A **repository** (repo) is just a shared folder on the internet. Think of it like a OneDrive folder, but:
- It has version history (every change is tracked)
- Anyone with access can see the same files
- It's where developers keep their work — and now where we keep ours

**GitHub** is the website that hosts repos. You're on it right now.

---

## The most important thing to know about Copilot CLI

**You don't need to memorize commands or syntax.** Copilot CLI understands plain language. Just type what you want, like you'd ask a colleague:

- `Help me prepare for my meeting with Contoso tomorrow`
- `What projects do I have that are missing outcomes?`
- `Why did that last command fail?`
- `How do I connect a new MCP server?`

If you're unsure about something, just ask. Literally type "how do I..." or "what is..." and it will explain. You can also use `/ask` to ask a side question without interrupting your current work.

**The prompts in the exercise sheets are starting points, not scripts.** Feel free to rephrase, follow up, or go in a completely different direction. There's no wrong way to talk to it.

---

## How do I use this during the session?

You have two options. Pick whichever feels more comfortable:

### Option 1: Just browse on GitHub (easiest)

1. You're already here — this page is on GitHub
2. Click on the **`exercises/`** folder in the file list above
3. Click on the exercise file (e.g., `exercise-01-build-your-briefing.md`)
4. Copy the prompts you need and paste them into Copilot CLI

That's it. No installation, no terminal magic. Just browse and copy.

### Option 2: Clone the repo to your machine (more useful long-term)

"Cloning" means downloading the entire folder to your laptop. Useful because:
- Files are on your machine — works offline
- Copilot CLI can read files directly with `@filename`
- You can add your own notes

**How to clone:**

Open PowerShell and run:

```powershell
cd ~\projects
git clone https://github.com/JW-Sthlm/cli-intro.git
cd cli-intro\v2
```

> **Don't have `git`?** Run `winget install Git.Git` first, then restart PowerShell.

> **What does `cd` mean?** It stands for "change directory" — like double-clicking a folder in File Explorer. `cd ~\projects` means "go to my projects folder."

Now all files are in `C:\Users\<you>\projects\cli-intro\v2\`. You can open them in any text editor or browse them in File Explorer.

---

## Folder structure — what's where

```
v2/
├── exercises/               ← YOUR exercise prompts — copy-paste these! ⭐
│   ├── exercise-01-build-your-briefing.md
│   └── exercise-02-pick-your-scenario.md
├── reference/               ← Keep these — useful during + after the session
│   ├── cheat-sheet.md          Quick reference for commands and workflows
│   ├── after-session-resources.md   Links for deep dives and self-study
│   └── troubleshooting.md      Common issues and fixes
├── pre-work/                ← Setup instructions (do this before the session)
│   ├── setup-guide.md
│   └── verify-checklist.md
├── deck/                    ← Presentation slides (the facilitator shows these)
└── demos/                   ← Demo scripts (the facilitator uses these)
```

---

## Jargon decoder

| Term | What it means | Familiar analogy |
|------|-------------|-----------------|
| **Repo** (repository) | A shared folder with version history | Like a OneDrive folder, but with tracked changes |
| **Clone** | Download a repo to your machine | Like "sync to my device" in OneDrive |
| **Git** | The tool that manages version history | Like Track Changes in Word, but for any file |
| **GitHub** | The website where repos live | Like SharePoint, but for code and documents |
| **Terminal / PowerShell** | A text-based way to talk to your computer | Like File Explorer, but you type instead of click |
| **Markdown (.md files)** | A simple text format with formatting | Like a Word doc, but plain text with `#` for headings |
| **MCP server** | A connector that lets Copilot talk to a system | Like a Power Automate connector |
| **Slash command** (`/help`) | A shortcut you type in Copilot CLI | Like a keyboard shortcut, but you type it |
| **Prompt** | What you type to Copilot CLI | Like what you'd say to a colleague — just in writing |

---

## What's next?

**Before the session:** Go to the [Setup Guide](pre-work/setup-guide.md) → then run the [Verify Checklist](pre-work/verify-checklist.md)

**During the session:** Open [Exercise 1](exercises/exercise-01-build-your-briefing.md) when the facilitator says "your turn"

**After the session:** Bookmark the [Cheat Sheet](reference/cheat-sheet.md) and check out [After-Session Resources](reference/after-session-resources.md)

---

## I'm stuck

- **During the session:** Raise your hand or ask in the Teams chat
- **After the session:** Check [Troubleshooting](reference/troubleshooting.md) or ask in the Teams channel
- **Or just ask CLI:** Type `How do I...` or `What went wrong?` — it understands
- **General CLI help:** https://docs.github.com/en/copilot/how-tos/copilot-cli
