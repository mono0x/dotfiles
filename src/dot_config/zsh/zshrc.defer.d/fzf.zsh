if ((${+commands[fzf]})); then
  fzf-cd() {
    local selected_dir
    selected_dir=$(repo-list | fzf --query "$LBUFFER")
    if [[ -n "$selected_dir" ]]; then
      # BUFFER is a special zle variable; making it local would prevent the line editor from picking up the change.
      BUFFER="cd ${selected_dir}" # noka: ZC1043
      zle accept-line
    fi
    zle redisplay
  }
  zle -N fzf-cd
  bindkey '^s' fzf-cd
fi
