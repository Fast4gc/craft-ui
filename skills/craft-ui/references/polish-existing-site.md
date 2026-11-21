# Polishing an existing site (not rebuilding it)

Use when the request is " essa landing está amadora", "melhora o layout do projeto", "olha o site em produção e conserta", or any task where a real codebase already has a working layout. This is a different job from reference-to-layout: **the product is already there; the work is elevation, not invention.**

## Principles

1. **Additive before destructive.** Append a scoped polish block (or a new override file) instead of rewriting existing CSS. The repo may contain uncommitted user work. Never overwrite tracked files wholesale; confirm with `git status` first.
2. **Screenshot first, inventory second.** Capture the current full page at 1440 / 768 / 390 before touching code. Write a short list of observed problems; do not fix from memory.
3. **Keep the information architecture.** If the site already has nine sections, do not reduce it to four because a reference has four. Improve what exists.
4. **Same voice, same tokens.** Read the project's design system and existing CSS variables. Reuse them; do not introduce a parallel palette, font or radius scale.
5. **Verify with the project's own commands.** Follow `AGENTS.md` / `README.md`: build before tests, run the relevant test suites, then screenshot again. A prettier page that breaks the build is not a delivery.

## The amateur signals checklist

These are the concrete things that make a working layout look unfinished. Check each one against the screenshot and fix it in place.

| Signal | Typical symptom | Fix |
|---|---|---|
| Micro-type | 8–11 px labels in mockups, charts, file trees, footers | Legibility floor: body copy 15–16 px, dense UI labels ≥ 11 px, footnotes ≥ 12 px. Mockups may be smaller only when decorative, never for information the user must read |
| Cramped rhythm | Section padding ~50–70 px on a 1440 canvas, content nearly touching dividers | Section spacing from the system scale, typically 80–120 px desktop / 60–80 px mobile; keep it consistent across sections |
| Raw loading/empty/error state | "Carregando…" or "Nenhum plano disponível" as bare text in a big card | Design these states: centered, generous padding, dashed or soft border, matching radius, clear retry action. They are part of the UI, not an exception |
| Weak hierarchy | Every card title the same size, muted text everywhere, links at 11 px | Restore the type scale: h2 40–56, card h3 19–24, body 15–16, links 13–14. Use the accent for actions and status, not decoration |
| Thin, colorless surfaces | 1 px low-contrast borders and flat panels with no elevation or warmth | Keep flat surfaces (matches developer tools), but strengthen borders with `color-mix` and use the existing surface/elevated tokens for depth |
| Tiny icon-only controls | Icons under 16 px without labels or hit areas | ≥ 40 px hit area, visible focus ring, text label or `aria-label` |
| Orphaned disclaimers | "Ilustração" / "Prévia" stuck at 9 px in a corner | 11–12 px with adequate contrast and clear association to the mockup |
| Inconsistent breakpoints | Fixes at 1000 px but not 800/600 px, or text shrinks on mobile | Check 1440 / 768 / 390 after every change; add overrides in the existing breakpoint blocks |

## Workflow

1. `git status --short` — record pre-existing modifications. Do not stage or discard them.
2. Capture baseline full-page screenshots at 1440 / 768 / 390 (browser tool). Note the top 3–5 amateur signals from the checklist.
3. Read the project's design tokens and the scoped CSS for the affected page. Add a clearly marked additive block at the end of that CSS with a short comment explaining why it exists.
4. Make only the changes on the checklist. Do not redesign sections, rewrite copy or add libraries.
5. Patch responsive breakpoints in the same block so the new type scale does not overflow at 390.
6. Run the project's build and tests, then re-screenshot the same three widths. Compare before/after and confirm no horizontal scroll, no clipped text, and no console errors.
7. Report: what changed, which signals were fixed, validation commands and results, and what you deliberately left alone.

## Handoff note

If the user later wants a reference-driven rebuild, the evidence gathered here (real tokens, real copy, section order) feeds the Design Contract in `design-contract.md`. Polishing first is often the best intake for a rebuild: it produces the truth about the product without guessing.
