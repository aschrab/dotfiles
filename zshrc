#!/bin/zsh

autoload -U compinit zrecompile

zsh_cache=${HOME}/.zsh_cache
mkdir -p $zsh_cache

if [ $UID -eq 0 ]; then
  compinit
else
  compinit -d $zsh_cache/zcomp-$HOST

  for f in ~/.zshrc $zsh_cache/zcomp-$HOST; do
    zrecompile -p $f && rm -f $f.zwc.old
  done
fi

zshrc_dir=~/.zsh.d
[ -d $zshrc_dir ] || zshrc_dir=$( dirname $(readlink ~/.zshrc) )/zsh.d

setopt extended_glob
for zshrc_snipplet in $zshrc_dir/R[0-9][0-9]*.zsh ; do
  source $zshrc_snipplet
done
