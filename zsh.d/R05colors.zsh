autoload -U colors
colors

fColor=$reset_color
pColor=$fg[green]
case "$USERNAME" in
  aarons|ats|aschrab)
    pColor=$fg[cyan]
    ;;
  aaron)
    pColor=$fg[magenta]
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
