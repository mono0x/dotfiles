# Jujutsu information in the Pure prompt.
#
# `vcs_info` has no jj backend, so the repository state is collected in a
# dedicated zsh-async worker and rendered through `prompt_pure_precustom`, which
# fills Pure's Git slots so that the jj segment gets the same position and
# colors as a Git one. Inside a jj workspace Pure's own Git segment is turned
# off so that colocated repositories do not render both.

(($+commands[jj])) || return

# Keys: root (jj workspace of $PWD), label/dirty/action (the rendered segment),
# worker (whether the async worker is running).
typeset -gA prompt_jj_state=()

# Locates the jj workspace enclosing $PWD. Only stats directories, so it is
# cheap enough to run on every prompt.
prompt_jj_find_root() {
  local dir=$PWD
  while true; do
    [[ -d $dir/.jj ]] && {
      REPLY=$dir
      return 0
    }
    [[ $dir == / ]] && return 1
    dir=${dir:h}
  done
}

# Runs inside the async worker. `--ignore-working-copy` keeps the prompt from
# snapshotting the working copy, which would take the repo lock and walk the
# whole tree on every render; in exchange the dirty marker only refreshes once
# some other jj command has run.
prompt_jj_async_info() {
  builtin cd -q -- $1 || return
  print -r -- $1

  # Label, dirty marker and action, one per line. The bookmark of the closest
  # parent is shown when the working-copy commit carries none itself, which is
  # the usual state right after `jj new`.
  command jj --ignore-working-copy --color never log --no-graph --revisions @ --template '
		separate(" ",
			coalesce(
				local_bookmarks.join(" "),
				parents.first().local_bookmarks().join(" "),
			),
			change_id.shortest(8),
		)
		++ "\n" ++ if(empty, "", "*")
		++ "\n" ++ if(conflict, "conflict")
	' 2>/dev/null
}

prompt_jj_async_callback() {
  local job=$1 code=$2 output=$3

  if [[ $job == '[async]' ]]; then
    # Worker died (see zsh-async for the exit codes), drop it so that the
    # next prompt starts a fresh one.
    ((code == 2 || code == 3 || code == 130)) && {
      async_stop_worker prompt_jj
      prompt_jj_state[worker]=
    }
    return
  fi

  # The job echoes the workspace it queried ahead of the segment fields, so
  # results for a workspace we have already left can be discarded.
  local -a fields=("${(@f)output}")
  [[ ${fields[1]} == "${prompt_jj_state[root]}" ]] || return

  prompt_jj_state[label]=${fields[2]}
  prompt_jj_state[dirty]=${fields[3]}
  prompt_jj_state[action]=${fields[4]}
  # Pure only redraws when the rendered prompt actually changed.
  prompt_pure_preprompt_render
}

prompt_jj_precmd() {
  local REPLY root=
  prompt_jj_find_root && root=$REPLY

  if [[ $root != "${prompt_jj_state[root]}" ]]; then
    # Drop the segment of the workspace we left, keeping the worker state.
    typeset -gA prompt_jj_state=(root "$root" worker "${prompt_jj_state[worker]}")
    ((${prompt_jj_state[worker]:-0})) && async_flush_jobs prompt_jj
  fi

  if [[ -z $root ]]; then
    zstyle -d ':prompt:pure:git' show
    return
  fi

  # Let jj own the VCS segment, Pure's Git info would duplicate it in a
  # colocated repository.
  zstyle ':prompt:pure:git' show false

  if ((!${prompt_jj_state[worker]:-0})); then
    async_start_worker prompt_jj -u -n 2>/dev/null || return
    async_register_callback prompt_jj prompt_jj_async_callback
    prompt_jj_state[worker]=1
  fi

  async_job prompt_jj prompt_jj_async_info "$root"
}

# Called by Pure on every preprompt render, so it may only read state that the
# async callback has already computed. Pure fills its Git slots just before
# this, so overwriting them inside a jj workspace (where the Git segment is
# disabled anyway) reuses its branch, dirty and action colors as-is.
prompt_pure_precustom() {
  [[ -n ${prompt_jj_state[root]} ]] || return
  psvar[14]=${prompt_jj_state[label]}
  psvar[15]=${prompt_jj_state[dirty]}
  psvar[16]=${prompt_jj_state[action]}
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_jj_precmd
# Must run before Pure's precmd, which reads the Git zstyle set above.
precmd_functions=(prompt_jj_precmd ${precmd_functions:#prompt_jj_precmd})
