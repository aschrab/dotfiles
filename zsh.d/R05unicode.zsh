# vim: ft=zsh fdm=marker

[[ $LANG == *UTF* ]] && return

unset LC_CTYPE

# Check if we're on a Unicode terminal
if is-at-least 4.0; then
  # Based on perl script by Jan-Pieter Cornet <johnpc@xs4all.nl>
  # http://lists.debian.org/debian-mentors/2003/debian-mentors-200312/msg00144.html
  # Converted to zsh with clues from promptnl script that comes with zsh

  # Make sure there's no typeahead, or it'll confuse things.  Remove
  # this block entirely to use this function in 3.0.x at your own risk.
  # {{{
  while read -t -k 1
  do
    RECV=$RECV$REPLY
  done
  if [[ -n $RECV ]]
  then
    print -z -r -- $RECV
    RECV=''
    REPLY=X
  fi #}}}

  # Send a sequence that's valid UTF8 and ISO8859-1
  # then ask the terminal where the cursor is
  stty -echo
  print -b -n '\r\xC2\xA4\x1B[6n'

  # Wait for reply {{{
  integer WAIT=5
  integer N=$SECONDS
  while [[ $REPLY != R ]] && ((SECONDS - N <= WAIT))
  do
      if read -t -k 1
      then
	  ((N=SECONDS))
	  RECV=$RECV$REPLY
      fi
  done #}}}

  print -b -n '\r' # Clear the test sequence

  # Parse the column number out of the terminal response {{{
  case ${${RECV#$(print -b -n '\x1B')\[[0-9]##;}%%R} in
    2)
      echo "UTF terminal detected"
      LANG=en_US.UTF-8
      ;;
    3)
      echo "Non-UTF terminal detected"
      LANG=en_US
      ;;
    *)
      echo "Couldn\'t determine terminal encoding"
      ;;
  esac #}}}
fi
