export BAUD=0

if [[ -n $TMUX ]] && [[ -r ${TMUX%%,*} ]]; then
  preexec_functions+='update_env_from_tmux'
fi

if [[ "${DISPLAY#${HOST}:}" != "$DISPLAY" ]]
then
  DISPLAY="localhost:${DISPLAY#${HOST}:}"
fi

if [[ -n "$DISPLAY" && -z "$XAUTHORITY" && -r ~/.Xauthority ]]; then
  export XAUTHORITY=~/.Xauthority
fi

# Set $TERMINFO to dir in original user's home
[[ -z $TERMINFO ]] && export TERMINFO=~${SUDO_USER}/.terminfo

if [[ $LANG == *UTF* ]]; then
  # Have perl assume the following are in UTF8
  # A: @ARGV
  # S: STDIN, STDOUT, STDERR
  # D: any file opened, unless otherwise specified
  #export PERL_UNICODE=ASD
fi

unset MAIL  # set it later in host specific portion
unset MAILCHECK

export CVS_RSH=ssh
export RSYNC_RSH=ssh
export MPAGE="-2m50t"
export COLORFGBG='default;default'
export HOST_DEFAULTS='-R'
export NOPASTE_SERVICES='Gist'
export MTR_OPTIONS="--order LSRDNABMV"
export DBIC_TRACE_PROFILE=console

# Have GTK programs honor ~/.XCompose file
export GTK_IM_MODULE=xim

# Enable colors in FreeBSD's ls
export CLICOLOR=1

export EMAIL="aaron@schrab.com"
export DEBEMAIL="$EMAIL"

if (( $+commands[nvim] )); then
  EDITOR=nvim
elif [[ -n $DISPLAY ]] && (( $+commands[vimx] )); then
  EDITOR=vimx
elif (( $+commands[vim] )); then
  EDITOR=vim
else
  EDITOR=vi
fi

[[ $EDITOR == vim ]] || alias vim=$EDITOR
[[ $EDITOR == vi ]] || alias vi=vim

[[ $EDITOR == vim* ]] && [[ -d $HOME/share/vim ]] && export VIM=$HOME/share/vim

unset VISUAL
export EDITOR
export PSQL_EDITOR="$EDITOR +'set ft=sql'"

() {
  local pager_setup=$commands[lessfile]
  if [[ -n ${pager_setup:=$commands[lesspipe]} ]]; then
    eval $( $pager_setup )
  elif [[ -x /usr/bin/lesspipe.sh ]]; then
    LESSOPEN='|/usr/bin/lesspipe.sh %s'
  fi
}
[[ -n ${PAGER:=less} ]] && [[ $PAGER != *less* ]] && alias less=$PAGER
export PAGER

export LESS=""
#LESS="$LESS --quit-at-eof"
LESS="$LESS --quit-if-one-screen"
LESS="$LESS --search-skip-screen"
LESS="$LESS --LONG-PROMPT"
#LESS="$LESS --chop-long-lines"
LESS="$LESS --jump-target=3"
LESS="$LESS --ignore-case"
LESS="$LESS --no-init"
LESS="$LESS --RAW-CONTROL-CHARS"

case "$LANG" in
  *[Uu][Tt][Ff]*)
    LESSCHARSET="utf-8"
    ;;
  *)
    LESSCHARSET=latin1
    ;;
esac
export LESSCHARSET

export HOSTALIASES=~/.hostaliases
export PYTHONSTARTUP=~/.pythonrc.py
