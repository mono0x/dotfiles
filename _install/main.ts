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
  await $`sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply --verbose ${account}`;
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
  const brew = path.join(homebrewDir, "bin", "brew");

  const homeDir = Deno.env.get("HOME");
  if (!homeDir) {
    console.error("HOME environment variable not set");
    Deno.exit(1);
  }

  const chezomiBinDir = path.join(homeDir, ".local", "bin");
  const chezmoi = path.join(chezomiBinDir, "chezmoi");
  if (!await fs.exists(chezmoi)) {
    await $`sh`
      .stdinText(`sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ${chezomiBinDir}`);
  }

  if (!await fs.exists(brew)) {
    await $`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`;
  }

  await $`/bin/bash --noprofile --norc`
    .stdinText(`
      export PATH=$PATH:${scoopShimDir}
      eval $("${brew}" shellenv)
      "${chezmoi}" init --verbose --apply ${account}
    `)
    .clearEnv()
    .env({
      HOME: homeDir,
    });
}

async function setupWindows() {
  // TODO

  const homeDir = Deno.env.get("USERPROFILE");
  if (!homeDir) {
    console.error("USERPROFILE environment variable not set");
    Deno.exit(1);
  }

  const scoop = path.join(homeDir, "scoop", "shims", "scoop.ps1");

  if (!await fs.exists(scoop)) {
    await $`pwsh -noprofile -noninteractive -`
      .stdinText(`
        Invoke-RestMethod get.scoop.sh | Invoke-Expression
        scoop install chezmoi git
      `);
  }

  const chezmoi = (await $`${scoop} which chezmoi`).stdout.trim();
  await $`pwsh -noprofile -noninteractive -`
    .stdinText(`
      "${chezmoi}" init --verbose --apply ${account}
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
