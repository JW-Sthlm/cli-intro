# Exercise 1 — Build Your Own Partner Briefing

> **Duration:** ~8 min  
> **Format:** Guided start → self-paced exploration  
> **Goal:** Everyone builds a real partner briefing using their own data

> ⚠️ **These exercises are read-only.** All prompts below pull and analyze data — nothing creates, updates, or deletes records in PMX, MSX, or any other system. If CLI ever proposes to create or modify something, review before confirming.

💡 **Remember:** The prompts below are starting points. You can rephrase, simplify, or ask follow-ups in your own words. Copilot CLI understands natural language — just talk to it like a colleague.

---

## Before You Start

Make sure Copilot CLI is running and your MCP servers are connected. If unsure, just ask:

```
Am I connected to PMX? What tools do I have available?
```

---

## Part A: Guided — Build the Briefing (4 min)

Pick a partner you have active work with. Copy-paste this prompt, replacing `[Partner Name]`:

```
I'm preparing for a meeting with [Partner Name]. Build me a structured partner briefing:

1. Pull our active PMX projects — show status, outcomes, deliverables at risk
2. Show the partner team — who is PDM, PTS, PSAM
3. Search MSX for open opportunities with this partner
4. Check my recent emails about this partner

Then synthesize into a briefing with:
- Partner overview and team
- Project portfolio health
- Outcome coverage (what's linked, what's missing)
- Pipeline summary
- Recommended talking points
- Suggested next steps
```

**What you should see:** A structured briefing pulling live data from PMX, MSX, and M365.

> **Not working?** 
> - PMX errors → re-run `az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47` in a separate PowerShell
> - "No projects found" → try a different partner, or ask `Show me my active PMX projects` first to find one

---

## Part B: Explore (4 min)

Try any of these follow-ups:

**Go deeper on gaps:**
```
Which of my projects with [Partner Name] are missing MSX opportunity links? Can you find matching opportunities?
```

**Draft a prep email:**
```
Draft a short prep email to the PDM with the key talking points from this briefing.
```

**Compare two partners:**
```
Now do the same briefing for [Other Partner]. How do they compare in terms of project health and pipeline?
```

**Ask about the workflow:**
```
If I wanted to reuse this briefing pattern every week for different partners, how would I set that up as a repeatable workflow?
```

---

## What You Just Did

- ✅ Connected multiple data sources in one conversation (PMX + MSX + M365)
- ✅ Produced a structured artifact, not just an answer
- ✅ Used real, live data — not a simulation
- ✅ Built something you could actually send to your team

**This is the delta:** M365 Copilot can summarize one email or one meeting. CLI pulled from three systems and synthesized a structured briefing. That's the operational difference.

---

## What's next?

➡️ Continue to [Exercise 2: Pick Your Scenario](exercise-02-pick-your-scenario.md) when the facilitator moves on

📋 Need a command reference? Open the [Cheat Sheet](../reference/cheat-sheet.md)

🔧 Something broken? Check [Troubleshooting](../reference/troubleshooting.md)
