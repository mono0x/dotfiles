---
name: write-rationale
description: Write the purpose and reasoning behind a change or design in commit messages, PR descriptions, code comments, or documentation, for readers who were not part of the conversation. Use when drafting such text, or when revising it and the task includes reorganizing its content. Do not use for revisions that only add to or correct existing text.
---

# Write Rationale

Write so that a reader who was not part of the conversation understands the purpose, the decisions and their reasons, and what the change gives up.

## 1. Outline what to convey as a nested list

Start from the reader and the purpose of the text. List what you might convey as nested bullets. Nest reasons under the decision they support, and behavior under the case it applies to. Build the outline from your understanding of the change; do not transcribe existing drafts, notes, or diffs.

## 2. Select what the reader needs

For each item, ask whether the reader needs it. Keep decisions and the reasons behind them, including evidence such as which breaking changes you checked against. Drop what the diff already shows unless the reader needs it to follow a decision. Drop the conversation's history and the play-by-play of the investigation; state the decision you took and the facts you confirmed.

Present the outline with each item marked keep or drop when the user is reviewing the draft, so they can point at specific items.

## 3. Turn the kept items into prose

Write the kept items so the reader can see how they relate. Express nesting through sentence connections, paragraphs, or a short list, as fits the format. Follow the conventions of the destination, such as the repository's commit style or the comment guidance in the `code-comment` skill.

## 4. Check the prose against the outline

Compare the final text with the kept items. Add anything missing and remove explanations that the selection dropped.
