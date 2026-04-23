# Copilot Overview Dashboard — Setup

> A small add-on you install once. It gives Copilot CLI a new skill: **generate a personal HTML dashboard of your setup** — every agent, skill, plugin, MCP server, and project it can see.
>
> Think of it as your **Copilot passport**. A mirror of what you've built.

---

## Why it exists

After the session you'll have:
- A personal `copilot-instructions.md`
- Maybe one or two plugins installed
- Maybe a custom agent
- A couple of MCP servers connected

It's hard to see all of that in one place. The overview does exactly that — one HTML page, opens in your browser, shows the whole picture.

It also doubles as an **example of what CLI can do**: a small extension + a small skill working together to produce a real artifact. Open the source if you're curious. Ignore it if you're not.

---

## Install (30 seconds)

Open PowerShell and run:

```powershell
iwr -useb https://raw.githubusercontent.com/JW-Sthlm/copilot-overview/main/install.ps1 | iex
```

That's it. The script:
1. Clones the repo to a temp folder
2. Copies the extension to `~\.copilot\extensions\copilot-overview\`
3. Copies the skill to `~\.copilot\skills\copilot-overview\`
4. Cleans up after itself

**If you're inside Copilot CLI when you install**, type `/reload` afterwards so it picks up the new tools. Or just restart CLI.

---

## Use it

In Copilot CLI, type:

```
Generate my Copilot overview
```

That's the whole interface. It will:
- Scan your environment
- Produce an HTML file (usually in `~\projects\_output\copilot-overview.html`)
- Open it in your browser

---

## Manual install (if the script fails)

Corporate environments sometimes block `iwr`. Fallback:

```powershell
git clone https://github.com/JW-Sthlm/copilot-overview.git $env:TEMP\copilot-overview
Copy-Item -Recurse "$env:TEMP\copilot-overview\.github\extensions\copilot-overview" "$env:USERPROFILE\.copilot\extensions\"
Copy-Item -Recurse "$env:TEMP\copilot-overview\skills\copilot-overview" "$env:USERPROFILE\.copilot\skills\"
Remove-Item -Recurse -Force "$env:TEMP\copilot-overview"
```

Then `/reload` inside CLI.

---

## Troubleshooting

| Symptom | Fix |
|---------|-----|
| `Skill not found: copilot-overview` | Run `/reload` in CLI, or restart CLI |
| Script can't reach GitHub | Use the manual install above |
| Overview HTML looks empty | You probably haven't installed plugins or agents yet. That's fine — run it again later |
| Browser doesn't open the file | Navigate to `~\projects\_output\copilot-overview.html` and double-click |

---

## What you're looking at

Sections in the dashboard:
- **Your custom instructions** — your `copilot-instructions.md`
- **Agents** — named helpers you can summon (global + plugin-contributed)
- **Skills** — workflows that activate automatically from keywords
- **MCP servers** — external tools CLI can talk to
- **Extensions** — local code that adds new tools (like this one)
- **Plugins** — packaged bundles of the above
- **Projects** — repos under your projects folder and what CLI-specific config they have

The **operating stack** section (top) is the mental model — M365 Copilot → GitHub Copilot → CLI → Agency → Squad. Same for everyone.

---

## Source

[github.com/JW-Sthlm/copilot-overview](https://github.com/JW-Sthlm/copilot-overview)

Public repo. No secrets. MIT-licensed. Feel free to read, fork, improve.
