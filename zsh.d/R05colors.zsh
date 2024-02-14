autoload -U colors
colors

fColor=$reset_color
pColor=$fg[green]
case "$USERNAME" in
  aarons|ats|aschrab|aaron)
    pColor=$fg[cyan]
    ;;
  michael|backup|lsm|bofh)
    pColor=$fg[yellow]
    ;;
  root|administrator)
    pColor=$fg[red]
    ;;
  *)
    pColor=$fg[green]
    ;;
esac
