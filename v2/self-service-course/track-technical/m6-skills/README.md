# Module 6 — Skills 🔧

> ⏱️ **Estimated time:** 25 min
> 🎯 **You'll be able to:** install skills the team has built, write your own simple skill, and ship it back to the vTeam for reuse.

---

## Skills vs agents — the difference

It's confusing because they both customize Copilot. The simple distinction:

| | Agent | Skill |
|--|-------|-------|
| **What it is** | A way to start a conversation in a specific style | A reusable capability that loads on demand |
| **Scope** | Conversation-level | Specific task within a conversation |
| **When it fires** | When you say `/agent <name>` | When the model decides "this would help" |
| **Best for** | Tone, format, structure | A workflow with steps, references, or scripts |

📖 **Analogy:** an agent is a person you're talking to (with a personality and rules). A skill is a tool that person can pull out of their toolbox when needed.

A **partner-briefing agent** sets the conversation tone.
A **qbr-prep skill** is a procedure with templates, references, and scripts that the agent (or any session) can invoke.

---

## What a skill looks like

A skill is a folder with at minimum:

```
my-skill/
├── SKILL.md          # The skill definition
├── references/       # (optional) reference docs the skill uses
└── scripts/          # (optional) helper scripts
```

The `SKILL.md` has frontmatter that tells Copilot when to fire the skill, and prose telling the skill what to do.

Minimal `SKILL.md`:

```markdown
---
name: "qbr-prep"
description: "Generates a partner QBR talk track from PMX project data and recent emails. Triggers: 'prep my QBR', 'QBR prep', 'partner QBR'."
---

# QBR Prep

You help prepare partner Quarterly Business Reviews.

## Steps

1. Ask the user which partner the QBR is for
2. Use PMX MCP to pull all projects for that partner
3. Use M365 MCP to find emails with that partner's domain in the last 90 days
4. Generate a talk track in this format:
   - Last 90 days: 3 wins, 1 challenge
   - Open projects: list with status
   - Next quarter: 2 priorities to align on
   - Open question to surface: 1 specific ask

Always be specific. Reference real project names. If data is missing, say so.
```

That's a working skill. Drop the folder in `~/.copilot/skills/`. The CLI auto-loads it.

---

## 🚀 Hands-on: install an existing skill

🔧 The team is building reusable skills you can install. Check the [`v2/extras/copilot-overview/`](../../../extras/copilot-overview/README.md) plugin and the wider org's skill library.

Generic install pattern:

```powershell
# Skills are git repos. Clone into your skills folder:
cd "$env:USERPROFILE\.copilot\skills"
git clone https://github.com/<org>/<skill-name>.git
```

Then in Copilot CLI:

```text
> /skills

Loaded skills:
  qbr-prep              ~/.copilot/skills/qbr-prep/SKILL.md
  vteam-update-formatter ~/.copilot/skills/vteam-update-formatter/SKILL.md
```

To trigger it, just say what you want — the description tells Copilot when to fire:

```text
> Prep my QBR for Contoso

  ✦ Activating skill: qbr-prep
  ✦ Pulling Contoso projects from PMX...
  ✦ Pulling last 90 days of email with @contoso.com...

  Last 90 days
  • 3 wins: Foundry pilot kicked off, AI Discovery Cards delivered, ECIF approved
  • 1 challenge: Fabric POC slipped two weeks on data access

  Open projects
  • Foundry pilot — In Progress, due Q3
  • Fabric POC   — In Progress, last update 12 days ago

  Next quarter
  • Align on Foundry agent build-out scope
  • Decide on managed-service tier vs self-serve

  Open question to surface
  • Who on Contoso's side will own the AI P&L next year?
```

Copilot recognizes "QBR" + "prep" matches the skill description, and runs the skill.

---

## 🚀 Hands-on: build a tiny skill

🔧 Build a "vteam-update-formatter" skill that turns raw bullets into our team's standard weekly format.

### Step 1: create the folder

```powershell
$skillsRoot = "$env:USERPROFILE\.copilot\skills"
New-Item -ItemType Directory -Force -Path "$skillsRoot\vteam-update-formatter"
```

### Step 2: write the SKILL.md

```powershell
code "$skillsRoot\vteam-update-formatter\SKILL.md"
```

Paste:

```markdown
---
name: "vteam-update-formatter"
description: "Formats raw activity bullets into the EMEA Agentic AI vTeam weekly update format. Triggers: 'format my vteam update', 'vteam weekly', 'team update format'."
---

# vTeam Update Formatter

You take raw bullets describing the user's week and format them into the EMEA Agentic AI vTeam weekly update template.

## Input

The user will paste raw bullets, possibly messy.

## Output format

```
## Week of <date range>

### Done
- <up to 5 items, one line each, action verb first>

### Doing
- <up to 3 items in flight, with expected completion>

### Asks / blockers
- <up to 2 items, or "none">

### Highlight
<one paragraph, 3 sentences max, on the most strategically important thing this week>
```

## Rules

- Action verbs first ("Shipped X", not "X was shipped")
- One line per item
- "Highlight" is the single most important thing — pick wisely, prune the rest
- If the user gave you fewer than 3 items, ask for more before producing output
```

### Step 3: use it

```
copilot
> Format my vteam update:
> - Ran a workshop with 12 partners
> - Started building a self-service course
> - Got stuck setting up Windows Sandbox
> - Pivoted to using Dev Box
> - Built a validation kit for the partner setup guide
```

You should get output in the expected format.

---

<details>
<summary><strong>🔧 "When to build a skill vs an agent vs nothing"</strong>: decision tree, click to expand</summary>

🔧 Decision tree:

- **One-off task:** just ask. Don't build anything.
- **Repeatable tone/format:** agent (M5).
- **Multi-step workflow with references/scripts/templates:** skill.
- **Workflow that needs to coordinate multiple MCPs and produce a structured artefact:** skill, definitely.

A good test: "could a colleague replace me by reading this and following it?" If yes, it's a skill.

</details>

---

<details>
<summary><strong>🔧 "Sharing skills"</strong>: push to a Git repo for the team, click to expand</summary>

🔧 Once your skill works for you, **make it a Git repo** and share with the vTeam:

```powershell
cd "$skillsRoot\vteam-update-formatter"
git init
git add .
git commit -m "Initial skill"
gh repo create <org>/<skill-name> --public --push
```

Now anyone on the team can `git clone` it into their own `~/.copilot/skills/`.

⚠️ **Don't put NDA partner content, customer data, or internal-only references in shared skills.** Skills travel. Treat them as if they'll be open-sourced eventually.

</details>

---

<details>
<summary><strong>⚠️ "Skill gotchas"</strong>: known traps, click to expand</summary>

- **Skills don't auto-update.** If the team upgrades a shared skill, you `git pull` to get it.
- **Activation is best-effort.** The CLI decides when to fire a skill based on the description and the user's prompt. Be specific in the description (`Triggers: ...`) to make activation reliable.
- **Skills can stack.** Two skills can fire in one conversation if both are relevant. This is usually fine; sometimes confusing.

</details>

---

## 🎯 Real-work pick-up

🔧 Pick **one** repeatable workflow you do for partners that has 4+ steps. Build it as a skill. Use it for one real instance. If it works, ship to the team.

---

## ✅ You're ready for M7 if

- You've installed at least one skill from the vTeam library and used it
- You've built one tiny skill of your own and triggered it successfully
- You understand the agent/skill/nothing decision tree

---

## 👉 Next: [Module 7 — Putting it all together](../m7-pipeline/README.md)
