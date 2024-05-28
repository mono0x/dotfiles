import $ from "@david/dax";
import * as fs from "@std/fs";
import * as path from "@std/path";

$.setPrintCommand(true);

if (
  !(Deno.build.os === "linux" || Deno.build.os === "darwin" ||
    Deno.build.os === "windows")
) {
  console.error(`Unsupported OS: ${Deno.build.os}`);
  Deno.exit(1);
}

// const ci = Deno.env.get("GITHUB_ACTIONS") === "true";
const remoteContainers = Deno.env.get("REMOTE_CONTAINERS") === "true";
const wsl = !!Deno.env.get("WSL_DISTRO_NAME");

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
  await $`sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --verbose mono0x`;
}

async function setupUnix(os: "linux" | "darwin") {
  if (os === "linux") {
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

  const homeDir = Deno.env.get("HOME");
  if (!homeDir) {
    console.error("HOME environment variable not set");
    Deno.exit(1);
  }

  const chezomiBinDir = path.join(homeDir, ".local", "bin");
  if (!await fs.exists(path.join(chezomiBinDir, "chezmoi"))) {
    await $`sh`
      .stdinText(`sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ${chezomiBinDir}`);
  }

  if (!await fs.exists(path.join(homebrewDir, "bin", "brew"))) {
    await $`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`;
  }

  await $`/bin/bash --noprofile --norc`
    .stdinText(`
      export PATH=$PATH:${scoopShimDir}
      eval $("${homebrewDir}/bin/brew" shellenv)
      "${chezomiBinDir}/chezmoi" init --verbose --apply mono0x
    `)
    .clearEnv()
    .env({
      HOME: homeDir,
    });
}

async function setupWindows() {
  // TODO
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
