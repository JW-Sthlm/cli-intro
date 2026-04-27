# Copilot CLI — Cheat Sheet (v2)

> For partner-facing roles. Print this or keep it open during and after the session.

---

## The #1 Rule

**Just talk to it.** You don't need to memorize commands or syntax. Type what you want in plain English:

- `Help me prepare for my meeting with Contoso`
- `What went wrong with that last command?`
- `How do I add a new MCP server?`
- `Explain what you just did`

The prompts and commands below are useful shortcuts — but natural language always works. If you're stuck, ask: `/ask How do I...`

---

## The Copilot Ladder

| Layer | What it does | When to use it |
|-------|-------------|---------------|
| **M365 Copilot** | Helps with individual tasks | Draft an email, summarize a meeting, find a file |
| **Copilot CLI** | Operationalizes workflows | Multi-step, multi-source, repeatable partner work |
| **Agency** | Microsoft integration layer | Internal auth, shared plugins, telemetry, governance |
| **Squad** | Multi-agent coordination | Long-running, role-divided, memory-heavy initiatives |

---

## The Kitchen Analogy

Think of your CLI setup like a kitchen:

| Piece | Kitchen | CLI |
|-------|---------|-----|
| **Instructions** | House rules — "veggies go on the left" | Rules that shape every output automatically. Write once, always active. |
| **Prompts** | Saved recipes you pull out by name | Reusable workflows: `/prompt partner-briefing` |
| **Skills** | Training that kicks in — like tempering chocolate when the order comes | Expertise that activates on its own when it detects a relevant topic |
| **MCP Servers** | Kitchen equipment everyone shares | Live connectors to PMX, MSX, M365, GitHub — real data |
| **Copilot** | Head chef who uses all of the above | The AI that ties instructions, prompts, skills, and tools together |

You don't need to understand every piece on day one. Start with Copilot + MCP servers (the chef and the equipment). Instructions, prompts, and skills come naturally as you get comfortable.

---

## Essential Commands

| Command | What it does |
|---------|-------------|
| `/env` | See connected tools (MCP servers, skills, agents) |
| `/model` | Switch AI model |
| `/plan` | Create a structured plan before executing |
| `/research` | Deep investigation with web search + citations |
| `/resume` | Pick up a previous session with full context |
| `/compact` | Summarize conversation to free up context |
| `/skills` | Browse available skills |
| `/share` | Export session to markdown or HTML |
| `/diff` | Review changes in current directory |
| `/help` | Show all commands |

---

## Referencing Things

The `@` symbol is how you point Copilot CLI at files. It reads the file and uses it as context for your conversation. You can reference files, folders, or even images.

| Syntax | What it does | Example |
|--------|-------------|---------|
| `@file` | Point at a single file | `@notes.txt analyze these workshop notes` |
| `@folder/` | Point at all files in a folder | `@project/ give me an overview` |
| `@file1 @file2` | Point at multiple files | `@books.py @utils.py how do these work together?` |
| `#number` | Reference a GitHub issue or PR | `#42 what is this about?` |
| `!command` | Run a shell command | `!dir` |

💡 **Tip:** You don't need to use `@` for everything. If you're just asking a question or working with data from MCP tools (like PMX), plain language works fine. Use `@` when you have a specific file you want Copilot to read.

---

## Partner Briefing Workflow (Reusable Pattern)

```
I'm preparing for a meeting with [Partner Name]. Build a structured briefing:
1. Pull our active PMX projects — status, outcomes, deliverables at risk
2. Show the partner team — PDM, PTS, PSAM
3. Search MSX for open opportunities
4. Check my recent emails about this partner
Synthesize into: overview, project health, outcome gaps, pipeline, talking points, next steps.
```

---

## Workshop → Action Plan Workflow

```
@notes.txt Turn these notes into a structured action plan:
executive summary, phased approach, task breakdown with owners,
open questions, risks, and next steps.
```

---

## PMX Quick Commands

| What you want | Prompt |
|--------------|--------|
| My projects | `Show me my active PMX projects` |
| Missing outcomes | `Which of my projects are missing outcomes?` |
| Partner team | `Who is the PDM for [partner]?` |
| Deliverables | `What deliverables are due this month?` |
| Link outcome | `Link MSX opportunity X to project Y` |

## MSX Quick Commands

| What you want | Prompt |
|--------------|--------|
| Search opportunities | `Search MSX for [keyword] in EMEA` |
| Partner pipeline | `Show open opportunities for [partner]` |

## M365 Quick Commands

| What you want | Prompt |
|--------------|--------|
| Today's meetings | `What meetings do I have today?` |
| Search email | `Find emails from [person] about [topic]` |
| Draft email | `Draft an email to [person] about [topic]` |
| Teams messages | `Show recent messages in [chat/channel]` |

---

## Four Properties That Make CLI Different

| Property | What it means |
|----------|--------------|
| **Tool-connected** | Calls PMX, MSX, M365, GitHub — real data, not guesses |
| **Repeatable** | Same workflow, different partner — reusable patterns |
| **Inspectable** | Output is an artifact (file, plan, doc) not a chat bubble |
| **Persistent** | `/resume` continues where you left off — across days |

---

## Self-Study Resources

- **Beginner course (2h):** https://jamesmontemagno.github.io/copilot-cli-for-beginners/
- **Course repo:** https://github.com/github/copilot-cli-for-beginners
- **Official docs:** https://docs.github.com/en/copilot/how-tos/copilot-cli
- **Internal portal:** https://copilot.github.microsoft.com/
- **AI Guidance:** https://eng.ms/docs/initiatives/ai-guidance-for-microsoft-developers/governance/github-copilot-guidelines

---

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Shift+Tab` | Cycle modes (suggest → autopilot) |
| `Ctrl+C` | Cancel current action |
| `Ctrl+C` × 2 | Exit |
| `Ctrl+L` | Clear screen |
| `P` | Open presenter view (in slide deck) |

---

## See also

- 📖 [Getting Started](../GETTING-STARTED.md) — what is this repo, what is Git, jargon decoder
- 📚 [After-Session Resources](after-session-resources.md) — beginner course, docs, internal links
- 🔧 [Troubleshooting](troubleshooting.md) — common issues and fixes
