# Exercise 1 — First Conversation

> **Duration:** ~5 min  
> **Format:** Guided — follow along, type each prompt  
> **Goal:** Get comfortable talking to Copilot CLI

---

## Before You Start

Make sure Copilot CLI is running. If not:

```
copilot
```

---

## Part A: Check Your Calendar

Copy-paste this into Copilot CLI:

```
What meetings do I have today? List them with times and who's invited.
```

**What you should see:** Your actual calendar events for today with attendees.

> **Didn't work?** Your M365 MCP server might not be connected. Type `/env` and check if M365 tools are listed.

---

## Part B: Search Your Email

Copy-paste this:

```
Search my recent emails for anything about partners or partner meetings. Show the 5 most recent.
```

**What you should see:** Recent emails matching the search, with sender, subject, and a preview.

---

## Part C: Check Your PMX Projects

Copy-paste this:

```
Show me my active PMX projects. For each one, show the project name, partner, and status.
```

**What you should see:** Your project list from Dynamics 365 Partner Management.

> **Getting an error about authentication?** You may need to re-authenticate Azure. Open a new PowerShell window and run:
> ```
> az login --tenant 72f988bf-86f1-41af-91ab-2d7cd011db47
> ```
> Then go back to Copilot CLI and try again.

---

## Part D: Ask a Follow-Up

Now try asking a follow-up about what Copilot just showed you. For example:

```
Which of these projects has the earliest end date?
```

or

```
Tell me more about the first project — what's the objective?
```

**What you should see:** Copilot remembers the context from your previous question and gives a relevant answer.

---

## Done?

You just:
- ✅ Queried your calendar
- ✅ Searched your email
- ✅ Pulled live data from PMX
- ✅ Had a follow-up conversation with context

All without leaving the terminal. All in natural language.

Move on to the next demo — or experiment with your own questions while you wait.
