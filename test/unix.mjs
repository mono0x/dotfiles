/// <reference types="zx/build/globals" />

cd(path.join(__dirname, ".."))

await $`./build-env/bootstrap.sh`
// Run the script twice to test idempotency
await $`./build-env/bootstrap.sh`

await $`zsh -i -c exit`
