if [[ -n $PZSH ]]; then
  if [[ -n $PPWD && -d $PPWD ]]; then
    # cd to directory parent shell was in (see su function)
    cd $PPWD
    unset PPWD
  fi
  if [ -r $HOME/.Zsh-hist.$host.$PZSH ]; then
    fc -R $HOME/.Zsh-hist.$host.$PZSH
    rm -f $HOME/.Zsh-hist.$host.$PZSH 2> /dev/null
  fi
fi

sudo () {
  if [ "$*" = "" -o "$*" = "-s" ]; then
    tmpfile=~/.Zsh-hist.$host.$$
    [ -w ~ ] && fc -ln -10 -1 >! $tmpfile 2> /dev/null
    PZSH=$$ command sudo -s
    rm -f $tmpfile
    unset tmpfile
  else
    command sudo "$@"
  fi
}

MYSU=$(whence mysu)
su () {
  if [ $# -eq 0 ] ; then
        tmpfile=~/.Zsh-hist.$host.$$
        [ -w ~ ] && fc -ln -10 -1 >! $tmpfile 2> /dev/null
        export PPWD=$PWD  # Save current directory,
        cd /              # cd to / so su isn't running in a mounted filesystem
        if [[ -n "$MYSU" ]] ; then
          PZSH=$$ $MYSU
        elif [[ $OSTYPE == solaris* ]] ; then
          PZSH=$$ command su root -c $SHELL
        else
          PZSH=$$ command su -m
        fi
        cd $PPWD   # back to old directory
        unset PPWD
        rm -f $tmpfile
        unset tmpfile
  else
        command su $*
  fi
}
