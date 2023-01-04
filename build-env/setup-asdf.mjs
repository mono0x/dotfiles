#!/usr/bin/env zx
/// <reference types="zx/build/globals" />

[
  "direnv",
  "golang",
  "kubectl",
  "nodejs",
  "ruby",
  "rust",
].forEach(async plugin => {
  await $`asdf plugin-add ${plugin}`
})
