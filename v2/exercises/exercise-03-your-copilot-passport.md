# Exercise 3 — Build your first skill

> **Subtitle:** Your Copilot Passport for day-to-day work  
> **Duration:** 20–25 min  
> **Format:** Talk to Copilot CLI. Let it create the files. Inspect only if you want to.  
> **Goal:** Build a small reusable skill you can take back to your own work.

---

## Why this exercise

Copilot CLI has a few building blocks under the hood: **instructions** describe how you work, **skills** describe reusable workflows, **agents** create scoped helpers, **MCP servers** connect tools, and **plugins** bundle capabilities. The deck slide [What's inside Copilot CLI](../deck/cli-intro-v3.html#cli-building-blocks) is the map.

The fastest way to understand a skill is to build one. You do not need to hand-write JSON or learn a framework. You describe the work you repeat often, ask Copilot CLI to turn it into a skill, then test whether the right prompt triggers the right behavior.

---

## The reference example

Start with the working reference: [copilot-overview-plugin](https://github.com/JW-Sthlm/copilot-overview). Here's a working skill someone in this team built. It generates a personal Copilot environment dashboard. Read its [README](https://github.com/JW-Sthlm/copilot-overview/blob/main/README.md) to see the shape of a skill before you build yours.

Read the README and focus on the pattern: trigger phrase → instructions → useful output.  
🔧 **Going deeper (optional):** Open `plugin.json` and `skills/copilot-overview/SKILL.md` to see how a plugin packages a skill.

---

## What you'll build — pick one

Choose one of these, or bring your own idea.

| Option | What it does | Best fit |
|--------|--------------|----------|
| **Partner briefing skill** | Pulls partner notes from a folder and structures them into a briefing format. | PSAs, PTSs, PDMs |
| **Meeting prep skill** | Given a calendar event, drafts an agenda with context and suggested questions. | Anyone with recurring stakeholder meetings |
| **Status update skill** | Turns recent work into a vTeam, manager, or weekly update. | Leads, managers, workstream owners |

Pick work you already repeat. Small is good. A skill that saves 10 minutes every week is better than an impressive demo you never use again.

---

## Build steps — talk to Copilot

### Step 1 — Study the reference shape

Paste this into Copilot CLI:

```text
Show me the structure of ~/projects/copilot-overview-plugin and explain how a skill works. Keep it simple. I am building my first skill, not coding a product.
```

**Expected outcome:** Copilot explains the main pieces: `plugin.json`, the `skills/` folder, `SKILL.md`, trigger descriptions, and optional reference files.

Ask follow-up questions in plain English: `What parts do I actually need for a simple skill?`  
🔧 **Going deeper (optional):** Ask Copilot to compare the README, INSTALL.md, and SKILL.md so you see the install story versus the runtime behavior.

---

### Step 2 — Scaffold your skill

Replace `<their-skill-name>` with a short folder-style name, for example `partner-briefing`, `meeting-prep`, or `status-update`.

```text
Help me scaffold a new skill called <their-skill-name> in ~/.copilot/skills/. Create the folder and a first SKILL.md. Do not over-engineer it. Ask me only if you need a decision.
```

**Expected outcome:** A new folder appears under `~\.copilot\skills\<their-skill-name>\` with a starter `SKILL.md`.

If Copilot asks what the skill should do, answer like you would brief a colleague.  
🔧 **Going deeper (optional):** Open the generated `SKILL.md` and check whether the trigger description is specific enough.

---

### Step 3 — Write the trigger and instructions

Use one of the prompts below, or adapt it to your own idea.

**Partner briefing example**

```text
Given partner notes stored in a folder, write the SKILL.md trigger description and instructions for a Partner Briefing skill. It should produce: context, current work, risks, suggested meeting questions, and next actions. Keep the output useful for a PSA or PTS.
```

**Meeting prep example**

```text
Given a calendar event and any available related notes, write the SKILL.md trigger description and instructions for a Meeting Prep skill. It should produce: purpose, likely attendees, agenda, context to read first, and questions to ask.
```

**Status update example**

```text
Given recent work notes, commits, emails, or project notes, write the SKILL.md trigger description and instructions for a Status Update skill. It should produce: headline, work completed, blockers, decisions needed, and next week.
```

**Expected outcome:** Copilot updates `SKILL.md` with trigger phrases and step-by-step instructions the skill can follow.

Focus on the output you want. Sections, tone, and usefulness matter more than file structure.  
🔧 **Going deeper (optional):** Add a `references/` folder with a sample template if your output should always follow the same format.

---

### Step 4 — Test that the skill activates

First reload Copilot CLI if needed:

```text
Reload my skills so the new skill is available.
```

Then try a natural trigger prompt. Example:

```text
Use my partner briefing skill to prepare a briefing from the notes in C:\Users\<you>\Documents\PartnerNotes\Contoso.
```

**Expected outcome:** Copilot recognizes the skill, follows the instructions in `SKILL.md`, and produces the artifact you asked for. If it does not trigger, ask:

```text
Why did my new skill not trigger? Review the SKILL.md trigger description and make it more explicit.
```

The test passes when the output is useful enough to improve your next real meeting or update.  
🔧 **Going deeper (optional):** Check whether the trigger phrases in `SKILL.md` match how you naturally ask for the work.

---

### Step 5 — Explain and share it

Paste this into Copilot CLI:

```text
What did we just build, and how would I share this skill with a colleague who is also using Copilot CLI?
```

**Expected outcome:** Copilot summarizes the skill in plain language and gives a simple sharing path: copy the skill folder, share the `SKILL.md`, or package it later as a plugin.

Practice the 30-second explanation: "I built a skill that turns X into Y when I ask Z."  
🔧 **Going deeper (optional):** Ask what would need to change if this became a team plugin.

---

## What good looks like

You are done when:

- The skill folder exists under `~\.copilot\skills\`.
- The skill triggers on the phrases you would naturally use.
- The output is useful for real work, not only for the workshop.
- You can explain to a peer what you built and when you would use it.

---

## Stretch — turn it into a plugin

A skill is enough for personal use. If you want to share it as a packaged team asset, turn it into a plugin later: add a `plugin.json`, keep the skill under `skills/<name>/`, and document the install flow. Use the copilot-overview [INSTALL.md](https://github.com/JW-Sthlm/copilot-overview/blob/main/INSTALL.md) as the model, then ask Copilot CLI to help package your folder.

---

## Validation note for hosts

> **Heads-up for hosts:** The reference plugin (`copilot-overview-plugin`) has not yet been validated on a clean machine. Before relying on it in a workshop, run the install flow in Windows Sandbox or on a fresh laptop. See `plan.md` Phase 10 / Phase 7 validation note.

---

## Next

- Keep your skill and use it once this week on real work.
- Share the skill folder with one colleague and ask whether the trigger makes sense to them.
- Keep the [cheat sheet](../reference/cheat-sheet.md) handy and check [after-session resources](../reference/after-session-resources.md) for what to learn next.
