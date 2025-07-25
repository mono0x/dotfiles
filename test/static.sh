#!/bin/bash
set -euo pipefail

# Get the root directory (parent of test directory)
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "Running static analysis tests..."

# Check shellcheck version
echo "Checking shellcheck version..."
shellcheck --version

# Check shell scripts in bin and src directories
echo "Checking shell scripts..."
find bin src -name "*.sh" -type f 2>/dev/null | while read -r file; do
    echo "Checking $file"
    shellcheck "$file"
done

# Check install.sh
echo "Checking install.sh"
shellcheck install.sh

# Check zsh syntax for dot_zshenv
echo "Checking zsh syntax for src/dot_zshenv"
zsh -n src/dot_zshenv

# Check zsh syntax for all .zsh files
echo "Checking zsh syntax for .zsh files..."
find src -name "*.zsh" -type f | while read -r file; do
    echo "Checking $file"
    zsh -n "$file"
done

echo "All static analysis tests passed!"