autoload -U colors
colors

fColor=$reset_color
prompt_color=green
case "$USERNAME" in
  aarons|ats|aschrab|aaron)
    prompt_color=cyan
    ;;
  michael|backup|lsm|bofh)
    prompt_color=yellow
    ;;
  root|administrator)
    prompt_color=red
    ;;
  *)
    prompt_color=green
    ;;
esac
pColor=$fg[$prompt_color]
