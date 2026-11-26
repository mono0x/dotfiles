#!/bin/bash
set -euo pipefail

cd -- "$(dirname -- "$0")/.."
run=$(mise tasks info bootstrap --json | jq -r '.run[0]')
test_dir=$(mktemp -d)
trap 'rm -rf -- "$test_dir"' EXIT
mkdir -p "$test_dir/.local/share/mise/shims"

cat >"$test_dir/.local/share/mise/shims/chezmoi" <<'MOCK'
#!/bin/sh
set -eu
[ "$#" -eq 1 ] && [ "$1" = apply ]
[ "$(command -v gh)" = "$PWD/bin/gh" ]
printf '%s\n' "${GH_TOKEN:-}${GITHUB_TOKEN:-}"
MOCK
chmod +x "$test_dir/.local/share/mise/shims/chezmoi"

unset GH_TOKEN GITHUB_TOKEN

output=$(HOME="$test_dir" TMPDIR="${TMPDIR:-/tmp}" GH_TOKEN=bootstrap-test-token /bin/sh -c "$run")
[[ $output == bootstrap-test-token ]]

output=$(HOME="$test_dir" TMPDIR="${TMPDIR:-/tmp}" GITHUB_TOKEN=bootstrap-test-token /bin/sh -c "$run")
[[ $output == bootstrap-test-token ]]

output=$(HOME="$test_dir" TMPDIR="${TMPDIR:-/tmp}" /bin/sh -c "$run")
[[ -z $output ]]

printf '%s\n' 'bootstrap environment checks passed'
