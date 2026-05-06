# Module 5: Custom AI agents 🔧

> ⏱️ **Estimated time:** 25 min
> 🎯 **You'll be able to:** build a reusable agent that handles a recurring partner task with consistent voice, structure, and context.

---

## Why agents

You've seen by now that you can ask Copilot to draft a partner brief. You probably noticed:

- The first draft is OK, then you edit
- Next time you do the same task, you re-explain the structure
- Two weeks in you're tired of re-typing "use 5 bullets, exec audience, end with one ask"

An **agent** is a saved set of instructions that runs every time you invoke it. Same structure, same voice, same standards, no re-explaining.

Compare:

```
# Without agent, you type this every time
> You are a partner solution architect. Answer in 5 bullets max, exec
> audience, plain language, no buzzwords, end with a single specific ask.
> Now: <actual question>

# With agent, you create the agent once, then:
> /agent partner-briefing
> <actual question>
```

The agent already knows the rules. You just give it the question.

---

<details>
<summary><strong>🔧 "What an agent is, technically"</strong>: anatomy of an agent file, click to expand</summary>

🔧 An agent is a Markdown file with a name and a system prompt. That's the whole abstraction.

Agents live at `~/.copilot/agents/<agent-name>.md` (Windows: `C:\Users\<you>\.copilot\agents\`). The CLI scans this folder on startup and registers anything it finds.

A minimal agent file:

```markdown
---
name: partner-briefing
description: Generates partner pre-call briefings in our standard format.
---

You are a Microsoft Partner Solution Architect helping prepare for partner meetings.

Output rules:
- Maximum 6 bullets
- Plain language, no buzzwords ("synergy", "leverage", "ecosystem", banned)
- Exec audience: assume your reader has 30 seconds
- Always end with one specific question to ask the partner
- If you don't know something, say so. Don't make it up.

Format:
**Background:** 2 bullets on who they are
**Their angle:** 2 bullets on what they care about
**The conversation:** 1 bullet on what to surface
**The ask:** 1 question to leave them with
```

Save that file as `~/.copilot/agents/partner-briefing.md`. Restart copilot. Now `partner-briefing` is a real agent.

</details>

---

## 🚀 Hands-on: build the partner-briefing agent

### Step 1: create the agent folder if it doesn't exist

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.copilot\agents"
```

### Step 2: create the agent file

Open VS Code (or any editor):

```powershell
code "$env:USERPROFILE\.copilot\agents\partner-briefing.md"
```

Paste the agent content from above. Save.

### Step 3: use it

```powershell
copilot
```

Inside copilot:

```text
> /agents

Available agents:
  default            (built-in)
  partner-briefing   ~/.copilot/agents/partner-briefing.md

> /agent partner-briefing
✦ Switched to agent: partner-briefing

> Brief me on Contoso for tomorrow's call. They're a 50-person Power Platform consultancy in Stockholm wanting to add an AI practice.

  Background
  • 50-person consultancy, Stockholm-based, strong Power Platform delivery
  • Customer base skews mid-market enterprise in Nordic financial services

  Their angle
  • AI practice as a margin play, not a cost center
  • Already building on Copilot Studio; want the next layer up

  The conversation
  • Surface Foundry agents + AI Discovery Cards as the on-ramp

  The ask
  • Who on their side owns the AI P&L next year?
```

The agent will reply in your defined format. Every time. Until you change the agent.

---

<details>
<summary><strong>🔧 "When to build an agent"</strong>: decision rules, click to expand</summary>

🔧 Build an agent when:

- You catch yourself repeating the same setup prompt
- You want to enforce a team standard (consistent format across the vTeam)
- You have a task where structure matters more than creativity

**Don't build an agent when:**

- You'll only do the task once
- The task is genuinely creative (let the model be free)
- You're still figuring out what good output looks like (build the prompt first, agent-ify later)

</details>

---

<details>
<summary><strong>📖 "Common partner-work agents"</strong>: what's worth building, click to expand</summary>

📖 / 🔧 Real candidates from our team:

| Agent | What it does |
|-------|-------------|
| `partner-briefing` | Pre-call briefings, fixed format |
| `vteam-update` | Weekly vTeam updates from raw notes |
| `qbr-prep` | QBR talk-track from PMX data |
| `partner-email` | First-draft partner outreach |
| `meeting-summary` | Standard meeting summary format |
| `decision-doc` | One-pager for "should we do X with this partner?" |

You'll see overlap with [`v2/extras/copilot-overview/`](../../../extras/copilot-overview/README.md) and other reusable assets the team is building.

</details>

---

<details>
<summary><strong>🔧 "Bonus: per-project agents"</strong>: agents scoped to a folder, click to expand</summary>

🔧 Agents can also live in a project folder, at `<project>/.copilot/agents/`. Useful when an agent only makes sense in the context of one project.

Example: in your `partner-briefings/` folder, create `.copilot/agents/contoso-specialist.md` with Contoso-specific knowledge. It's only available when you're in that folder.

User-level agents apply everywhere. Project-level agents apply only when you `cd` into the project. Both can coexist.

</details>

---

## 🎯 Real-work pick-up

🔧 Build one agent this week for a recurring task you actually do. Use it for two real partner interactions. If it saved you time, share it with the vTeam in Teams.

If after two uses you're still editing the agent rules, keep iterating. That's the actual work of building good agents.

---

## ✅ You're ready for M6 if

- You've created an agent file and verified it shows up in `/agents`
- You've used it for at least one real (or test) prompt
- You can articulate when an agent is helpful vs when it's overhead

---

## 👉 Next: [Module 6: Skills](../m6-skills/README.md)
