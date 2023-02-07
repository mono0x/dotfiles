import $ from "https://deno.land/x/dax@0.24.1/mod.ts";
import * as fs from "https://deno.land/std@0.173.0/fs/mod.ts";
import * as path from "https://deno.land/std@0.173.0/path/mod.ts";

$.setPrintCommand(true);

const __dirname = path.dirname(path.fromFileUrl(import.meta.url));

$.cd(path.join(__dirname, ".."));

await $`shellcheck --version`;
for await (const entry of fs.expandGlob("{bin,build-env}/**/*.sh")) {
  await $`shellcheck ${entry.path}`;
}
await $`zsh -n conf/.zshenv conf/.zshrc`;
