# Anti "feito por IA" checklist

Read this before the plan and again before the final screenshot. A layout can be pixel-clean and still read as generic. These are the symptoms and the concrete fix for each.

| Symptom | Why it reads as AI | Fix |
|---|---|---|
| Huge empty band in the middle of the page (600–900 px of nothing between sections) | Sections were placed to fill a template, not to carry content; spacing used as decoration | Give every section real content from the content bank; derive vertical rhythm from the reference; delete spacer divs; check the full-page screenshot at 1440 and 390 and require content at every scroll position |
| Random section stack: hero → features → logos → testimonials → pricing → FAQ → CTA → footer on every project | Genre habit instead of the brief | Build the spine from A/B; each section must answer a named visitor question; cut sections with no real content. A 3-section page with real content beats an 8-section page with filler |
| **Wrong topology:** turning the reference's vertical rows (copy left + preview right) into a 3-card grid, or a split section into stacked blocks | The agent normalized the reference into a familiar pattern — this is a silent, high-impact failure | Copy the topology literally into the Design Contract: rows stay rows, grids stay grids, bento stays bento. Before coding, compare the wireframe's left/right split and stacking order with the reference. If they differ, the contract is wrong — fix it, not the padding |
| **Borrowed hero recipe:** same lateral glow + dotted grid + floating dashboard on unrelated products | The reference's composition was transplanted instead of its style system | Run `references/pattern-transfer.md`. Require A + B evidence for every adopted ingredient; if the hero would fit a different industry, drop the recipe and keep only the tokens |
| Placeholder copy ("Lorem ipsum", "Dashboard 1", "Seu produto aqui"), fake logos, invented "10.000+ clientes" | No evidence was gathered | Pull strings from Agent A/B; if none exist, ask the user; if the user approves placeholders, mark them visibly as such in the contract |
| Default purple/teal glow blobs and mesh gradients | The "AI gradient" reflex | Use only colors sampled from the reference or the live site; glows only if the reference shows them; no radial blob hero by default |
| Every block is an identical card with equal padding and the same radius | One global token applied everywhere | Radius and density per element type from Style DNA; let hierarchy change size and elevation; the reference decides how many elevation levels exist |
| Every section fades and slides up on scroll | Scroll-reveal default from tutorials | One orchestrated moment (usually the hero); the rest is static unless the reference shows otherwise |
| Two identical CTA buttons, "Trusted by" with made-up companies | Conversion cliché | One primary action; real proof only, otherwise omit the block |
| Emoji or generic icon-set look that does not match the reference | Default asset choice | Match the reference's icon stroke style, or use simple geometric marks built from tokens |
| English labels inside a pt-BR product (or the reverse) | Language was never checked | Agent A reports the product language; all UI copy and the final reply follow it |
| Tiny body text with enormous section padding | Airy-by-default density | Match the reference's density; keep body text readable (16px+ as a baseline); use the reference's scale, not a "premium" guess |
| Micro-type: 8–11 px labels in previews, charts and footers | Looks like a screenshot shrunk to fit, not a product | Legibility floor: meaningful labels ≥ 11 px, footnotes ≥ 12 px, body 15–16 px. Only purely decorative mockup detail may be smaller |
| Cramped sections (~50–70 px padding) on a 1440 canvas | No rhythm system; sections glued together | Use the project's section scale, typically 80–120 px desktop / 60–80 px mobile, consistently |
| Raw "Carregando…" / "Nenhum plano disponível" as bare text in a large card | Empty states treated as an afterthought | Design them: centered, generous padding, soft/dashed border, matching radius and a retry action when applicable |
| Long page for the sake of looking impressive | Length mistaken for completeness | Compare section count and word count with the reference; if the reference has four sections, do not ship nine |

## 30-second rejection test

For each section in the wireframe, answer in one line:

1. What question does it answer, or what job does it do?
2. Where did it come from (live site / user request / named reference)?
3. What is the exact real content inside it?

A section that fails any of the three gets cut **before** code. A page that passes is specific to this product and cannot be swapped with another product's — that is the opposite of "feito por IA".

## When the reference is weak

If the reference is low-contrast, tiny-typed or structurally confusing, keep its mood but fix the usability problem and say so in the final reply. "Faithful" is not a reason to ship unreadable text.
