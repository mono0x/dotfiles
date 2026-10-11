---
name: chezmoi-prune-remove
description: Prune entries in this repository's src/.chezmoiremove once at least 30 days have elapsed since their adding commit, preserving entries marked with keep comments. Use when asked to clean up old .chezmoiremove entries.
---

# Prune old .chezmoiremove entries

Remove entries from `src/.chezmoiremove` once at least 30 days have elapsed since the commit that added them. Preserve entries that must keep removing their targets on every apply by marking them as follows:

```text
# keep: The application recreates this file, so remove it on every apply.
.config/example/obsolete.conf
```

`# keep:` protects only the immediately following line. Do not insert a blank line between the comment and its entry. Give each protected entry its own comment and reason. Ordinary comments do not protect entries. Do not use inline comments after entries.

## Determine which entries have expired

Work from the repository root. Read `git status --short` and `git diff HEAD -- src/.chezmoiremove` first to identify existing changes. Capture the current time once at the start and use it for every entry.

1. Read the working tree file. Exclude blank lines, comment lines, and entries immediately preceded by `# keep:`. Honor keep comments even if they are uncommitted.
2. Use `git blame --line-porcelain -- src/.chezmoiremove` to find each remaining line's commit and `committer-time`. Preserve uncommitted additions or modifications whose commit hash consists entirely of zeros.
3. Verify each entry's adding commit in its diff. If its history is ambiguous, inspect the line history using its line number in HEAD:

   ```sh
   git log -L <line>,<line>:src/.chezmoiremove --format='%H %ct %cI %s'
   ```

   Map working tree line numbers to HEAD before using this command. Use the adding commit's committer timestamp, not its author date or the file's last modification time. Reordering entries or adding comments does not reset their age. If an entry was deleted and later re-added, use the re-adding commit. Preserve entries whose adding commit cannot be established, including those at a shallow history boundary, and report why.
4. Remove an entry when `current Unix timestamp - adding commit %ct >= 30 * 24 * 60 * 60`. Include entries exactly 30 days old. Do not round elapsed time to whole days.

Do not treat template control lines such as `{{ ... }}` as entries. Inspect template structure before pruning templated entries. Preserve them if the safe deletion range cannot be established.

## Remove expired entries and verify

Determine all candidates before editing, then remove only those entry lines. Preserve remaining entries, their order, comments, blank lines, and existing changes. Retain both keep comments and their protected entries. If no entries qualify, leave the file unchanged.

Run `git diff --check` and `mise exec -- hk check`. Review the diff to confirm that only eligible entries were removed. Review deployment effects with `chezmoi diff`; do not run `chezmoi apply`.

Report removed entries with their adding commits and timestamps, reasons for preserving entries, and validation results. This skill edits only `src/.chezmoiremove`. Commit or push only when separately requested.
