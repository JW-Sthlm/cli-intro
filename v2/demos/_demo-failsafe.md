# Demo Failsafe Playbook

Use this when the demo breaks during the session. The audience does not need to watch you debug. They need to see the pattern, understand the value, and leave with confidence that there is a safe way forward.

## If CLI crashes / hangs / loops

**⚠️ Common trap** — The recent workshop lost credibility when the demo opened with "any new session is just crashing". Use the backup path quickly.

- [ ] Do not try to fix it live.
- [ ] Open the backup recording from the placeholder link below.
- [ ] Say: "This is a real example of what happens when CLI gets confused — let's watch the recorded version and I'll flip back at the end to debug live with anyone who wants to."
- [ ] Use the moment as a credibility builder: the willingness to handle failure on screen is useful for non-coders.

## If MCP servers fail to respond

**📖 Business roles** — Keep the value story alive: structure first, live data second.

- [ ] Pivot to the prompt-only version of the demo with no real data.
- [ ] Frame it clearly: "Imagine PMX data here. The structure is the point; the live connection is what makes it operational."
- [ ] Let people who are set up correctly run the real version themselves.
- [ ] Ask one successful participant to share back what they saw.

## If the model is too slow / quota exceeded

**🔧 Technical deep dive** — Switching models is optional depth. Do it once, then move on if it still fails.

- [ ] Switch model live with `/model gpt-5-mini`, or whichever fast model is currently working.
- [ ] Try the next prompt once after switching.
- [ ] If quota is hit on all models, stop the live demo and use the backup recording.

## If a participant's setup blocks the whole session

- [ ] Do not troubleshoot 1:1 in front of the room.
- [ ] Direct the participant to the next Setup Clinic session.
- [ ] Book or point to that clinic then-and-there.
- [ ] Carry on with whoever is set up.

## Backup recording link

- [ ] `[TODO: record and link a 3–5 min backup video of the partner briefing demo]`
- [ ] Store the recording as an unlisted Stream or Loom link that is accessible internally.
- [ ] Add the link here once recorded.
- [ ] Update the storyboard to reference the same backup recording.

> **Remember:** The audience will forgive a broken demo. They will not forgive 10 minutes of trying to fix one in silence. Move on.

## See also

- `_demo-prep-checklist.md` — run this before the session
- `demo-01-partner-briefing.md` — primary demo script
