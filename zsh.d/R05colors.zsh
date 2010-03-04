if [[ -z "$normal" ]]
then
  export   black="%{$(echo -n '\e[0;30m')%}"
  export     red="%{$(echo -n '\e[0;31m')%}"
  export   green="%{$(echo -n '\e[0;32m')%}"
  export  yellow="%{$(echo -n '\e[0;33m')%}"
  export    blue="%{$(echo -n '\e[0;34m')%}"
  export magenta="%{$(echo -n '\e[0;35m')%}"
  export    cyan="%{$(echo -n '\e[0;36m')%}"
  export   white="%{$(echo -n '\e[0;37m')%}"
  export  normal="%{$(echo -n '\e[0;22m')%}"
fi

fColor=$normal
pColor=$green
case "$USERNAME" in
  aarons|ats|aschrab)
    pColor=$cyan
    ;;
  aaron)
    pColor=$magenta
    ;;
  michael|backup|lsm|bofh)
    pColor=$yellow
    ;;
  root|administrator)
    pColor=$red
    ;;
  *)
    pColor=$green
    ;;
esac

export pColor
