import $ from "https://deno.land/x/dax@0.24.1/mod.ts"
import * as path from "https://deno.land/std@0.173.0/path/mod.ts"

const __dirname = path.dirname(path.fromFileUrl(import.meta.url))

$. cd(path.join(__dirname, ".."))

await $`./build-env/bootstrap.sh`
// Run the script twice to test idempotency
await $`./build-env/bootstrap.sh`

await $`zsh -i -c exit`
