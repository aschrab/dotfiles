#!/bin/zsh

zshrc_dir=~/.zsh.d
[ -d $zshrc_dir ] || zshrc_dir=$( dirname $(readlink ~/.zshrc) )/zsh.d

case "$zshrc_dir" in
  /*)
    ;;
  *)
    zshrc_dir="$HOME/$zshrc_dir"
    ;;
esac

setopt extended_glob
for zshrc_snipplet in $zshrc_dir/R[0-9][0-9]*.zsh ; do
  source $zshrc_snipplet
done
