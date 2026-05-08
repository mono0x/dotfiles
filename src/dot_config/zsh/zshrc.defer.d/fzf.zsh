if ((${+commands[fzf]})); then
  fzf-cd() {
    local selected_dir
    selected_dir=$({
      ghq list --full-path
      print -r -- "$HOME/.local/share/chezmoi"
    } | sort | fzf --query "$LBUFFER")
    if [[ -n "$selected_dir" ]]; then
      BUFFER="cd ${selected_dir}"
      zle accept-line
    fi
    zle redisplay
  }
  zle -N fzf-cd
  bindkey '^s' fzf-cd
fi
