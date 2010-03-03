# vim: ft=zsh

if [[ "$TERM" == "linux" ]]
then
  case "$OSTYPE:$HOST" in
    linux*:*)
      ;;
    *bsd*:*)
      ;;
    *)
      TERM=vt100
      ;;
  esac
elif [[ "$TERM" == "xterm-debian" && ! -f /etc/debian_version ]]
then
  TERM=xterm
fi

if [[ "$TERM" == "vt100" && "$OSTYPE" = darwin* ]]
then
  TERM=xterm
fi

export TERM
