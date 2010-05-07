function upto () {
  local cur=`builtin pwd -L`
  local pattern="$1"

  local switch="${cur%/$pattern/*}/$pattern"

  cd "$switch"
}

function __upto () {
  local cur=`builtin pwd -L`
  read -cA args

  local pattern="$args[2]"

  reply=()
  while [[ -n $cur ]]; do
    cur="${cur%/*}"
    local base="${cur##*/}"
    if [[ $base == (#l)"$pattern"* ]]; then
      reply=($reply $cur)
    fi
  done

  #echo $reply
}

compctl -x \
    'p[1]' -U -K __upto -- \
  upto
