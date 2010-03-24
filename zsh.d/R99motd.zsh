#  Run a few informative commands
if [[ ! -f .hushlogin && -n $PZSH ]]; then
  case "$OSTYPE" in
  linux*|*bsd*)
    :
    ;;
  *)
    if [ -s /etc/motd ]; then
      cat /etc/motd
    fi
    ;;
  esac
fi
