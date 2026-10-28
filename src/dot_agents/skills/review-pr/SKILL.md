---
name: review-pr
description: Review a pull request or local changes using the PR Review Toolkit's specialized checks for code quality, tests, error handling, comments, type design, and simplification. Use when asked for a PR review or a focused review of these aspects.
---

# Review PR

Use the upstream [PR Review Toolkit](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/pr-review-toolkit)
with the Codex adaptations below. Paths are relative to this skill directory.
chezmoi downloads the unmodified upstream files into `upstream/` at a commit
tracked by Renovate.

Read [the review workflow](upstream/commands/review-pr.md), then read only the
relevant reviewer instructions under `upstream/agents/`. Apply these adaptations
to both the workflow and reviewer instructions.

## Scope and review passes

- Use the user's PR, commit range, files, and requested aspects to define scope.
  For a PR, review its diff against the PR's base branch. For local work with no
  explicit scope, inspect staged, unstaged, and relevant untracked changes.
  Keep that scope consistent across all review passes.
- With no aspects specified, select all applicable passes. Assess test coverage
  when behavior changes, even if no test files changed. Treat simplification as
  suggestions; modify files only when the user has requested changes.
- Run the selected passes sequentially yourself. If the user requests parallel
  review, use available Codex subagents, giving each the scope, relevant upstream
  instructions, and these adaptations. Merge duplicate findings afterward.

## Codex adaptations

- Treat `/pr-review-toolkit:review-pr` and `$ARGUMENTS` as this skill's invocation
  and the user's request. Use available Codex tools for upstream `Bash`, `Glob`,
  `Grep`, and `Read` operations. `Task` refers to delegation as described above;
  Claude's `/agents` list and frontmatter fields such as `model`, `color`, and
  `allowed-tools` do not configure Codex.
- Follow applicable `AGENTS.md` instructions for the reviewed project. Interpret
  `CLAUDE.md` references as project-guideline checks against those instructions.
  Upstream examples of logging functions, error IDs, frameworks, and coding
  conventions apply only when the project actually uses or requires them.
- Use upstream procedures within the requested review. Their proactive triggers
  and autonomous editing instructions do not expand the task. A review request
  does not authorize publishing a GitHub review, comment, or PR.

Return the combined findings in the upstream workflow's format, preserving file
and line references and distinguishing actionable issues from suggestions.
