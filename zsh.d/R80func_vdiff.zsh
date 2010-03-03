# vim: ft=zsh

vdiff () {
  local cvs='' opt=''
  if [[ "$1" == '!c' || "$1" == '!cvs' ]]
  then
    shift
  else
    if [[ -d .svn ]]; then
      cvs="svn"
    elif [[ -d CVS ]]; then
      cvs="cvs"
    fi
  fi

  if [[ "$cvs" == '' ]]
  then
    opt='-u'
  fi
  $cvs diff $opt "$@" > $TMPDIR/$host.$$.diff
  local dstat=$?

  if [ -s $TMPDIR/$host.$$.diff ]; then
    case "$cvs:$dstat" in
      :0|cvs:0)
        echo "No differences"
        ;;
      *:1|svn:0)
        case "$EDITOR" in
          *vim*)
            $EDITOR +'set ft=diff fdm=diff' -R $TMPDIR/$host.$$.diff
            ;;
          *)
            $EDITOR -R $TMPDIR/$host.$$.diff
            ;;
          esac
        ;;
      *)
        ;;
    esac
  else
    echo "No differences"
  fi
  rm -f $TMPDIR/$host.$$.diff
}
