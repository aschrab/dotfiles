emulate zsh -c 'autoload -U compinit zrecompile'

zsh_cache=${HOME}/.zsh_cache
mkdir -p $zsh_cache

compinit -u -d $zsh_cache/zcomp-$HOST-$ZSH_VERSION
autoload -U bashcompinit && bashcompinit

# Attempt to load completion for kitty
(kitty + complete setup zsh 2>/dev/null) | source /dev/stdin

for f in ${ZDOTDIR:-$HOME}/.zshrc $zsh_cache/zcomp-$HOST-$ZSH_VERSION; do
	zrecompile -p $f && rm -f $f.zwc.old
done
