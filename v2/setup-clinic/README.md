# Setup Clinic

A guided 30-45 minute setup session for the Copilot CLI intro workshop.

This is for people who got stuck on the pre-work, are new to Windows Terminal, or just want someone to walk through the setup with them. No coding experience needed.

The point is simple: leave with a working setup.

---

## Who this is for

📖 Business roles: this session is for PSAs, PTSs, PSAMs, PDMs, and other partner-facing roles who need Copilot CLI working before the main workshop.

It is especially useful if:

- You could not install Copilot CLI on your own
- You have never used PowerShell or Windows Terminal
- You are unsure which GitHub account to use
- You got stuck on Azure login, GitHub login, or MCP setup
- You want someone to validate your setup before the main session

No code. No slides. No judgement.

---

## What you leave with

By the end of the clinic, every participant should have:

- The readiness script passing or a clear next step for any remaining issue
- Both GitHub accounts authenticated: personal and Microsoft EMU
- Azure CLI logged in to the Microsoft tenant
- PMX, GitHub, and M365 MCP setup started or validated
- One first Copilot CLI conversation opened and responding

You do not need to memorize commands. The habit we want is: just talk to it.

---

## Format

**Time:** 30-45 minutes

**Style:** screen-share plus parallel work

**How it runs:**

1. Host shows what a good verification output looks like
2. Everyone works through setup together
3. Host pauses at each gate: Node, Copilot CLI, GitHub auth, Azure login, MCP setup
4. Each participant runs the readiness script
5. Participants paste the summary line in chat
6. Host triages failures one by one
7. Everyone opens Copilot CLI and sends one prompt

The host should validate each participant's verification output before they leave.

---

## What the host should announce 1 day ahead

Send participants [participant-prep.md](participant-prep.md) with the calendar invite or Teams reminder.

Ask them to bring:

- Their Microsoft laptop
- Ability to install software, or admin-on-request available
- Their GitHub Microsoft account password ready
- 30-45 minutes where they can share screen if needed

If people cannot install software themselves, ask them to join anyway. The clinic can identify exactly what IT/admin help is needed.

---

## Session materials

| File | Use it for |
|------|------------|
| [Host runbook](host-runbook.md) | Minute-by-minute script for the facilitator |
| [Host cheatsheet](host-cheatsheet.md) | Fast commands and fixes during live troubleshooting |
| [Participant prep](participant-prep.md) | Short message to send before the clinic |
| [Post-clinic follow-up](post-clinic-followup.md) | Message to send after the clinic |

---

## Paired pre-work files

Use these during the clinic:

| File | Use it for |
|------|------------|
| [Setup Guide](../pre-work/setup-guide.md) | Main installation steps |
| [Verify Checklist](../pre-work/verify-checklist.md) | Human-readable readiness checklist |
| [verify.ps1](../pre-work/verify.ps1) | Automatic readiness check |
| [Troubleshooting](../reference/troubleshooting.md) | Common issues and fixes |

---

## The one command everyone should run

This checks the laptop setup and prints a clear pass/fail summary.

```powershell
.\v2\pre-work\verify.ps1
```

If PowerShell blocks the script, run it with execution policy bypass for this one command.

```powershell
pwsh -ExecutionPolicy Bypass -File .\v2\pre-work\verify.ps1
```

---

## What good looks like

A good session ends with every participant able to say one of these:

- "All checks passed."
- "One item failed, and I know exactly what to fix."
- "I need admin help, and I know which install is blocked."

That is enough. The main workshop is about using Copilot CLI, not debugging setup.
