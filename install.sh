#!/usr/bin/env bash
# craft-ui installer: copies (or symlinks) the skill into the skills folder of each coding agent.
# Usage: ./install.sh [options]
set -euo pipefail

SKILL="craft-ui"
REPO_URL="https://github.com/Fast4gc/craft-ui.git"

# name | global skills dir | project skills dir | detect dir (exists when the agent is installed)
AGENTS=(
  "claude|$HOME/.claude/skills|.claude/skills|$HOME/.claude"
  "codex|$HOME/.codex/skills|.agents/skills|$HOME/.codex"
  "trae|$HOME/.trae/skills|.trae/skills|$HOME/.trae"
  "cursor|$HOME/.cursor/skills|.cursor/skills|$HOME/.cursor"
  "gemini|$HOME/.gemini/skills|.gemini/skills|$HOME/.gemini"
  "antigravity|$HOME/.gemini/antigravity/skills|.agent/skills|$HOME/.gemini/antigravity"
  "opencode|$HOME/.config/opencode/skills|.opencode/skills|$HOME/.config/opencode"
  "kiro|$HOME/.kiro/skills|.kiro/skills|$HOME/.kiro"
  "copilot|$HOME/.copilot/skills|.github/skills|$HOME/.copilot"
  "cline|$HOME/.cline/skills|.cline/skills|$HOME/.cline"
  "universal|$HOME/.agents/skills|.agents/skills|$HOME/.agents"
)

usage() {
  cat << USAGE
craft-ui installer

Usage: ./install.sh [options]

  -a, --agent LIST   Comma-separated agents, or "all". Default: every agent detected on this machine.
                     Agents: $(for a in "${AGENTS[@]}"; do printf '%s ' "${a%%|*}"; done)
  -p, --project      Install into the current project (./.claude/skills, ./.trae/skills, ...) instead of your user folder
      --path DIR     Install into a custom skills directory (ignores --agent)
      --link         Symlink to this checkout instead of copying (updates with git pull)
  -u, --uninstall    Remove the skill instead of installing it
  -l, --list         Show agents and their install paths
  -h, --help         Show this help

Examples:
  ./install.sh                       # detected agents, user scope
  ./install.sh -a claude,codex,trae  # specific agents
  ./install.sh -p -a trae            # this project only, for Trae
  curl -fsSL https://raw.githubusercontent.com/Fast4gc/craft-ui/main/install.sh | bash -s -- -a claude
USAGE
}

want="" scope="global" custom="" link=0 uninstall=0 list=0
while [ $# -gt 0 ]; do
  case "$1" in
    -a|--agent) want="${2:-}"; shift 2 ;;
    -p|--project) scope="project"; shift ;;
    --path) custom="${2:-}"; shift 2 ;;
    --link) link=1; shift ;;
    -u|--uninstall) uninstall=1; shift ;;
    -l|--list) list=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
done

if [ "$list" = 1 ]; then
  printf '%-12s %-45s %s\n' AGENT "USER PATH" "PROJECT PATH"
  for a in "${AGENTS[@]}"; do IFS='|' read -r n g p d <<< "$a"; printf '%-12s %-45s %s\n' "$n" "${g/#$HOME/~}" "$p"; done
  exit 0
fi

# Locate the skill sources: next to this script, or clone to a temp dir (curl | bash case).
here="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"
src="$here/skills/$SKILL"
tmp=""
if [ ! -f "$src/SKILL.md" ] && [ "$uninstall" = 0 ]; then
  command -v git >/dev/null || { echo "git is required to download craft-ui." >&2; exit 1; }
  tmp="$(mktemp -d)"; trap '[ -n "$tmp" ] && rm -rf "$tmp"' EXIT
  git clone --depth 1 "$REPO_URL" "$tmp/repo" >/dev/null 2>&1
  src="$tmp/repo/skills/$SKILL"
  [ "$link" = 1 ] && { echo "--link needs a local checkout; copying instead."; link=0; }
fi

targets=()
if [ -n "$custom" ]; then
  targets+=("custom|$custom")
else
  for a in "${AGENTS[@]}"; do
    IFS='|' read -r n g p d <<< "$a"
    if [ "$scope" = "project" ]; then dir="$PWD/$p"; else dir="$g"; fi
    if [ -z "$want" ]; then
      # auto mode: only detected agents, and skip "universal" unless asked
      [ "$n" = "universal" ] && continue
      [ -d "$d" ] && targets+=("$n|$dir")
    elif [ "$want" = "all" ] || [[ ",$want," == *",$n,"* ]]; then
      targets+=("$n|$dir")
    fi
  done
fi

if [ ${#targets[@]} -eq 0 ]; then
  echo "No supported agent detected. Pick one with --agent (see --list) or use --path DIR." >&2
  exit 1
fi

for t in "${targets[@]}"; do
  n="${t%%|*}"; dir="${t#*|}"; dest="$dir/$SKILL"
  if [ "$uninstall" = 1 ]; then
    if [ -e "$dest" ] || [ -L "$dest" ]; then rm -rf "$dest"; echo "removed   $n  ${dest/#$HOME/~}"; else echo "not found $n  ${dest/#$HOME/~}"; fi
    continue
  fi
  mkdir -p "$dir"
  rm -rf "$dest"
  if [ "$link" = 1 ]; then ln -s "$src" "$dest"; mode="linked  "; else cp -R "$src" "$dest"; mode="installed"; fi
  echo "$mode $n  ${dest/#$HOME/~}"
done

[ "$uninstall" = 1 ] || echo "Done. Restart your agent (or start a new session), then ask for a layout \"in the style of\" a reference image."
