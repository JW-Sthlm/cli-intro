# Self-service course, design notes

Internal notes for whoever maintains this. Not part of the learner-facing material.

## Why this exists

The 45-min workshop ([cli-intro v2](../README.md)) gets people excited but assumes setup is done. In practice many partners showed up to the workshop without setup completed, too many friction points without a guide. The Setup Clinic is one mitigation. This self-service course is the other: an async path for the partner who can't make a clinic, or who joins the org six months from now.

## Source

Adapted from [`jamesmontemagno/copilot-cli-for-beginners`](https://github.com/jamesmontemagno/copilot-cli-for-beginners), MIT licensed. We took the chapter structure and replaced the developer-coded Python book app with partner-work scenarios.

## Two-track decision

Original course is one path for developers. We split because:

- **Business roles** (PDM, PSS, business-side PSA) get diminishing returns past MCP. Custom agents, skills, and pipelines are not on their job description and the cognitive load is high. Stopping at M4 gives a clean "you're now productive" moment.
- **Technical roles** (PTS, technical PSA, CSA, PSAM) need the deeper chapters because they'll be building the reusable assets the rest of the team consumes.

Modules 0–4 are shared. Modules 5–7 build on M4 only.

## Audience markers

- 📖 = business-track callout, applies to everyone
- 🔧 = technical-track deep dive, optional for business
- ⚠️ = common trap we've seen kill workshop momentum

These mirror what setup-guide.md and the workshop slides use, so a learner moving between materials sees a consistent vocabulary.

## What we deliberately did NOT include

- **No code review chapter.** Original M03 is heavy on review/test/debug for software developers. Replaced with "files as context" because that's the highest-value workflow for partner roles (drop the RFP in, get the analysis out).
- **No assignment grading.** Each module ends with a "try this" prompt but no scoring. This is self-service, not a course you pass.
- **No video.** Text + screenshots. Cheap to maintain, no broken links to YouTube videos six months later.
- **No Codespaces deep-dive.** Mentioned as a fallback in M1 only. Most partner work needs local files (Outlook attachments, partner decks), so local install is the default.

## Open questions / placeholders

The course is now placeholder-free for the in-CLI flow. Remaining open items are content quality, not blockers:

| ID | Where | What's needed |
|----|-------|---------------|
| ~~p10~~ | ~~M1 (Setup), M4 (MCP)~~ | ✅ Resolved 2026-05-05 (Walk A): pick option 2 "Copilot CLI" at the install-target prompt. M4 now spells this out. |
| course-validate-source-current | All modules | Re-check source course chapters didn't change before each ship. |
| ~~course-screenshot-pass~~ | ~~All modules~~ | ✅ Replaced with HTML-style terminal mockups in fenced code blocks (2026-05-06). |
| ~~course-humanizer-pass~~ | ~~All modules~~ | ✅ Done 2026-05-06. Em dashes swept across all 8 module READMEs + course README + design notes. Other AI tells (leverage/robust/crucial/furthermore) absent except in deliberate teaching examples (M2 rewrite exercise, M5 banned-word list, M6 humanizer example input). |
| ~~m6-skill-example~~ | ~~M6~~ | ✅ Done 2026-05-06. Minimal `qbr-prep` SKILL.md kept as illustrative skeleton. Hands-on install swapped to real `content-humanizer` skill (sourced from olivomarco/vbd-copilot). Real install path + real audit/rewrite trigger example. |
| ~~m7-pipeline-example~~ | ~~M7~~ | ✅ Done 2026-05-06. Primary capstone swapped to PMX `/hygiene` weekly check (real MCP tool, real cadence). Worked example: `/hygiene` → `pmx-fixer` agent walks through actionable findings + drafts Teams pings for others' projects. Friday partner portfolio sweep added as bonus optional pipeline (2 MCPs + content-humanizer skill + agent). |

## When to revise

- After three or more partners complete the course async, gather feedback and revise.
- When the source course pushes a major update (chapters added/removed), check for drift.
- When PMX MCP, M365 MCP, or GitHub MCP changes their setup flow.

## Foldable section pattern (rolled out 2026-05-02 to M0+M1, 2026-05-06 to M2-M7)

Modules use `<details><summary>` HTML inside markdown so non-tech readers can skip the dense bits and tech-curious readers can deep-dive. Convention:

- **Always visible:** the spine, pitch, decision tables, critical warnings (data boundaries, the 2-account dance), the main step-by-step path, hands-on exercises (🚀), readiness gates (✅), next-module links (👉).
- **Folded:** optional context, definitions for non-tech readers ("never opened PowerShell?"), troubleshooting tables, alternative paths, legacy fallbacks, "for the curious" deep-dives.
- **Summary line format:** `<strong>📖|🔧|⚠️ marker + topic</strong>: hint, click to expand`, colon connector (em-dash banned per voice profile).
- **Tested in:** GitHub.com, VS Code preview.

**Status:** applied to all 8 modules (M0-M7).

## Terminal mockup pattern (rolled out 2026-05-06)

Where M0/M1/M2-M7 would have benefited from a screenshot showing CLI behavior, we use a fenced `text` code block that mocks real terminal output. Reasons over PNG screenshots:

- Editable when CLI output drifts (model versions, MCP names, prompts change quarterly).
- Searchable (`grep` finds actual text inside mockups).
- Renders consistently on GitHub web + VS Code preview without an asset pipeline.
- Diff-friendly in PRs.
- No image-to-image AI pass needed (the pass that prompted this pivot kept failing on terminal screenshots).

Conventions:

- Use ` ```text ` or unlabeled fences. GitHub renders monospace either way.
- Show the prompt indicator (`PS C:\... >` or `>`) so the reader knows where input ends.
- Use Unicode glyphs (✓ ✦ ⬆️ ❯) freely, they render in code fences.
- Avoid `<div class="terminal">` styling. GitHub strips inline CSS.

## Why markdown, not HTML

Asked 2026-05-02. Answer:

- We ship via the cli-intro GitHub repo. GitHub renders markdown natively. Foldables work. Code blocks work. Internal links work.
- Markdown is editable by anyone (no JS / build / deploy step).
- When the course stabilises and we want a polished standalone web property, we publish via **GitHub Pages + mkdocs-material** (the same toolchain James's source course uses). Same markdown source, prettier rendering. Adds search, sidebar nav, dark mode, version selector.
- Going to HTML now would mean rewriting on every change. Going to mkdocs later is one config commit.

So: **markdown now, mkdocs-material later.** Decide on the publish step after the humanizer pass.

## Course versus workshop versus clinic

| Format | Length | Best for | Owner |
|--------|--------|----------|-------|
| **Workshop** (`v2/`) | 45 min live | Cohort kickoff, exec sessions | Johan |
| **Setup Clinic** (`v2/setup-clinic/`) | 90 min live | Stuck-on-setup attendees post-workshop | Johan or trained host |
| **Self-service course** (this) | 90 min – 3h async | Anyone who missed the workshop or wants to go deeper | This course owns itself once shipped |

The course should be discoverable from the workshop's `after-session-resources.md` and the Setup Clinic's `post-clinic-followup.md`.

## Maintenance

This is a living artefact. When people complete it and feed back issues, edit the modules in place. Keep changes small and additive, don't restructure unless the friction is structural.
