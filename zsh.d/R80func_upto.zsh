function upto () {
  local cur=`builtin pwd -L`
  local pattern="$1"

  local switch="${cur%/$pattern/*}/$pattern"

  cd "$switch"
}

function __upto () {
  local cur=`builtin pwd -L`

  reply=()
  while [[ -n $cur ]]; do
    cur="${cur%/*}"
    local base="${cur##*/}"
    reply=($reply $base)
  done
}

compctl -x \
    'p[1]' -K __upto -- \
  upto
