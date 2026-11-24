- Use the `natural-japanese` skill when creating or revising Japanese deliverables, including documents, articles, and source code comments. Do not use it for ordinary conversation, answers to questions, progress updates, or completion reports unless the user explicitly requests it.
- Prefer simplicity and follow YAGNI, KISS, and DRY. Do not add backward-compatibility shims or fallback paths unless required by the task or project.
- Favor colocation: keep related code, tests, types, and assets close to where they are used rather than splitting them into distant shared layers prematurely.
- Keep identifier names concise, but do not abbreviate English words unless the abbreviation is conventional in the target language. Respect the naming conventions of the original code.
- When creating a worktree, identify the default branch and its corresponding remote; do not assume the remote is named `origin`. If that remote exists, fetch it and use the updated remote-tracking default branch as the base. If no remote exists, use the local default branch. Use a different base only when the user specifies one; if fetching fails, report the failure instead of using a stale base.

## Cross-repository work under herdr-core

Under herdr-core, decide whether to handle work in another repository yourself or delegate it to Codex via `hc`. Locate the repository with the `ghq` skill. If your own task arrived as an `<hc from=...>` message, do it yourself and never delegate further.

- Do it yourself when the task is read-only or a small change that needs no build or test run. Before editing, read the target repository's `AGENTS.md` or `CLAUDE.md`, since neither loads outside the current working directory.
- Delegate when the task needs building, testing, or committing in the target repository, depends heavily on its toolchain, would crowd your context, or can run in parallel with your own work. Use `hc` for this, not subagents or plugins that start Codex.

When delegating:

- Create the worktree yourself, so the Codex sandbox covers it: `hc run --cwd <repo> wt switch --create <branch> --base <base> --no-cd --format json`. Resolve `<base>` using the worktree rule above: the freshly fetched remote-tracking default branch when a remote exists, or `^` for the local default branch when none exists, unless the user specifies another base.
- Start Codex in that worktree: `hc run --bg --name <name> --cwd <worktree> codex --no-daemon "<task>"`. State the exact scope, require it to follow the repository's `AGENTS.md`, forbid starting other agents, and ask it to report the branch and results with `hc send`.
- Ask Codex to push or open a PR only when the user explicitly requested it.
- Review the actual diff before reporting. Once accepted, run `hc kill` and `hc rm` on the terminal, but leave the worktree for the user.
