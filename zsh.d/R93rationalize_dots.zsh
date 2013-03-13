_rationalize_dot() {
if [[ $LBUFFER != g(it|)\ * ]] && [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
else
    LBUFFER+=.
fi
}
zle -N _rationalize_dot
bindkey -M emacs . _rationalize_dot

