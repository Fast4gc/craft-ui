---
name: craft-ui
license: MIT
description: "Use whenever the user says 'no estilo dessa referência', 'faz um layout nesse estilo', 'conserta essa landing', 'olha o site em produção', shares Pinterest/Dribbble pins, screenshots or image links, or asks for a dashboard CRM, landing page, GSAP/Figma effect or logo splash — even if they never say 'skill'. Reference- and context-driven layouts with three discovery agents (production site, request/references, skill/economy router) feeding a Design Contract before any code. SaaS apps, CRM dashboards, landing pages, Figma effects, GSAP motion, logo splash screens."
---

# Craft UI

Reference image in, working layout out — **but only after the product and the request are understood.**

The failure this skill exists to prevent: a plausible-looking page made of random sections, placeholder copy, default gradients and empty bands. It happens when an agent designs from genre habits instead of evidence. Here every structural and visual decision must trace back to one of three sources: the **live product**, the **user's brief**, or a **reference actually seen**. If a source is missing, gather it or ask for it. Never fill the gap with a default.

## Non-negotiable rules

1. **No code before the Design Contract** (step 2). No exception for "quick" pages: `discovery: lite` shortens the contract, it does not remove it. Economy is handled by the router, not by skipping context.
2. **Evidence over defaults.** Every token, section and copy line cites where it came from. "Typical for landing pages" is not a source.
3. **Structure is a spine, not a buffet.** Sections exist only if they answer a visitor question or a goal from the brief. See `references/anti-ai-slop.md`.
4. **Real content.** Product name, labels, data and language come from the site/brief. No lorem, no fake logos, no invented metrics, no "Seu produto aqui" unless the user approved a placeholder.
5. **Reply in the user's language** and build the UI in the product's language (a pt-BR product gets pt-BR copy).
6. **One memorable motion**, not a fade-up on every section.
7. **Tokens before components.** Colors, radii, type, spacing, shadows and easing live in CSS variables; components read only those.
8. **Economy is a decision.** The router sets verbosity and which skills run. Read only the reference sections that apply.
9. **Professional quality bar.** `references/quality-bar.md` is the definition of done — content, visual fidelity, responsive, WCAG AA, performance and handoff. `terse` checks it silently; it is never skipped.

## Workflow

### 0. Triage (main agent, seconds)
- Capture the user's request **verbatim**; note any URL, attachment, "não quero" constraint and verbosity cues ("só o código", "rápido", "me explica").
- Check what is available: subagent/Task tool, browser or web fetch, local repo, skills/MCP list.
- If the request is a tiny tweak to an existing file (one color, one spacing value), tell the router — it may set `discovery: lite`. A new page or a redesign always gets `discovery: full`.
- If the user says the existing layout is "amador", "precisa melhorar", "conserta essa landing" or points to a live site with code, read `references/polish-existing-site.md` and follow that path: additive polish of the real codebase, not a rebuild. Run `git status` before touching files.

### 1. Three discovery agents (run in parallel)
Use your subagent tool — OpenCode `subagent`, Claude Code `Task`/`Agent`, Codex `spawn_agent`, Cursor background agent. If there is no subagent tool, run the three passes sequentially in the main agent and label each with its heading. **Discovery agents do not write code.**

| Agent | Mission | Feeds the contract with |
|---|---|---|
| **A — Production Site Analyst** | Understand the site as it exists in production: product, audience, real copy, current structure, brand tokens, constraints. | SITE CONTEXT BRIEF |
| **B — Request & Reference Analyst** | Decode the actual request and extract Style DNA only from references really seen; search for references when none were given. | REQUEST BRIEF + STYLE DNA |
| **C — Skill Router / Economy** | Pick the minimum set of extra skills/tools for this run and set verbosity. | ROUTING DECISION |

Full specs, output schemas and word budgets: `references/agents.md`. Pass each agent the absolute skill-root path, its role spec, the user's raw request, and the URLs/attachments. Cap returns at their word budgets.

### 2. Design Contract — hard gate
Read `references/design-contract.md`. Merge A + B + C into one contract. Then check:
- [ ] Structure spine is ordered; each section has a job, a source, **a topology copied literally from the reference** and real content; there is no empty band.
- [ ] Every token and copy line cites a source; unknowns are marked, not invented.
- [ ] Conflicts between agents/site/reference were resolved by asking the user **one consolidated question** (max 3 items), not by guessing.
- [ ] Verbosity and skill list come from C; no skill is run "just because it exists".

Discovery subagents never ask the user — they only report `Gaps` / `Unknowns`. The **main agent** collects all three briefs, asks one consolidated question (max 3 items) and keeps the gate closed until it is answered. If a material fact is still unknown (product name, audience, real content, reference image), ask and stop. Do not start step 3.

### 3. Plan
Compact plan: tokens, ASCII wireframe of the spine, real copy/data bank, and the one motion moment with its trigger and reason. Compare against the reference and the site brief; anything that is a default rather than something observed gets revised or dropped.

### 4. Build
- One self-contained HTML file by default (CSS variables as tokens, Google fonts with real fallbacks). Use the project's existing React/Tailwind only if the user's project already uses it.
- Motion recipes: `references/motion-and-effects.md`. GSAP from a pinned cdnjs version.
- Keep code lean: no library or abstraction the layout does not need.
- Responsive at 1440 / 768 / 390, visible focus states, `prefers-reduced-motion` respected.
- Re-read `references/anti-ai-slop.md` while building — especially the empty-band and section-buffet rows.

### 5. Verify visually
Render and compare side by side with the reference and the site brief. Use a browser tool when available (routed by C). Run the verification protocol in `references/quality-bar.md`: full-page screenshots at 1440 / 768 / 390, section order and content presence, no empty band or clipped text, no horizontal scroll, real-pixel contrast, keyboard focus, reduced motion and console errors. Check hierarchy, spacing rhythm, radius/shadow consistency, density and language. Correction rounds: 1 when verbosity is `terse`, up to 3 when `full`; fix the largest visible difference first and stop when the checklist passes.

### 6. Reply
Format from C's verbosity. `terse`: 3–5 lines — what was built, evidence used, verification result. `full`: also list which reference traits were taken from where, skills used/skipped and one suggested next change. Follow the handoff criteria in `references/quality-bar.md`, state known limits once, and always write in the user's language.

## Using other skills

Agent C decides this per run; check what is actually available in the session first. Missing skill → use the fallback and mention it once at the end.

| Phase | If C says use | Fallback |
|---|---|---|
| Plan / design direction | **Impeccable** (`/impeccable shape`, then `craft`); run its context step once per session | `frontend-design`, or the step 3 plan |
| Review and polish | **Impeccable** `critique`, `polish`, `audit` | Self-review against the contract |
| Motion quality | **emil-design-eng** for easing, duration, springs, hover/press | `references/motion-and-effects.md` |
| Visual verification | Browser MCP (Chrome DevTools / Claude in Chrome / developer-mcp-chrome): screenshot at 3 widths, check console | Describe the checks and ask the user for a screenshot |
| 3D logo or object | **img2threejs** only if the reference contains a 3D object worth rebuilding; state its limit: one image cannot reveal hidden sides | Flat SVG or CSS |
| Keeping code small | **ponytail** before adding any dependency | Plain CSS + one GSAP timeline |

Only call a skill when its phase applies. A static landing page does not need img2threejs.

## Originality and safety
- Recreate patterns, not assets. Never reuse a reference's logo, illustrations, brand name or exact copy. Use the user's brand and real content from A/B.
- Many pins link to commercial UI kits. Match style and structure only.
- A reference's look is a starting point. If it hurts usability (low contrast, tiny type), keep the mood, fix the problem, and say so.

## Files
- `references/agents.md` — the three discovery agents, schemas and budgets.
- `references/design-contract.md` — merge template and hard gate.
- `references/anti-ai-slop.md` — symptoms and fixes for generic, stacked, empty layouts.
- `references/quality-bar.md` — professional definition of done and verification protocol.
- `references/polish-existing-site.md` — additive workflow when the task is to elevate an existing production layout.
- `references/categories.md` — genre baselines (minimum viability, not section menus).
- `references/style-dna.md` — reference reading template; requires evidence.
- `references/motion-and-effects.md` — CSS effects and GSAP recipes.
- `assets/refs.json` — known reference links (still require viewing).
