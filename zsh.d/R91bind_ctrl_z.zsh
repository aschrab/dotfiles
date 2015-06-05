# Have ^Z on an empty line run `fg`
# So that it can be used to toggle between shell and backgroundable-programs
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
    zle redisplay
  else
    zle push-input
  fi
}

zle -N fancy-ctrl-z
bindmodes emacs,,viins,vicmd fancy-ctrl-z '^Z'
