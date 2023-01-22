#!/usr/bin/env -S deno run --allow-env --allow-read --allow-run
import $ from "https://deno.land/x/dax@0.24.1/mod.ts"

const installed = await (async () => {
  try {
    return (await $`asdf plugin list`.stdout("piped")).stdout.split("\n")
  } catch (e) {
    if (e.exitCode === 1) {
      // No plugins installed
      return []
    } else {
      throw e
    }
  }
})()

const plugins = [
  "direnv",
  "golang",
  "kubectl",
  "nodejs",
  "ruby",
  "rust",
]

for (const plugin of plugins.filter(plugin => !installed.includes(plugin))) {
  await $`asdf plugin add ${plugin}`
}
