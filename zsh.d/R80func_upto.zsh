function upto () {
  local cur=`builtin pwd -L`
  local pattern="$1"

  local switch="${cur%/$pattern/*}/$pattern/$2"

  cd "$switch"
}
