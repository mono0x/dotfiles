---
name: verify
description: Verify a code change by building, running, and exercising the affected behavior end to end. Use when asked to verify changes or confirm that a feature works in the running application.
---

# Verify

Confirm that the requested change works by observing the affected behavior in the
running application. Tests, lint, type checks, and code inspection can supplement
this evidence but do not replace it.

## Choose what to exercise

Use the user's request and the current diff to identify the changed behavior and
its expected result. Respect an explicitly selected scope. If the scope is unclear,
inspect staged and unstaged changes, including relevant untracked files, before
choosing a representative flow.

Read project instructions and any relevant project-local verification or launch
skills, including recipes under `.agents/skills/` and `.claude/skills/`. Follow the
closest applicable recipe. Otherwise infer the build and launch commands from the
project's README, task configuration, and package manifests.

For changes with no runtime behavior, such as prose-only documentation or test-only
edits, run the applicable checks and explain that no application flow was exercised.

## Run and observe

Build the changed code when needed, start the application, and drive the affected
flow using the tools available in this session:

- For a CLI, invoke the changed command with representative input and inspect its
  output, exit status, and relevant side effects.
- For a service, send requests to the running service and inspect responses and
  relevant state changes.
- For a UI, use available browser or desktop tools to perform the affected user
  interaction and inspect the resulting screen and state.
- For a library, execute a small example through its public interface and inspect
  the result.

Check the expected outcome and meaningful failure cases relevant to the change.
If a failure belongs to the authorized task, fix it and repeat the affected flow.
Stop when the behavior is confirmed or a concrete blocker prevents further work.
If dependencies, credentials, tools, or a graphical session are unavailable, report
the blocker and what remains unverified; passing tests do not establish runtime
verification. Clean up temporary artifacts and processes started for verification.

## Report and retain the recipe

Report what was exercised, the commands or interactions used, the observed result,
and any remaining gaps. Distinguish runtime evidence from automated check results.

If discovering the launch procedure required non-obvious steps and no applicable
project recipe exists, save the successful procedure in the closest relevant
`.agents/skills/verify/SKILL.md`. Keep it project-specific: prerequisites, build and
launch commands, how to exercise the app, expected observations, and cleanup.
Preserve the runtime-verification requirement. Update an existing recipe only when
it proved incorrect or incomplete; do not store per-run results or secrets.
