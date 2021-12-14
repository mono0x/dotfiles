#!/bin/sh
set -xeu

cd "$(cd "$(dirname "$0")/.."; pwd)"

./build-env/devcontainer.sh
