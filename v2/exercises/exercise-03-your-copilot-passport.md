# Exercise 3 — Your Copilot Passport

> **Duration:** ~5 min  
> **Format:** Run one thing. Look at the result. Take a screenshot.  
> **Goal:** See everything you've just built, in one place.

---

💡 **This is the victory lap.** You've installed plugins. Added custom instructions. Maybe spun up an agent. Now let's look at the whole setup in one view.

---

## What you're about to do

Install a small add-on that gives Copilot CLI a new skill — generating a **personal HTML dashboard** of your environment. One file. Opens in your browser. Shows every agent, skill, plugin, MCP server, and project CLI can see.

Think of it as your Copilot passport.

---

## Step 1 — Install (30 seconds)

Open PowerShell (outside CLI) and paste:

```powershell
iwr -useb https://raw.githubusercontent.com/JW-Sthlm/copilot-overview/main/install.ps1 | iex
```

Done. The script drops two folders into your `~\.copilot\` directory and cleans up.

> **Installer blocked by corp policy?** See [extras/copilot-overview/README.md](../extras/copilot-overview/README.md) for the manual install (two `Copy-Item` commands).

---

## Step 2 — Reload CLI

If CLI is already open, type:

```
/reload
```

If it isn't, just start it: `copilot`

---

## Step 3 — Generate your overview

Type this in CLI:

```
Generate my Copilot overview
```

That's the whole prompt. No flags, no syntax. CLI will:
1. Scan your environment
2. Build an HTML file
3. Open it in your browser

---

## Step 4 — Look at it

Scroll through. Notice:

- **Your custom instructions** — that `copilot-instructions.md` you wrote earlier? It's the first thing CLI reads every session.
- **Agents** — the helpers you can summon by name.
- **Skills** — workflows that activate from keywords in your prompts.
- **MCP servers** — the external tools CLI is wired to (PMX, GitHub, M365, etc.).
- **Projects** — every repo under `~\projects\` and what Copilot config each one has.

The section at the top — M365 Copilot → GitHub Copilot → CLI → Agency → Squad — is the mental model. Same for everyone. It's there to help you explain the stack to others.

---

## Step 5 — Take a screenshot

Seriously. Save it somewhere. This is your **starting kit** — the setup you walked out of the workshop with. Six months from now you'll have forgotten what you had on day one.

---

## What just happened (under the hood)

You used **two things** working together:

1. **An extension** — local JavaScript that added a new tool to CLI (the thing that scans your config).
2. **A skill** — a markdown file that told CLI how to use that tool and generate the HTML.

That's it. That's the whole pattern for extending Copilot CLI. Every plugin you've seen today follows the same recipe.

You now know enough to build your own.

---

## If it looks empty

That's fine. You've done the intro session and not much else. Run the overview again next month, after you've installed a couple more plugins or added your first custom agent. Watch it fill up.

---

## Next

- **Share it** — screenshot your overview, send it to a teammate, ask them what's on theirs
- **Extend it** — the source is public at [github.com/JW-Sthlm/copilot-overview](https://github.com/JW-Sthlm/copilot-overview). Read the extension code if you're curious. Ignore it if you're not.
- **Keep the [cheat sheet](../reference/cheat-sheet.md) handy** and check [after-session resources](../reference/after-session-resources.md) for what to learn next.
