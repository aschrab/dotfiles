#!/bin/bash

realname=$(perl -MCwd -e 'print Cwd::abs_path($ARGV[0])' "$0")
dotfile_dir=$(dirname "$realname")

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

vscode="$HOME/Library/Application Support/Code/User"
mkdir -p "$vscode"
[ -e "$vscode/settings.json" ] ||
	ln -s "$dotfile_dir/config/Code/User/settings.json" "$vscode"

cat <<EOF
# Add following to top of /etc/pam.d/sudo
auth       optional       /usr/local/lib/pam/pam_reattach.so
auth       sufficient     pam_tid.so
EOF
