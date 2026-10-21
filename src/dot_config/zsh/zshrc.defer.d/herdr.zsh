_herdr_update_tab_name() {
  [[ "${HERDR_ENV:-}" == 1 && -n "${HERDR_TAB_ID:-}" ]] || return 0
  (($+commands[herdr] && $+commands[jq])) || return 0

  local branch label number
  number=$(herdr tab get "$HERDR_TAB_ID" 2>/dev/null | jq -er '.result.tab.number') || return 0
  branch=$(git branch --show-current 2>/dev/null) || branch=''
  case "$branch" in
  main | master) branch='' ;;
  *) branch=${branch#users/} ;;
  esac
  label="$number ${branch:-${PWD:t}}"
  herdr tab rename "$HERDR_TAB_ID" "$label" >/dev/null 2>&1 || true
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _herdr_update_tab_name
