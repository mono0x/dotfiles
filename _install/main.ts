import $ from "@david/dax";
import * as fs from "@std/fs";
import * as path from "@std/path";

$.setPrintCommand(true);

const account = "mono0x";

if (
  !(Deno.build.os === "linux" || Deno.build.os === "darwin" ||
    Deno.build.os === "windows")
) {
  console.error(`Unsupported OS: ${Deno.build.os}`);
  Deno.exit(1);
}

const ci = Deno.env.get("GITHUB_ACTIONS") === "true";
const remoteContainers = Deno.env.get("REMOTE_CONTAINERS") === "true";
const wsl = !!Deno.env.get("WSL_DISTRO_NAME");

console.log(`
  OS: ${Deno.build.os}
  CI: ${ci}
  Remote Containers: ${remoteContainers}
  WSL: ${wsl}
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

  case "windows":
    await setupWindows();
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

  const scoopShimDir = await (async () => {
    if (!wsl) return;
    const scoop = await $.which("scoop");
    return scoop && path.dirname(scoop);
  })();

  const homebrewDir = os === "linux"
    ? "/home/linuxbrew/.linuxbrew"
    : "/opt/homebrew";
  const brew = path.join(homebrewDir, "bin", "brew");

  console.log("Installing Homebrew");

  if (!await fs.exists(brew)) {
    await $`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`;
  }

  console.log("Installing and initializing chezmoi");

  await $`/bin/bash --noprofile --norc`
    .stdinText(`
      export PATH=$PATH:${scoopShimDir}
      eval $("${brew}" shellenv)
      BREW_NO_AUTO_UPDATE=1 "${brew}" install chezmoi
      chezmoi init --verbose --apply ${account}
    `)
    .clearEnv()
    .env({
      GITHUB_ACTIONS: Deno.env.get("GITHUB_ACTIONS"),
      HOME: homeDir,
    });
}

async function setupWindows() {
  const homeDir = Deno.env.get("USERPROFILE");
  if (!homeDir) {
    console.error("USERPROFILE environment variable not set");
    Deno.exit(1);
  }

  console.log("Installing scoop");

  const scoopShimDir = path.join(homeDir, "scoop", "shims");
  if (!await fs.exists(scoopShimDir)) {
    await $`pwsh -noprofile -noninteractive -`
      .stdinText(`
        Invoke-RestMethod get.scoop.sh | Invoke-Expression
        scoop install chezmoi git
      `);
  }

  console.log("Initializing chezmoi");

  const chezmoi = path.join(scoopShimDir, "chezmoi.exe");
  await $`pwsh -noprofile -noninteractive -`
    .stdinText(`
      . "${chezmoi}" init --verbose --apply ${account}
    `);
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
