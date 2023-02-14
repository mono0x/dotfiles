import $ from "https://deno.land/x/dax/mod.ts";

$.setPrintCommand(true);

const __dirname = $.path.dirname($.path.fromFileUrl(import.meta.url));

$.cd($.path.join(__dirname, ".."));

await $`./build-env/bootstrap.sh`;
// Run the script twice to test idempotency
await $`./build-env/bootstrap.sh`;

await $`zsh -i -c exit`;
