#!/bin/bash

realname=$(perl -MCwd -e 'print Cwd::abs_path($ARGV[0])' "$0")
dotfile_dir=$(dirname "$(dirname "$realname")")

plist=~/Library/LaunchAgents/user.path.plist
launchctl unload ~/Library/LaunchAgents/user.path.plist 2>/dev/null || true
mkdir -p "$(dirname "$plist")"
perl -pe 's,\$HOME/,'"$HOME/,g" <$dotfile_dir/Library/LaunchAgents/user.path.plist >"$plist"
launchctl load ~/Library/LaunchAgents/user.path.plist

# Show Cmd+tab app switcher on all displays, not just one with Dock
if [ "$(defaults read com.apple.dock appswitcher-all-displays)" != 1 ]; then
  defaults write com.apple.dock appswitcher-all-displays -bool true
  killall Dock
fi

# Link VS Code settings into odd place it uses
vscode="$HOME/Library/Application Support/Code"
mkdir -p "$vscode"
[ -e "$vscode/User/settings.json" ] ||
	ln -is "$dotfile_dir/config/Code/User" "$vscode"

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

sudo_local=/etc/pam.d/sudo_local.template
grep -q pam_reattach $sudo_local || cat <<EOF
# Add following to $sudo_local (to survive updates)
# and copy to same location without .template for immediate effect
auth       optional       /opt/homebrew/lib/pam/pam_reattach.so
auth       sufficient     pam_tid.so
EOF
