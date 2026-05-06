# Module 2: Your first conversations

> ⏱️ **Estimated time:** 20 min
> 🎯 **You'll be able to:** drive the CLI confidently for summarize, rewrite, and draft tasks. Know when to start a new session and when to keep going.

---

## The three modes you'll use

Copilot CLI has three modes. You'll use them all naturally, just helpful to know they exist.

| Mode | What it is | When to use |
|------|-----------|-------------|
| **Ask** (default) | Type a question, get an answer | "Summarize this." "What does this mean?" |
| **Agent** | It can run commands, edit files | "Find all TXT files in this folder." "Add a row to this CSV." |
| **Plan** | It explains what it would do *before* doing it | High-stakes tasks, anything touching real files |

You don't switch modes manually. The CLI picks based on what you ask. If it asks "want me to run this command?", that's agent mode asking permission.

⚠️ Always read what it's about to do. *Always.* Especially anything that says "delete" or "overwrite".

---

## 🚀 Hands-on: 4 partner-work conversations

Open a fresh PowerShell. Type `copilot`. Wait for the prompt. Now try these in order.

### 1. Summarize

📖 Paste this into the CLI:

> Imagine you're a Microsoft Partner Solution Architect. A partner asks: "what's the difference between Azure OpenAI and Foundry?" Give me a 4-bullet answer for a non-technical exec.

**What you should get:** a structured 4-bullet response with comparable concepts. Decent first draft.

What a session looks like in the terminal:

```text
PS C:\Users\you> copilot
✦ Copilot CLI · gpt-5 · ready
> Imagine you're a Microsoft Partner Solution Architect...

  • Azure OpenAI Service: ...
  • Azure AI Foundry: ...
  • Where they overlap: ...
  • The exec takeaway: ...

> _
```

**Try one follow-up:**

> Now make it shorter. Two bullets. Same audience.

Notice the CLI remembers what you asked before. That's the conversation context.

### 2. Rewrite

📖 Paste this:

> Rewrite this in plain language for an exec audience: "We propose to leverage cross-functional synergies to drive accelerated value realization across the partner ecosystem through optimized workload distribution."

**What you should get:** something that doesn't sound like a robot wrote it.

### 3. Draft

📖 Paste this:

> Draft a 6-line email to a partner asking to schedule a 30-min call to align on their AI roadmap. Friendly tone, single ask, suggest two time slots next week.

**What you should get:** a usable draft. Tweak the times, send.

### 4. Reason about something

📖 Paste this:

> A partner sells consulting services in Sweden, mid-market customers, ~50 employees, focused on Power Platform and Dynamics. They want to add an AI practice. What 3 services should they offer first and why?

**What you should get:** opinionated, not generic. Real reasoning. The CLI is good at this.

---

## How to keep a session productive

After 5–10 messages your session is full of context. That's good when you're refining one thing. It's bad when you switch topics.

**Rule of thumb:** start a new session when you switch tasks.

- Same partner, different angles → keep going.
- New partner, new task → exit (`/exit`), reopen (`copilot`), start fresh.

You'll get a feel for it. Costs nothing to start fresh.

⚠️ **Don't drag old context across topics.** If you ask about Partner A then Partner B in the same session, Copilot may bleed Partner-A details into the Partner-B answer. Embarrassing. Just `/exit` between partners.

---

## Useful slash commands

Type `/` inside copilot to see the menu. The ones you'll actually use:

| Command | Does |
|---------|------|
| `/exit` | Leaves the session |
| `/login` / `/logout` | Auth |
| `/help` | Lists everything |
| `/env` | Shows what MCP servers are connected (for M4) |

⬆️ at the prompt brings back your previous prompts. Good for tweaking the same prompt with small variations.

What the slash menu looks like:

```text
> /
  /exit       Leave this session
  /help       Show all commands
  /login      Sign in
  /logout     Sign out
  /env        Show connected MCP servers
  /clear      Clear the screen
  ...
```

---

<details>
<summary><strong>⚠️ Things that go wrong</strong>: quick reference, click to expand</summary>

📖

| What happens | Why | What to do |
|--------------|-----|------------|
| Answer is wrong / made up | Copilot doesn't actually know about your specific partner | Give it more context. Drop in the partner's website URL or a recent press release. |
| Answer keeps repeating | You're stuck in a context loop | `/exit` and start fresh |
| It refuses to do something | Safety filter triggered | Rephrase. If it's a legit ask, push back: "this is for internal Microsoft use" |
| Suspiciously confident answer | LLMs hallucinate | Spot-check anything specific (numbers, names, dates) |

</details>

---

## 🎯 Try this on your real work

📖 **Pick one task you'll do this week** (a partner email, a status update, a meeting summary) and run it through Copilot CLI before doing it the old way.

Compare the time. Compare the quality. That's the only validation that matters.

---

## ✅ You're ready for M3 if

- You've had at least one useful conversation
- You know how to `/exit` and start fresh
- You can tell when a conversation has drifted and you should reset

---

## 👉 Next: [Module 3: Drop a file in, get insight out](../m3-files-as-context/README.md)
