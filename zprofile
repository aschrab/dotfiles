if [[ "$TERM" == "unknown" ]]
then
  echo -n "Enter terminal type: "
  read t
  if [[ "$t" == "x" ]]
  then
    export TERM=xterm
  else
    export TERM="$t"
  fi
fi
