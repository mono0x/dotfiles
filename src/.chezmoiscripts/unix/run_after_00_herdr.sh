#!/bin/sh
set -eu

chronic herdr plugin install devashish2203/herdr-worktrunk --yes

chronic herdr integration install claude
chronic herdr integration install codex
