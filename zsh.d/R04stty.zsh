ttyctl -f

stty() {
  local frozen
  frozen=$(ttyctl)
  ttyctl -u
  command stty "$@"
  [[ $frozen == *not* ]] || ttyctl -f
}

stty -ixon
