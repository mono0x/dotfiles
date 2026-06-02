# Agent Guideline

## Repository Overview

This repository manages macOS dotfiles using chezmoi. Source files live under the `src/` directory (configured via `.chezmoiroot`), and chezmoi deploys them from `~/.local/share/chezmoi` to the appropriate locations in the home directory.

## Development Commands

### Running Tests

```sh
# Run all linters and format checks
hk check --all

# Auto-fix formatting and lint issues
hk fix --all
```

### Setup and Apply

```sh
# Initial setup (installs Homebrew, chezmoi, and applies configuration)
./install.sh

# Apply chezmoi changes in clean environment
mise run cz apply -v   # or: ./bin/cz-clean-env apply -v

# Preview changes before applying
mise run cz diff

# Note: CI tests run install.sh twice to verify idempotency
```

### Environment Tools

- **Homebrew**: package management (defined in `Brewfile`)
- **hk**: lint/format runner with pre-commit hook (config in `hk.pkl`)
- **mise**: runtime/tool version management (config in `mise.toml`; manages dprint, hk, shellcheck, etc.)
