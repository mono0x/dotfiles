import $ from "@david/dax";

$.setPrintCommand(true);

const packages = Deno.args;
if (packages.length === 0) {
  console.error("No packages specified");
  Deno.exit(1);
}

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
