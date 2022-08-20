#!/bin/sh

const root = path.join(__dirname, "..")

await fs.mkdirp(path.join(os.homedir(), "bin"))
await fs.mkdirp(path.join(os.homedir(), ".config"))

cd(root)

await $`git submodule init`
await $`git submodule sync --recursive`
await $`git submodule update --recursive`

const rcs = [
  ".asdfrc",
  ".gitconfig",
  ".ideavimrc",
  ".npmrc",
  ".peco",
  ".source-highlight",
  ".tigrc",
  ".tmux.conf",
  ".zshenv",
  ".zshrc",
]

rcs.forEach(rc => {
  fs.ensureSymlink(path.join(root, rc), path.join(os.homedir(), rc))
})
fs.ensureSymlink(path.join(root, ".gitignore.global"), "~/.gitignore")

switch (os.type()) {
  case "Linux":
    fs.ensureSymlink(path.join(root, ".gitconfig.linux"), "~/.gitconfig.platform")
    break

  case "Darwin":
    fs.ensureSymlink(path.join(root, ".gitconfig.macos"), "~/.gitconfig.platform")

    for (const cmd of [
      "/opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight",
      "/usr/local/share/git-core/contrib/diff-highlight/diff-highlight",
    ]) {
      if (fs.pathExists(cmd)) {
        fs.ensureSymlink(cmd, "~/bin/diff-highlight")
        break
      }
    }

    break
}

fs.ensureSymlink(path.join(root, "nvim"), "~/.config/nvim")

if (!fs.pathExists("~/.asdf")) {
  await $`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0`
}

if (!fs.pathExists("~/.zinit")) {
  await fs.mkdirp("~/.zinit")
  await $`git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin`
}
