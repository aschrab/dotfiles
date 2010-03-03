# vim: ft=zsh

precmd () {
  # Make sure the prompt begins on a new line
  print -nP "%{${red}\$${normal}${(pl:COLUMNS:: ::\r:)}%}"

  if jobs % >& /dev/null; then
    psvar[1]="*"
  else
    psvar[1]=""
  fi
}

screen-title () {
}
xtitle () {
  print -n "\E]2;$*"
}

if [[ -r /etc/debian_chroot ]]; then
  DEBCHROOT="(`cat /etc/debian_chroot`)"
elif [[ -r /etc/chroot_id ]]; then
  DEBCHROOT="(`cat /etc/chroot_id`)"
else
  DEBCHROOT=''
fi

esc=$(print -n "\E")
beep=$(print -n "\C-g")
tty=${TTY##/dev/}
export TTY

case "$TERM" in
  xterm|xtermc|xterm-debian|xterm-color|rxvt-unicode|rxvt|gnome|Eterm)
    if [[ $TERM == xterm && $OSTYPE == freebsd* ]]
    then
      TERM=xterm-color
    fi
    stty erase '^?'
    print -P "${green}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"
    PS1='%{${esc}]1;%(#.#.$)$host$DEBCHROOT${beep}${esc}]2;%(#.#.$)$host$DEBCHROOT($tty):%~${beep}%}'
    PS1="$PS1"'%{$pColor%}%1v%!)$host$DEBCHROOT%(#.#.$)%{$fColor%} '
    RPS1='%{$pColor%} %~%{$fColor%}'
    ;;
  screen*)
    print -P "${yellow}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"
    PS1='%{]1;%(#.#.$)$host$DEBCHROOT]2;n %(#.#.$)$host$DEBCHROOT($tty)!%~k$host$DEBCHROOT%(#.#.$)%.\%}'
    PS1="$PS1"'%{$pColor%}%1v%!)$host$DEBCHROOT%(#.#.$)%{$fColor%} '
    RPS1='%{$pColor%} %~%{$fColor%}'
    case "$OSTYPE" in
      solaris*)
        # Solaris' usual termcap entry for screen sucks, so don't use it.
        TERM=xterm
        ;;
    esac
    alias telnet='TERMCAP= telnet'

    screen-title () {
      print -n "\E\"$*\E\134"
    }

    preexec () {
      print -n "\Ek$host$DEBCHROOT:$1\E\\"
    }

    ;;

  linux)
    fColor=$normal
    stty erase '^?'
    print -P "${magenta}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"
    PS1='%{$pColor%}%1v%!)$host$DEBCHROOT%(#.#.$)%{$fColor%} '
    RPS1='%{$pColor%} %~%{$fColor%}'

    xtitle () {
    }
    ;;
  *)
    stty erase '^H' kill '^U'
    print -P "%U%Szsh $ZSH_VERSION, .zshrc $rcvers%s%u"
    PS1='%U%1v%!)%(#..%u)$host$DEBCHROOT%(#.#.$)%(#.%u.) '
    RPS1='%U%~%u'
    xtitle () {
    }
    ;;
esac

export RPS1
