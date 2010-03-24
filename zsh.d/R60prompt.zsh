precmd () {
  # Make sure the prompt begins on a new line
  print -nP "%F{red}\$%f${(pl:COLUMNS:: ::\r:)}%}"

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

tty=${TTY##/dev/}
export TTY

zset_title() {
  case "$TERM" in
    xterm|xtermc|xterm-debian|xterm-color|rxvt-unicode|rxvt|gnome|Eterm)
      print -nP "\E]1;%(#.#.$)$host$DEBCHROOT\C-g"
      print -nP "\E]2;%(#.#.$)$host$DEBCHROOT($tty):%~\C-g"
      ;;
    screen*)
      print -nP "\E]1;%(#.#.$)$host$DEBCHROOT\C-g"
      print -nP "\E]2;\En %(#.#.$)$host$DEBCHROOT($tty)!%~\C-g\Ek$host$DEBCHROOT%(#.#.$)%.\E\\"
      ;;
  esac
}
precmd_functions+='zset_title'

RPS1=''
PS1='
%U%{$pColor%}%1v%2m$DEBCHROOT  %~ $(zgit_current_branch)%E%u
%!%(#.#.$)%{$fColor%} '

case "$TERM" in
  xterm|xtermc|xterm-debian|xterm-color|rxvt-unicode|rxvt|gnome|Eterm)
    if [[ $TERM == xterm && $OSTYPE == freebsd* ]]
    then
      TERM=xterm-color
    fi
    stty erase '^?'
    print -P "%K{green}zsh $ZSH_VERSION, .zshrc $rcvers%k"
    ;;
  screen*)
    print -P "%K{yellow}zsh $ZSH_VERSION, .zshrc $rcvers%k"
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
    stty erase '^?'
    print -P "%K{magenta}zsh $ZSH_VERSION, .zshrc $rcvers%k"

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
