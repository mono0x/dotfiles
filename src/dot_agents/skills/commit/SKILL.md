---
name: commit
description: Create a git commit following the repository's documented conventions and existing commit style.
---

# Commit

## Inspect the changes and conventions

- Run `git status` and inspect the staged and unstaged diffs. Read surrounding code when needed to understand the change.
- Before drafting the message, find and read the repository's commit-message rules in `AGENTS.md`, `CLAUDE.md`, `CONTRIBUTING` files, `README` files, and any linked contribution or commit guides. Check commitlint or commit-template configuration when present.
- Read recent commit subjects and bodies with `git log -10 --format='%s%n%b%n---'`. Inspect history for the affected paths if the overall history is mixed.
- Follow explicit repository rules first. Where they leave details unspecified, infer the language, subject format, prefixes/scopes, capitalization, length, and body style from existing commits. Do not impose Conventional Commits or another generic style unless the repository calls for it.

## Create the commit

Stage only the changes intended for this commit, preserving unrelated work. When the body needs to explain why, draft it with the `write-rationale` skill. Write a message that accurately describes the staged changes and check it against the rules and examples you found before committing.

Create the requested commit and report the result. If a hook fails, address the failure without bypassing the hook, then retry.
