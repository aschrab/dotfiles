_rationalize_dot() {
if [[ $LBUFFER = *.. ]]; then
    LBUFFER+=/..
else
    LBUFFER+=.
fi
}
zle -N _rationalize_dot
bindkey . _rationalize_dot

