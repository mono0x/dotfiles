import $ from "@david/dax";
import * as path from "@std/path";

$.setPrintCommand(true);

$.cd(path.resolve(import.meta.dirname!, ".."));

const targets = [
  "x86_64-unknown-linux-gnu",
  "aarch64-unknown-linux-gnu",
  "x86_64-pc-windows-msvc",
  "x86_64-apple-darwin",
  "aarch64-apple-darwin",
];

for (const target of targets) {
  await $`deno compile --target ${target} --output bootstrap/_build/bootstrap-${target} -A bootstrap/src/main.ts`;
}
