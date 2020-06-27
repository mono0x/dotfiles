#!/bin/sh
asdf plugin-add golang
asdf plugin-add kubectl
asdf plugin-add nodejs
asdf plugin-add ruby
asdf plugin-add rust

"$ASDF_DIR/plugins/nodejs/bin/import-release-team-keyring"
