<div align="center">

# craft-ui

**Da referência do Pinterest ao layout pronto.**
Uma skill para agentes de código que lê o estilo de uma imagem e reconstrói em código real: SaaS, CRM, landing pages, efeitos Figma, GSAP e splash de logo.

![license](https://img.shields.io/badge/license-MIT-blue)
![format](https://img.shields.io/badge/format-Agent%20Skill%20(SKILL.md)-6f42c1)
![agents](https://img.shields.io/badge/agents-Claude%20Code%20%C2%B7%20Codex%20%C2%B7%20Trae%20%C2%B7%20Cursor%20%C2%B7%20Gemini%20%C2%B7%20%2B5-111)

</div>

---

## O que ela faz

Você manda uma referência (print, pin, imagem) e pede "faz nesse estilo" — ou só aponta o site em produção e pede para consertar a landing. A skill não copia pixels: extrai o **sistema de estilo** da imagem (paleta, tipografia, raios, sombras, densidade, grid, motion) e reconstrói com o **seu** conteúdo.

Antes de escrever qualquer linha de código, ela roda **três agentes de descoberta**: um entende o site em produção, outro decodifica o pedido e busca/analisa referências, e o terceiro decide quais skills extras usar e o quanto falar. O resultado é um **Design Contract** — estrutura, conteúdo real e tokens com origem — que trava o layout e impede o resultado genérico ("feito por IA").

| Categoria | Entrega |
|---|---|
| `saas-app` | Telas de aplicativo SaaS com shell, navegação e estados reais |
| `crm-dashboard` | Dashboards de CRM/admin legíveis "num relance": pipeline, tabelas, status |
| `landing-page` | Landing pages com hero, seções e CTA seguindo a estrutura da referência |
| `figma-effects` | Glass, blur, sombras em camadas, gradiente, grain e glow em CSS/SVG |
| `gsap-motion` | Entradas, scroll reveal, pin, marquee, botão magnético, contadores |
| `logo-splash` | Tela de abertura com a sua marca, curta, pulável e com handoff limpo |

### Fluxo

```
pedido do usuário + URL do site + referências
        │
        ├─► Agente A: site em produção ─► SITE CONTEXT BRIEF
        ├─► Agente B: pedido + referências ─► REQUEST BRIEF + STYLE DNA
        └─► Agente C: router de skills/economia ─► ROUTING DECISION
        │
        ▼
DESIGN CONTRACT (gate: sem código antes dele)
        ▼
plano (tokens + wireframe) ─► código ─► screenshot e comparação ─► ajustes
```

1. **Descoberta (3 agentes, em paralelo quando possível):** A lê o site em produção e o repo; B entende o pedido, busca referências quando não vieram nenhuma e escreve o Style DNA só do que realmente viu; C escolhe o mínimo de skills extras e define `terse` ou `full`.
2. **Design Contract:** fusão dos três briefs. Cada seção tem um trabalho, uma origem e conteúdo real; cada token cita sua fonte. Se faltar informação, a skill pergunta — nunca inventa.
3. **Plano:** tokens (cor, tipo, raio, sombra, easing) e wireframe antes de qualquer componente.
4. **Build:** HTML autocontido por padrão, responsivo (1440 / 768 / 390), com `prefers-reduced-motion` respeitado e o checklist anti-IA aplicado.
5. **Verificação:** compara com a referência e com o site lado a lado, exige conteúdo em toda a altura da página e corrige as maiores diferenças primeiro.

### Os três agentes

| Agente | O que ele responde | Entrega |
|---|---|---|
| **A — Produção** | Quem é o produto, para quem, o que diz hoje, qual é a ação principal e quais tokens já existem | `SITE CONTEXT BRIEF` (≤ 300 palavras) |
| **B — Pedido e referência** | O que o usuário realmente quer, o que está fora de escopo, e como é a referência vista | `REQUEST BRIEF + STYLE DNA` (≤ 350 palavras + 100 por referência) |
| **C — Router e economia** | Quais skills usar (e quais pular com motivo) e se a resposta será curta ou completa | `ROUTING DECISION` (≤ 200 palavras) |

Especificações, schemas e orçamento de palavras: `skills/craft-ui/references/agents.md`. Sem ferramenta de subagent, os três passos rodam sequencialmente no próprio agente, com os mesmos cabeçalhos.

### Economia de tokens

A economia é uma decisão do agente C, não um atalho que pula contexto:

- `terse` (padrão quando o usuário quer só o artefato): resposta final de 3–5 linhas e 1 rodada de verificação.
- `full`: explicação completa, traits da referência citados e até 3 rodadas de verificação.
- Só os arquivos de referência necessários são lidos; `discovery: lite` vale apenas para ajustes minúsculos em código existente, nunca para uma página nova — e mesmo assim o Design Contract encurta, nunca desaparece.

### Anti-cópia de padrão

`skills/craft-ui/references/pattern-transfer.md` ataca o erro mais caro: a skill ver um hero com glow lateral + grade de pontos + dock flutuante e replicar isso em qualquer produto. Agora **tokens de estilo são portáveis; composição não**. Cada padrão admitido entra no Design Contract com evidência do produto (agente A) **e** do pedido (agente B) — se o layout serviria para uma padaria ou um escritório de advocacia, ele é rejeitado.

### Anti "feito por IA"

`skills/craft-ui/references/anti-ai-slop.md` ataca os sintomas que geram o layout errado: faixa vazia no meio da página, pilha aleatória de seções, texto placeholder, gradientes padrão, cards todos iguais, fade-up em tudo, idioma errado e páginas longas sem conteúdo. Regra rápida: para cada seção, diga **qual pergunta ela responde, de onde veio e que conteúdo real contém** — se não der, ela é cortada antes do código.

### Polir um site que já existe

Quando o pedido é "essa landing está amadora", a skill não reconstrói: ela segue `skills/craft-ui/references/polish-existing-site.md`. O fluxo é **aditivo** (respeita alterações não commitadas), começa com screenshots antes/depois em 1440/768/390 e ataca sinais concretos: micro-tipografia, ritmo de seções apertado, hierarquia fraca e estados de carregamento/vazio/erro crus. A verificação usa os comandos do próprio projeto (build + testes) antes de declarar entrega.

### Padrão profissional

`skills/craft-ui/references/quality-bar.md` é o definition of done: conteúdo real, fidelidade visual, responsividade em 1440/768/390, base WCAG AA (contraste, foco, semântica, reduced motion), performance/robustez e handoff limpo. O protocolo de verificação usa screenshots de página inteira — é assim que uma faixa vazia aparece. Vale para modo `terse` e `full`; a economia muda o quanto se fala, nunca o que é aceitável entregar.

## Instalação

### Opção 1: `npx skills` (mais simples, vários agentes)

```bash
npx skills add Fast4gc/craft-ui
# só alguns agentes, no escopo do usuário:
npx skills add Fast4gc/craft-ui -g -a claude-code -a codex
```

### Opção 2: instalador do repositório

**macOS / Linux**
```bash
git clone https://github.com/Fast4gc/craft-ui.git && cd craft-ui
./install.sh                         # todos os agentes detectados
./install.sh -a claude,codex,trae    # agentes específicos
./install.sh -p -a trae              # só no projeto atual
./install.sh --link                  # symlink: atualiza com git pull
```

Sem clonar:
```bash
curl -fsSL https://raw.githubusercontent.com/Fast4gc/craft-ui/main/install.sh | bash -s -- -a claude
```

**Windows (PowerShell)**
```powershell
git clone https://github.com/Fast4gc/craft-ui.git; cd craft-ui
.\install.ps1                              # agentes detectados
.\install.ps1 -Agent claude,codex,trae
.\install.ps1 -Project -Agent trae
```

### Opção 3: plugin do Claude Code
```
/plugin marketplace add Fast4gc/craft-ui
/plugin install craft-ui@craft-ui
```

### Opção 4: manual ou importar arquivo
Copie `skills/craft-ui/` para a pasta de skills do seu agente (tabela abaixo). No **Trae**, também dá para importar `craft-ui.skill` (gerado com `./scripts/package.sh` ou baixado em Releases), que é um zip com `SKILL.md` na raiz.

### Agentes suportados

| Agente | Pasta do usuário | Pasta do projeto |
|---|---|---|
| Claude Code | `~/.claude/skills/` | `.claude/skills/` |
| Codex | `~/.codex/skills/` | `.agents/skills/` |
| Trae | `~/.trae/skills/` | `.trae/skills/` |
| Cursor | `~/.cursor/skills/` | `.cursor/skills/` |
| Gemini CLI | `~/.gemini/skills/` | `.gemini/skills/` |
| Antigravity | `~/.gemini/antigravity/skills/` | `.agent/skills/` |
| OpenCode | `~/.config/opencode/skills/` | `.opencode/skills/` |
| Kiro | `~/.kiro/skills/` | `.kiro/skills/` |
| GitHub Copilot | `~/.copilot/skills/` | `.github/skills/` |
| Cline | `~/.cline/skills/` | `.cline/skills/` |
| Universal | `~/.agents/skills/` | `.agents/skills/` |

> Os agentes mudam esses caminhos com frequência. Se o seu não carregar a skill, confira a documentação dele e use `./install.sh --path <pasta>`. Depois de instalar, reinicie o agente ou abra uma nova sessão.

## Como usar

Anexe a imagem de referência e peça em linguagem natural:

```
Faz um dashboard de CRM nesse estilo [imagem]
Landing page para um app de notas: estrutura da ref 1, cores da ref 3
Splash do logo no estilo dessa ref, entrando no hero com GSAP
Aplica esse efeito de vidro nos cards do meu painel
Olha o site em produção em https://minhaempresa.com.br e conserta essa landing [print]
```

Também dá para invocar direto: `/craft-ui` (Claude Code) ou "use a skill craft-ui" (Codex e outros).

## Skills que se combinam com ela

O agente C decide **por execução** quais destas skills usar e quais pular (com motivo). A `craft-ui` tem fallback embutido quando não estão instaladas.

| Fase | Skill | Instalar |
|---|---|---|
| Direção e polimento | [Impeccable](https://github.com/pbakaus/impeccable) | `npx skills add pbakaus/impeccable --skill impeccable -g -y` |
| Motion e microinterações | [emil-design-eng](https://github.com/emilkowalski/skills) | `npx skills add emilkowalski/skills --skill emil-design-eng` |
| Rebuild 3D a partir de imagem | [img2threejs](https://github.com/hoainho/img2threejs) | `npx --yes img2threejs@latest install` |
| Código enxuto | [ponytail](https://github.com/DietrichGebert/ponytail) | `claude plugin marketplace add DietrichGebert/ponytail` |
| Verificação visual | Qualquer MCP de browser (ex.: Chrome DevTools MCP) | conforme a documentação do MCP |

## Atualizar e remover

```bash
git pull && ./install.sh                  # atualizar (ou use --link uma vez)
./install.sh --uninstall -a all           # remover
npx skills update                         # se instalou via npx skills
```

## Estrutura

```
craft-ui/
├── skills/craft-ui/
│   ├── SKILL.md                      # fluxo, gate do Design Contract e orquestração
│   ├── references/
│   │   ├── agents.md                 # 3 agentes: schemas, orçamento, prompts
│   │   ├── design-contract.md        # template de fusão + gate antes do código
│   │   ├── anti-ai-slop.md           # sintomas e correções do layout genérico
│   │   ├── quality-bar.md            # definition of done profissional + verificação
│   │   ├── polish-existing-site.md   # fluxo aditivo para melhorar layout já publicado
│   │   ├── pattern-transfer.md       # impede copiar o hero da referência sem contexto
│   │   ├── categories.md             # baseline por categoria + slots de Style DNA
│   │   ├── style-dna.md              # como ler uma referência (exige evidência)
│   │   └── motion-and-effects.md     # efeitos Figma em CSS, GSAP e splash
│   └── assets/refs.json              # links das referências
├── install.sh · install.ps1          # instaladores
├── scripts/package.sh                # gera dist/craft-ui.skill
└── .claude-plugin/                   # manifest do plugin do Claude Code
```

## Contribuindo com referências

As seções **Reference DNA** em `references/categories.md` começam vazias de propósito: só devem ser preenchidas a partir de imagens realmente analisadas. Abra um PR com o DNA preenchido seguindo o template de `references/style-dna.md`. Não inclua imagens ou assets de terceiros no repositório, apenas links e descrições do estilo.

## Aviso sobre referências

Muitas referências do Pinterest apontam para UI kits comerciais. A skill foi escrita para recriar **padrões e estilo**, não logos, ilustrações, marcas ou textos de terceiros.

## Licença

[MIT](LICENSE)
