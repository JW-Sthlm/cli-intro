# Image Prompts - Copilot CLI Intro Session (v2: Pixel Art)

## Reference Character

All images feature the same protagonist: the pixel avatar from `Casual pixel avatar with coffee and laptop.png`.

**Character description for every prompt:** A friendly guy with short light-brown hair, light stubble, blue eyes, wearing a black t-shirt with a cyan/magenta pixel robot face on the chest. He holds a takeaway coffee cup in one hand and a silver laptop tucked under the other arm. Confident, relaxed posture.

Upload the reference image alongside each prompt so GPT can match the character consistently.

## Reusable Images from copilot-cli-for-beginners (MIT Licensed)

Credit: James Montemagno / GitHub - [github/copilot-cli-for-beginners](https://github.com/github/copilot-cli-for-beginners) (MIT)

| Image | Source path | Use for | Notes |
|-------|-------------|---------|-------|
| Auth device flow | `00-quick-start/images/auth-device-flow.png` | Setup page, setup verify slide | Use as-is - clean diagram style |
| Colleague context analogy | `02-context-conversations/images/colleague-context-analogy.png` | Fallback for "What Makes CLI Different" | Warm illustrated style (different art style from our pixel set) |

Download URLs:
- https://raw.githubusercontent.com/github/copilot-cli-for-beginners/main/00-quick-start/images/auth-device-flow.png
- https://raw.githubusercontent.com/github/copilot-cli-for-beginners/main/02-context-conversations/images/colleague-context-analogy.png

---

## Custom Image Prompts (for OpenAI GPT Image Gen)

### Style guide - append to EVERY prompt

> **Style:** Retro pixel art illustration in the style of the attached reference image. Semi-realistic pixel art - NOT 8-bit or 16-bit low-res sprites, but modern high-detail pixel art with visible square pixels, clean edges, and a slightly retro video game aesthetic. Color palette: black, teal (#2D6E6D), cyan, magenta/pink accents, warm skin tones, white background or simple flat-color backgrounds. The main character MUST match the attached reference image exactly - same hair, stubble, blue eyes, black t-shirt with cyan/magenta pixel robot logo, coffee cup, and laptop. No text or lettering in the image.

---

### Prompt 1: "The Matrix Moment" - Realizing What CLI Can Do

**Use for:** Title slide hero or Slide 3 ("What Makes CLI Different")

**Prompt:**

The pixel art guy (see attached reference) sits at a desk with his laptop open showing a dark terminal screen with teal-colored text. He leans back with wide eyes and a grin - the "aha" moment. From the terminal, luminous pixel streams flow upward: small pixel icons of a calendar, an email envelope, a bar chart, a database cylinder, and a document - all floating in an arc above his head like power-ups being absorbed in a video game. Small pixel sparkle effects (teal and magenta) burst around the icons. His coffee cup sits on the desk, steam rising in pixelated curls. The background is a simple warm cream/off-white. The feel is magical and empowering - like unlocking a new ability in an RPG.

[Append style guide]

---

### Prompt 2: "From Chaos to Clarity" - The Before/After

**Use for:** Transition visual between positioning and demo, or Slide 2

**Prompt:**

A split-scene pixel art illustration with a soft glowing teal line dividing left and right. LEFT SIDE: The pixel art guy (see attached reference) looks stressed, surrounded by floating pixel browser tabs, sticky notes, half-open emails, a calendar with red conflict markers, and scattered spreadsheet icons - everything tilted and overlapping like a cluttered retro game inventory screen. He is juggling items and his coffee is spilling slightly. RIGHT SIDE: The same character, now calm and confident, sitting at his laptop with a single clean terminal window. The same data (calendar, email, documents) flows in as organized pixel streams from the left, arriving as a neat structured document on screen. He has a satisfied smile and his coffee is safely in hand. Left side has warm orange/yellow pixel tones. Right side has cool teal/blue tones.

[Append style guide]

---

### Prompt 3: "The Briefing Factory" - Multi-Source Synthesis

**Use for:** Demo 1 intro card ("Partner Briefing Factory")

**Prompt:**

A whimsical pixel art scene showing a friendly "information factory." The pixel art guy (see attached reference) stands at the center next to a glowing pixel terminal that acts as the machine core. From the left, small pixel icons arrive on simple conveyor belts: a tiny database cylinder (PMX), an email envelope, a calendar page, a Teams chat bubble, and a small office building (partner). They feed into the terminal, which glows teal. On the right, a single polished pixel document emerges - a clean briefing with small checkmark and bullet-point icons visible. Pixel sparkle effects (magenta and teal) surround the output. The guy has his arms crossed confidently, watching with a slight smile. His coffee cup sits on top of the terminal. The factory feels like a cozy RPG crafting station, not industrial.

[Append style guide]

---

### Prompt 4: "The Copilot Ladder" - Progression Visual

**Use for:** Slide 2 ("The Copilot Ladder") - core positioning visual

**Prompt:**

A vertical pixel art illustration showing four ascending platforms connected by glowing teal pixel pathways, like levels in a platformer game. BOTTOM PLATFORM (green accent): A pixel chat bubble with a sparkle icon and small task icons (email, meeting note). SECOND PLATFORM (teal, highlighted/active): The pixel art guy (see attached reference) stands here at his laptop terminal, with connected tool icons orbiting - calendar, database, email, files. A structured document flows out. This platform glows brightest. THIRD PLATFORM (blue accent): The terminal is wrapped in a pixel shield/frame icon - representing enterprise governance. Multiple small pixel figures share the workspace. TOP PLATFORM (purple accent, partially in pixel clouds): Multiple small pixel agent figures work together, passing items between them like a co-op game. The path between platforms has small pixel arrows pointing up. The composition is vertical, bottom to top, and feels like natural progression - not difficulty. The guy's coffee cup is visible on the second platform.

[Append style guide]

---

### Prompt 5: "Sticky Notes to Strategy" - Workshop to Plan

**Use for:** Demo 2 intro card ("Workshop Notes -> Action Plan")

**Prompt:**

A two-act pixel art illustration. LEFT SIDE: A pixel whiteboard covered in colorful but messy pixel sticky notes (yellow, pink, green, blue), hasty pixel sketches, arrows going everywhere, and a small pixel coffee ring stain. The pixel art guy (see attached reference) and two other pixel colleagues stand around it - excited expressions but slightly confused about what is next, like characters looking at a puzzle in an adventure game. RIGHT SIDE: The same content transformed. A clean pixel project plan floats as a glowing holographic document - with clear phase labels as colored blocks, small task cards neatly stacked, tiny pixel avatar icons assigned to tasks, and a timeline bar flowing left to right. The guy's laptop terminal sits between the two sides, glowing teal as the bridge. Small teal pixel particles flow from the sticky notes through the terminal into the plan. He now looks satisfied, coffee in hand.

[Append style guide]

---

## Placement Guide

| Slide / Location | Image | Type |
|-----------------|-------|------|
| Title slide / hero | Prompt 1: "Matrix Moment" | Generate |
| Slide 2: Copilot Ladder | Prompt 4: "Ladder" | Generate |
| Slide 3: What Makes CLI Different | Prompt 2: "Chaos to Clarity" | Generate |
| Demo 1 card: Briefing Factory | Prompt 3: "Briefing Factory" | Generate |
| Demo 2 card: Workshop -> Plan | Prompt 5: "Sticky Notes to Strategy" | Generate |
| Setup page | Reuse `auth-device-flow.png` | Reuse (credit James) |
| Stand-alone avatar / social | Reference image as-is | Existing |

## How to generate

1. Open ChatGPT with GPT-4o image generation
2. Upload `Casual pixel avatar with coffee and laptop.png` as the reference
3. Paste the prompt + style guide
4. If the character drifts, re-upload the reference and say: "Match this character exactly - same pixel art style, same hair, same shirt with robot logo, same coffee cup"
5. Generate at 1024x1024 or 1792x1024 (wide) depending on slide layout
