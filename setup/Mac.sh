#!/bin/bash

# Show Cmd+tab app switcher on all displays, not just one with Dock
defaults write com.apple.dock appswitcher-all-displays -bool true
killall Dock

# Link VS Code settings into odd place it uses
realname=$(perl -MCwd -e 'print Cwd::abs_path($ARGV[0])' "$0")
dotfile_dir=$(dirname "$realname")

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

vscode="$HOME/Library/Application Support/Code"
mkdir -p "$vscode"
[ -e "$vscode/settings.json" ] ||
	ln -is "$dotfile_dir/config/Code/User" "$vscode"

cat <<EOF
# Add following to top of /etc/pam.d/sudo
auth       optional       /usr/local/lib/pam/pam_reattach.so
auth       sufficient     pam_tid.so
EOF
