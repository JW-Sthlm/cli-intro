# Demo 01 — The Basics

> **Duration:** ~5 min  
> **Goal:** Show that Copilot CLI understands natural language, has useful slash commands, and can work with your screen

---

## Setup

- Have Copilot CLI running in PowerShell
- Have your calendar and email accessible (M365 MCP configured)

---

## Script

### 1. Natural language — just talk to it

**Type:**

```
What meetings do I have today?
```

**Talking point:** No special syntax. No query language. Just ask in plain English. It uses your M365 connection to check your actual calendar.

---

### 2. Slash commands — quick actions

**Type:**

```
/help
```

**Talking point:** Slash commands are shortcuts for common actions. Point out a few:
- `/model` — switch AI models
- `/env` — see what's connected
- `/plan` — think before doing
- `/research` — deep investigation mode

**Type:**

```
/model
```

**Talking point:** You can pick different AI models depending on the task. Like choosing the right tool from a toolbox.

---

### 3. @ mentions — point it at files

**Type:**

```
@README.md summarize this file
```

> Navigate to a folder with a README first, or use any text file.

**Talking point:** The `@` symbol lets you point Copilot at specific files. It reads them and works with the content.

---

### 4. # references — GitHub issues and PRs

**Type:**

```
#1 what is this issue about?
```

> Use any issue number from a repo you have access to.

**Talking point:** `#` connects to GitHub. You can reference issues, pull requests — anything in your repos.

---

### 5. Screenshot — what's on your screen

**Show something on screen** (a PMX dashboard, an email, a webpage — anything visual).

**Type:**

```
Look at my last screenshot and tell me what you see
```

> Take a screenshot first (Win+Shift+S or PrtSc), then ask.

**Talking point:** Copilot can analyze screenshots. Useful for: "What does this error mean?", "Summarize this dashboard", "Draft a response to this email I'm looking at."

---

## Key Messages

- You don't need to learn a programming language — it speaks yours
- Slash commands = shortcuts, not requirements
- It connects to your actual tools (calendar, email, files, GitHub)
- Screenshots make it visual — show it what you see
