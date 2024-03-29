[ -n "$PS1" ] && PS1='\[\e]2;\$\h(\l):\w\a\]''\n''\[\e[0;45m\]'' \D{%d%b%H:%M:%S} \h \w \[\e[0;22m\]''\n''\[\e[0;45m\]''\!\$''\[\e[0;22m\] '
PROMPT_DIRTRIM=2

# For newer versions of Mac OS that have zsh as default shell
export BASH_SILENCE_DEPRECATION_WARNING=1

if [[ $PS1 && -f /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi

if [[ -n "$PS1" ]] && [[ -d "$HOME/.functions" ]] ; then
  for f in "$HOME/.functions"/* ; do
    # shellcheck disable=1090
    . "$f"
  done
fi

alias l='ls -F'
alias ll='l -l'
alias la='l -a'
alias lla='ll -a'
alias ..='cd ..'

alias g=git

set -o noclobber

shopt -s autocd cdspell dirspell extglob 2> /dev/null
# The following breaks completion
# shopt -s failglob

# menu complete from older bash versions is awful
# and inputrc doesn't allow version checking
if [[ -n "$PS1" ]] && (( BASH_VERSINFO[0] >= 4 )); then
  bind -m vi-insert 'TAB: menu-complete'
  bind -m emacs 'TAB: menu-complete'
fi

# Remember when last command started
trap '[[ -z $LAST_COMMAND_TIME ]] && LAST_COMMAND_TIME=$SECONDS' DEBUG

long_command_notification() {
  echo -ne '\a'
}

# Notify (beep) if a command takes longer than $LONG_COMMAND_TIME
LONG_COMMAND_TIME=5
notify_after_long_command() {
  if [[ -n $LONG_COMMAND_TIME ]] && [[ -n $LAST_COMMAND_TIME ]] && [[ $(( SECONDS - LAST_COMMAND_TIME )) -gt $LONG_COMMAND_TIME ]]
  then
    long_command_notification
  fi
  LAST_COMMAND_TIME=
}
PROMPT_COMMAND=notify_after_long_command
