# vim: ft=zsh

export BAUD=0

if [[ "${DISPLAY#${HOST}:}" != "$DISPLAY" ]]
then
  DISPLAY="localhost:${DISPLAY#${HOST}:}"
fi

unset MAIL  # set it later in host specific portion
unset MAILCHECK

export CVS_RSH=ssh
export RSYNC_RSH=ssh
export MPAGE="-2m50t"
export COLORFGBG='default;default'
export WORDCHARS='*?_-.[]~/&|;!#$%^(){}<>,'
export HOST_DEFAULTS='-R'

export NNTPSERVER="news.execpc.com"
export EMAIL="aaron@schrab.com"
export DEBEMAIL="$EMAIL"

if [[ -d "/usr/local/lib/site_perl" ]]; then
  export PERL5LIB="/usr/local/lib/site_perl"
fi

if whence vim >& /dev/null
then
  [[ -d $HOME/share/vim ]] && export VIM=$HOME/share/vim
  EDITOR==vim
  alias vi=vim
else
  EDITOR==vi
fi
VISUAL="$EDITOR"
export EDITOR VISUAL

FOO=$(whence lessfile)
FOO=${FOO:=$(whence lesspipe)}
if [ -n "$FOO" ]; then
  eval $($FOO)
else
  PAGER=$(whence zless)
fi
unset FOO
PAGER=${PAGER:=$(whence less)}
if [ -n "$PAGER" ]; then
  PAGER="$PAGER"
else
  PAGER="$PAGER"
  alias less=$PAGER
fi

#export LESS="-aCMj3"
# Don't include -X in $LESS, remove smcups/rmcups settings from terminfo entry
export LESS="-FaMeSj3"
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
