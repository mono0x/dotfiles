#!/usr/bin/env zx
/// <reference types="zx/build/globals" />

const installed = (await $`asdf plugin list`).stdout.split("\n")

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
