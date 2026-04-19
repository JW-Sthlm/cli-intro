# What Is This Repo? (And What Is a Repo?)

> If you've never used GitHub before, start here. This page explains everything in plain language.

---

## The short version

This repo contains all materials for the **Copilot CLI intro session** — slides, exercise prompts, cheat sheets, and setup guides. You're here to grab exercise prompts during the session and reference materials after.

---

## Wait — what's a "repo"?

A **repository** (repo) is just a shared folder on the internet. Think of it like a OneDrive folder, but:
- It has version history (every change is tracked)
- Anyone with access can see the same files
- It's where developers keep their work — and now where we keep ours

**GitHub** is the website that hosts repos. You're on it right now.

---

## How do I use this during the session?

You have two options. Pick whichever feels more comfortable:

### Option 1: Just browse on GitHub (easiest)

1. You're already here — this page is on GitHub
2. Click on the **`v2/exercises/`** folder above
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
cd cli-intro
```

> **Don't have `git`?** Run `winget install Git.Git` first, then restart PowerShell.

> **What does `cd` mean?** It stands for "change directory" — like double-clicking a folder in File Explorer. `cd ~\projects` means "go to my projects folder."

Now all files are in `C:\Users\<you>\projects\cli-intro\`. You can open them in any text editor or browse them in File Explorer.

---

## Folder structure — what's where

```
v2/
├── deck/                    ← Presentation slides (the facilitator shows these)
│   ├── cli-intro-v2.html       Open in browser to view slides
│   └── ...
├── demos/                   ← Demo scripts (the facilitator uses these)
│   ├── demo-01-partner-briefing.md
│   └── demo-02-workshop-to-plan.md
├── exercises/               ← YOUR exercise prompts (copy-paste these!)
│   ├── exercise-01-build-your-briefing.md
│   └── exercise-02-pick-your-scenario.md
├── pre-work/                ← Setup instructions (you did this before the session)
│   ├── setup-guide.md
│   └── verify-checklist.md
└── reference/               ← Keep these — useful after the session
    ├── cheat-sheet.md          Quick reference for commands and workflows
    ├── after-session-resources.md   Links for deep dives and self-study
    └── troubleshooting.md      Common issues and fixes
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

---

## I'm stuck

- **During the session:** Raise your hand or ask in the Teams chat
- **After the session:** Check `v2/reference/troubleshooting.md` or ask in the Teams channel
- **General CLI help:** https://docs.github.com/en/copilot/how-tos/copilot-cli
