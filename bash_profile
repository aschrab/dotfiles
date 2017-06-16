# vim: ft=sh

[[ -s ~/.bashrc ]] && source ~/.bashrc
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

if [[ "$SHLVL" = 1 ]] && [[ -n "$PS1" ]]; then
  # If in an interactive shell, try running zsh.
  ZSH_EXE=$(which zsh 2>/dev/null)
  if [[ -x $ZSH_EXE ]] && $ZSH_EXE -c :; then
    SHLVL='' SHELL=$ZSH_EXE exec $ZSH_EXE -l
  fi
fi
