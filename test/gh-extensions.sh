#!/bin/bash
set -euo pipefail

script=$(cd -- "$(dirname -- "$0")/../src/.chezmoiscripts/unix" && pwd -P)/run_after_01_gh_extensions.sh
test_dir=$(mktemp -d)
trap 'rm -rf -- "$test_dir"' EXIT
export TEST_LOG="$test_dir/log" TEST_EXTENSIONS="$test_dir/extensions"
mkdir -p "$test_dir/bin"
export PATH="$test_dir/bin:$PATH"

cat >"$test_dir/bin/gh" <<'MOCK'
#!/bin/sh
set -eu
case "$1 $2" in
  'extension list')
    cat "$TEST_EXTENSIONS"
    exit "${TEST_LIST_STATUS:-0}"
    ;;
  'extension remove')
    printf '%s\n' "$*" >>"$TEST_LOG"
    exit "${TEST_REMOVE_STATUS:-0}"
    ;;
  'extension install')
    printf '%s\n' "$*" >>"$TEST_LOG"
    exit "${TEST_INSTALL_STATUS:-0}"
    ;;
  *) exit 1 ;;
esac
MOCK
cat >"$test_dir/bin/chronic" <<'MOCK'
#!/bin/sh
exec "$@"
MOCK
chmod +x "$test_dir/bin/"*

install='extension install github/gh-actions-lock --pin v0.4.1'
install_infra='extension install babarot/gh-infra --pin v0.20.0'
replace=$(printf '%s\n%s' 'extension remove gh-actions-lock' "$install")

: >"$TEST_EXTENSIONS"
: >"$TEST_LOG"
sh "$script"
[[ $(cat "$TEST_LOG") == "$(printf '%s\n%s' "$install" "$install_infra")" ]]

printf 'gh other\towner/gh-other\tv1.0.0\n' >"$TEST_EXTENSIONS"
printf 'gh infra\tbabarot/gh-infra\tv0.20.0\n' >>"$TEST_EXTENSIONS"
: >"$TEST_LOG"
sh "$script"
[[ $(cat "$TEST_LOG") == "$install" ]]

for version in v0.4.1 v0.4.0 v0.5.0; do
  printf 'gh actions-lock\tgithub/gh-actions-lock\t%s\n' "$version" >"$TEST_EXTENSIONS"
  printf 'gh infra\tbabarot/gh-infra\tv0.20.0\n' >>"$TEST_EXTENSIONS"
  : >"$TEST_LOG"
  sh "$script"
  if [[ $version == v0.4.1 ]]; then
    [[ ! -s $TEST_LOG ]]
  else
    [[ $(cat "$TEST_LOG") == "$replace" ]]
  fi
done

printf 'gh actions-lock\tgithub/gh-actions-lock\tv0.4.1\n' >"$TEST_EXTENSIONS"
printf 'gh infra\tbabarot/gh-infra\tv0.19.0\n' >>"$TEST_EXTENSIONS"
: >"$TEST_LOG"
sh "$script"
[[ $(cat "$TEST_LOG") == "$(printf '%s\n%s' 'extension remove gh-infra' "$install_infra")" ]]

: >"$TEST_LOG"
status=0
TEST_LIST_STATUS=4 sh "$script" || status=$?
[[ $status == 4 && ! -s $TEST_LOG ]]

: >"$TEST_LOG"
status=0
TEST_REMOVE_STATUS=1 sh "$script" || status=$?
[[ $status == 1 && $(cat "$TEST_LOG") == 'extension remove gh-infra' ]]

: >"$TEST_EXTENSIONS"
: >"$TEST_LOG"
status=0
TEST_INSTALL_STATUS=1 sh "$script" || status=$?
[[ $status == 1 && $(cat "$TEST_LOG") == "$install" ]]

printf '%s\n' 'gh extension checks passed'
