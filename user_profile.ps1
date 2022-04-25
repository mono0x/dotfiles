Set-PSReadLineOption `
    -BellStyle None `
    -EditMode Emacs `
    -HistoryNoDuplicates `
    -ShowToolTips

# https://gist.github.com/trapezoid/5c824599f58f1b00f41487c51c41fe13
if (Get-InstalledModule -Name PSReadline -MinimumVersion 2.2.0 -ErrorAction SilentlyContinue) {
    Set-PSReadLineOption -PredictionSource History -PredictionViewStyle InlineView
    Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord

    function Switch-PredictionView() {
        if ((Get-PSReadLineOption).PredictionViewStyle -eq "InlineView") {
            Set-PSReadLineOption -PredictionViewStyle ListView
            Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function HistorySearchForward
            Set-PSReadLineKeyHandler -Key "Ctrl+b" -Function HistorySearchBackward
        }
        else {
            Set-PSReadLineOption -PredictionViewStyle InlineView
            Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
        }
    }

    Set-PSReadLineKeyHandler -Chord "Ctrl+r" -ScriptBlock { Switch-PredictionView }
}

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
function gd() { git di $args }
function gf() { git fetch --all $args }
function gg() { git grep -H --heading -I --line-number --break --show-function $args }
function gl() { git log $args }
function gs() { git status $args }
Set-Alias grep rg
function ll { uutils ls -l $args }
