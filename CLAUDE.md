# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository manages macOS dotfiles using chezmoi. Configuration files are stored in the `src/` directory, and chezmoi deploys them from `~/.local/share/chezmoi` to the appropriate locations in the home directory.

## Directory Structure

- `src/`: chezmoi source files (configuration templates)
  - `src/dot_config/`: XDG-compliant configuration files (zsh, git, neovim, ghostty, etc.)
  - `src/.chezmoiscripts/`: chezmoi execution scripts
    - `unix/`: Unix-compatible scripts
    - `darwin/`: macOS-specific scripts
- `bin/`: utility scripts
  - `cz`: wrapper to run chezmoi in a clean environment
  - `run-clean-env`: executes commands with minimal environment variables
- `test/`: test files
  - `test/goss/`: Goss environment validation configuration

## chezmoi Naming Conventions

- `dot_` prefix: expands to files starting with `.`
- `.tmpl` suffix: processed as templates
- `run_before_`, `run_after_`, `run_onchange_`: control script execution timing

## Development Commands

### Running Tests

```sh
# Static analysis (shellcheck and zsh syntax check)
./test/static.sh

# Format check
oxfmt --check

# Format files
oxfmt

# Environment validation with Goss (run after chezmoi apply)
GOSS_USE_ALPHA=1 goss validate --format documentation
```

### Setup and Apply

```sh
# Initial setup (installs Homebrew, chezmoi, and applies configuration)
./install.sh

# Apply chezmoi changes in clean environment (via mise shell alias)
cz apply -v

# Preview changes before applying
cz diff

# Note: CI tests run install.sh twice to verify idempotency
```

### Zsh Performance

```sh
mise run zsh-bench  # benchmark: hyperfine -w 5 -r 50 'zsh -i -c exit'
mise run zsh-prof   # profiling: ZPROF=1 zsh -i -c exit
```

### Environment Tools

- **mise**: runtime version management; defines `cz` shell alias and tasks in `mise.toml`
- **Homebrew**: package management (defined in Brewfile)
- **oxfmt**: formatter for shell/TOML/JSON files (configured in `.oxfmtrc.json`; ignores `sync/`)
- **goss**: environment validation

## Architecture

### Clean Environment Execution

`bin/cz` is a wrapper script that runs chezmoi in a clean environment. It uses `env -i` to reset all environment variables and launches bash with `--noprofile --norc`, then configures only essential paths:

- System paths via `/usr/libexec/path_helper`
- Homebrew environment (`/opt/homebrew`)

This prevents interference from existing shell configurations when applying dotfiles, ensuring consistent and reproducible deployments.

### Zsh Configuration Lazy Loading

- `.zshenv`: environment variable configuration (especially ZDOTDIR)
- `.zprofile`: login shell configuration
- `dot_config/zsh/.zshrc.tmpl`: main zsh configuration — loads Homebrew env and runs `sheldon source`
  - `zshrc.d/`: immediately loaded via sheldon
  - `zshrc.defer.d/`: lazy-loaded via `zsh-defer` (mise, alias, fzf, zoxide, completions, etc.)

**sheldon** manages zsh plugins (`dot_config/sheldon/plugins.toml`). All plugins except `zsh-defer`, `zsh-smartcache`, and `pure` are deferred using the custom `defer` template (`zsh-defer source`).

### Template System

`.tmpl` files are processed by chezmoi's template engine. Platform-specific configurations (e.g., `conf.d/platform.tmpl`) and environment-dependent values like Homebrew paths are dynamically generated.
