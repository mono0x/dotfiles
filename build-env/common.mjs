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

await Promise.all(
  rcs.map(rc => {
    fs.ensureSymlink(path.join(root, rc), path.join(os.homedir(), rc))
  })
)
await fs.ensureSymlink(path.join(root, ".gitignore.global"), path.join(os.homedir(), ".gitignore"))

switch (os.type()) {
  case "Linux":
    fs.ensureSymlink(path.join(root, ".gitconfig.linux"), path.join(os.homedir(), ".gitconfig.platform"))
    break
  case "Darwin":
    fs.ensureSymlink(path.join(root, ".gitconfig.macos"), path.join(os.homedir(), ".gitconfig.platform"))
    break
}

for (const cmd of [
  "/home/linuxbrew/.linuxbrew/share/git-core/contrib/diff-highlight/diff-highlight",
  "/opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight",
  "/usr/local/share/git-core/contrib/diff-highlight/diff-highlight",
]) {
  if (await fs.pathExists(cmd)) {
    await fs.ensureSymlink(cmd, path.join(os.homedir(), "bin", "diff-highlight"))
    break
  }
}

await fs.ensureSymlink(path.join(root, "nvim"), path.join(os.homedir(), ".config", "nvim"))

if (!await fs.pathExists(path.join(os.homedir(), ".asdf"))) {
  await $`git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0`
}

if (!await fs.pathExists(path.join(os.homedir(), ".zinit"))) {
  await fs.mkdirp(path.join(os.homedir(), ".zinit"))
  await $`git clone https://github.com/zdharma-continuum/zinit.git ~/.zinit/bin`
}
