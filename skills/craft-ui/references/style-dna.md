# Style DNA: reading a reference

Use this on every reference image before designing. Fill the template from what is visible. Mark anything you cannot see as "unknown" instead of inventing it. A DNA written from a category baseline or from an unseen link is **invalid** — it must say `Evidence: seen` and name the image it came from. This is the main defense against "feito por IA" layouts.

## How to look
1. First impression in one line (mood, era, density).
2. Structure: grid, columns, sidebar or none, section order, alignment.
3. Surfaces and depth: flat, bordered, shadowed, glass, layered. Count how many distinct elevation levels exist.
4. Shape language: radius per element type (buttons, cards, inputs, avatars), not one global value.
5. Color: sample 4 to 6 values (background, surface, text, muted text, accent, status). Estimate hex values and say they are estimated.
6. Type: classify (grotesk, geometric, serif, mono), weights used, size contrast between headline and body, tracking. Suggest a close, freely available family.
7. Details that carry the style: icon style and stroke weight, chart style, badge shape, divider treatment, image treatment, grain or blur.
8. Motion (only if the reference is a video, GIF, or the user describes it): trigger, property, duration, easing.

## Template

```
STYLE DNA: <reference name>
Source: <attached image / file / url> · Evidence: seen | not seen
Mood: ...
Structure: ...
Surfaces / depth: ...
Radius: buttons __ cards __ inputs __ pills __
Color (estimated): bg #____ surface #____ text #____ muted #____ accent #____ status #____
Type: display ____ / body ____ ; scale ____ ; weights ____
Signature details: ... (the 2-3 things that make it recognizable)
Motion: ...
Take from this reference: ...
Leave behind: ... (anything that hurts usability or is brand-specific)
```

## Multiple references
Give each its own DNA, then merge into one token set. Where two references conflict, pick one and say which. Do not average them, since averaged styles look muddy.

## Tokens
Turn the DNA into CSS variables before writing any component: colors, radii, shadows, spacing scale, type scale, easing, durations. Components then read tokens only, so a change to the reference interpretation is a one-place edit.

Never fill a token from the genre baseline in `categories.md`. The baseline says what a screen needs to function; the DNA says what this reference actually looks like. If the DNA has `unknown` for a token, leave it unknown in the Design Contract and ask the user — do not default to a palette, radius or font that "feels right".
