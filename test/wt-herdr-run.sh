#!/bin/bash
set -euo pipefail

runner=$(cd -- "$(dirname -- "$0")/../bin" && pwd -P)/wt-herdr-run
test_dir=$(mktemp -d)
trap 'rm -rf -- "$test_dir"' EXIT
export TEST_REPO="$test_dir/repo" TEST_WORKTREE="$test_dir/worktree" TEST_LOG="$test_dir/log"
mkdir -p "$test_dir/bin" "$TEST_REPO" "$TEST_WORKTREE"
export PATH="$test_dir/bin:$PATH"
export HERDR_ENV=1 HERDR_WORKSPACE_ID=original

cat >"$test_dir/bin/git" <<'SH'
#!/bin/bash
printf '%s\n' "$TEST_REPO"
SH
cat >"$test_dir/bin/wt" <<'SH'
#!/bin/bash
case $3 in
switch) jq -n --arg path "$TEST_WORKTREE" '{path: $path, action: "created"}' ;;
remove)
  printf '%s\n' remove >>"$TEST_LOG"
  exit "${TEST_REMOVE_STATUS:-0}"
  ;;
*) exit 1 ;;
esac
SH
cat >"$test_dir/bin/herdr" <<'SH'
#!/bin/bash
case "$1 $2" in
'workspace create')
  printf '%s\n' "$*" >>"$TEST_LOG"
  printf '%s\n' '{"result":{"workspace":{"workspace_id":"new"},"root_pane":{"pane_id":"new:p1"}}}'
  ;;
'pane run')
  [[ $3 == new:p1 && $4 == *' --worker '* && $4 == *' new -- '* ]] || exit 1
  ;;
'workspace close')
  [[ $3 == new ]] || exit 1
  printf '%s\n' close >>"$TEST_LOG"
  ;;
*) exit 1 ;;
esac
SH
chmod +x "$test_dir/bin/"*

# Repeated reviews must each create a workspace, even with the same label.
"$runner" --workspace 'review pr:123' pr:123 -- /usr/bin/true
"$runner" --workspace 'review pr:123' pr:123 -- /usr/bin/true
[[ $(wc -l <"$TEST_LOG") -eq 2 ]]
[[ $(head -n 1 "$TEST_LOG") == "workspace create --label review pr:123 --cwd $TEST_WORKTREE --focus" ]]

: >"$TEST_LOG"
"$runner" --worker "$TEST_REPO" "$TEST_WORKTREE" true new -- /usr/bin/true
[[ $(cat "$TEST_LOG") == $'remove\nclose' ]]

: >"$TEST_LOG"
"$runner" --worker "$TEST_REPO" "$TEST_WORKTREE" false new -- /usr/bin/true
[[ $(cat "$TEST_LOG") == close ]]

: >"$TEST_LOG"
if "$runner" --worker "$TEST_REPO" "$TEST_WORKTREE" true new -- /usr/bin/false; then
  exit 1
fi
[[ ! -s $TEST_LOG ]]

if TEST_REMOVE_STATUS=1 "$runner" --worker "$TEST_REPO" "$TEST_WORKTREE" true new -- /usr/bin/true; then
  exit 1
fi
[[ $(cat "$TEST_LOG") == remove ]]

: >"$TEST_LOG"
HERDR_ENV=0 "$runner" pr:123 -- /usr/bin/true
[[ $(cat "$TEST_LOG") == remove ]]

printf '%s\n' 'wt-herdr-run checks passed'
