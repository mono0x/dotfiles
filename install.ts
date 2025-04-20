import $ from "jsr:@david/dax@^0.42.0";
import * as fs from "jsr:@std/fs@^0.224.0";
import * as path from "jsr:@std/path@^0.224.0";

$.setPrintCommand(true);

const account = "mono0x";

if (
  !(Deno.build.os === "linux" || Deno.build.os === "darwin")
) {
  console.error(`Unsupported OS: ${Deno.build.os}`);
  Deno.exit(1);
}

const ci = Deno.env.get("GITHUB_ACTIONS") === "true";
const remoteContainers = Deno.env.get("REMOTE_CONTAINERS") === "true";

console.log(`
  OS: ${Deno.build.os}
  CI: ${ci}
  Remote Containers: ${remoteContainers}
`);

if (remoteContainers) {
  await setupRemoteContainer();
  Deno.exit(0);
}

switch (Deno.build.os) {
  case "linux":
  case "darwin":
    await setupUnix(Deno.build.os);
    break;
}

async function setupRemoteContainer() {
  console.log("Installing and initalizing chezmoi");
  await $`sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --verbose ${account}`;
}

async function setupUnix(os: "linux" | "darwin") {
  const homeDir = Deno.env.get("HOME");
  if (!homeDir) {
    console.error("HOME environment variable not set");
    Deno.exit(1);
  }

  if (os === "linux") {
    console.log("Installing dependencies");

    await aptInstall([
      // https://docs.brew.sh/Homebrew-on-Linux
      "build-essential",
      "procps",
      "curl",
      "file",
      "git",

      "language-pack-en",
      "libssl-dev",
      "pkg-config",
      "zsh",
    ]);
  }

  const homebrewDir = os === "linux"
    ? "/home/linuxbrew/.linuxbrew"
    : "/opt/homebrew";
  const brew = path.join(homebrewDir, "bin", "brew");

  console.log("Installing Homebrew");

  if (!await fs.exists(brew)) {
    await $`/bin/bash --noprofile --norc`
      .stdinText(`
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      `);
  }

  console.log("Installing and initializing chezmoi");

  await $`/bin/bash --noprofile --norc`
    .stdinText(`
      eval $("${brew}" shellenv)
      HOMEBREW_NO_AUTO_UPDATE=1 "${brew}" install chezmoi
      chezmoi init --verbose --apply ${account}
    `)
    .clearEnv()
    .env({
      GITHUB_ACTIONS: Deno.env.get("GITHUB_ACTIONS"),
      HOME: homeDir,
    });
}

async function aptInstall(packages: string[]) {
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
}
