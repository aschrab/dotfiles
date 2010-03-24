# Have `pwd` show both the real path and what the shell thinks it is
function pwd () {
  local real=`builtin pwd -r`
  if [[ ! -t 1 ]]; then
    # Only output real path when used in backticks.
    echo $real
  elif [[ $real == $PWD ]]; then
    echo $PWD
  else
    echo "$PWD ($real)"
  fi
}
