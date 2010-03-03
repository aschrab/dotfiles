# vim: ft=zsh

mcd () {
  mkdir "$@"
  cd "$argv[-1]"
}
