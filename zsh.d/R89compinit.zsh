autoload -U compinit zrecompile

zsh_cache=${HOME}/.zsh_cache
mkdir -p $zsh_cache

compinit -u -d $zsh_cache/zcomp-$HOST

for f in ~/.zshrc $zsh_cache/zcomp-$HOST; do
	zrecompile -p $f && rm -f $f.zwc.old
done
