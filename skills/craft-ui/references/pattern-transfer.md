# Pattern transfer — why the skill must not copy a hero recipe

This is the highest-priority failure mode in craft-ui. A reference image shows a *specific solution for a specific product*. The skill's job is to extract the style system, **not to transplant the solution**. If two unrelated products receive the same hero (lateral glow + dotted grid + floating dashboard, for example), the skill has failed even if the pixels look polished.

## The three-source rule

Every visual pattern must be justified by **two** sources before it enters the Design Contract:

| Source | Question it answers | Can it justify a pattern alone? |
|---|---|---|
| **A — production site** | Does this product actually have the content/feature that pattern shows? | **No** |
| **B — user request / reference** | Did the user ask for it, or does the reference actually show it? | **No** |
| **C — routing** | Is using it cheap and appropriate for this run? | **No** |

A reference alone is never enough. `seen in reference` is an observation, not a requirement.

## Archetype contamination

Common AI hero recipes that get copied blindly:

- lateral cyan/emerald glow + dotted grid + floating product dashboard;
- centered headline + one oversized product screenshot;
- split hero with code snippet on the right;
- dark editorial hero with a stock photo;
- three floating glass cards over a mesh gradient.

Each can be correct. None is a default. Before using one, answer:

1. Does the product have a real UI worth showing in the hero? If not, a dashboard mockup is decoration — cut it.
2. Does the product's visual identity use that color/treatment? If the live product is light and typographic, a dark glow hero is a costume.
3. Did the user ask for that composition? A "landing para minha padaria" does not inherit a developer-cloud hero because the reference pin did.
4. Would the same layout be plausible for a competitor in a different field? If yes, it is generic.

If any answer fails, the pattern is **rejected** even when the reference shows it. Keep the style tokens (palette, type, radius, density) — those are portable; the composition is not.

## Hero decision procedure (run before writing the wireframe)

1. Write one sentence from Agent A: what this product actually is and what the hero must make the visitor do.
2. List the reference's hero ingredients in Style DNA, each tagged `observed`.
3. For each ingredient, mark `adopt` / `adapt` / `drop` with a reason from A and from B. Example: "adopt centered headline — product has one clear message (A) and user asked for a direct landing (B)"; "drop floating dashboard — product has no UI to show (A), reference shows one but user never mentioned it (B)".
4. If more than one hero ingredient is `adopt` solely because of the reference, go back to step 1. The hero is not yet grounded.
5. Record the decision in the Design Contract's **Pattern adoption ledger**.

## Worked example (Hadix Cloud)

- `adopt` dark hero: product is a developer tool, live site uses dark surfaces (A); user asked to improve the existing landing, not change its identity (B).
- `adopt` product preview dock: the product has a real panel with projects, logs and deploy states (A); the reference shows it and the user called it the most important block (B).
- `drop` generic purple mesh / 3D object: product tokens are emerald and flat (A); reference does not show it (B).
- `adapt` lateral glow + dotted grid: both A (brand gradient/grid exist) and B (user's screenshot) support it, but keep it restrained — it is atmosphere, not the message.

The result belongs to Hadix. Applying the same three `adopt` lines to a bakery, a law firm or a course platform would be wrong even though the reference image is identical.

## Hard gate additions

Add these checks to step 2 of `SKILL.md` before any code:

- [ ] No hero/section pattern was adopted from the reference alone. Every `adopt` cites A and B.
- [ ] The composition would NOT be plausible for an unrelated product in a different field.
- [ ] Style tokens (colors, type, radius, density) are separated from composition patterns; only tokens are freely portable.
- [ ] The Pattern adoption ledger lists `adopt` / `adapt` / `drop` with reasons.

## Anti-patterns to report, not repeat

When the user says "a skill copia o padrão" / "fica com cara de template" / "é sempre o mesmo hero", treat it as a **contract bug**: the gate let a reference-only pattern through. Fix the ledger, not the CSS. Also say so plainly in the final reply — the user should know the skill learned the distinction.
