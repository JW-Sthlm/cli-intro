# Exercise 1B — Build Your Partner Briefing in Cowork

> Start here. This is a parallel version of Exercise 1, executed in M365 Copilot Cowork instead of the CLI. No terminal needed.
>
> **Session ownership:** This exercise may be lifted out and run as part of a dedicated Cowork session by a separate facilitator. It is intentionally self-contained — no dependency on Exercise 1 or the CLI setup beyond the same goal (a partner briefing in your own voice).
>
> **Status:** Draft. May be replaced or extended by a colleague-led Cowork enablement track.

> **Duration:** ~15 min  
> **Format:** Guided prompts → side-by-side reflection  
> **Goal:** Build a real partner briefing using M365 Copilot Cowork

> ⚠️ **This exercise is read-only.** The prompts below ask Cowork to pull and summarize context. They should not create, update, or delete records. Review anything before you copy it into an email, meeting note, or partner-facing document.

💡 **Remember:** You do not need special syntax. Write like you would ask a colleague for help. Replace `[Partner Name]` with a real partner you are working with.

---

## Why this exercise exists

M365 Copilot Cowork is M365 Copilot with multi-step workflows and tool integrations. For partner-facing roles, it is often the most natural starting point if you are not yet comfortable with a terminal. You stay inside the Microsoft 365 experience, ask in plain language, and let Copilot pull together the context it can reach.

The CLI version of this exercise and this Cowork version produce **the same business artifact**: a partner briefing for an upcoming meeting. Doing both makes the trade-off visible. Cowork is familiar and fast for Microsoft 365 context. CLI can go deeper when the work needs more tool access, repeatability, and files you can keep editing.

---

## What you'll build

You will build a partner briefing for an upcoming meeting.

Your briefing should include:

- Project status
- Recent activity
- Talking points
- Open questions

This is the same outcome as Exercise 1. The difference is the tool you use to get there.

---

## Prerequisites

- M365 Copilot license — you have one
- Cowork enabled in your tenant — likely already on
- A real partner you have email, calendar, or Teams context for
- A partner meeting coming up in the next 1–2 weeks

> Pick a real partner, not a test case. The exercise works best when Cowork has recent emails, meetings, or chats to summarize.

---

## Part 1 — Pull the context (5 min)

Open M365 Copilot Cowork in Edge or Teams.

Copy this prompt and replace `[Partner Name]`.

```
Pull together everything from my recent emails, calendar, and Teams chats about [Partner Name] over the last 30 days. Group by theme.
```

If the answer is too broad, refine it in plain English. For example:

```
Focus only on the last two weeks and include named contacts if you can find them.
```

```
Look specifically for mentions of project status, blockers, open questions, and next meetings.
```

```
If you find project IDs or opportunity names, list them separately so I can verify them.
```

**What you should see:** A grouped summary of recent Microsoft 365 context about the partner.

> If the first answer is messy, that is normal. Cowork usually improves quickly when you ask it to narrow the date range, focus on specific people, or reorganize the answer.

---

## Part 2 — Structure the briefing (5 min)

Now turn the context into a briefing.

Copy this prompt to turn the raw context into a briefing.

```
Turn this into a partner briefing for my meeting next week.

Use these sections:
- Project status
- What's happened recently
- Three talking points
- Open questions for the partner

Keep it concise and practical. Write it in my voice, as something I could use to prepare for the meeting.
```

Then iterate. Cowork is good at simple follow-ups like:

```
Make this more concise. Keep only what I need before the meeting.
```

```
Drop the background section and focus on actions.
```

```
Rewrite this in second person, as if I am briefing a colleague who will join the meeting.
```

```
Add a short opening paragraph I can paste into a meeting prep email.
```

**What you should see:** A usable partner briefing that you can review, edit, and bring into your meeting prep.

---

## Part 3 — Compare to CLI (5 min, optional but valuable)

**🔧 Going deeper (optional)** — Optional comparison for people who want to understand the tool boundary.

If you are also doing Exercise 1 with CLI, run the same partner briefing there.

Use the same partner. Ask for the same outcome. Then compare the outputs side by side.

**Reflection question — Yuriy's challenge:**

> What did the CLI version get that Cowork could not? What did Cowork do better? Where is the seam?

Use these prompts if helpful:

```
Compare this Cowork briefing with the CLI briefing. What is different in the sources, structure, and level of detail?
```

```
Which version would I use before a real partner meeting, and what would I still need to verify manually?
```

> This is not about picking a winner. It is about learning which tool fits which job.

---

## Closing reflection

Write 2–3 lines for yourself.

| Question | My notes |
|---|---|
| Which approach feels more natural for me right now? |  |
| What's the one thing the other approach could give me that this one can't? |  |
| Will I keep using Cowork, switch to CLI, or use both for different jobs? |  |

---

## When this exercise might NOT be enough

**🔧 Going deeper (optional)** — Read this if you want to know when CLI becomes worth the extra setup.

Cowork is a strong starting point when the work lives in Microsoft 365. There are moments where the natural next step is CLI.

- **Partner data lives outside Microsoft 365.** For example, PMX data in D365 is not something Cowork can normally reach directly. CLI can use the PMX MCP tools to pull that context when you have access.
- **You need to repeat the workflow on 10 partners.** Cowork is good for one conversation. CLI is better when you want a repeatable pattern you can run again and again.
- **You want a structured file, not just a chat answer.** Cowork can help draft the briefing. CLI can create a persistent file on disk that you can edit, version, reuse, or share as an artifact.
- **You need to see exactly which tools were used.** CLI is more inspectable. It can show the steps, files, commands, and connected tools involved in the work.

That is the natural moment to graduate to CLI. Not because Cowork is weaker. Because the job has moved from “help me prepare” to “help me run a repeatable workflow across systems.”

---

## What you just did

- ✅ Used Cowork to gather recent Microsoft 365 context
- ✅ Turned that context into a structured partner briefing
- ✅ Practiced refining the result in plain language
- ✅ Compared Cowork and CLI as two ways to produce the same business artifact

---

## Resources

- ➡️ Main exercise: [Exercise 1 — CLI version](exercise-01-build-your-briefing.md)
- 📚 Cowork docs: [TODO: official Cowork enablement guide]
- 🧭 Setup Clinic: [TODO: link to the next Setup Clinic session]
- 📋 Need a command reference if you try CLI next? Open the [Cheat Sheet](../reference/cheat-sheet.md)
- 🔧 Something broken in CLI setup? Check [Troubleshooting](../reference/troubleshooting.md)
