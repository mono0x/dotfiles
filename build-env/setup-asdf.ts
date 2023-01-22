#!/usr/bin/env -S deno run --allow-env --allow-read --allow-write --allow-run --allow-net
import $ from "https://deno.land/x/dax@0.24.1/mod.ts"

$.setPrintCommand(true)

const installed = await (async () => {
  const result = await $`asdf plugin list`.stdout("piped").noThrow()
  if (result.code == 0) {
    return result.stdout.split("\n")
  } else {
    // No plugins installed
    return []
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
