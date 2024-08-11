if ($PSVersionTable["PSEdition"] -ne "Core") {
  Write-Host "This script requires PowerShell Core. Skip."
  return
}

# https://stackoverflow.com/questions/9738535/powershell-test-for-noninteractive-mode
function IsInteractive {
  # Test each Arg for match of abbreviated '-NonInteractive' command.
  $NonInteractive = [Environment]::GetCommandLineArgs() | Where-Object { $_ -like '-NonI*' }

  if ([Environment]::UserInteractive -and -not $NonInteractive) {
    # We are in an interactive shell.
    return $true
  }

  return $false
}

if (-not (IsInteractive)) {
  return
}

Set-PSReadLineOption `
  -BellStyle None `
  -EditMode Emacs `
  -HistoryNoDuplicates `
  -PredictionSource None `
  -ShowToolTips

Set-PSReadLineKeyHandler -Key Ctrl+n -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Remove default aliases to use coreutils-uutils
# https://secondlife.hatenablog.jp/entry/2020/08/17/070735
Remove-Alias -ErrorAction SilentlyContinue -Name (
  @"
    [, arch, b2sum, b3sum, base32, base64, basename, basenc, cat, cksum, comm, cp, csplit, cut,
    date, dd, df, dircolors, dirname, du, echo, env, expand, expr, factor, false, fmt, fold,
    hashsum, head, hostname, join, link, ln, ls, md5sum, mkdir, mktemp, more, mv, nl, nproc,
    numfmt, od, paste, pr, printenv, printf, ptx, pwd, readlink, realpath, relpath, rm, rmdir,
    seq, sha1sum, sha224sum, sha256sum, sha3-224sum, sha3-256sum, sha3-384sum, sha3-512sum,
    sha384sum, sha3sum, sha512sum, shake128sum, shake256sum, shred, shuf, sleep, sort, split,
    sum, sync, tac, tail, tee, test, touch, tr, true, truncate, tsort, unexpand, uniq, unlink,
    wc, whoami, yes
"@ -split ',' |
  ForEach-Object { $_.trim() } |
  Where-Object { ! @('tee', 'sort', 'sleep').Contains($_) }
)

# https://tex2e.github.io/blog/powershell/which
function which($cmd) {
  Get-Command $cmd -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Definition
}

Set-Alias cz chezmoi
Set-Alias g git
function ga() { git add $args }
function gd() { git di $args }
function gf() { git fetch --all $args }
function gg() { git grep -H --heading -I --line-number --break --show-function $args }
Remove-Alias -Force gl
function gl() { git log $args }
Remove-Alias -Force gm
function gm() { git checkout (git symbolic-ref refs/remotes/origin/HEAD | sed "s@^refs/remotes/origin/@@") }
function gs() { git status $args }
Set-Alias grep rg
function ll { uutils ls -l $args }

. $env:USERPROFILE\.config\pwsh\conf.d\deno.ps1
. $env:USERPROFILE\.config\pwsh\conf.d\starship.ps1
. $env:USERPROFILE\.config\pwsh\conf.d\wezterm.ps1
