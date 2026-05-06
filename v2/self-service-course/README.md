# Copilot CLI: Self-service course for Microsoft partner roles

A self-paced version of GitHub's [Copilot CLI for Beginners](https://jamesmontemagno.github.io/copilot-cli-for-beginners/), adapted for **Microsoft's partner organization** (PSA, PTS, PDM, PSS, PSAM, GBB, CSA, and anyone else who works with partners every day).

Two tracks. Pick yours.

---

## 🎯 Who this is for

You're somewhere on this spectrum:

| You are... | Your day looks like... | Track |
|------------|------------------------|-------|
| **PDM, PSS, partner manager**, business-side PSA | Decks, briefings, partner emails, status updates, **Excel and Outlook all day**. You're not coding. | 📖 **Track A: Business** |
| **PTS, technical PSA, CSA, PSAM, GBB** | Architecture conversations, demos, customer technical reviews, occasional scripting and IaC | 🔧 **Track B: Technical** |
| Not sure | Start with Track A. Decide after Module 4. | 📖 → 🔧 |

**Track A** covers Modules 0–4 (~90 min total). When you finish, you can drive 80% of partner-work CLI value.
**Track B** does Modules 0–7 (~3h total). Adds custom agents, reusable skills, and end-to-end pipelines.

---

## 📚 Modules

### Track A: Business roles (📖 stop after M4)

| # | Module | Time | What you'll be able to do |
|---|--------|------|---------------------------|
| 0 | [Why CLI for partner work](track-business/m0-why-cli/README.md) | 10 min | Decide if this is for you. Understand "talk-to-it" vs "code-the-thing". |
| 1 | [Setup, the lazy way](track-business/m1-setup/README.md) | 15–30 min | Working CLI on your laptop with the right accounts wired up. |
| 2 | [Your first conversations](track-business/m2-first-conversations/README.md) | 20 min | Summarize, rewrite, draft, all without leaving the terminal. |
| 3 | [Drop a file in, get insight out](track-business/m3-files-as-context/README.md) | 20 min | Analyze RFPs, partner decks, transcripts, and customer docs. |
| 4 | [MCP power-ups: PMX, M365, GitHub](track-business/m4-mcp-power-ups/README.md) | 20 min | Pull from your inbox, your calendar, your projects, your repos. |

### Track B: Technical roles (🔧 continue from M4)

| # | Module | Time | What you'll be able to do |
|---|--------|------|---------------------------|
| 5 | [Custom AI agents](track-technical/m5-custom-agents/README.md) | 25 min | Build a reusable "partner-briefing" agent. |
| 6 | [Skills](track-technical/m6-skills/README.md) | 25 min | Package a workflow once. The whole vTeam reuses it. |
| 7 | [Putting it all together](track-technical/m7-pipeline/README.md) | 30 min | Ship one reusable asset that combines MCP + agents + skills. |

---

## ✅ Before you start

Before Module 1 you need:

1. **A laptop** running Windows 10/11. (Mac works, but our examples are Windows.)
2. **GitHub Copilot access** through your Microsoft enterprise account. You already have this, check at [github.com/settings/copilot](https://github.com/settings/copilot).
3. **Two GitHub accounts wired up:**
   - Your personal GitHub username (for general work)
   - Your `*_microsoft` EMU account (for Microsoft-internal repos like PMX MCP)
   - If you don't have an EMU account yet, see Module 1.
4. **Optional but recommended:** an Azure subscription you can `az login` to (your Microsoft tenant).

> 📖 **No coding experience required for Track A.** If you can install software and follow numbered steps, you can complete it.
>
> 🔧 **For Track B you'll write a little YAML and Markdown.** No real programming.

---

## 📖 / 🔧 / ⚠️ markers

Throughout this course you'll see these:

- 📖 **Business track example or callout:** relevant to all roles
- 🔧 **Technical deep dive:** Track B only; Track A folks can skip
- ⚠️ **Common trap:** pause and read this; we hit this in workshops

---

## How this differs from the original course

The [GitHub original](https://jamesmontemagno.github.io/copilot-cli-for-beginners/) is excellent, but built for **software developers** working on a **Python book app**. This version:

- Uses **partner work scenarios** throughout (RFPs, briefings, vTeam updates, PMX projects)
- Adds the **EMU/personal account dance** that's specific to Microsoft
- Adds **MCP servers we actually use** (PMX, M365, GitHub) instead of generic database examples
- Calls out **data boundaries** (NDA content, partner data) explicitly
- Splits into a **business + technical track** so non-coders can stop at the value plateau

The source course is referenced where it goes deeper than we need to.

---

## 🆘 If you get stuck

1. Re-run [`v2/pre-work/verify.ps1`](../pre-work/verify.ps1). It diagnoses 8 common problems automatically.
2. Open [`v2/reference/troubleshooting.md`](../reference/troubleshooting.md). Known issues from real workshops.
3. Drop a question in the **Agentic AI vTeam** Teams channel.
4. The [Setup Clinic](../setup-clinic/README.md) is a 90-minute live session if async isn't working for you.

---

## 🎒 What you'll build by the end

**Track A graduates** can:
- Open a CLI, talk to Copilot, get useful output
- Drop a partner doc in, get a structured analysis out
- Pull data from their Outlook, calendar, and PMX projects via natural language

**Track B graduates** can do all of that plus:
- Build a reusable partner-briefing agent
- Package a workflow as a Skill the whole vTeam uses
- Ship an end-to-end pipeline (MCP → agent → skill → output) for a real recurring task

---

## License & attribution

Course structure adapted from [GitHub's Copilot CLI for Beginners](https://github.com/jamesmontemagno/copilot-cli-for-beginners) (MIT). Partner-specific content and examples © Microsoft, internal use.
