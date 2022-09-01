/// <reference types="zx/build/globals" />

cd(path.join(__dirname, ".."))

await $`./build-env/devcontainer.sh`
