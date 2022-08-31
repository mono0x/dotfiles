/// <reference types="zx/build/globals" />

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
    $`ln -sfn ${path.join(root, rc)} ${path.join(os.homedir(), rc)}`
  })
)
await $`ln -sfn ${path.join(root, ".gitignore.global")} ${path.join(os.homedir(), ".gitignore")}`

switch (os.type()) {
  case "Linux":
    await $`ln -sfn ${path.join(root, ".gitconfig.linux")} ${path.join(os.homedir(), ".gitconfig.platform")}`
    break
  case "Darwin":
    await $`ln -sfn ${path.join(root, ".gitconfig.macos")} ${path.join(os.homedir(), ".gitconfig.platform")}`
    break
}

for (const cmd of [
  "/home/linuxbrew/.linuxbrew/share/git-core/contrib/diff-highlight/diff-highlight",
  "/opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight",
  "/usr/local/share/git-core/contrib/diff-highlight/diff-highlight",
]) {
  if (await fs.pathExists(cmd)) {
    await $`ln -sfn ${cmd} ${path.join(os.homedir(), "bin", "diff-highlight")}`
    break
  }
}

await $`ln -sfn ${path.join(root, "nvim")} ${path.join(os.homedir(), ".config", "nvim")}`

if (!await fs.pathExists(path.join(os.homedir(), ".asdf"))) {
  await $`git clone https://github.com/asdf-vm/asdf.git ${path.join(os.homedir(), ".asdf")} --branch v0.8.0`
}

if (!await fs.pathExists(path.join(os.homedir(), ".zinit"))) {
  await fs.mkdirp(path.join(os.homedir(), ".zinit"))
  await $`git clone https://github.com/zdharma-continuum/zinit.git ${path.join(os.homedir(), ".zinit", "bin")}`
}
