#!/bin/sh
asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

echo 'bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring'
