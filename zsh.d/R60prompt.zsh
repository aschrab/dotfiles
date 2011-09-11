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
  local xterm screen
  case "$TERM" in
    xterm|xtermc|xterm-debian|xterm-color|rxvt-unicode|rxvt|gnome|Eterm)
      xterm=y
      ;;
    screen*)
      screen=y
      ;;
  esac

  if [[ -n $TMUX ]]; then
    xterm=y
    screen=n
  fi

  if [[ $xterm == y || $screen == y ]]; then
    print -nP "\E]1;${1:-%(#.#.$)$host$DEBCHROOT}\C-g"
  fi

  if [[ $xterm == y ]]; then
    print -nP "\E]2;${1:-%(#.#.$)$host$DEBCHROOT($tty):%~}\C-g"
  fi

  if [[ $screen == y ]]; then
    print -nP "\E]2;\En ${1:-%(#.#.$)$host$DEBCHROOT($tty)!%~}\C-g\Ek${1:-$host$DEBCHROOT%(#.#.$)%.}\E\\"
  fi
}
precmd_functions+='zset_title'

RPS1=''
PS1='
%S%{$pColor%} %1v%2m$DEBCHROOT  %~ $(zgit_current_branch)%E%s%{$fColor%}
%{$pColor%}%!%(#.#.$)%{$fColor%} '

case "$TERM" in
  xterm|xtermc|xterm-debian|xterm-color|rxvt-unicode|rxvt|gnome|Eterm)
    if [[ $TERM == xterm && $OSTYPE == freebsd* ]]
    then
      TERM=xterm-color
    fi
    stty erase '^?'
    print -P "${fg[green]}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"
    ;;
  screen*)
    print -P "${fg[yellow]}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"
    case "$OSTYPE" in
      solaris*)
        # Solaris' usual termcap entry for screen sucks, so don't use it.
        TERM=xterm
        ;;
    esac
    alias telnet='TERMCAP= telnet'

    preexec () {
      print -n "\Ek$host$DEBCHROOT:$1\E\\"
    }

    ;;

  linux)
    fColor=$reset_color
    stty erase '^?'
    print -P "${fg[magenta]}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"

    ;;
  *)
    stty erase '^H' kill '^U'
    print -P "%U%Szsh $ZSH_VERSION, .zshrc $rcvers%s%u"
    PS1='%U%1v%!)%(#..%u)$host$DEBCHROOT%(#.#.$)%(#.%u.) '
    RPS1='%U%~%u'
    ;;
esac
