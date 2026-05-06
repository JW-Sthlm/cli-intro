# Module 3: Drop a file in, get insight out

> ⏱️ **Estimated time:** 20 min
> 🎯 **You'll be able to:** point Copilot at a file or folder, get a structured analysis, and use the result in your work.

---

## The big unlock

📖 In M2 you typed prompts. That's chat. The actual win happens when you give the CLI **a real file** to work with.

A 30-page partner RFP. A transcript from a call. A pitch deck. A folder of customer technical docs. The CLI can read all of that, and produce something useful.

---

## How "context" works

When you run `copilot` from a folder, that folder becomes its working directory. The CLI can read files in that folder by filename. You don't paste content, you reference it.

Example:

```text
PS C:\Users\you\downloads> copilot
✦ Copilot CLI · gpt-5 · ready
> Read partner-rfp.pdf and summarize the customer's top 3 asks for an exec audience.

  Reading partner-rfp.pdf (28 pages)...

  Top 3 asks:
  • Migrate 200 SQL Server instances to Azure SQL by Q3
  • Establish a 24/7 managed service tier for the production estate
  • Co-fund a $50K POC against the Fabric platform

> _
```

The CLI sees `partner-rfp.pdf` is in its working dir, reads it, summarizes.

⚠️ **Forgetting which folder you're in is the #1 source of "it can't see my file".** Type `pwd` (or look at the prompt) before you start. If your file is on your Desktop and you opened copilot from `C:\Users\you`, the CLI can't find it.

---

## 🚀 Hands-on: 3 partner exercises

### Exercise 1: summarize a real file

📖 Pick a file you'd analyze this week. Anything: a partner deck, an analyst report, a long email thread you exported, a meeting transcript. Just put it in a folder.

```powershell
cd <folder containing the file>
copilot
```

Inside copilot:

```
> What's in <filename>? Give me a 5-bullet summary.
```

**Tweak:**

```
> Now identify three things the partner cares about that they didn't say out loud. What's the subtext?
```

This is where the CLI earns its keep, pattern-matching across the whole document. Faster than you reading it.

### Exercise 2: structured extraction

📖 Drop in a partner's website "About" page (save the HTML, or paste the URL, depending on your setup).

Ask:

```
> From this content, extract:
> - Company size (employees, geography)
> - Practice areas
> - Customer logos mentioned
> - Microsoft technologies they reference
> - 3 things they're clearly proud of
> Format as a Markdown table.
```

**Why this matters:** that's a partner pre-call brief, generated in 30 seconds. You used to do this by hand for every meeting.

### Exercise 3: comparing files

📖 Drop two partner RFPs (or two customer briefs) in the same folder.

```
> Compare partner-a-rfp.pdf and partner-b-rfp.pdf. What are 3 themes they have in common? What's unique to each?
```

If you don't have two partner RFPs, use any two long documents you have.

---

## ⚠️ Data boundary reminder

When you drop files in:

- The file content is sent to the Copilot endpoint as part of the conversation.
- Treat this the same way you'd treat M365 Copilot.
- **Public, internal-only, partner-NDA → usually fine for analysis you keep internal.**
- **Customer PII, credentials, anything labelled Highly Confidential → don't.**

If in doubt, ask the CLI to read a redacted version.

---

<details>
<summary><strong>🔧 "Multi-file projects"</strong>: point at a whole folder, click to expand</summary>

🔧 You can also point at a whole folder. Copilot will scan its file tree.

```text
> What does this folder contain? Categorize the files and tell me what kind of project this is.
```

Useful for partner asset libraries, repo dumps, document archives.

⚠️ Big folders eat context budget fast. If your folder has 1000+ files, narrow it: `What's in the /docs subfolder?`

</details>

---

<details>
<summary><strong>📖 "Outputs you can ask for"</strong>: quick reference, click to expand</summary>

📖

| You want... | Ask for... |
|-------------|------------|
| A 1-pager for an exec | "Summarize for a non-technical exec, 6 bullets max" |
| A talk track for a meeting | "Give me a 3-minute talking script with 3 questions to ask the partner" |
| A spreadsheet | "Output as CSV with columns: ..." |
| A briefing doc | "Output as Markdown, sections: Background, Key asks, Risks, Recommended next step" |
| A status update | "Output as 3 bullets in the format: Done / Doing / Blocked" |

The CLI cares about the format you ask for. Be specific.

</details>

---

<details>
<summary><strong>⚠️ "What this is NOT good at"</strong>: guardrails, click to expand</summary>

⚠️ The CLI is great at extracting and structuring. It's mediocre at:

- **Math.** It will quote numbers from the doc, but don't trust it to add things up. Verify.
- **Specifics it can't see.** It won't know "what did this partner do last quarter" unless that info is in the doc you gave it.
- **Knowing when it's wrong.** It will sound confident even when it's hallucinating. Spot-check.

</details>

---

## 🎯 Real-work pick-up

📖 Pick the next partner meeting on your calendar. Find one document related to that partner (their website, a past email, an old deck). Drop it in a folder, ask Copilot for a 4-bullet pre-call brief. See if it saves you the prep time.

That's the test that matters.

---

## ✅ You're ready for M4 if

- You've successfully fed at least one real file to Copilot and gotten useful output
- You know how to set the working directory before starting
- You're comfortable asking for a specific output format

---

## 👉 Next: [Module 4: MCP power-ups: PMX, M365, GitHub](../m4-mcp-power-ups/README.md)
