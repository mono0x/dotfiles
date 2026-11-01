#!/bin/bash
set -euo pipefail

runner=$(cd -- "$(dirname -- "$0")/../bin" && pwd -P)/herdr-run
test_dir=$(mktemp -d)
trap 'rm -rf -- "$test_dir"' EXIT
export TEST_LOG="$test_dir/log" TEST_OUTPUT="$test_dir/output"
mkdir -p "$test_dir/bin" "$test_dir/non-repository"
export PATH="$test_dir/bin:$PATH"
export HERDR_ENV=1

cat >"$test_dir/bin/herdr" <<'MOCK'
#!/bin/bash
case "$1 $2" in
'workspace create')
  printf '%s\n' "$*" >>"$TEST_LOG"
  [[ ${TEST_CREATE_STATUS:-0} == 0 ]] || exit "$TEST_CREATE_STATUS"
  printf '%s\n' '{"result":{"workspace":{"workspace_id":"new"},"root_pane":{"pane_id":"new:p1"}}}'
  ;;
'pane run')
  [[ $3 == new:p1 ]] || exit 1
  [[ ${TEST_LAUNCH_STATUS:-0} == 0 ]] || exit "$TEST_LAUNCH_STATUS"
  /bin/zsh -f -c "$4"
  ;;
'workspace close')
  [[ $3 == new ]] || exit 1
  printf '%s\n' close >>"$TEST_LOG"
  ;;
*) exit 1 ;;
esac
MOCK
cat >"$test_dir/bin/capture" <<'MOCK'
#!/bin/bash
[[ $# == 5 && $1 == 'a b' && -z $2 && $3 == "a'b" && $4 == '$HOME; $(false)' && $5 == $'line\nbreak' ]] || exit 1
pwd -P >"$TEST_OUTPUT"
MOCK
chmod +x "$test_dir/bin/"*
cd -- "$test_dir/non-repository"

# shellcheck disable=SC2016 # Shell syntax must reach the command as literal arguments.
"$runner" -- capture 'a b' '' "a'b" '$HOME; $(false)' $'line\nbreak'
[[ $(cat "$TEST_OUTPUT") == "$(pwd -P)" ]]
[[ $(head -n 1 "$TEST_LOG") == "workspace create --label non-repository --cwd $(pwd -P) --focus" ]]
[[ $(tail -n 1 "$TEST_LOG") == close ]]

"$runner" --workspace 'temporary agent' -- /usr/bin/true
"$runner" --workspace 'temporary agent' -- /usr/bin/true
[[ $(wc -l <"$TEST_LOG") -eq 6 ]]

: >"$TEST_LOG"
if "$runner" -- /bin/bash -c 'exit 42'; then
  exit 1
fi
[[ $(wc -l <"$TEST_LOG") -eq 1 ]]
# The worker preserves the command's exit status.
status=0
"$runner" --worker new -- /bin/bash -c 'exit 42' || status=$?
[[ $status == 42 ]]

: >"$TEST_LOG"
if TEST_CREATE_STATUS=1 "$runner" -- /usr/bin/true; then
  exit 1
fi
[[ $(wc -l <"$TEST_LOG") -eq 1 ]]

: >"$TEST_LOG"
if TEST_LAUNCH_STATUS=1 "$runner" -- /usr/bin/true; then
  exit 1
fi
[[ $(wc -l <"$TEST_LOG") -eq 1 ]]

: >"$TEST_LOG"
# shellcheck disable=SC2016 # Expand the output path in the child shell.
HERDR_ENV=0 "$runner" -- /bin/bash -c 'pwd -P >"$TEST_OUTPUT"'
[[ ! -s $TEST_LOG && $(cat "$TEST_OUTPUT") == "$(pwd -P)" ]]
status=0
HERDR_ENV=0 "$runner" -- /bin/bash -c 'exit 42' || status=$?
[[ $status == 42 ]]

for invalid in '' '--' '--workspace'; do
  status=0
  "$runner" "$invalid" || status=$?
  [[ $status == 2 ]]
done
printf '%s\n' 'herdr-run checks passed'
