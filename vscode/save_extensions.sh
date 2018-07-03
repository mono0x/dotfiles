#!/bin/sh
code --list-extensions | sort > "$(cd "$(dirname $0)"; pwd)/extensions.txt"
