/// <reference types="zx/build/globals" />

cd(path.join(__dirname, ".."))

await $`npx zx ./build-env/common.mjs`
// Run the script twice to test idempotency
await $`npx zx ./build-env/common.mjs`

await $`zsh -i -c exit`
