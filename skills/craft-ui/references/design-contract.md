# The Design Contract

The contract is the single source of truth for the build. It is written after the three briefs and before any component. If a field cannot be filled with evidence, mark it `unknown` and ask the user — do not fill it with a genre default.

Even in `discovery: lite` mode, a shortened contract and the full gate below are mandatory; only the number of evidence sources shrinks. `lite` never means "skip the contract".

## Template

```
DESIGN CONTRACT
Sources: A = <site context> · B = <request/reference> · C = <routing>

1. Product & audience: ... (A; quote)
2. Goal / primary action: ... (A+B; ONE action)
3. Structure spine (ordered):
   1) <section> — job: <question it answers> — source: <A current site / B reference / B request> — content: <real copy/data>
   2) ...
   Cut rule: if a section has no job, no source or no content, remove it.
4. Content bank (real strings, product language):
   headlines: ... · nav: ... · CTAs: ... · features: ... · proof/prices: ... · footer: ...
5. Tokens (each with a source, never "default"):
   colors: bg __ surface __ text __ muted __ accent __ status __  (from <reference> / <site CSS>)
   type: display __ / body __ ; scale __ ; weights __
   radius: buttons __ cards __ inputs __ pills __
   space: base __ and rhythm __
   depth: elevation count __ and shadow recipe __
   motion: one moment — trigger __ property __ duration __ easing __
6. Reference traits: take from <ref> ... · take from <ref> ... · leave behind ...
7. Effects: <which effect and why> (max one hero moment)
8. Constraints: widths 1440 / 768 / 390 · a11y focus + reduced motion · stack <from project>
9. Economy: verbosity <from C> · skills used <from C> · reference files to read <from C>
10. Unknowns: resolved <how> · open questions asked <list>
```

## Hard gate

Before step 3 of `SKILL.md`, every box must be ticked:

- [ ] Each spine section has a job, a source and real content (no placeholder section).
- [ ] No empty band: the wireframe has content at every vertical position; spacing comes from the reference's rhythm, not from spacer divs.
- [ ] Every token cites a source; `unknown` tokens were asked about, not guessed.
- [ ] Copy is in the product's language and contains no invented brand, logo, metric or testimonial.
- [ ] Conflicts between A, B and the reference were reported by the subagents, then resolved by the **main agent** asking the user (one consolidated message, max 3 questions), not averaged. Subagents never ask the user themselves.
- [ ] C's verbosity and skill list are copied into block 9; no skill is run without a "why".

If any box fails, go back to the briefs or ask the user. Never "just build something reasonable".

## Keeping the contract stable

During build and verification, change the contract before changing the code when a new fact appears. If a screenshot shows an empty void or a random extra section, that is a **contract failure** — fix the spine, not the padding.
