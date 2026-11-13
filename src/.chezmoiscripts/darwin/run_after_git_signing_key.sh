#!/bin/sh
set -eu

key="$HOME/.ssh/id_ecdsa_sk_rk_git-sign"
if [ -s "$key" ] && [ -s "$key.pub" ]; then
  exit 0
fi

umask 077
mkdir -p "$HOME/.ssh"

identities=$(sc_auth list-ctk-identities -t ssh -e b64)
case "$identities" in
*"Key Type"*"Label"*) ;;
*)
  printf '%s\n' "Could not list Secure Enclave identities: $identities" >&2
  exit 1
  ;;
esac
if ! printf '%s\n' "$identities" | awk '$4 == "git-sign" { found = 1 } END { exit !found }'; then
  sc_auth create-ctk-identity -l git-sign -k p-256-ne -t none
  identities=$(sc_auth list-ctk-identities -t ssh -e b64)
fi

fingerprint=$(printf '%s\n' "$identities" | awk '$4 == "git-sign" { print $2 }')
test -n "$fingerprint"

# Download into a temporary directory because -K exports all resident keys.
directory=$(mktemp -d)
trap 'rm -rf -- "$directory"' EXIT
cd "$directory"
expect <<'EXPECT'
set timeout 60
spawn ssh-keygen -w /usr/lib/ssh-keychain.dylib -K -N ""
expect {
    -re {Enter PIN[^:]*: *} {
        send -- "\r"
        exp_continue
    }
    timeout {
        puts stderr "Timed out downloading the signing key."
        exit 1
    }
    eof {
        set result [wait]
        if {[lindex $result 2] != 0 || [llength $result] != 4} {
            exit 1
        }
        exit [lindex $result 3]
    }
}
EXPECT

# macOS 15 may omit the identity label from the downloaded filenames.
downloaded=id_ecdsa_sk_rk_git-sign
if [ ! -s "$downloaded" ]; then
  downloaded=id_ecdsa_sk_rk
fi
test -s "$downloaded"
test -s "$downloaded.pub"
downloaded_fingerprint=$(ssh-keygen -lf "$downloaded.pub" | awk '{ print $2 }')
if [ "$(printf '%s' "${fingerprint#SHA256:}" | tr -d '=')" != "$(printf '%s' "${downloaded_fingerprint#SHA256:}" | tr -d '=')" ]; then
  printf '%s\n' 'Downloaded key does not match the git-sign identity.' >&2
  exit 1
fi
mv "$downloaded" "$key"
mv "$downloaded.pub" "$key.pub"

printf '\n%s\n' \
  "Git signing key files are ready: $key" \
  'Add the public key to GitHub as a signing key:' \
  "  pbcopy < $key.pub" \
  '  https://github.com/settings/ssh/new'
