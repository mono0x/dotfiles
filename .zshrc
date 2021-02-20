# .zshrc
# vim: foldmethod=marker

# Compile {{{
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi
# }}}

# Variables {{{
CPUARCH="$(uname -m)"
# }}}

# zinit {{{
source ~/.zinit/bin/zinit.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

if [ -f $HOME/.asdf/completions/_asdf ]; then
  zinit ice wait"0" lucid
  zinit snippet $HOME/.asdf/completions/_asdf
fi

if [ -f $HOME/google-cloud-sdk/completion.zsh.inc ]; then
  zinit ice wait"0" lucid
  zinit snippet $HOME/google-cloud-sdk/completion.zsh.inc
fi

zinit ice wait"0" as"completion" lucid
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit ice wait"0" as"completion" lucid
zinit snippet https://github.com/docker/compose/blob/master/contrib/completion/zsh/_docker-compose

# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
_zicompinit_custom() {
  setopt extendedglob local_options
  autoload -Uz compinit
  local zcd=${ZINIT[ZCOMPDUMP_PATH]:-${ZDOTDIR:-$HOME}/.zcompdump}
  local zcdc="$zcd.zwc"
  # Compile the completion dump to increase startup speed, if dump is newer or doesn't exist,
  # in the background as this is doesn't affect the current session
  if [[ -f "$zcd"(#qN.m+1) ]]; then
        compinit -i -d "$zcd"
        { rm -f "$zcdc" && zcompile "$zcd" } &!
  else
        compinit -C -d "$zcd"
        { [[ ! -f "$zcdc" || "$zcd" -nt "$zcdc" ]] && rm -f "$zcdc" && zcompile "$zcd" } &!
  fi
}

zinit wait lucid for \
 atinit"_zicompinit_custom; zicdreplay" \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions
# }}}

# Options {{{
setopt auto_list
setopt auto_pushd
setopt noflowcontrol
setopt print_eight_bit
setopt prompt_subst
setopt pushd_ignore_dups

export WORDCHARS="*?_-.[]~&;!#$%^(){}<>"

stty stop undef
# }}}

# History {{{
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=100000

setopt extended_glob
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt interactive_comments
setopt share_history

# http://mollifier.hatenablog.com/entry/20090728/p1
zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  [[ ${#line} -ge 4 ]]
}
# }}}

# Prompt {{{
autoload colors
colors

autoload -Uz add-zsh-hook

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn):*' branchformat '%b:r%r'

autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "+"
  zstyle ':vcs_info:git:*' unstagedstr "-"
  zstyle ':vcs_info:git:*' formats ' (%s)-[%b] %c%u'
  zstyle ':vcs_info:git:*' actionformats ' (%s)-[%b|%a] %c%u'
fi

update_vcs_info_message() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

add-zsh-hook precmd update_vcs_info_message

# https://gist.github.com/knadh/123bca5cfdae8645db750bfb49cb44b0#gistcomment-3556104
start_command_execution_timer() {
  command_start=$(($(print -P %D{%s%6.}) / 1000))
}

add-zsh-hook preexec start_command_execution_timer

update_command_execution_timer() {
  if [ $command_start ]
  then
    local now=$(($(print -P %D{%s%6.}) / 1000))
    local d_ms=$(($now - $command_start))
    local d_s=$((d_ms / 1000))
    local ms=$((d_ms % 1000))
    local s=$((d_s % 60))
    local m=$(((d_s / 60) % 60))
    local h=$((d_s / 3600))

    if   ((h > 0)); then command_time=${h}h${m}m
    elif ((m > 0)); then command_time=${m}m${s}s
    elif ((s > 9)); then command_time=${s}.$(printf %03d $ms | cut -c1-2)s # 12.34s
    elif ((s > 0)); then command_time=${s}.$(printf %03d $ms)s # 1.234s
    else unset command_time
    #else command_time=${ms}ms
    fi

    unset command_start
  else
    unset command_time
  fi
}

add-zsh-hook precmd update_command_execution_timer

() {
  local PATH_PART='%{${fg[blue]}%}%/%{${reset_color}%}'

  local ARCH_PART=' %{${fg[magenta]}%}(${CPUARCH})%{${reset_color}%}'

  local VCS_PART='%1(v|%{${fg[green]}%}%1v%f|)%{${reset_color}%}'

  local COMMAND_TIME_PART='$(if [ $command_time ]; then echo " %{${fg[yellow]}%}$command_time%{${reset_color}%}"; fi)'

  user_host_part() {
    if [ $UID = 0 ]
    then
      local user_color='%{${fg[red]}%}'
    else
      local user_color='%{${reset_color}%}'
    fi

    # https://unix.stackexchange.com/questions/9605/how-can-i-detect-if-the-shell-is-controlled-from-ssh
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]
    then
      local session_type=remote/ssh
    else
      case $(ps -o comm= -p $PPID) in
        sshd|*/sshd) local session_type=remote/ssh
        ;;
      esac
    fi

    if [ "$session_type" = remote/ssh ]
    then
      echo "${user_color}%n%{${reset_color}%}@%m "
    fi
  }

  prompt_part() {
    if [ $UID = 0 ]
    then
      local prompt_color='%{${fg[red]}%}'
    else
      local prompt_color='%{${fg[blue]}%}'
    fi
    echo "${prompt_color}>%{${reset_color}%} "
  }

  PROMPT="
$( user_host_part )${PATH_PART}${ARCH_PART}${VCS_PART}${COMMAND_TIME_PART}
$( prompt_part )"
  PROMPT2="%B%{${fg[blue]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
}

zstyle ':completion:*' use-cache true
zstyle ':completion:*:default' menu select=1
# }}}

# Key {{{
bindkey -d
bindkey -e

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
# }}}

# Aliases {{{
alias sudo="sudo "
alias sudoe='sudo -e'
alias tmux='TERM=screen-256color tmux'
alias man='vs man'
alias vi='vim'

case "${OSTYPE}" in
linux*)
  alias ls="ls --color"

  alias comm='LC_ALL=C comm'
  alias grep='LC_ALL=C grep'
  alias look='LC_ALL=C look'
  alias sort='LC_ALL=C sort'
  alias uniq='LC_ALL=C uniq'
  ;;
darwin*)
  if which arch &> /dev/null; then
    alias exec-x86_64='arch -arch x86_64 '
    alias exec-arm64='arch -arch arm64 '

    if [ -f /opt/homebrew/bin/brew ]
    then
      alias brew='arch -arch arm64 /opt/homebrew/bin/brew'
      alias brew-x86_64='arch -arch x86_64 /usr/local/bin/brew'
    fi
  fi

  alias ls="ls -G"

  alias base64='gbase64'
  alias comm='LC_ALL=C gcomm'
  alias date='gdate'
  alias grep='LC_ALL=C ggrep'
  alias look='LC_ALL=C look'
  alias md5sum='gmd5sum'
  alias sed='gsed'
  alias sha1sum='gsha1sum'
  alias sha224sum='gsha224sum'
  alias sha256sum='gsha256sum'
  alias sha384sum='gsha384sum'
  alias sha512sum='gsha512sum'
  alias shuf='gshuf'
  alias sort='LC_ALL=C gsort'
  alias tail='gtail'
  alias uniq='LC_ALL=C guniq'
  alias wc='gwc'
  ;;
esac
alias ll='ls -l'
alias la='ls -A'
alias lla='ls -Al'

if which hub &> /dev/null; then
  alias git='hub'
fi
alias g='git'
alias ga='git add'
alias gbr='git br'
alias gci='git ci'
alias gco='git co'
alias gd='git di'
alias gf='git fetch --all'
alias gg='git grep -H --heading -I --line-number --break --show-function'
alias gl='git log'
alias gme='git me'
alias gpr='git pull --rebase'
alias gs='git status'

alias b='bundle'
alias be='bundle exec'
alias bet='bundle exec thor'
alias ber='noglob bundle exec rake'
alias rake='noglob rake'

alias d='docker'
alias dc='docker-compose'

# http://www.reddit.com/r/commandline/comments/12g76v/how_to_automatically_source_zshrc_in_all_open/
trap "source ~/.zshrc" USR1
alias source-zshrc-all="pkill -usr1 zsh"
# }}}

# Peco {{{
if which peco &> /dev/null; then
  peco-cd() {
    local selected_dir=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
      BUFFER="cd ${GOPATH}/src/${selected_dir}"
      zle accept-line
    fi
    zle redisplay
  }
  zle -N peco-cd
  bindkey '^s' peco-cd
fi
# }}}

# Functions {{{
# tmux
() {

vs() {
  if [ -n "${TMUX}" ]; then
    tmux split-window -h "exec $*"
  else
    command $*
  fi
}

sp() {
  if [ -n "${TMUX}" ]; then
    tmux split-window -v "exec $*"
  else
    command $*
  fi
}

quit() {
  command osascript -e "quit app \"$1\""
}

}

# }}}

# Environment variables {{{
export LESS='-R'
# }}}

#eval 'dircolors'
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Load local zshrc
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Dedup PATH
path=($path)

# Finish profiling {{{
if [ -n "$ZPROF" ]; then
  zprof
fi
# }}}
