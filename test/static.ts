import $ from "https://deno.land/x/dax/mod.ts";

$.setPrintCommand(true);

const homedir = Deno.env.get("HOME") ?? Deno.env.get("USERPROFILE") ??
  Deno.env.get("HOMEPATH");
if (!homedir) {
  throw new Error("HOME is not set");
}

const root = $.path.join(
  $.path.dirname($.path.fromFileUrl(import.meta.url)),
  "..",
);
$.cd(root);

await $`shellcheck --version`;
for await (const file of $.fs.expandGlob("{bin,src}/*.sh")) {
  await $`shellcheck ${file.path}`;
}
await $`shellcheck ${$.path.join(root, "install.sh")}`;

for (const file of ["src/dot_zshenv", "src/dot_zshrc"]) {
  await $`zsh -n ${$.path.join(root, file)}`;
}
await $`deno lint`;
