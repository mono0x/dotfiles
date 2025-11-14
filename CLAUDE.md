# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository manages macOS dotfiles using chezmoi. Configuration files are stored in the `src/` directory, and chezmoi deploys them from `~/.local/share/chezmoi` to the appropriate locations in the home directory.

## Directory Structure

- `src/`: chezmoi source files (configuration templates)
  - `src/dot_config/`: XDG-compliant configuration files (zsh, git, neovim, wezterm, etc.)
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
deno fmt --check

# Environment validation with Goss (run after chezmoi apply)
GOSS_USE_ALPHA=1 goss validate --format documentation
```

### Setup

```sh
# Initial setup (runs install.sh)
./install.sh

# Manual chezmoi apply
./bin/cz apply -v
```

### Environment Tools

- **mise**: runtime version management (deno, etc.)
- **Homebrew**: package management (defined in Brewfile)
- **goss**: environment validation

## Architecture

### Clean Environment Execution

`bin/run-clean-env` resets environment variables to a minimal set, configuring only Homebrew and system paths. This allows running chezmoi and brew without interference from existing shell configurations.

### Zsh Configuration Lazy Loading

- `.zshenv`: environment variable configuration (especially ZDOTDIR)
- `.zprofile`: login shell configuration
- `dot_config/zsh/.zshrc`: main zsh configuration
  - `zshrc.d/`: immediately loaded configurations
  - `zshrc.defer.d/`: lazy-loaded configurations (mise, alias, fzf, etc.)

### Template System

`.tmpl` files are processed by chezmoi's template engine. Platform-specific configurations (e.g., `conf.d/platform.tmpl`) and environment-dependent values like Homebrew paths are dynamically generated.
