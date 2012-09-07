export BAUD=0

if [[ "${DISPLAY#${HOST}:}" != "$DISPLAY" ]]
then
  DISPLAY="localhost:${DISPLAY#${HOST}:}"
fi

# Set $TERMINFO to dir in original user's home
[[ -z $TERMINFO ]] && export TERMINFO=~${SUDO_USER}/.terminfo

if [[ $LANG == *UTF* ]]; then
  # Have perl assume the following are in UTF8
  # A: @ARGV
  # S: STDIN, STDOUT, STDERR
  # D: any file opened, unless otherwise specified
  export PERL_UNICODE=ASD
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

# Enable colors in FreeBSD's ls
export CLICOLOR=1

export EMAIL="aaron@schrab.com"
export DEBEMAIL="$EMAIL"

export PSQL_EDITOR="vim +'set ft=sql'"

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

export LESS=""
LESS="$LESS --quit-at-eof"
LESS="$LESS --quit-if-one-screen"
LESS="$LESS --search-skip-screen"
LESS="$LESS --LONG-PROMPT"
#LESS="$LESS --chop-long-lines"
LESS="$LESS --jump-target=3"
LESS="$LESS --ignore-case"
LESS="$LESS --no-init"

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
