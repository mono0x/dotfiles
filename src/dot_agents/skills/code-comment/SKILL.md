---
name: code-comment
description: Write, edit, or review source code comments, including comments in tests. Use when deciding what a comment should explain, where to place it, or whether it still earns its place.
---

# Code Comments

## Decide what needs a comment

Read the expression, names, file location, and surrounding code first. Prefer a clear name or simpler implementation if it makes the behavior self-explanatory. Add a comment when readers still need a non-obvious constraint, invariant, dependency behavior, workaround, or rationale. For example, a whitespace-handling comment can explain that leading spaces carry meaning in the input format.

Leave routine defaults unexplained. Explain a deliberate departure from the default when its reason is hard to infer. Keep the history of the change and discarded approaches in the commit message or PR description.

## Write for the next maintainer

State the current constraint in terms that make sense to someone opening the file after merge. Use established, searchable terms and tell readers what a future edit must preserve. For example, `// Keep the timestamp outside the cache key so retries reuse the same entry.` Read the comment without the diff or PR context and replace any reference to the previous implementation that a reader cannot resolve.

In public code, describe observable behavior or a documented contract. Leave private paths, function names, and implementation details out of public comments.

## Keep useful context close

Put each comment next to the code it explains. For a caveat tied to one option, use a trailing comment on that option's line when it fits. Keep a representative output example when a format string obscures the result, or a short usage example when the return value's chaining behavior is easy to miss.

When reviewing comments, preserve accurate context that still helps the reader. Remove redundancy and update stale claims.
