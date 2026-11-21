# Categories

Each section has a **genre baseline** (what this kind of screen needs to work, true regardless of style) and a **Reference DNA** slot. The baseline is never a substitute for the reference's actual look: once the user's images have been viewed, record their DNA in the slot so later runs start from it.

Contents: saas-app · crm-dashboard · landing-page · figma-effects · gsap-motion · logo-splash

---

## saas-app
Reference label: "Anotamy SaaS" (links in `assets/refs.json`).

Baseline:
- App shell: navigation (sidebar or top), a clear primary action, one main work area, one secondary panel at most.
- Show real product states: a populated view, plus empty and loading states if the screen has lists.
- Density follows the reference. Do not default to airy if the reference is compact.
- Use realistic content for the user's product, never "Lorem ipsum" or "Dashboard 1".

Reference DNA: _(fill after the image has been viewed)_

---

## crm-dashboard
Reference label: "Create a CRM" (pin and Payhip/UI Forge article in `assets/refs.json`). The article lists commercial UI kits; take structure and style only.

Baseline:
- The job of a CRM screen is scanning: what needs attention, who, and what next. Make that readable at a glance before any decoration.
- Typical modules: pipeline or deal stages, contact table with status chips, activity feed, key metrics, follow-up tasks. Include only those the user's flow needs.
- Tables: aligned numerals, one row height, truncated text with a clear tooltip or detail view, sortable headers.
- Status color is information. Keep a small, consistent set and pair color with a label or icon.
- Charts: few series, direct labels, no decorative gradients that change the reading of values.

Reference DNA: _(fill after the image has been viewed)_

---

## landing-page
Reference label: "Landing page layouts", 4 pins (`assets/refs.json`).

Baseline:
- The hero is the most characteristic thing about the product, shown in the form the reference uses (headline, product shot, demo, or illustration). One primary action.
- Section order serves the visitor's questions: what is it, does it work, who uses it, what does it cost, how do I start.
- Four references usually means four layouts. Choose one structure as the spine and borrow single ideas from the others (a section pattern, a nav style), and say which.
- Social proof and pricing use the user's real or clearly placeholder data, not invented logos of real companies.

Reference DNA: _(fill after the images have been viewed)_

---

## figma-effects
Reference label: "Figma Effects", 2 pins. Recipes: `references/motion-and-effects.md`.

Baseline: identify which Figma effect each reference shows (layer blur, background blur/glass, drop or inner shadow stacks, gradient fills or mesh, noise/grain, glow, strokes with gradient) and rebuild it in CSS or SVG. Keep text contrast readable on top of blurred or gradient surfaces.

Reference DNA: _(fill after the images have been viewed)_

---

## gsap-motion
Reference label: "GSAP effects" (pin in `assets/refs.json`). Recipes: `references/motion-and-effects.md`.

Baseline: a Pinterest pin is a still or short clip. Describe the motion you infer (trigger, what moves, order, duration) and confirm with the user if it is ambiguous. Prefer one orchestrated moment over many small effects.

Reference DNA: _(fill after the pin has been viewed)_

---

## logo-splash
Reference label: "Logos Splash", 2 pins. Recipe: splash section in `references/motion-and-effects.md`.

Baseline: a splash is a brand moment that should end fast and hand off cleanly to the first screen. Use the user's logo or a placeholder mark, never the reference's logo.

Reference DNA: _(fill after the images have been viewed)_
