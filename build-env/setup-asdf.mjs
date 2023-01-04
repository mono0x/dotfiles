#!/usr/bin/env zx
/// <reference types="zx/build/globals" />

const installed = await (async () => {
  try {
    return (await $`asdf plugin list`).stdout.split("\n")
  } catch (e) {
    if (e.exitCode === 1) {
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

plugins
  .filter(plugin => !installed.includes(plugin))
  .forEach(async plugin => {
    await $`asdf plugin add ${plugin}`
  })
