# Changelog

## 0.2.2
- **Anti-contaminação de arquétipo:** `pattern-transfer.md` impede que um hero de referência (glow lateral + grid + dock) seja transplantado para produtos sem relação. Tokens são portáveis; composição não.
- Design Contract agora exige **Pattern adoption ledger** com evidência A + B por ingrediente (`adopt`/`adapt`/`drop`) e gate extra no SKILL.md.
- Agentes A e B passam a declarar respectivamente o que o produto suporta e o que foi apenas observado na referência.

## 0.2.1
- **Polimento de site existente:** `polish-existing-site.md` com fluxo aditivo (respeita trabalho não commitado), checklist de sinais amadores (micro-tipografia, ritmo apertado, estados vazios crus) e verificação antes/depois.
- Quality bar e anti-slop ganham piso de legibilidade (corpo 15–16 px, rótulos ≥ 11 px) e exigência de estados de carregamento/vazio/erro projetados.
- Validado em produção real: landing do Hadix polida no CSS escopo, `npm run build` + 166 testes + 7 testes de SEO verdes.

## 0.2.0
- **Descoberta em 3 agentes antes de qualquer código:** A analisa o site em produção, B decodifica o pedido e busca/analisa referências, C escolhe skills extras e define verbosidade/economia. Fallback sequencial quando não há subagents.
- **Design Contract como gate obrigatório:** estrutura, conteúdo real e tokens com origem citada; pergunta quando falta informação em vez de inventar.
- **Anti "feito por IA":** checklist de sintomas (faixa vazia, pilha de seções, placeholder, gradientes padrão, fade-up em tudo, idioma errado) e teste de rejeição por seção.
- Style DNA agora exige `Evidence: seen` e fonte; categories.md deixa claro que o baseline é mínimo de viabilidade, não cardápio de seções.
- Economia de tokens passa a ser decisão explícita do router (`terse`/`full`, leitura seletiva de referências, `discovery: lite` só para ajustes mínimos).
- **Padrão profissional:** `quality-bar.md` com definition of done (conteúdo, fidelidade, responsividade, WCAG AA, performance, handoff) e protocolo de verificação com screenshots de página inteira; a economia nunca reduz os critérios de aceite.

## 0.1.0
- First release of the `craft-ui` skill: reference intake (Style DNA), plan, build, visual verification.
- Categories: SaaS app, CRM dashboard, landing page, Figma effects, GSAP motion, logo splash.
- Orchestration with Impeccable, emil-design-eng, browser MCP, img2threejs and ponytail, with built-in fallbacks.
- Installers for macOS/Linux (`install.sh`) and Windows (`install.ps1`); Claude Code plugin manifest.
