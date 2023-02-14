import $ from "https://deno.land/x/dax/mod.ts";

$.setPrintCommand(true);

const __dirname = $.path.dirname($.path.fromFileUrl(import.meta.url));

$.cd($.path.join(__dirname, ".."));

await $`./build-env/devcontainer.sh`;
