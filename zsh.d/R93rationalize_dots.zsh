_rationalize_dot() {
if [[ $LBUFFER != g(it|)\ * ]] && [[ $LBUFFER = *../# ]]; then
    [[ $LBUFFER != */ ]] && LBUFFER+=/
    LBUFFER+=../
else
    LBUFFER+=.
fi
}
zle -N _rationalize_dot
bindmodes emacs,viins _rationalize_dot .
