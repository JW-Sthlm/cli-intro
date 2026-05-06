# Module 7: Putting it all together 🔧

> ⏱️ **Estimated time:** 30 min (or longer, this is the capstone)
> 🎯 **You'll be able to:** combine MCP + agents + skills into one end-to-end pipeline that handles a recurring partner task. You ship one reusable asset.

---

## What "putting it together" means

You now have the four building blocks:

1. 📖 **Conversations** (M2)
2. 📖 **Files as context** (M3)
3. 📖 **MCP servers** (M4)
4. 🔧 **Agents** (M5)
5. 🔧 **Skills** (M6)

Real productivity comes from **combining them**. Not 5 separate tools, one workflow that uses all 5.

---

## The capstone: build one real pipeline

🔧 Pick **one recurring partner task** that takes you 30+ min today, and that you do at least monthly. Build a pipeline that does most of the work.

We'll do **the PMX `/hygiene` weekly check** as the worked example. It's real, it's weekly, and you'll use it. After that there's a **bonus pipeline** (Friday partner portfolio sweep) for when you want to push further.

Other examples worth picking for your own capstone:

- **Pre-meeting partner brief:** takes a partner name, pulls projects from PMX, recent emails from M365, generates a 1-pager via the `partner-briefing` agent.
- **Partner technical assessment doc:** takes a partner's URL, pulls their public web content, asks Copilot to assess against a Microsoft technology fit framework, outputs a structured doc.
- **Workshop attendee follow-up:** for each attendee in a CSV, drafts a personalized follow-up email.

Pick one that's real for you. Don't pick the most ambitious, pick the most boring recurring one. That's where the time savings compound.

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
OUTPUT  -- what you end with (PMX updates, Markdown doc, Teams drafts)
```

For the **PMX `/hygiene` weekly check**, that looks like:

```
INPUTS:  none (the slash command knows "this week")
   |
SOURCES: PMX MCP (pmx-project_hygiene_check, built into /hygiene)
   |
TRANSFORM: pmx-fixer agent
           - groups findings by ownership
           - walks me through the ones I can fix in PMX directly
           - drafts Teams pings for findings owned by others
   |
OUTPUT:  PMX records updated in place
         + clipboard-ready Teams messages for project owners
```

Two MCPs aren't always needed. This one uses just PMX, plus an agent that does the triage. The skill from M6 isn't required here. The bonus pipeline below uses both.

---

## 🚀 Hands-on: build the PMX `/hygiene` weekly check

We'll do this one. Adapt for your real task.

### Step 1: confirm `/hygiene` works

The `/hygiene` slash command ships with the PMX MCP server (you installed it in M4). It runs `pmx-project_hygiene_check` against your in-progress projects and reports findings across 10 categories (no outcome linked, overdue, missing business objective, stale, duplicate opportunity, and so on).

```text
PS C:\Users\you> copilot
✦ Copilot CLI · gpt-5 · ready
> /hygiene

  ✦ Running pmx-project_hygiene_check on your in-progress projects...

  43 projects audited
    12 you own (actionable)
    4  you created but no longer own (informational)
    27 you're a team contact on (informational)

  Findings on projects YOU OWN (12 actionable):
  • Fabric POC, Contoso              overdue (end date 2026-04-15)
  • AI Discovery Cards, Acme         no_outcome (no MSX opp / solution / referral linked)
  • Foundry Pilot, Globex            missing_business_objective
  • Azure Migration Wave 2, Initech  stale (no update in 47 days)
  ... 8 more

  Findings on projects OTHERS OWN (9 informational):
  • Azure Migration, Initech       overdue (owner: jane@microsoft.com)
  ... 8 more
```

This is your raw input. By itself it's a list. The triage agent turns it into action.

### Step 2: write the pmx-fixer agent

The agent walks you through the actionable findings one at a time, calls PMX MCP write tools to make the fixes, and drafts Teams pings for findings owned by others.

```powershell
code "$env:USERPROFILE\.copilot\agents\pmx-fixer.md"
```

Paste:

```markdown
---
name: pmx-fixer
description: Triages PMX hygiene findings. Walks the user through actionable fixes, drafts Teams pings for findings owned by others.
---

You help the user clean up PMX hygiene findings on a weekly cadence.

## Steps

1. If `/hygiene` hasn't been run in this session, run it via the PMX MCP first.
2. Split findings into two buckets:
   - Actionable: projects the user owns (`ownedByMe: true`)
   - Informational: projects owned by others
3. For each actionable finding, walk the user through it ONE AT A TIME:
   - State the project name and the finding category
   - Offer the most likely fixes as numbered options
   - When the user picks an option, call the appropriate PMX MCP write tool
     (update_project, link_outcome, update_task, etc.)
   - Confirm the fix landed before moving on
4. After actionable findings are done, draft Teams pings for the informational
   ones (one short message per project owner). Group by owner so the user gets
   one ping per person, not one per project.
5. End with a one-line summary: how many fixed, how many pings drafted.

## Rules

- Never update a project the user doesn't own. Drafts only for others.
- Show the proposed change BEFORE writing to PMX. Always confirm.
- Be specific. Project names, not "the first one". GUIDs in tool calls only,
  never in user-facing text.
```

### Step 3: trigger it

```text
> /agent pmx-fixer
✦ Switched to agent: pmx-fixer

> Walk me through this week's hygiene.

  ✦ Running /hygiene...
  ✦ 12 actionable, 9 informational. Starting with actionable.

  [1/12] Fabric POC, Contoso, overdue (end date 2026-04-15)

  Most likely fixes:
    1. Project actually wrapped, close it (status=Completed, set actual end date)
    2. Project still active, push end date out
    3. Skip (revisit next week)

> 1

  ✦ Setting status=Completed, actual end date=2026-04-30. OK to apply? [y/N]
> y
  ✦ Applied. PMX updated.

  Outcome check: no MSX opportunity linked. Want to link one now? [y/N]
> y
  ✦ Search MSX opportunity by partner "Contoso"... 3 matches:
    1. Fabric POC FY26 H2 (open, $40K)
    2. Azure migration scoping (won, $120K)
    3. Copilot Studio pilot (open, $25K)
> 1
  ✦ Linked. Moving to next finding.

  [2/12] AI Discovery Cards, Acme, no_outcome
  ...
```

After the 12 actionable ones:

```text
  ✦ All actionable findings closed. Drafting Teams pings for the 9 owned by others.

  --- To: jane@microsoft.com (3 projects) ---
  Hi Jane, Friday hygiene nudge: 3 of your projects show as overdue in PMX,
  Azure Migration / Initech (Apr 12), Fabric Refresh / Contoso (Apr 15),
  Copilot Pilot / Globex (Apr 22). Mind a quick pass to close them out
  or push the dates? Thanks.

  --- To: john@microsoft.com (2 projects) ---
  ...

  Summary: 12 actionable findings closed. 9 pings drafted for 4 owners.
  Total time: 14 minutes.
```

You review the pings, paste into Teams, done.

### Step 4: iterate

First time will not be perfect. Note what the agent missed (a fix option, an edge case, a partner the agent guessed wrong on). Update the agent. By iteration 3 or 4 the weekly hygiene check goes from a 30-minute chore to a 10-minute walkthrough.

---

## 🚀 Bonus: Friday partner portfolio sweep (optional)

🔧 If you want to push further, this one combines all four building blocks: 2 MCPs + 1 skill + 1 agent. It produces a Friday-morning portfolio doc with a one-line summary per active partner, ready to scan over coffee.

The pipeline:

```
INPUTS:  list of active partners (or detect from PMX)
   |
SOURCES: PMX MCP (recent project activity per partner)
         M365 MCP (recent emails per partner, calendar this week)
   |
TRANSFORM: portfolio-sweep agent
           - one paragraph per partner (state, what's open, what changed)
           - content-humanizer skill on the final draft to strip AI tone
   |
OUTPUT:  portfolio-YYYY-MM-DD.md, one section per partner,
         scannable in 2 minutes
```

Two notes before you build this:

- **Ground every claim in a source.** Partner section says "Foundry pilot slipped two weeks"? That fact came from a specific PMX update or a specific email. If the agent can't cite the source, it shouldn't make the claim.
- **Run content-humanizer LAST.** The raw draft from the agent will read AI-ish. The humanizer pass turns it into something you'd actually read on a Friday morning.

Sketch of the agent's `SKILL.md`-style guardrails (paste into `~/.copilot/agents/portfolio-sweep.md`):

```markdown
---
name: portfolio-sweep
description: Friday portfolio sweep. One scannable paragraph per active partner from PMX + M365 data, humanized.
---

You produce a Friday-morning portfolio sweep doc.

## Steps

1. Determine "active partners": ask the user, or infer from PMX
   (partners with project activity in the last 14 days).
2. For each partner:
   a. PMX MCP: open projects, deliverables status, recent task updates
   b. M365 MCP: emails sent/received in the last 7 days
3. Write one paragraph per partner: 3-4 sentences max. State, what's open,
   what changed this week, one open question or risk.
4. After the full draft, invoke the content-humanizer skill on the prose.
5. Save as `portfolio-YYYY-MM-DD.md`.

## Rules

- Every claim cites a source (project name, email subject, meeting title).
- If a partner had zero activity, say so. Don't pad.
- Skip partners with NDA-flagged content. Mark them "review separately".
- One paragraph = one partner. No multi-partner paragraphs.
```

Trigger:

```text
> /agent portfolio-sweep
✦ Switched to agent: portfolio-sweep
> Sweep this week. Partners: Contoso, Acme, Globex, Initech.

  ✦ PMX: pulling project activity for 4 partners...
  ✦ M365: pulling emails + calendar for 4 partners...
  ✦ Drafting paragraphs...
  ✦ Activating content-humanizer skill on the draft...

  ## Portfolio sweep, week of 2026-05-04

  ### Contoso
  Fabric POC closed Friday after a two-week slip on data access. The MSX
  opportunity is linked and the customer signed off on the next phase
  (Foundry pilot scoping). One open question: who on Contoso's side owns
  the AI P&L next year? Worth surfacing in the next steerco.

  ### Acme
  Quiet week. AI Discovery Cards delivered Tuesday, no outcome linked yet.
  Action: link the MSX referral before Monday or the deliverable looks
  orphaned in PMX.

  ### Globex
  Foundry Pilot kicked off, 5 consultants trained, positive signal in the
  follow-up email thread. ECIF burndown on track. Risk: their PSA leaves
  in three weeks, no transition plan yet.

  ### Initech
  Azure migration overdue (end date was Apr 12). Owner is Jane on her side,
  not Microsoft. Nudge her in the Friday hygiene ping (already drafted).

  Save as portfolio-2026-05-10.md? [y/N]
> y
  ✦ Saved.
```

That's two MCPs feeding an agent, one skill cleaning up the prose, one Markdown file out. Reproducible every Friday.

---

<details>
<summary><strong>🔧 "When this stops being a project and becomes a tool"</strong>: the maturity bar, click to expand</summary>

🔧 You know your pipeline is mature when:

- You ran it 5+ times
- The output needed less than 2 minutes of editing
- A teammate could trigger it and get the same quality

That's the moment to share it. Push the agent and skill to a Git repo, document the entry-point prompt, drop a Teams message in the vTeam channel.

That asset is now a force multiplier across the team.

</details>

---

<details>
<summary><strong>⚠️ "Common pipeline traps"</strong>: what kills pipelines, click to expand</summary>

- **Over-engineering before validating.** Build the simplest version first. Use it for real. Iterate.
- **Hiding too much.** Don't make the pipeline opaque. The user should always see what data was pulled and have a chance to correct before output is saved.
- **Hard-coding things that should be flexible.** "Last 7 days" → make it a parameter. "vTeam channel" → ask the user.
- **Brittle MCP dependencies.** If PMX MCP is down, the pipeline should degrade gracefully ("couldn't reach PMX, here's what I have from M365 only").
- **Forgetting data boundaries.** A pipeline that generates partner-facing content from internal data needs an explicit human-review gate.

</details>

---

## 🎯 The real graduation moment

🔧 You've built and used a pipeline that combines MCP + skills/agents and produces a real output you'd ship without rewriting from scratch.

That's the bar.

---

<details>
<summary><strong>🔧 "Where to go from here"</strong>: what to ship next, click to expand</summary>

🔧 You've now seen all four layers (conversations, context, MCPs, agents/skills). Real depth comes from doing the work:

- **Ship 3 pipelines** for your real recurring tasks. Most of them will be small.
- **Share at least one** with the vTeam. Force-multiplier moment.
- **Read other people's skills** in the team library. Steal patterns.
- **Watch the source course** for advanced patterns: [GitHub Copilot CLI for Beginners](https://jamesmontemagno.github.io/copilot-cli-for-beginners/).

When new MCP servers ship (and they will), the playbook is the same: install, sketch the pipeline, build the agent/skill, iterate.

</details>

---

## ✅ Course graduate 🎓

You've completed Track B. You now know more about Copilot CLI than 95% of people in the org. The remaining 5% are the people you're going to teach.

Find someone on your team who hasn't done this yet. Send them this course.

---

## 👉 Back to [course home](../../README.md)
