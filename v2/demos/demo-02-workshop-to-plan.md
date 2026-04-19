# Demo 2 — From Workshop Notes to Action Plan

> **Duration:** ~10 min  
> **Goal:** Show how CLI bridges the gap between "good conversation" and "structured next step"  
> **Core message:** CLI doesn't just summarize — it decomposes, structures, and produces a persistent, inspectable plan you can hand off and iterate on.

---

## Why This Demo Matters

**The universal problem:** A discovery call, workshop, or brainstorm produces great ideas and energy — then stalls. Notes live in a OneNote nobody re-opens. Action items scatter across memories. The momentum dies between "we agreed" and "someone acts."

**What M365 Copilot can do:** Summarize the meeting. Extract action items. Produce a decent first draft of a recap email. One-off, flat, hard to decompose further.

**What CLI does differently:** Takes raw input → decomposes into a structured plan with phases, tasks, dependencies, risks, owners → saves it as a persistent artifact → supports iteration across sessions → the plan becomes a living document, not a recap.

---

## Setup

- Copilot CLI running
- A fabricated but realistic set of "workshop notes" (below)
- Optionally: a real meeting transcript or notes from your own work

### Workshop Notes (paste these into a file before the demo)

Create `workshop-notes.txt` in your working directory:

```
Discovery Workshop — Contoso Nordic (ISV Partner)
Date: 2026-04-15
Attendees: Johan (PSA), Maria (PTS), Erik (Contoso CTO), Anna (Contoso PM)

Context: Contoso has a SaaS platform for logistics. They want to add AI capabilities. 
Current stack: .NET backend, Azure SQL, deployed on App Service.
They explored Azure OpenAI briefly but hit rate limits and cost concerns.

Key findings:
- They have 200+ enterprise customers, mostly in Nordics
- Their main ask: intelligent document processing for shipping docs (invoices, customs forms, bills of lading)
- Secondary ask: predictive demand forecasting for their customers
- They want a "Copilot-like" experience inside their app
- Erik is skeptical about cost at scale — needs TCO model
- Anna wants a phased approach — MVP in 3 months, full in 6
- They have 4 developers, no ML/AI expertise
- Currently no Azure AI services in use
- They already have data in Azure SQL that could feed models
- Maria flagged: this could be a great co-sell opportunity — fits the "AI Business Solutions" sales play
- Need to check: is there an existing Azure doc intelligence sample we can start from?
- Need to check: ISV benefits for Azure AI consumption
- Risk: their App Service plan may be too small for AI workloads
- Risk: Erik may push back if phase 1 cost exceeds 5k EUR/month
```

---

## Script

### Act 1: Set the scene (1 min)

**SAY:** "Every partner-facing role has this experience. Great workshop, great energy, good notes — and then... nothing structured happens. The notes live in OneNote. The action items live in memory. Two weeks later, the partner follows up and you're reconstructing what you agreed. Let me show you how CLI changes this."

---

### Act 2: Feed the context — show @ file reference (2 min)

**Type:**

```
@workshop-notes.txt

These are raw notes from a discovery workshop with an ISV partner. I need to turn this into a structured action plan. But first — analyze the notes and tell me:
1. What are the key opportunities here?
2. What are the risks and blockers?
3. What's missing — what questions should we have asked but didn't?
```

**Talking point:** "The `@` tells CLI to read the file. It doesn't just summarize — it analyzes. Look at the 'what's missing' section. That's the kind of insight that usually takes a week to surface."

---

### Act 3: Generate the structured plan (4 min)

**Type:**

```
Now create a structured action plan from this workshop. Include:
1. Executive summary — 3 sentences max
2. Phased roadmap — Phase 1 (MVP, 3 months) and Phase 2 (full, 6 months)
3. For each phase: deliverables, Azure services needed, effort estimate, key assumptions
4. Task breakdown — concrete tasks with suggested owners (PSA, PTS, Partner)
5. Open questions — things we need to resolve before Phase 1 starts
6. Risks with mitigations
7. Next steps — what happens this week

Make it actionable enough that someone who wasn't in the workshop could pick this up and run with it.
```

**Talking point (while it generates):** "This is the bridge. The raw notes become a plan. Phased. With owners. With risks. With open questions. You could send this to the partner, share it with your team, or put it in PMX."

**DO:** Let the full output render. Give audience time to read the structure — especially the task breakdown and next steps.

---

### Act 4: Show iteration — the plan evolves (2 min)

**Type:**

```
Good. Now add a TCO estimate section for Phase 1. Erik needs to see costs below 5k EUR/month. Use Azure Document Intelligence pricing and Azure OpenAI pricing for a mid-volume scenario (assume 10,000 documents/month, average 3 pages each).
```

**Talking point:** "The plan is a living document. I can add sections, refine estimates, adjust scope — all in the same session. And if I come back tomorrow..."

**Type:**

```
/compact
```

**SAY:** "...I `/resume` and keep going. The plan, the context, the decisions — all preserved."

---

### Act 5: Land the message (1 min)

**SAY:** "What just happened? Raw workshop notes became a phased plan with tasks, owners, risks, and cost estimates — in about 5 minutes. I could refine it, share it, or hand it off. This is the gap CLI fills: between 'we had a great conversation' and 'here's what we're doing.'"

**Optional — show /plan:**

```
/plan Create a PMX project for Contoso Nordic based on this action plan, with the Phase 1 deliverables as project deliverables.
```

**SAY:** "And if you want CLI to think before acting — `/plan` creates a structured plan of what IT will do, so you can review before it executes."

---

## Key Messages to Land

| Message | How to land it |
|---------|---------------|
| **From conversation to action** | "Notes → phased plan in 5 minutes" |
| **Inspectable** | "The plan is an artifact — visible, shareable, reviewable" |
| **Iterable** | "Add a TCO section? Sure. Refine scope? Keep going." |
| **Persistent** | /resume = continue the plan next week |
| **Decomposition** | "Not just summary — tasks, owners, risks, dependencies" |
| **Delta vs M365 Copilot** | "M365 summarizes the meeting. CLI turns it into a living plan." |
| **Handoff-ready** | "Someone who wasn't there can pick this up and run" |
