# Quality bar (professional delivery)

"Professional" here means the artifact can be handed to a client or shipped as a starting point without a reviewer finding the usual AI artifacts. These criteria are **non-negotiable even when `verbosity: terse`** — in terse mode they are checked silently, not skipped.

## Definition of done

A layout is done only when all five groups pass.

### 1. Context and content
- [ ] Product name, language and voice come from Agent A/B, not from invention.
- [ ] Every section in the spine carries real content from the content bank. No "Lorem", "Seu produto aqui", fake logos, invented metrics or testimonials.
- [ ] One primary action; labels are specific ("Começar grátis" beats "Saiba mais" when the goal is signup).
- [ ] Copy is proofread in the product language; no English leftovers in a pt-BR UI.

### 2. Structure and visual fidelity
- [ ] The section order **and topology** match the Design Contract spine and the reference (rows stay rows, grid stays grid, split stays split); no trendy filler section was added.
- [ ] No empty vertical band: content at every scroll position at 1440 and 390.
- [ ] Radii, elevation count, density and spacing come from the Style DNA — not one global card style.
- [ ] Palette limited to sampled tokens; no default purple/teal glow unless the reference shows it.
- [ ] One motion moment; trigger and easing match the reference; the rest is static.

### 3. Responsive and accessibility (WCAG AA baseline)
- [ ] 1440 / 768 / 390: no horizontal scroll, no clipped or overlapping text, no hidden primary action.
- [ ] One `<h1>`; use `<header>`, `<main>`, `<section>`, `<footer>` appropriately; nav has a label.
- [ ] Body text contrast ≥ 4.5:1, large text ≥ 3:1 against its **actual** background (including over gradients and blur).
- [ ] Visible `:focus-visible` ring on every interactive element; full keyboard reachability.
- [ ] Images have meaningful `alt` (or `alt=""` when decorative); icon-only buttons have `aria-label`.
- [ ] Form controls have associated labels; status and errors are announced where applicable.
- [ ] `prefers-reduced-motion: reduce` removes animation and shows the final state.
- [ ] No motion on keyboard-driven surfaces without user intent.

### 4. Performance and robustness
- [ ] One self-contained HTML file by default; tokens as CSS variables; no framework added unless the project already uses it.
- [ ] Fonts: at most one display + one body family with real fallbacks; `font-display: swap` when self-hosted.
- [ ] GSAP pinned version from cdnjs only when needed; no other runtime dependency without Agent C's approval.
- [ ] Images are appropriately sized and in a modern format when possible; explicit `width`/`height` or `aspect-ratio` to avoid layout shift.
- [ ] No console errors; the page is still readable if JS fails (hide-then-reveal elements are visible by default in CSS).
- [ ] No external asset from an untrusted or unknown host.

### 5. Handoff
- [ ] Code is lean: no dead selectors, no commented-out experiments, no unused libraries.
- [ ] Final reply states what was built, the evidence used, the verification result and one next change the user could request.
- [ ] Known limits are stated once (unseen reference, blocked site, approximated brand color).

## Verification protocol

1. Render at 1440, 768 and 390. Capture **full-page** screenshots, not just the viewport — empty bands only show up there.
2. Walk the page top to bottom and assert: section order, content presence, no empty band, no clipped text, no horizontal scroll.
3. Check contrast on the real rendered pixels — especially muted text over blur/gradient and text on dark surfaces.
4. Tab through the page; press Enter/Space on every control; toggle reduced motion and re-check.
5. Check the console for errors and failed requests.
6. Fix the largest visible difference first. Correction rounds: 1 for `terse`, up to 3 for `full`. Stop when the checklist passes — do not keep polishing.

## Non-goals

- Copying pixels, logos, illustrations or brand names from a reference.
- Inventing social proof to make a page look "complete".
- Adding animations, libraries or sections because they are fashionable.
- Shipping a layout that cannot be traced back to the site, the brief or a reference actually seen.
