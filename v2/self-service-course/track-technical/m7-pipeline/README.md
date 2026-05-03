# Module 7 — Putting it all together 🔧

> ⏱️ **Estimated time:** 30 min (or longer — this is the capstone)
> 🎯 **You'll be able to:** combine MCP + agents + skills into one end-to-end pipeline that handles a recurring partner task. You ship one reusable asset.

---

## What "putting it together" means

You now have the four building blocks:

1. 📖 **Conversations** (M2)
2. 📖 **Files as context** (M3)
3. 📖 **MCP servers** (M4)
4. 🔧 **Agents** (M5)
5. 🔧 **Skills** (M6)

Real productivity comes from **combining them**. Not 5 separate tools — one workflow that uses all 5.

---

## The capstone: build one real pipeline

🔧 Pick **one recurring partner task** that takes you 30+ min today, and that you do at least monthly. Build a pipeline that does most of the work.

Examples:

- **Weekly vTeam update** — pulls from PMX MCP, your inbox, your calendar; runs through `vteam-update-formatter` skill; outputs a Markdown file.
- **Pre-QBR brief generator** — takes a partner name, pulls projects from PMX, recent emails from M365, generates a 1-pager via the `qbr-prep` skill.
- **Partner technical assessment doc** — takes a partner's URL, pulls their public web content, asks Copilot to assess against a Microsoft technology fit framework, outputs a structured doc.
- **Workshop attendee follow-up** — for each attendee in a CSV, pulls their public LinkedIn/GitHub data, drafts a personalized follow-up email.

Pick one that's real for you. Don't pick the most ambitious — pick the most boring recurring one. That's where the time savings compound.

---

## Designing your pipeline

🔧 Before building anything, sketch this on paper:

```
INPUTS  -- what you start with (partner name, date range, project ID)
   |
   v
SOURCES -- which MCP servers fetch which data
   |
   v
TRANSFORM -- which agent or skill processes the raw data
   |
   v
OUTPUT  -- what you end with (Markdown doc, CSV, email draft)
```

For weekly vTeam update, that might look like:

```
INPUTS:  current week range
   |
SOURCES: PMX MCP (open projects, last status)
         M365 MCP (calendar last 7 days, sent emails last 7 days)
   |
TRANSFORM: vteam-update-formatter skill
   |
OUTPUT:  weekly-update-YYYY-MM-DD.md in vteam folder
```

This sketch tells you what you need: 2 MCPs (already have), 1 skill (built in M6), 1 output convention.

---

## 🚀 Hands-on: build the weekly-update pipeline

We'll do this one. Adapt for your real task.

### Step 1: the entry-point prompt

Build the prompt that triggers everything:

```
> Generate my weekly vTeam update for the week of <Monday's date>.
> Pull from PMX (my open projects, any status changes) and from my M365
> (calendar from this week, emails I sent or received from external partners).
> Format using the vteam-update-formatter skill.
> Save the output as weekly-update-YYYY-MM-DD.md in my current folder.
```

This is one prompt. The CLI plus MCPs plus skill do the rest.

### Step 2: encode it as an agent

Save this prompt structure as an agent so you don't retype it. In `~/.copilot/agents/weekly-update.md`:

```markdown
---
name: weekly-update
description: Generates the EMEA Agentic AI vTeam weekly update from PMX + M365 data using the standard format.
---

When invoked, generate the user's weekly vTeam update.

## Steps

1. Determine the week range. If the user didn't specify, assume last Monday through Sunday.
2. Use PMX MCP to fetch the user's open projects with last status update date.
3. Use M365 MCP to fetch:
   - Calendar events in the week range that include external partners (non-microsoft.com domains)
   - Sent and received emails with external partners
4. Pass the raw data to the vteam-update-formatter skill.
5. Save the formatted output as `weekly-update-YYYY-MM-DD.md` in the current folder.
6. Show the user the output and ask if they want to edit before saving.

Be specific. Use real project names and partner names. If data is missing, say so explicitly.
```

### Step 3: trigger it

```powershell
cd <wherever you keep your weekly updates>
copilot
> /agent weekly-update
> Generate my update for this week.
```

It'll ask for confirmation before saving (good — you stay in the driver's seat). You review, edit, ship.

### Step 4: iterate

First time will not be perfect. The output will need editing. Note what you edited. Update the skill or agent to encode that learning. By iteration 3 or 4, the output is shippable as-is.

---

## When this stops being a project and becomes a tool

🔧 You know your pipeline is mature when:

- You ran it 5+ times
- The output needed less than 2 minutes of editing
- A teammate could trigger it and get the same quality

That's the moment to share it. Push the agent and skill to a Git repo, document the entry-point prompt, drop a Teams message in the vTeam channel.

That asset is now a force multiplier across the team.

---

## ⚠️ Common pipeline traps

- **Over-engineering before validating.** Build the simplest version first. Use it for real. Iterate.
- **Hiding too much.** Don't make the pipeline opaque. The user should always see what data was pulled and have a chance to correct before output is saved.
- **Hard-coding things that should be flexible.** "Last 7 days" → make it a parameter. "vTeam channel" → ask the user.
- **Brittle MCP dependencies.** If PMX MCP is down, the pipeline should degrade gracefully ("couldn't reach PMX, here's what I have from M365 only").
- **Forgetting data boundaries.** A pipeline that generates partner-facing content from internal data needs an explicit human-review gate.

---

## 🎯 The real graduation moment

🔧 You've built and used a pipeline that combines MCP + skills/agents and produces a real output you'd ship without rewriting from scratch.

That's the bar.

---

## Where to go from here

You've now seen all four layers (conversations, context, MCPs, agents/skills). Real depth comes from doing the work:

- **Ship 3 pipelines** for your real recurring tasks. Most of them will be small.
- **Share at least one** with the vTeam. Force-multiplier moment.
- **Read other people's skills** in the team library. Steal patterns.
- **Watch the source course** for advanced patterns: [GitHub Copilot CLI for Beginners](https://jamesmontemagno.github.io/copilot-cli-for-beginners/).

When new MCP servers ship (and they will), the playbook is the same: install, sketch the pipeline, build the agent/skill, iterate.

---

## ✅ Course graduate 🎓

You've completed Track B. You now know more about Copilot CLI than 95% of people in the org. The remaining 5% are the people you're going to teach.

Find someone on your team who hasn't done this yet. Send them this course.

---

## 👉 Back to [course home](../../README.md)
