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

Você manda uma referência (print, pin, imagem) e pede "faz nesse estilo". A skill não copia pixels: extrai o **sistema de estilo** da imagem (paleta, tipografia, raios, sombras, densidade, grid, motion) e reconstrói com o **seu** conteúdo.

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
referência ─► Style DNA ─► plano (tokens + wireframe) ─► código ─► screenshot e comparação ─► ajustes
```

1. **Intake:** lê a imagem e escreve o "Style DNA". Se só houver link do Pinterest (que bloqueia leitura automática), a skill pede o print em vez de inventar.
2. **Plano:** tokens (cor, tipo, raio, sombra, easing) e wireframe antes de qualquer componente.
3. **Build:** HTML autocontido por padrão, responsivo (1440 / 768 / 390), com `prefers-reduced-motion` respeitado.
4. **Verificação:** compara com a referência lado a lado e corrige as maiores diferenças primeiro.

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
```

Também dá para invocar direto: `/craft-ui` (Claude Code) ou "use a skill craft-ui" (Codex e outros).

## Skills que se combinam com ela

A `craft-ui` usa estas skills **quando estão instaladas** e tem fallback embutido quando não estão.

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
│   ├── SKILL.md                      # fluxo e orquestração
│   ├── references/
│   │   ├── categories.md             # baseline por categoria + slots de Style DNA
│   │   ├── style-dna.md              # como ler uma referência
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
