# Repository Guidelines

## Project Structure & Module Organization
This repository is managed with chezmoi; tracked dotfiles live under `src/`. Template naming uses `dot_*` to map to files in `$HOME` (for example, `src/dot_zshenv` becomes `~/.zshenv`) and `executable_*` for scripts deployed into `~/bin`. Neovim, WezTerm, and other app settings reside in `src/dot_config`. Local utilities live in `src/bin`. Tests and verification scripts sit in `test/` (`test/static.sh` and `test/goss/`). Vendor snapshots stay in `third_party/`, while machine-specific sync assets are under `sync/`.

## Build, Test, and Development Commands
- `chezmoi apply --dry-run --verbose`: Preview how a change affects the target machine before applying.
- `chezmoi apply --verbose`: Apply dotfile updates locally; run after validating.
- `./test/static.sh`: Run ShellCheck on scripts and validate `.zsh` syntax.
- `goss -g test/goss/test-dotfiles.yaml validate`: Smoke-test expected files after apply.
- `deno fmt`: Format Markdown and JSON files per `deno.jsonc` (excludes `sync/` and `third_party/`).

## Coding Style & Naming Conventions
Shell scripts default to POSIX `sh` unless Bashisms are required; keep `#!/bin/sh` and use two-space indentation. Fail fast with `set -eu` or `set -euo pipefail` as appropriate. Zsh files must stay compatible with `zsh -n`. Name new templates with chezmoi prefixes (`dot_`, `executable_`, `run_once_`) so they resolve correctly. Keep paths XDG-aware (write to `$XDG_CONFIG_HOME`, etc.) to align with the existing layout. Run `deno fmt` for supported text files and `shellcheck` on new scripts.

## Testing Guidelines
Add or update expectations in `test/goss/test-dotfiles.yaml` when provisioning new files. For script-heavy changes, extend `test/static.sh` or run `shellcheck src/path/to/script.sh`. When adding Zsh functions, verify with `zsh -n path/to/file.zsh`. Execute `chezmoi apply --destination tmpdir --dry-run` to inspect rendered results without touching `$HOME`.

## Commit & Pull Request Guidelines
Write imperative, concise commit titles (`Add bun`, `Update cooldown days`). Reference GitHub issues or pull requests using `(#id)` when applicable. In pull requests, summarize what changed, how it was tested (`./test/static.sh`, `goss validate`), and include screenshots for UI-related configs (such as WezTerm) when relevant. Ensure applied machines stay secure—omit secrets and machine-specific tokens; use placeholders and document setup steps in comments or the README.
