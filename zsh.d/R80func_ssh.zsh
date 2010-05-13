ssh () {
  local foo
  local bar
  foo="$argv[$#]"

  if [[ "$foo" =~ '^([^@]+@)?[0-9.]+$' ]]
  then
    bar="$foo"
  elif [[ "$foo" = *.* ]]
  then
    stripdom=3
    bar=${(j:.:)${(s:.:)foo}[1,-$stripdom]}
    if [[ -z "$bar" ]]
    then
      bar="$foo"
    fi
  else
    bar="$foo"
  fi
  xtitle "$bar"
  screen-title "$bar"
  command ssh "$@"
}
