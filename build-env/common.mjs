#!/usr/bin/env zx
/// <reference types="zx/build/globals" />

const root = path.join(__dirname, "..")
const conf = path.join(root, "conf")

await fs.mkdirp(path.join(os.homedir(), "bin"))
await fs.mkdirp(path.join(os.homedir(), ".config"))

cd(root)

await $`git submodule init`
await $`git submodule sync --recursive`
await $`git submodule update --recursive`

const rcs = [
  ".asdfrc",
  ".config/starship.toml",
  ".gitconfig",
  ".ideavimrc",
  ".npmrc",
  ".source-highlight",
  ".tigrc",
  ".tmux.conf",
  ".zshenv",
  ".zshrc",
]

await Promise.all(
  rcs.map(rc => {
    $`ln -sfn ${path.join(conf, rc)} ${path.join(os.homedir(), rc)}`
  }),
  $`ln -sfn ${path.join(conf, ".gitignore.global")} ${path.join(os.homedir(), ".gitignore")}`,
  $`ln -sfn ${path.join(conf, ".yarnrc.global.yml")} ${path.join(os.homedir(), ".yarnrc.yml")}`,
)

const gitconfig = {
  "Linux": ".gitconfig.linux",
  "Darwin": ".gitconfig.macos",
}[os.type()]
if (gitconfig) {
  await $`ln -sfn ${path.join(conf, gitconfig)} ${path.join(os.homedir(), ".gitconfig.platform")}`
}

for (const prefix of ["/home/linuxbrew/.linuxbrew", "/opt/homebrew", "/usr/local"]) {
  const cmd = path.join(prefix, "share/git-core/contrib/diff-highlight/diff-highlight")
  if (await fs.pathExists(cmd)) {
    await $`ln -sfn ${cmd} ${path.join(os.homedir(), "bin/diff-highlight")}`
    break
  }
}

await $`ln -sfn ${path.join(conf, "nvim")} ${path.join(os.homedir(), ".config/nvim")}`

if (!await fs.pathExists(path.join(os.homedir(), ".asdf"))) {
  await $`git clone https://github.com/asdf-vm/asdf.git ${path.join(os.homedir(), ".asdf")} --branch v0.8.0`
}

if (!await fs.pathExists(path.join(os.homedir(), ".zinit"))) {
  await fs.mkdirp(path.join(os.homedir(), ".zinit"))
  await $`git clone https://github.com/zdharma-continuum/zinit.git ${path.join(os.homedir(), ".zinit/bin")}`
}
