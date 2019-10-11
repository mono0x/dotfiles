#!/bin/sh
asdf plugin-add golang
asdf plugin-add kubectl
asdf plugin-add nodejs
asdf plugin-add ruby

echo 'bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring'
