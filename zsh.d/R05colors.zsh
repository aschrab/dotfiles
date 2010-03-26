pColor=green
case "$USERNAME" in
  aarons|ats|aschrab)
    pColor=cyan
    ;;
  aaron)
    pColor=magenta
    ;;
  michael|backup|lsm|bofh)
    pColor=yellow
    ;;
  root|administrator)
    pColor=red
    ;;
  *)
    pColor=green
    ;;
esac

export pColor
