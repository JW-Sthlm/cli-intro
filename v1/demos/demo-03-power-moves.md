# Demo 03 — Power Moves

> **Duration:** ~7 min  
> **Goal:** Show the advanced capabilities that turn Copilot CLI from a helper into a strategic tool: /research for deep investigation, skills for domain expertise, and how these combine with PMX/MSX data

---

## Setup

- Copilot CLI running with all MCP servers
- Pick a topic relevant to your audience (e.g., a partner's technology area, a market trend, or a specific Azure workload)

---

## Script

### 1. /research — deep investigation mode

**Type:**

```
/research What is the current state of AI agent adoption among ISVs in the Nordic market? Include trends, challenges, and opportunities for Microsoft partners.
```

**Talking point:** `/research` is different from a regular question. It runs a deep search — web sources, GitHub, structured data — and produces a report with citations. Think of it as having a research analyst on your team.

*Wait for the research to complete (usually 30-60 seconds).*

**Point out:** The citations, the structure, the depth. This isn't a ChatGPT answer — it's an investigated report.

---

### 2. Combine research with PMX data

**Type:**

```
Now look at the MSX opportunities in EMEA related to AI agents or autonomous systems. Cross-reference with what you just found — are there gaps we should be pursuing?
```

**Talking point:** This is where it gets powerful. You take external intelligence (market research) and overlay it with internal data (your MSX pipeline). Copilot can spot patterns you'd miss manually.

---

### 3. Generate a partner roadmap suggestion

**Type:**

```
Based on the research and MSX opportunity data, draft a suggested technical roadmap for a partner looking to build AI agent solutions on Azure. Include: which Azure services to start with, what skills they need, and 2-3 concrete project ideas with estimated complexity.
```

**Talking point:** This is the kind of output you'd normally spend hours assembling. Market context + pipeline data + Azure expertise = a roadmap you can actually bring to a partner conversation.

---

### 4. Skills — domain expertise on demand

**Type:**

```
/skills
```

**Talking point:** Skills are pre-packaged expertise that extend what Copilot can do. Show the list — highlight a few:
- **Azure skills** (deploy, diagnostics, compliance)
- **PMX tools** (the MCP server we've been using)
- **Content creation** (slides, reports)

**Type:**

```
Use the azure-compute skill to recommend a VM size for a partner running a mid-size SQL Server workload with 32GB RAM and 8 cores.
```

**Talking point:** You don't need to memorize Azure VM SKUs. Skills give Copilot access to specialized knowledge — pricing APIs, best practices, configuration guides.

---

### 5. Custom agents and extensions

**Type:**

```
/env
```

**Talking point:** Show the extensions and agents section. Explain briefly:
- **Custom agents** — specialized personas you can create for specific tasks (e.g., a partner briefing agent)
- **Extensions** — add new tools (e.g., screenshot analysis, calendar integration)
- **Instructions files** — teach Copilot your team's conventions and preferences

This is how you go from "useful tool" to "customized assistant that knows your workflow."

---

### 6. /plan — think before you act

**Type:**

```
/plan Create a one-page partner brief for [Partner Name] that includes their project portfolio, outcome coverage, open opportunities, and a recommended next step.
```

**Talking point:** `/plan` creates a structured plan before doing anything. You review it, adjust it, then tell Copilot to execute. Like giving a brief to a colleague — you describe the output, they figure out the steps.

---

## Key Messages

- `/research` = deep investigation with citations, not just a quick answer
- Combining research + internal data (PMX/MSX) = strategic insights
- Skills give Copilot domain expertise you don't have to carry in your head
- Custom agents and instructions make it YOUR assistant, not a generic one
- `/plan` gives you control — review before execution
