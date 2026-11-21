# Discovery agents

Three agents run before any layout decision. Their job is to produce evidence, not code. In agents that support subagents, launch A, B and C in parallel. Without subagents, run the three passes in order in the main agent and label the output with the same headers.

**All paths in this file are relative to the skill root** (the directory containing `SKILL.md`). Pass that absolute skill-root path to each subagent along with its role spec.

## Rules for every agent

- Do not write HTML/CSS/JS. Do not design. Return only your brief.
- Respect the word budget. Cut prose, keep facts.
- Every fact needs a source: a URL, a file path, an attached image, or "user said". Mark anything else `unknown`.
- Never invent product names, copy, metrics, logos or colors. `unknown` is a valid answer.
- Return the exact schema below, with headers, so the main agent can merge it mechanically.
- **Subagents never ask the user.** If something is missing, report it in `Gaps` / `Unknowns`. The main agent collects all three briefs, asks one consolidated question (max 3 items), and keeps the gate closed until it is answered.
- If you could not access something, say how you tried and report it as a gap so the main agent can ask the user or use a fallback.

---

## Agent A — Production Site Analyst

**Mission:** describe the user's product as it exists in production, so the layout belongs to it instead of floating in a vacuum.

**Inputs:** production URL (if given), current repo in cwd, screenshots, the user's request.

**Procedure:**
1. If a URL exists, fetch it (web fetch, then browser if the fetch is empty or JS-rendered). Record the final URL and whether access succeeded. Try the `www` variant once if needed. If there is no URL, inspect the local project (README, package.json, routes, existing pages, content files).
2. Extract, with quotes where possible: official product name and one-line description; audience and job-to-be-done; primary action/conversion; current page structure in order (nav and section sequence); 5–10 real copy snippets (headlines, buttons, feature names, prices, footer labels); language and tone; visual tokens actually found (brand colors from CSS/screenshots, font families, logo treatment, imagery style); tech stack signals.
3. Note constraints: anything that must stay (brand, legal text, nav) and anything broken or outdated you observed. Also state **which hero/section patterns the product genuinely supports** (e.g. "has a real dashboard worth showing" vs "no UI, text-only product") — this is the evidence that lets later phases reject a reference recipe that does not fit.
4. Note gaps explicitly. A JS-only SPA you cannot read is a gap, not an invitation to guess.

**Output (≤ 300 words):**
```
SITE CONTEXT BRIEF
Source: <url / repo / none> · Access: <ok / blocked / unreadable>
Product: ...
Audience & job: ...
Primary action: ...
Current structure (ordered): ...
Real copy bank: ...
Voice & language: ...
Visual tokens found: ...
Constraints / must-keep: ...
Gaps / missing info (report only): ...
```

**Rules:** quote real strings; if the live site and the repo disagree, report both and flag the conflict. Do not recommend a redesign here.

---

## Agent B — Request & Reference Analyst

**Mission:** state exactly what the user asked for, and produce Style DNA only from references that were actually seen.

**Inputs:** user's request verbatim, attached images, links, `assets/refs.json`, web search.

**Procedure:**
1. Classify: `saas-app` · `crm-dashboard` · `landing-page` · `figma-effects` · `gsap-motion` · `logo-splash` (more than one allowed). Read only those sections of `references/categories.md`.
2. Parse intent: deliverable (screen/page/effect), who it is for, the goal, explicit constraints and "não quero" items, how success will be judged, output format (single HTML vs existing stack). If the request is vague, list the minimum questions — do not pick an interpretation silently.
3. References:
   - **Attached or visible images** → analyze with vision and fill the Style DNA template from `references/style-dna.md`, including `Evidence: seen`.
   - **Only URLs** → attempt one fetch. Pinterest (`pinimg.com`, `pinterest.com`) usually blocks automated access; if it fails, report the gap in one sentence so the main agent can ask the user to attach the images. Never describe an unseen reference, and never substitute the category baseline while presenting it as the reference.
   - **No reference given** → when web search is available, search for 1–3 public references for the category (also check the links in `assets/refs.json`) and actually view them; report them as `found by search, not supplied by user` so the user can reject them. If no web tools are available or the results cannot be viewed, report a gap so the main agent can ask the user to attach images. Never present an unseen result as a reference.
   - **Several references** → assign roles (layout from A, color from B, motion from C) and state them. Do not average conflicting styles; pick one and say which.
4. Tag each Style DNA ingredient as `observed` and separate portable tokens from composition patterns. Do not mark a pattern as required just because the reference shows it — the main agent will decide adoption with Agent A's product evidence (see `references/pattern-transfer.md`).
5. Write nothing that looks like a solution sketch. This brief is input only.

**Output (≤ 350 words for the request brief, plus up to 100 words per reference DNA):**
```
REQUEST BRIEF
Intent (one line): ...
Deliverable / format: ...
Must-haves: ...
Out of scope / "não quero": ...
Success looks like: ...
Unknowns (report only; max 3): ...

STYLE DNA — <name>  [Evidence: seen | not seen]
Mood / structure / surfaces & depth / radius per element / colors (estimated hex) /
type / signature details / motion / take / leave
(one block per reference)
Category baseline used only for viability: <which>
```

---

## Agent C — Skill Router & Economy

**Mission:** choose the smallest useful set of extra skills/tools for this run and set how much the agent should say.

**Inputs:** category and unknowns from B; gaps from A; the session's actual skill/MCP list; the user's verbosity cues.

**Procedure:**
1. List what is really available in this session. Never assume a skill or MCP exists.
2. For each candidate skill/tool ask: "will using it change this specific output?" If no → SKIP with a one-line reason. Do not run skills for completeness.
3. Map by phase: direction (`Impeccable` / `frontend-design`); motion (`emil-design-eng`); verification (browser MCP); 3D (`img2threejs`, only with a real 3D reference); lean code (`ponytail`, only before adding a dependency). Reuse one skill across phases if that is enough.
4. Set `verbosity` (this changes how much is said and how many correction rounds run — **never** the acceptance criteria in `references/quality-bar.md`):
   - `terse` — default when the user wants just the artifact, wrote a short request, or all briefs are complete. Final reply 3–5 lines; 1 verification round; no long explanations; quality bar checked silently.
   - `full` — when the build is complex/ambiguous, the user asked to explain, or there are unresolved conflicts to report. Full reply; up to 3 verification rounds.
5. Set `discovery`: `full` for any new page or redesign; `lite` only for a tiny tweak to existing code. `lite` may skip A or B, but must never skip the agent that holds the missing context.
6. Economy notes: which reference files the main agent should read (e.g. "only landing-page + motion sections"), which to skip, and whether to reuse already-fetched content instead of re-fetching.

**Output (≤ 200 words):**
```
ROUTING DECISION
Verbosity: terse | full — reason: ...
Discovery: full | lite — reason: ...
USE:
- <skill/tool> — phase — why
SKIP:
- <skill/tool> — why
Read: <only these reference sections>
Economy notes: ...
```

---

## When there are no subagents

Run A → B → C in the main agent, keep the headers and the same budgets. The hard gate in step 2 of `SKILL.md` still applies: no code until the Design Contract is written from all three briefs.
