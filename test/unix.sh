#!/bin/sh
set -e

cd "$(cd "$(dirname "$0")/.."; pwd)"

./build-env/common.sh
# Run script twice to test idempotency
./build-env/common.sh
