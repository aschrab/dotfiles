# Have ^Z on an empty line run `bg`
# So that can put a program into background with ^Z^Z
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    bg
    zle redisplay
  else
    zle push-input
  fi
}

zle -N fancy-ctrl-z
bindmodes emacs,,viins,vicmd fancy-ctrl-z '^Z'
