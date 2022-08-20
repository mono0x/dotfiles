cd(path.join(__dirname, ".."))

await $`shellcheck ./**/*.sh`
await $`zsh -n .zshenv .zshrc`
