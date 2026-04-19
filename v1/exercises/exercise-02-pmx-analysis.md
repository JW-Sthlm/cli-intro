# Exercise 2 — PMX Analysis

> **Duration:** ~8 min  
> **Format:** Guided start → self-paced challenges  
> **Goal:** Use Copilot CLI to find patterns, gaps, and insights in your PMX data

---

## Part A: Guided — Find Your Gaps (3 min)

### Step 1: Check outcome coverage

Copy-paste this into Copilot CLI:

```
Which of my PMX projects are missing outcomes? Show me a list with project name, partner, and what's missing (MSX Opportunity, Solution ID, or Referral).
```

**What you should see:** A list of projects with missing outcome links. These are your reporting gaps.

---

### Step 2: Fix one

Pick a project from the list. Copy-paste this (replace the project name):

```
Search MSX opportunities related to [partner name from the project]. Show me open ones in EMEA.
```

**What you should see:** MSX opportunities that could be linked to your project.

If you find a match, you can ask:

```
Link the MSX opportunity "[opportunity name]" to my project "[project name]"
```

---

## Part B: Self-Paced Challenges (5 min)

Pick one or more of these challenges. Work at your own pace. The cheat sheet has helpful commands if you get stuck.

---

### Challenge 1: Partner Team Review

```
Show me the team for [pick a partner]. Who is the PDM, PTS, and PSAM?
```

Then try:

```
What projects do we have with this partner? Are any overdue or missing deliverables?
```

---

### Challenge 2: Opportunity Gap Analysis

```
Show me all my projects and their linked MSX opportunities. Are there any opportunities without a project, or projects without an opportunity?
```

---

### Challenge 3: Deliverable Check

```
Show me my deliverables that are due in the next 30 days. Are any at risk?
```

Then:

```
For any overdue deliverables, draft a short status update I could send to the project team.
```

---

### Challenge 4: Cross-Reference with Calendar

```
Do I have any meetings this week with partners that I also have PMX projects with? Show me the overlap.
```

---

## Tips

- If Copilot asks for clarification, just answer naturally
- You can always say "show me more detail on the second one" — it keeps context
- If something doesn't work, try rephrasing. There's no magic syntax.

---

## Done?

Raise your hand or drop a message if you found something interesting. Gaps, patterns, surprises — these are exactly the kinds of things Copilot is good at surfacing.
