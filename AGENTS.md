# Agent Guidelines

## Repository Overview

This repository manages macOS dotfiles with chezmoi. `.chezmoiroot` sets `src/` as the chezmoi source directory, while repository-level files configure development tooling and CI.

Follow chezmoi's source-state conventions when changing files under `src/`. Use the existing nearby files as the guide for naming and organization.

## Sources of Truth

- `README.md`: setup instructions
- `mise.toml`: tools, bootstrap configuration, and project tasks
- `hk.pkl`: linting, formatting, and git hooks
- `Brewfile`: Homebrew dependencies
- `.github/`: CI workflows and automation
- `goss.yaml` and `test/goss/`: applied-system validation
- `src/.chezmoiscripts/`: scripts run by chezmoi
- `src/.chezmoiexternal.toml.tmpl`: external files managed by chezmoi
- `src/.chezmoiignore`: deployment exclusions

Consult these files instead of copying version numbers, tool lists, or workflow details into documentation.

## Development Workflow

Use the commands defined by the current project configuration:

- Use `mise` for tools, tasks, and bootstrap operations.
- Use `hk` for repository checks and automatic fixes.
- Use `chezmoi diff` to review deployment changes before applying them.

Run the checks configured in `hk.pkl` after making changes. When behavior changes, update the closest relevant validation alongside it.
