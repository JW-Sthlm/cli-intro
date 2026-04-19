# Copilot CLI — Cheat Sheet

> Print this or keep it open during the session

---

## Slash Commands (the essentials)

| Command | What it does |
|---------|-------------|
| `/help` | Show all available commands |
| `/env` | See connected MCP servers, skills, and agents |
| `/model` | Switch AI model (different brains for different tasks) |
| `/plan` | Create a structured plan before executing |
| `/research` | Deep investigation with web search and citations |
| `/skills` | Browse available skills (Azure, content, etc.) |
| `/diff` | Review changes made in current directory |
| `/share` | Export session to markdown or HTML |
| `/compact` | Summarize history to free up context space |
| `/clear` | Start fresh — new session |
| `/exit` | Leave Copilot CLI |

---

## Referencing Things

| Syntax | What it does | Example |
|--------|-------------|---------|
| `@filename` | Point at a file | `@README.md summarize this` |
| `#number` | Reference GitHub issue or PR | `#42 what is this about?` |
| `!command` | Run a shell command | `!dir` |

---

## PMX Commands (Partner Management)

These work because of the PMX MCP server. Just type naturally:

| What you want | Example prompt |
|--------------|---------------|
| My projects | `Show me my active PMX projects` |
| Missing outcomes | `Which projects are missing outcomes?` |
| Partner team | `Who is the PDM for [partner]?` |
| Link an outcome | `Link MSX opportunity X to project Y` |
| Project details | `Tell me about project [name]` |
| Deliverables | `What deliverables are due this month?` |
| Tasks | `Show my open tasks` |

---

## MSX Commands (Opportunities)

| What you want | Example prompt |
|--------------|---------------|
| Search opportunities | `Search MSX for [keyword] in EMEA` |
| Partner opportunities | `Show open opportunities for [partner]` |
| Opportunity details | `Tell me about opportunity [number]` |

---

## M365 Commands (Mail, Calendar, Teams)

| What you want | Example prompt |
|--------------|---------------|
| Today's meetings | `What meetings do I have today?` |
| Search email | `Find emails from [person] about [topic]` |
| Draft email | `Draft an email to [person] about [topic]` |
| Teams messages | `Show recent messages in [chat/channel]` |
| Send a message | `Send a Teams message to [person] saying [text]` |

---

## Screenshots

1. Take a screenshot: `Win+Shift+S` or `PrtSc`
2. Ask Copilot about it:

```
Look at my last screenshot and summarize what you see
```

---

## Pro Tips

- **Be specific.** "Show me projects for Contoso" works better than "show me projects"
- **Follow up.** Copilot remembers context — say "tell me more about the second one"
- **Rephrase if stuck.** There's no magic syntax. Try different words.
- **Use /plan for complex tasks.** It creates a structured plan you can review before execution.
- **Save good prompts.** If something works well, write it down for next time.

---

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Shift+Tab` | Cycle through modes (suggest → autopilot) |
| `Ctrl+C` | Cancel current action |
| `Ctrl+C` × 2 | Exit |
| `Ctrl+L` | Clear screen |
| `Ctrl+S` | Run command, keep your input |
