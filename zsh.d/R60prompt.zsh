precmd () {
  # Make sure the prompt begins on a new line
  print -nP "%{${fg[red]}\$${reset_color}${(pl:COLUMNS:: ::\r:)}%}"

  if jobs % >& /dev/null; then
    psvar[1]="*"
  else
    psvar[1]=""
  fi
}

if [[ -r /etc/debian_chroot ]]; then
  DEBCHROOT="(`cat /etc/debian_chroot`)"
elif [[ -r /etc/chroot_id ]]; then
  DEBCHROOT="(`cat /etc/chroot_id`)"
else
  DEBCHROOT=''
fi

tty=${TTY##/dev/}
export TTY

zset_title() {
  local xterm screen tmux
  case "$TERM" in
    xterm*|rxvt*|gnome*|Eterm)
      xterm=y
      ;;
    screen*)
      screen=y
      ;;
  esac

  if [[ $xterm == y || $screen == y ]]; then
    print -nP "\E]1;${1:-%(#.#.$)$host$DEBCHROOT}\C-g"
  fi

  if [[ $xterm == y ]]; then
    print -nP "\E]2;${1:-%(#.#.$)$host$DEBCHROOT($tty):%~}\C-g"
  fi

  if [[ $screen == y ]]; then
    print -nP "\Ek${1:-$host$DEBCHROOT:%~}\E\\"
  fi
}
precmd_functions+='zset_title'

RPS1=''
PS1='
%S%{$pColor%} %D{%H:%M:%S}  %1v%2m$DEBCHROOT  %~ $(zgit_current_branch)%E%s%{$fColor%}
%{$pColor%}%!%(#.#.$)%{$fColor%} '

case "$TERM" in
  screen*)
    zset_command_title () {
      print -n "\Ek$host$DEBCHROOT:$1\E\\"
    }
    preexec_functions+='zset_command_title'
    ;;
esac
