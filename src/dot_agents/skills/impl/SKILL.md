---
name: impl
description: Start implementing a task in a dedicated worktree created with worktrunk (`wt`) and record how it should be finished (rebase onto the default branch or open a PR). Use only when the user explicitly invokes impl.
---

# Impl

Implement the requested task in its own worktree so the main worktree stays
untouched. The `impl-finish` skill later integrates the work.

## Arguments

- Finish mode: `rebase` (put the commits on the default branch) or `pr` (open a
  pull request). If the user gave no mode, ask before creating the worktree.
- Base branch: the default branch unless the user names another one.
- The task description: everything else.

## Start

1. Choose a short kebab-case branch name for the task that follows the
   repository's existing branch naming.
2. Create the worktree from the main worktree:

   ```sh
   wt switch --create <branch> --no-cd --format json   # add --base <base> if specified
   ```

   Take the worktree path from the JSON output. The agent shell does not follow
   `wt switch`, so run every later command in that path (for example
   `cd <path> && ...` or `git -C <path>`) and edit files under it.
3. State the plan in one message so it stays in the conversation context:

   ```text
   impl: branch=<branch> base=<base> worktree=<path> finish=<rebase|pr>
   ```

## Implement

- Implement the task in the worktree, following the project's instructions.
- Run the checks the project configures and fix failures belonging to the task.
- Commit the work in logical commits following the repository's commit
  conventions. Leave no uncommitted changes.

When done, report the result and the recorded finish mode, and tell the user to
run `impl-finish`. Do not finish on your own.
