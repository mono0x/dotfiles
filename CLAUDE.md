# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository managed by chezmoi for setting up a macOS development environment. The main focus is on Zsh configuration, terminal tools, and development environment setup.

## Architecture

- **chezmoi structure**: Uses chezmoi's `src/` directory with special prefixes:
  - `dot_` prefix for dotfiles (e.g., `dot_zshenv` becomes `.zshenv`)
  - `.tmpl` suffix for template files that use chezmoi's templating
  - `symlink_` prefix for symlinks
  - `private_` prefix for private files
- **Installation**: Driven by shell script (`install.sh`) that handles package installation and chezmoi setup
- **Configuration layers**:
  - Base shell configuration in `src/dot_zshenv` and `src/dot_zprofile`
  - Zsh config in `src/dot_config/zsh/` with modular loading
  - Tool-specific configs in `src/dot_config/` subdirectories

## Common Commands

### Development and Testing

- `./install.sh` - Run the installation script
- `./test/static.sh` - Run static analysis tests (shellcheck, zsh syntax)

### chezmoi Operations

- `chezmoi init --apply mono0x` - Initialize and apply dotfiles
- `chezmoi apply --verbose` - Apply configuration changes
- `chezmoi source-path` - Show source directory path
- `chezmoi diff` - Show differences between source and target

### Testing

- `./install.sh` - Test installation process
- `goss validate --format documentation` - Run goss tests
- CI runs tests on macOS with idempotency checks

## Key Files and Directories

### Core Installation

- `install.sh` - Main installation script that handles package installation and chezmoi setup
- `deno.jsonc` - Deno configuration with dependencies and tasks (legacy)

### Configuration Management

- `src/dot_config/zsh/` - Zsh configuration with functions and deferred loading
- `src/dot_config/git/` - Git configuration with platform-specific templates
- `src/dot_config/nvim/` - Neovim configuration
- `src/dot_config/wezterm/` - WezTerm terminal configuration

### Testing

- `test/static.sh` - Static analysis for shell scripts and Zsh files
- `test/goss/test-dotfiles.yaml` - System state validation tests
- `goss.yaml` - Goss configuration

### Synchronization

- `sync/` - Files synchronized between systems (karabiner configs)
- `third_party/` - External dependencies (neodev.nvim, wezterm-types)

## Template System

Uses chezmoi templating for platform-specific configuration:

- `.tmpl` files support Go templating syntax
- Platform detection with `{{ .chezmoi.os }}`
- Conditional configuration based on environment

## Dependencies

### Runtime Dependencies

- Shell script for installation
- chezmoi for dotfiles management
- Homebrew (installed automatically)
- zsh shell

### Development Dependencies

- shellcheck for shell script linting
- goss for system testing
- mise for tool version management

## Testing Strategy

1. **Static Analysis**: Validate shell scripts and Zsh syntax
2. **Integration Tests**: Run full installation and verify system state
3. **Idempotency**: Ensure scripts can run multiple times safely
4. **CI/CD**: Automated testing on macOS
