tap "homebrew/bundle"

ci = ENV["GITHUB_ACTIONS"] == "true"
STDERR.puts "GITHUB_ACTIONS => #{ENV["GITHUB_ACTIONS"]}"
STDERR.puts "CI => #{ci}"

brew "chezmoi"
brew "curl"
brew "mise"
brew "sheldon"
brew "socat"
brew "starship"
brew "zsh"

unless ci
  brew "bat"
  brew "colordiff"
  brew "deno"
  brew "editorconfig"
  brew "exiftool"
  brew "fswatch"
  brew "fzf"
  brew "ghq"
  brew "git"
  brew "git-delta"
  brew "git-lfs"
  brew "hadolint"
  brew "htop"
  brew "hub"
  brew "jq"
  brew "mercurial"
  brew "neovim"
  brew "ripgrep"
  brew "shellcheck"
  brew "tig"
  brew "xz"
  brew "zx"
end

if OS.mac?
  unless ci
    tap "1password/tap"

    brew "autoconf"
    brew "automake"
    brew "cmake"
    brew "coreutils"
    brew "findutils"
    brew "gpg"
    brew "gnu-sed"
    brew "grep"
    brew "gzip"
    brew "rsync"
    brew "unzip"
    brew "wget"

    cask "1password-cli"
    cask "git-credential-manager"
  end
end
