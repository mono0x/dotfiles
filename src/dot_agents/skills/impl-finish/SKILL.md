---
name: impl-finish
description: Finish work started with the impl skill by rebasing its commits onto the default branch or opening a pull request, then removing the worktree. Use when the user invokes impl-finish or asks to finish, merge, land, or open a PR for work started with impl.
---

# Impl Finish

Integrate the work from an `impl` worktree and remove the worktree.

## Determine the target

Find the `impl:` line (branch, base, worktree, finish mode) recorded when `impl`
started. Choose the finish mode in this order:

1. A mode the user gives with this invocation or explicitly requests afterward.
2. The mode recorded when `impl` started.
3. Otherwise ask the user. Do not guess.

If the branch or worktree is unknown, ask the user, using `wt list` to show the
candidates.

## Prepare

In the worktree, commit any remaining changes that belong to the task and
confirm the working tree is clean. Run the project's checks if they have not
passed since the last change.

## Finish

Run `wt` from the main worktree (`-C <main worktree>`), since the task
worktree is removed at the end.

### rebase

```sh
wt -C <main worktree> merge <base> --branch <branch> --no-squash --no-commit
```

This rebases the branch onto the base, fast-forwards the base, and removes the
worktree and the merged branch. If the rebase conflicts, resolve it in the
worktree with the user's intent in mind and rerun. If the base branch's worktree
has uncommitted changes that block the fast-forward, stop and ask the user. Do
not push the base branch unless the user asks.

### pr

1. Rebase the branch onto the latest remote base and push it.
2. Create the PR with `gh pr create --base <base>`, writing the title and body
   from the commits and following the repository's PR conventions.
3. Remove the worktree and keep the branch:

   ```sh
   wt -C <main worktree> remove <branch> --no-delete-branch
   ```

Report the outcome: the resulting commits on the base branch or the PR URL, and
confirmation that the worktree was removed.
