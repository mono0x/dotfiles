---
name: ghq
description: Locate local clones of repositories managed by ghq. Use whenever the user mentions a repository by name or URL (for example `owner/repo`, `repo`, or a GitHub URL) and its source code, docs, or history would help, before searching the web. Also use when the user asks to clone a repository.
---

# ghq

The user keeps repository clones under the ghq root (`ghq root`), laid out as
`<root>/<host>/<owner>/<repo>`. When a repository is mentioned, read the local
clone if one exists instead of fetching files from the web.

## Find a local clone

Search with the most specific form of the name the user gave:

```sh
ghq list -p -e owner/repo   # exact match on owner/repo, repo, or host/owner/repo
ghq list -p repo            # substring match when the exact name is uncertain
```

If a single path matches, use it directly. If several match, pick the one that
fits the context, or ask the user when the choice is ambiguous.

Before relying on a clone for current behavior, check how fresh it is with
`git -C <path> log -1 --format='%h %cs'`. Do not pull, switch branches, or
otherwise change a clone the user may be working in unless asked.

## Clone a missing repository

When no local clone exists, do not clone it unless the user asked to clone or
read it locally. Use other sources instead. If cloning would clearly be more
efficient, such as when many files need to be read or searched, ask the user
before cloning. When cloning is requested or approved, clone it into the ghq
root:

```sh
ghq get owner/repo          # GitHub shorthand
ghq get <url>               # other hosts
ghq get --shallow owner/repo
```

Use `--shallow` when only the current tree is needed and the repository is
large. After cloning, locate it with `ghq list -p -e owner/repo`.

Do not use `ghq rm`, `ghq migrate`, or `ghq get --update` unless the user asks.
