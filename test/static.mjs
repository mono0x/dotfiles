/// <reference types="zx/build/globals" />

cd(path.join(__dirname, ".."))

await $`shellcheck --version`
await $`shellcheck ./**/*.sh`
await $`zsh -n conf/.zshenv conf/.zshrc`
