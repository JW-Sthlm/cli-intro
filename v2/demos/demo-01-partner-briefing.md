# Demo 1 — The Partner Briefing Factory

> **Duration:** ~12 min  
> **Goal:** Show how CLI turns partner prep from scattered tab-hopping into a repeatable, structured workflow  
> **Core message:** This is not an AI answering one question — it's an operational workflow that connects your actual tools, produces an artifact, and can be rerun for any partner.

---

## Why This Demo Matters

**What the audience already does:** Before a Partner Sync or QBR, they open PMX, check projects, open MSX, search opportunities, open Outlook, find recent threads, open Teams, check recent chats, maybe open a SharePoint for last quarter's deck — and then try to assemble it all in their head or a Word doc.

**What M365 Copilot can do:** Summarize one email thread. Summarize one meeting. Draft a generic email. Each is a single ask/answer — disconnected, not structured, not reusable.

**What CLI does differently:** One conversation that pulls from PMX + MSX + M365 + your instructions → produces a structured briefing artifact. Repeatable for the next partner. Inspectable. Persistent.

---

## Setup

- Copilot CLI running with PMX, M365, and GitHub MCP servers
- Pick a real partner you have active projects with
- Have at least one recent email or meeting related to that partner

---

## Script

### Act 1: Set the scene (1 min)

**SAY:** "Imagine you have a Partner Sync tomorrow. You need to know: where do our projects stand, are there outcome gaps, what's in the MSX pipeline, what did we last discuss, and who's on the team. Today, that means opening five tabs and assembling the picture yourself. Let me show you a different approach."

---

### Act 2: Pull the data — show the tools working (5 min)

**Type:**

```
I'm preparing for a Partner Sync with [Partner Name] tomorrow. Help me build a structured briefing. Start by pulling:
1. Our active PMX projects with this partner — status, outcomes, deliverables
2. The partner team — who is PDM, PTS, PSAM
3. Open MSX opportunities with this partner in EMEA
4. My recent emails to or from people at this partner
```

**Talking point (while it works):** "Notice what's happening. It's not guessing — it's calling specific tools. PMX for project data. MSX for the pipeline. M365 for your email. Each tool returns real, current data from your actual systems. M365 Copilot can't do this — it lives inside Office. CLI connects across tools."

**DO:** Point out the tool calls as they happen. The audience should see PMX, MSX, M365 being invoked explicitly.

---

### Act 3: Synthesize — show the artifact (3 min)

**Type:**

```
Now synthesize this into a structured partner briefing with these sections:
1. Partner Overview — team, key contacts
2. Project Portfolio — status, health, any at risk
3. Outcome Coverage — what's linked, what's missing
4. Pipeline — open opportunities, deal sizes, stages
5. Recent Activity — last conversations, open threads
6. Recommended Talking Points — based on everything above
7. Suggested Next Steps — concrete actions with owners

Format it as a clean document I could share with my team.
```

**Talking point:** "This is the key difference. M365 Copilot gives you an answer in a chat bubble. CLI gives you an artifact — structured, sections, shareable. You could paste this into a prep doc, email it to the team, or build on it next week."

**DO:** Let the output render. Give the audience time to read the structure. Point out: talking points are derived from data, not generic.

---

### Act 4: Show repeatability (2 min)

**SAY:** "Now here's why this is a factory, not just a one-off. This exact conversation? I can rerun it for any partner. Change the name, same workflow. And if I save these prompts as a skill or instruction file, my whole team can use the same pattern."

**Type:**

```
Save this conversation workflow. If I wanted to reuse this exact briefing pattern for a different partner next week, what would I need?
```

**Talking point:** "This is what takes CLI from 'useful tool' to 'operational capability.' Instructions files, skills, custom agents — these are how you standardize a workflow across a team. Not everyone needs to learn the prompts. You build the pattern once, everyone uses it."

---

### Act 5: Show persistence (1 min)

**SAY:** "One more thing M365 Copilot can't do."

**Type:**

```
/compact
```

**SAY:** "This summarizes the conversation for later. If I close this and come back tomorrow with `/resume`, all the context is there. The decisions, the data, the briefing — nothing lost. For work that spans multiple days or sessions, this is the game changer."

---

## Key Messages to Land

| Message | How to land it |
|---------|---------------|
| **Tool-connected** | Point at each MCP tool call as it happens |
| **Multi-source synthesis** | "Five tabs → one conversation" |
| **Artifact, not answer** | "A structured document, not a chat bubble" |
| **Repeatable** | "Change the partner name, same workflow" |
| **Team-standardizable** | "Instructions + skills = everyone uses the same pattern" |
| **Persistent** | /resume = context survives across sessions |
| **Delta vs M365 Copilot** | "M365 helps you with one thing at a time. CLI operationalizes the whole workflow." |
