_herdr_update_tab_name() {
  [[ "${HERDR_ENV:-}" == 1 && -n "${HERDR_TAB_ID:-}" && -n "${HERDR_WORKSPACE_ID:-}" ]] || return 0
  (($+commands[herdr] && $+commands[jq])) || return 0

  local branch label tabs tab_id
  tabs=$(herdr tab list --workspace "$HERDR_WORKSPACE_ID" 2>/dev/null) || return 0
  branch=$(git branch --show-current 2>/dev/null) || branch=''
  case "$branch" in
  main | master) branch='' ;;
  *) branch=${branch#users/} ;;
  esac
  while IFS=$'\t' read -r tab_id label; do
    herdr tab rename "$tab_id" "$label" >/dev/null 2>&1 || true
  done < <(jq -r --arg tab_id "$HERDR_TAB_ID" --arg label "$branch" '
    .result.tabs | to_entries[]
    | (.key + 1) as $number
    | .value as $tab
    | (if $tab.tab_id == $tab_id then $label
       elif $tab.label | test("^[0-9]+( |$)") then $tab.label | sub("^[0-9]+( |$)"; "")
       else empty end) as $name
    | ("\($number)" + if $name == "" then "" else " \($name)" end) as $label
    | select($label != $tab.label)
    | [$tab.tab_id, $label] | @tsv
  ' <<<"$tabs")
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _herdr_update_tab_name
