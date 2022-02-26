Set-PSReadLineOption `
  -BellStyle None `
  -EditMode Emacs `
  -HistoryNoDuplicates `
  -PredictionSource History `
  -PredictionViewStyle ListView `
  -ShowToolTips

# https://secondlife.hatenablog.jp/entry/2020/08/17/070735
@"
  arch, base32, base64, basename, cat, cksum, comm, cp, cut, date, df, dircolors, dirname,
  echo, env, expand, expr, factor, false, fmt, fold, hashsum, head, hostname, join, link, ln,
  ls, md5sum, mkdir, mktemp, more, mv, nl, nproc, od, paste, printenv, printf, ptx, pwd,
  readlink, realpath, relpath, rm, rmdir, seq, sha1sum, sha224sum, sha256sum, sha3-224sum,
  sha3-256sum, sha3-384sum, sha3-512sum, sha384sum, sha3sum, sha512sum, shake128sum,
  shake256sum, shred, shuf, sleep, sort, split, sum, sync, tac, tail, tee, test, touch, tr,
  true, truncate, tsort, unexpand, uniq, wc, whoami, yes
"@ -split ',' |
ForEach-Object { $_.trim() } |
Where-Object { ! @('tee', 'sort', 'sleep').Contains($_) } |
ForEach-Object {
  $cmd = $_
  if (Test-Path Alias:$cmd) { Remove-Item -Path Alias:$cmd }
  $fn = '$input | uutils ' + $cmd + ' $args'
  Invoke-Expression "function global:$cmd { $fn }"
}

Set-Alias g git
function ga() { git add $args }
function gci() { git ci $args }
function gd() { git di $args }
function gf() { git fetch --all $args }
function gg() { git grep -H --heading -I --line-number --break --show-function $args }
function gl() { git log $args }
function gs() { git status $args }
Set-Alias grep rg
function ll { uutils ls -l $args }
