#!/usr/bin/env -S deno run --allow-env --allow-read --allow-write --allow-run --allow-net
import $ from "https://deno.land/x/dax/mod.ts";

const link = async (
  oldpath: string,
  newpath: string,
) => {
  const tempDir = await Deno.makeTempDir();
  try {
    const temp = $.path.join(tempDir, $.path(newpath).basename());
    await Deno.symlink(oldpath, temp);
    await Deno.stat(temp); // check if the symlink is valid
    await Deno.rename(temp, newpath);
  } finally {
    await Deno.remove(tempDir, { recursive: true });
  }
};

$.setPrintCommand(true);

const homedir = Deno.env.get("HOME") ?? Deno.env.get("USERPROFILE") ??
  Deno.env.get("HOMEPATH");
if (!homedir) {
  throw new Error("HOME is not set");
}
const __dirname = $.path.dirname($.path.fromFileUrl(import.meta.url));

const root = $.path.join(__dirname, "..");
const conf = $.path.join(root, "conf");

await $.fs.ensureDir($.path.join(homedir, "bin"));
await $.fs.ensureDir($.path.join(homedir, ".config"));

$.cd(root);

await $`git submodule init`;
await $`git submodule sync --recursive`;
await $`git submodule update --recursive`;

const rcs = [
  ".asdfrc",
  ".config/starship.toml",
  ".gitconfig",
  ".ideavimrc",
  ".npmrc",
  ".source-highlight",
  ".tigrc",
  ".tmux.conf",
  ".wezterm.lua",
  ".zshenv",
  ".zshrc",
];

await Promise.all(
  rcs.map((rc) => link($.path.join(conf, rc), $.path.join(homedir, rc))),
);
await link(
  $.path.join(conf, ".gitignore.global"),
  $.path.join(homedir, ".gitignore"),
);
await link(
  $.path.join(conf, ".yarnrc.global.yml"),
  $.path.join(homedir, ".yarnrc.yml"),
);

const gitconfigs = {
  linux: ".gitconfig.linux",
  darwin: ".gitconfig.macos",
  windows: ".gitconfig.windows",
};

const gitconfig = gitconfigs[Deno.build.os];
await link(
  $.path.join(conf, gitconfig),
  $.path.join(homedir, ".gitconfig.platform"),
);

for (
  const prefix of ["/home/linuxbrew/.linuxbrew", "/opt/homebrew", "/usr/local"]
) {
  const cmd = $.path.join(
    prefix,
    "share/git-core/contrib/diff-highlight/diff-highlight",
  );
  try {
    await link(cmd, $.path.join(homedir, "bin/diff-highlight"));
    break;
  } catch (e) {
    if (e instanceof Deno.errors.NotFound) {
      continue;
    } else {
      throw e;
    }
  }
}

await link($.path.join(conf, "nvim"), $.path.join(homedir, ".config/nvim"));

try {
  await $`git clone https://github.com/asdf-vm/asdf.git ${
    $.path.join(homedir, ".asdf")
  } --branch v0.11.0`;
} catch (_e) { /* do nothing */ }

try {
  await $.fs.ensureDir($.path.join(homedir, ".zinit"));
  await $`git clone https://github.com/zdharma-continuum/zinit.git ${
    $.path.join(homedir, ".zinit/bin")
  }`;
} catch (_e) { /* do nothing */ }
