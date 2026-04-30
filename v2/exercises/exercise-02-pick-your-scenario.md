# Exercise 2 — Pick Your Scenario

> **Duration:** ~8 min  
> **Format:** Self-paced — pick the scenario closest to your real work  
> **Goal:** Apply CLI to a partner workflow that matters to you

> ⚠️ **These exercises are read-only.** All prompts pull and analyze data — nothing creates, updates, or deletes records in PMX, MSX, or any other system. "Draft" prompts generate text for you to review — they don't send anything.

💡 **Remember:** These prompts are starting points. Rephrase them, shorten them, combine them — whatever feels natural. If you're not sure what to type, just describe what you want in plain English. There's no wrong way to talk to CLI.

---

Pick **one** scenario. Each one builds on what you saw in the demos. The prompts are ready to copy-paste — adjust the partner/project names to your own.

---

## Scenario A: Workshop Notes → Action Plan

*Best for: PSA, PTS, PSS, practice leads — anyone who runs discovery calls or workshops*

**Step 1:** Create a file with rough notes (or use these example notes):

```
Quick notes from call with Northwind Traders:
- They want to modernize their analytics — currently using on-prem SQL + Excel
- Interested in Fabric but worried about data governance
- 3 data engineers, no Fabric experience
- Timeline: want a proof of concept in 6 weeks
- Budget: unclear, need to discuss internally
- Key contact: Sara (CTO), skeptical but open
- Risk: their IT team may resist cloud migration
- Opportunity: could expand to AI/ML workloads after analytics
```

Save as `notes.txt`, then:

```
@notes.txt Turn these workshop notes into a structured action plan with: executive summary, phased approach, task breakdown with owners, open questions, risks, and next steps.
```

**Step 2:** Iterate:

```
Add a section on which Azure services are needed for Phase 1, and estimate monthly cost.
```

---

## Scenario B: Opportunity Gap Analysis

*Best for: PTS, PDM, Partner GTM — anyone tracking partner pipeline*

**Step 1:**

```
Show me all my PMX projects and their linked MSX opportunities. For each project, tell me: is there a linked opportunity? If not, search MSX for a matching one.
```

**Step 2:**

```
Which of my projects have the weakest outcome coverage? Prioritize them by impact — which gaps should I fix first?
```

**Step 3:**

```
Draft a summary of the gaps I should address this week, formatted as a status update I could share with my manager.
```

---

## Scenario C: Multi-Source Partner Email

*Best for: PDM, Partner GTM, PSA — anyone who writes partner-facing comms*

**Step 1:**

```
I need to write a follow-up email to [Partner Name]. Before drafting, gather context:
1. Our active PMX projects and their status
2. Any recent emails in the thread with this partner
3. Open MSX opportunities

Then draft a professional but warm follow-up that references our active work, acknowledges recent discussions, and proposes a concrete next step.
```

**Step 2:** Refine:

```
Make the tone more direct. Add a specific ask for a meeting next week.
```

---

## Scenario D: Research → Partner Roadmap

*Best for: PSA, PTS, partner solution leads — strategic and technical conversations*

**Step 1:**

```
/research What are the top AI workloads that ISV partners in EMEA are building on Azure in 2026? Focus on document intelligence, AI agents, and data platform modernization.
```

**Step 2:**

```
Now search MSX for open opportunities in EMEA related to AI or data modernization. Cross-reference with the research — where are the gaps we should be pursuing?
```

**Step 3:**

```
Based on the research and pipeline data, draft a suggested technology roadmap for a partner looking to build AI solutions on Azure. Include: recommended services, skills needed, and 3 concrete project ideas with estimated effort.
```

---

## Tips

- **Just talk to it.** No special syntax needed. "Show me my projects that are behind schedule" works just as well as a carefully crafted prompt.
- **Ask it to explain itself.** "Why did you pick those?" or "What tools did you just use?" — CLI will tell you.
- **Use `/ask` for side questions.** Wondering how something works? `/ask What is an MCP server?` gives you an answer without losing your conversation context.
- **Follow up naturally.** "Tell me more about the second one" or "Make it shorter" both work.
- **If something doesn't work**, try rephrasing — or just ask: "That didn't work. What went wrong?"

## Finished Early?

Try a second scenario. Or experiment with your own idea — what's a real workflow you do every week that involves multiple tools or data sources?

---

## Reflect

After the exercise, think about:
- Could this workflow become a repeatable pattern for your team?
- Where is the delta vs what M365 Copilot already does for you?
- What would you need to standardize this as a team workflow?

---

## What's next?

📋 **Keep the [Cheat Sheet](../reference/cheat-sheet.md)** — it has the reusable workflow prompts and all key commands

📚 **Go deeper:** Check [After-Session Resources](../reference/after-session-resources.md) for the self-paced beginner course, docs, and internal links

🔧 **Something not working?** See [Troubleshooting](../reference/troubleshooting.md)
