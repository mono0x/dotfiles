import $ from "https://deno.land/x/dax/mod.ts";

$.setPrintCommand(true);

const packages = [
  "build-essential",
  "language-pack-en",
  "libssl-dev",
  "pkg-config",
  "zsh",
];

const installed = new Set(
  (await $`dpkg --get-selections`.lines())
    .map((l) => l.split(/\t+/))
    .filter(([, v]) => v === "install")
    .map(([k]) => k.includes(":") ? k.split(":")[0] : k),
);

const installs = packages.filter((p) => !installed.has(p));

if (installs.length > 0) {
  await $`${Deno.uid() == 0 ? "" : "sudo"} apt-get install -y ${installs}`;
}
