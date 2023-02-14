import $ from "https://deno.land/x/dax/mod.ts";

$.setPrintCommand(true);

const __dirname = $.path.dirname($.path.fromFileUrl(import.meta.url));

$.cd($.path.join(__dirname, ".."));

await $`shellcheck --version`;
for await (const entry of $.fs.expandGlob("{bin,build-env}/**/*.sh")) {
  await $`shellcheck ${entry.path}`;
}
await $`zsh -n conf/.zshenv conf/.zshrc`;

await $`deno lint`;
