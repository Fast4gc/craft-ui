# Motion and effects recipes

Contents: motion principles · Figma-style effects in CSS · GSAP setup · GSAP patterns · logo splash

## Motion principles
(Aligned with emil-design-eng. If that skill is installed, defer to it for interaction details.)
- Motion that answers a user action (hover, press, open, close) is fast: usually under 300 ms. Ease-out for things entering or responding, not ease-in, which feels sluggish.
- Orchestrated moments that run once (hero entrance, splash) can be longer, but keep them tight, and make them skippable or short enough that nobody waits.
- Animate `transform` and `opacity`. Avoid animating layout properties.
- One memorable moment per page. Do not add fade-and-slide-up to every section by default; only do it if the reference does.
- Always respect `prefers-reduced-motion`.

```css
:root {
  --ease-out: cubic-bezier(0.23, 1, 0.32, 1);
  --ease-in-out: cubic-bezier(0.77, 0, 0.175, 1);
  --ease-drawer: cubic-bezier(0.32, 0.72, 0, 1);
  --dur-fast: 150ms;
  --dur-base: 220ms;
}
.btn { transition: transform var(--dur-fast) var(--ease-out), background-color var(--dur-fast) var(--ease-out); }
.btn:active { transform: scale(0.97); }
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after { animation-duration: 0.01ms !important; transition-duration: 0.01ms !important; }
}
```

## Figma-style effects in CSS
Identify the effect in the reference first, then use the matching recipe. Check text contrast on top of each.

**Background blur (glass)**
```css
.glass {
  background: color-mix(in srgb, var(--surface) 55%, transparent);
  backdrop-filter: blur(20px) saturate(140%);
  -webkit-backdrop-filter: blur(20px) saturate(140%);
  border: 1px solid color-mix(in srgb, #fff 18%, transparent);
}
```
Glass only reads when something colorful sits behind it. Provide that layer.

**Layer blur / glow blobs**
```css
.blob { position:absolute; width:480px; aspect-ratio:1; border-radius:50%;
  background: radial-gradient(circle, var(--accent) 0%, transparent 70%);
  filter: blur(60px); opacity:.55; pointer-events:none; }
```

**Layered shadows (Figma "stacked drop shadow")**
```css
.card { box-shadow: 0 1px 1px rgb(0 0 0 / .04), 0 4px 8px rgb(0 0 0 / .05), 0 16px 32px rgb(0 0 0 / .06); }
```

**Inner shadow / inner highlight**
```css
.pill { box-shadow: inset 0 1px 0 rgb(255 255 255 / .35), inset 0 -1px 0 rgb(0 0 0 / .08); }
```

**Gradient border**
```css
.gborder { border:1px solid transparent;
  background: linear-gradient(var(--surface), var(--surface)) padding-box,
              linear-gradient(135deg, var(--accent), transparent 60%) border-box; }
```

**Mesh-like gradient**: stack 3 to 4 `radial-gradient(at x% y%, color, transparent 55%)` on the background.

**Grain / noise (no external image)**
```css
.grain::after { content:""; position:absolute; inset:0; pointer-events:none; opacity:.08; mix-blend-mode:overlay;
  background-image:url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200'><filter id='n'><feTurbulence type='fractalNoise' baseFrequency='.8' numOctaves='2' stitchTiles='stitch'/></filter><rect width='100%' height='100%' filter='url(%23n)'/></svg>"); }
```

## GSAP setup
Load from cdnjs with a pinned version. In published artifacts only cdnjs, jsDelivr `/npm/`, Tailwind CDN and jQuery hosts are allowed.
```html
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/gsap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.5/ScrollTrigger.min.js"></script>
```
Wrap everything in `matchMedia` so reduced motion gets the final state with no animation:
```js
gsap.registerPlugin(ScrollTrigger);
const mm = gsap.matchMedia();
mm.add("(prefers-reduced-motion: no-preference)", () => {
  // all animations here
});
```
Hide-then-reveal elements must be visible by default in CSS and only hidden by JS (`gsap.set`), so the page still works if the script fails.

## GSAP patterns
**Hero entrance (one timeline)**
```js
const tl = gsap.timeline({ defaults: { ease: "power3.out", duration: 0.8 } });
tl.from(".hero h1", { y: 32, opacity: 0 })
  .from(".hero p", { y: 20, opacity: 0 }, "-=0.5")
  .from(".hero .cta", { y: 16, opacity: 0 }, "-=0.5")
  .from(".hero .shot", { y: 48, opacity: 0, scale: 0.98 }, "-=0.6");
```

**Scroll reveal with stagger**
```js
gsap.from(".card", { y: 24, opacity: 0, stagger: 0.08, duration: 0.6, ease: "power2.out",
  scrollTrigger: { trigger: ".cards", start: "top 80%", once: true } });
```

**Pinned section / scrubbed progress**
```js
gsap.timeline({ scrollTrigger: { trigger: ".story", start: "top top", end: "+=1500", scrub: 0.6, pin: true } })
  .to(".story .a", { opacity: 0, y: -40 })
  .from(".story .b", { opacity: 0, y: 40 }, "<");
```
Use pinning only if the reference does, and test it on mobile.

**Marquee (constant motion uses linear)**
```js
gsap.to(".marquee-track", { xPercent: -50, ease: "none", duration: 24, repeat: -1 });
```
The track contains its content twice so the loop is seamless.

**Magnetic button (pointer devices only)**
```js
document.querySelectorAll(".magnetic").forEach(el => {
  const x = gsap.quickTo(el, "x", { duration: 0.4, ease: "power3" });
  const y = gsap.quickTo(el, "y", { duration: 0.4, ease: "power3" });
  el.addEventListener("pointermove", e => { const r = el.getBoundingClientRect();
    x((e.clientX - r.left - r.width / 2) * 0.25); y((e.clientY - r.top - r.height / 2) * 0.25); });
  el.addEventListener("pointerleave", () => { x(0); y(0); });
});
```

**Number count-up**
```js
const o = { v: 0 };
gsap.to(o, { v: 12840, duration: 1.2, ease: "power2.out", onUpdate: () => el.textContent = Math.round(o.v).toLocaleString() });
```

## Logo splash
Principles: total under about 2.5 s, plays once per session, can be skipped, and hands off to the first screen without a jump. Draw the sequence from the reference (what appears, in what order, what the exit is), using the user's mark.

```html
<div id="splash" role="presentation"> <!-- fixed, inset 0, bg token, z-index top -->
  <svg id="mark" viewBox="0 0 100 100"><path d="..." fill="none" stroke="currentColor" stroke-width="2"/></svg>
</div>
```
```js
(function () {
  const splash = document.getElementById("splash");
  const seen = (() => { try { return sessionStorage.getItem("splash"); } catch { return null; } })();
  const reduce = matchMedia("(prefers-reduced-motion: reduce)").matches;
  if (!splash || seen || reduce) { splash && splash.remove(); return; }
  try { sessionStorage.setItem("splash", "1"); } catch {}

  const path = splash.querySelector("path");
  const len = path.getTotalLength();
  gsap.set(path, { strokeDasharray: len, strokeDashoffset: len });

  const tl = gsap.timeline({ onComplete: () => splash.remove() });
  tl.to(path, { strokeDashoffset: 0, duration: 0.9, ease: "power2.inOut" })
    .to(path, { fill: "currentColor", duration: 0.3 }, "-=0.2")
    .to("#mark", { scale: 0.9, duration: 0.25, ease: "power2.in" }, "+=0.15")
    .to(splash, { yPercent: -100, duration: 0.6, ease: "power3.inOut" });
  splash.addEventListener("click", () => tl.progress(1));
})();
```
Start the hero entrance timeline from the splash's `onComplete` (or overlap its last 0.3 s) so the handoff reads as one motion. Variants from other references (letter-by-letter reveal, counter preloader, mask wipe, scale-to-fill) swap the middle of the timeline, not the structure.
