#!/usr/bin/env -S deno run --allow-env --allow-read --allow-write --allow-run --allow-net
import $ from "https://deno.land/x/dax@0.24.1/mod.ts"
import * as fs from "https://deno.land/std@0.173.0/fs/mod.ts"
import * as path from "https://deno.land/std@0.173.0/path/mod.ts"

$.setPrintCommand(true)

const homedir = (Deno.env.get("HOME") ?? Deno.env.get("USERPROFILE") ?? Deno.env.get("HOMEPATH"))
if (!homedir) {
  throw new Error("HOME is not set")
}
const __dirname = path.dirname(path.fromFileUrl(import.meta.url))

const root = path.join(__dirname, "..")
const conf = path.join(root, "conf")

await fs.ensureDir(path.join(homedir, "bin"))
await fs.ensureDir(path.join(homedir, ".config"))

$.cd(root)

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

for (const rc of rcs) {
  await $`ln -sfn ${path.join(conf, rc)} ${path.join(homedir, rc)}`
}
await $`ln -sfn ${path.join(conf, ".gitignore.global")} ${path.join(homedir, ".gitignore")}`
await $`ln -sfn ${path.join(conf, ".yarnrc.global.yml")} ${path.join(homedir, ".yarnrc.yml")}`

const gitconfigs = {
  linux: ".gitconfig.linux",
  darwin: ".gitconfig.macos",
  windows: ".gitconfig.windows",
}

const gitconfig = gitconfigs[Deno.build.os]
await $`ln -sfn ${path.join(conf, gitconfig)} ${path.join(homedir, ".gitconfig.platform")}`

for (const prefix of ["/home/linuxbrew/.linuxbrew", "/opt/homebrew", "/usr/local"]) {
  const cmd = path.join(prefix, "share/git-core/contrib/diff-highlight/diff-highlight")
  if (await fs.exists(cmd)) {
    await $`ln -sfn ${cmd} ${path.join(homedir, "bin/diff-highlight")}`
    break
  }
}

await $`ln -sfn ${path.join(conf, "nvim")} ${path.join(homedir, ".config/nvim")}`

try {
  await $`git clone https://github.com/asdf-vm/asdf.git ${path.join(homedir, ".asdf")} --branch v0.11.0`
} catch (_e) { /* do nothing */ }

try {
  await fs.ensureDir(path.join(homedir, ".zinit"))
  await $`git clone https://github.com/zdharma-continuum/zinit.git ${path.join(homedir, ".zinit/bin")}`
} catch (_e) { /* do nothing */ }
