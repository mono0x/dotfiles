#!/bin/bash
# SessionStart hook that prints local instruction files as additional context.
# Usage: local-instructions.sh claude|codex
set -euo pipefail

cwd=$(jq -r '.cwd // empty')
cwd=${cwd:-$PWD}
root=$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null || printf '%s' "$cwd")

# Prints the first existing file.
print_first() {
  local file
  for file in "$@"; do
    [[ -f $file ]] || continue
    printf '<local-instructions path="%s">\n%s\n</local-instructions>\n' "$file" "$(<"$file")"
    return
  done
}

case $1 in
claude)
  print_first "$HOME/.claude/CLAUDE.local.md" "$HOME/.codex/AGENTS.local.md"
  # Claude Code loads the project's CLAUDE.local.md natively but never AGENTS.local.md.
  [[ -f $root/CLAUDE.local.md ]] || print_first "$root/AGENTS.local.md"
  ;;
codex)
  print_first "$HOME/.codex/AGENTS.local.md"
  print_first "$root/AGENTS.local.md"
  ;;
*) exit 2 ;;
esac
