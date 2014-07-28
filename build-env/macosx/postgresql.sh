#!/bin/sh
rm -rf /usr/local/var/postgres/*
initdb --locale=C -E UTF8 /usr/local/var/postgres

# To have launchd start postgresql at login:
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
# Then to load postgresql now:
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
