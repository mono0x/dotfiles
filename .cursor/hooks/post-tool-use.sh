#!/bin/bash
jq -r '.file_path' | xargs -I{} hk run post-tool-use {} >&2 || exit 2
