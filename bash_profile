# vim: ft=sh

[[ -s ~/.bashrc ]] && source ~/.bashrc
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

if [[ -n "$PS1" ]]; then
  # If in an interactive shell, try running zsh.
  # If that exits normally, exit this shell as well.
  ZSH_EXE=$(which zsh)
  if [[ -x $ZSH_EXE ]]; then
    SHLVL='' SHELL=$ZSH_EXE $ZSH_EXE -l && exit
  fi
fi
