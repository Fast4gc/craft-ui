---
name: craft-ui
license: MIT
description: Turns Pinterest/Dribbble-style visual references into real, built layouts (SaaS app screens, CRM/admin dashboards, landing pages, Figma-style effects, GSAP scroll/entrance motion, logo splash/preloader screens). Use whenever the user shares Pinterest or Dribbble pins, screenshots or image links as inspiration, or says things like "faz um layout nesse estilo", "no estilo dessa referência", "refs do Pinterest", "clone o estilo", "dashboard CRM", "landing page", "efeito GSAP", "efeito Figma", "splash do logo", "tela de abertura", even if they never say "skill". Orchestrates other design skills (Impeccable, emil-design-eng, browser/Chrome MCP, img2threejs, ponytail) when installed, with built-in fallbacks when they are not.
---

# Craft UI

Reference image in, working layout out. The job is to extract the **style system** of a reference (palette, type, radius, depth, density, grid, motion) and rebuild it as real code for the user's own content. Copying pixels or assets is not the goal: it produces weaker work and borrows someone else's design.

## Workflow

Follow these phases in order. Skipping the intake is the most common way to produce a generic result.

### 1. Classify the request
Pick one or more categories and read `references/categories.md` for those sections only:
`saas-app` · `crm-dashboard` · `landing-page` · `figma-effects` · `gsap-motion` · `logo-splash`

Known reference links live in `assets/refs.json`.

### 2. Reference intake (never guess)
- If images are attached or visible: analyze them with vision and write a **Style DNA** using the template in `references/style-dna.md`.
- If the user only gave URLs: try to fetch them. Pinterest (`pinimg.com`, `pinterest.com`) blocks automated access, so this usually fails. When it does, say so in one sentence and ask the user to attach the images or screenshots. Do not describe a reference you have not seen, and do not substitute the genre baseline in `categories.md` while presenting it as the reference.
- If there are several references, note what to take from each (e.g. layout from A, color from B, motion from C). Ask only if that split is unclear.

### 3. Plan before code
Write a compact plan: Style DNA, page/screen structure (ASCII wireframe), real copy and data for the user's product, and which effects appear and why. Review it against the reference: anything that is a default rather than something the reference shows gets revised or dropped.

### 4. Build
- Output: one self-contained HTML file by default (CSS variables as tokens, system and Google fonts with real fallbacks). Use React/Tailwind only if the user's project already uses it.
- Motion and effects: `references/motion-and-effects.md`. GSAP loads from cdnjs at a pinned version.
- Keep the code lean. Do not add libraries or abstractions the layout does not need (see the ponytail row below).
- Responsive at 1440 / 768 / 390, visible focus states, `prefers-reduced-motion` respected.

### 5. Verify visually
Render it and compare against the reference side by side. Use a browser tool when one exists (see table). Check hierarchy, spacing rhythm, radius and shadow consistency, contrast, and that effects match the reference's intensity. Do at most 2 or 3 correction rounds, fixing the largest visible differences first.

## Using other skills

Check which skills and MCP tools are actually available in this session before relying on any. If one is missing, use the fallback and mention it once at the end, not repeatedly.

| Phase | If available | Fallback |
|---|---|---|
| Plan / design direction | **Impeccable** (`/impeccable shape`, then `craft`); run its context step once per session | `frontend-design` skill, or the plan in step 3 |
| Review and polish | **Impeccable** `critique`, `polish`, `audit` | Self-review against the reference |
| Motion quality | **emil-design-eng** for easing, duration, springs, hover and press states | `references/motion-and-effects.md` |
| Visual verification | Browser MCP (Chrome DevTools / Claude in Chrome / developer-mcp-chrome): screenshot at 3 widths, check console | Describe what to check and ask the user for a screenshot |
| 3D logo or object | **img2threejs** only when the reference contains a 3D object worth rebuilding, such as a splash or hero. Always state its limit: one image cannot reveal hidden sides | Flat SVG or CSS treatment |
| Keeping code small | **ponytail** before adding any dependency or abstraction | Prefer plain CSS and a single GSAP timeline |

Only call a skill when its phase actually applies. A static landing page does not need img2threejs.

## Originality and safety
- Recreate patterns, not assets. Do not reuse a reference's logo, illustrations, brand name, or exact copy. Use the user's brand and real content.
- Many pins link to commercial UI kits. Match the style system and structure only.
- A reference's look is a starting point. If it hurts usability (low contrast, tiny type), keep the mood and fix the problem, and say so.

## Final reply
Short: what was built, which reference traits were taken from where, which skills were used or skipped, and what the user could ask to change next.
