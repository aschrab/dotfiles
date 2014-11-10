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
      # Really only want to do the following for tmux,
      # but there isn't a reliable way to distinguish remotely
      tmux=y
      title=2
      ;;
  esac

  local title
  title=0

  if [[ $xterm == y || $tmux == y ]]; then
    print -nP "\E]${title};${1:-%(#.#.$)$host$DEBCHROOT($tty):%~}\C-g"
  fi

  if [[ $screen == y ]]; then
    print -nP "\E]1;${1:-%(#.#.$)$host$DEBCHROOT}\C-g"
    print -nP "\Ek${1:-$host$DEBCHROOT:%~}\E\\"
  fi
}
precmd_functions+='zset_title'

rev="$(tput rev)"
rum="$(tput rum)"
RPS1=''
PS1='
%{$pColor$rev%} %D{%d%b%H:%M:%S}  %1v%n@%2m$DEBCHROOT  %~ ${vcs_info_msg_0_}%E%{$rum$fColor%}
%{$pColor%}%!%(#.#.$)%{$fColor%} '

PS2='%{$pColor%}%_>%{$fColor%} '

# Update prompt before running a command so that it will display time when the
# command was started rather than when the previous command ended
zle-update-prompt() {
  zle reset-prompt
  zle .$WIDGET
}
zle -N accept-line zle-update-prompt

case "$TERM" in
  screen*)
    zset_command_title () {
      print -n "\Ek$host$DEBCHROOT:$1\E\\"
    }
    preexec_functions+='zset_command_title'
    ;;
esac
