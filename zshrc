#!/bin/zsh -f

# reset signal handlers
trap -
bindkey -em
umask 077

export BAUD=0

rcvers='$Revision: 1.99 $'
rcvers=$rcvers[(w)2]

if [[ "$TERM" == "linux" ]]
then
  case "$OSTYPE:$HOST" in
    linux*:*.schrab.com)
      ;;
    linux*:fnord.guru.execpc.com)
      ;;
    linux*:*.qqx.org)
      ;;
    *bsd*:*)
      ;;
    *)
      TERM=vt100
      ;;
  esac
elif [[ "$TERM" == "xterm-debian" && ! -f /etc/debian_version ]]
then
  TERM=xterm
fi

if [[ "$TERM" == "vt100" && "$OSTYPE" = darwin* ]]
then
  TERM=xterm
fi

# Try making directory, don't care if it fails (may be there already)
mkdir "/tmp/$LOGNAME" >& /dev/null
# On some systems $LOGNAME stays the same across su, so check if TMPDIR for
# non-root user was created by root, and fix it if necessary
if [[ $EUID -eq 0 && "$LOGNAME" != root && -n "`echo /tm[p]/$LOGNAME(Nu0)`" ]]
then
  echo "TMPDIR owned by root, fixing" >&2
  chown "$LOGNAME" "/tmp/$LOGNAME"
fi
# Check the ownership, and make sure the permisisons are correct
if [[ `echo /tm[p]/$LOGNAME(Nu:$LOGNAME:)` == /tmp/$LOGNAME(/|) ]] &&
   chmod 0700 "/tmp/$LOGNAME" >& /dev/null
then
  export TMPDIR="/tmp/$LOGNAME"
  export TMP="$TMPDIR"
  export TMPPREFIX="$TMPDIR/zsh"
else
  echo "TMPDIR not secure" >&2
  echo "TMPDIR not secure" >&2
  echo "TMPDIR not secure" >&2
fi

#  Set various shell variables
#export host=`print -P %m`

# Set $host by:
# - Split $HOST on '.'
# - Remove $stripdom - 1 portions from the end
# - Rejoin
if [[ "$HOST" = *.* ]]
then
  stripdom=3
  host=${(j:.:)${(s:.:)HOST}[1,-$stripdom]}
else
  host="$HOST"
fi

[ "$USERNAME" = "aarons" -o "$USERNAME" = "root" ] && HOME=~aarons

if [[ -z "$pColor" ]]
then
  #export   black="%{$(echo -n '\e[0;30m')%}"
  export     red="%{$(echo -n '\e[0;31m')%}"
  export   green="%{$(echo -n '\e[0;32m')%}"
  export  yellow="%{$(echo -n '\e[0;33m')%}"
  export    blue="%{$(echo -n '\e[0;34m')%}"
  export magenta="%{$(echo -n '\e[0;35m')%}"
  export    cyan="%{$(echo -n '\e[0;36m')%}"
  export   white="%{$(echo -n '\e[0;37m')%}"
fi

fColor=$white
pColor=$green
case "$USERNAME" in
  aarons)
    pColor=$cyan
    ;;
  aaron)
    pColor=$magenta
    ;;
  michael|backup|lsm|bofh)
    pColor=$yellow
    ;;
  root)
    pColor=$red
    ;;
  *)
    pColor=$green
    ;;
esac

export pColor

alias stty='noglob stty'

case "$TERM" in
  xterm|xtermc|xterm-debian|xterm-color|rxvt)
    if [[ $TERM == xterm && $OSTYPE == freebsd* ]]
    then
      TERM=xterm-color
    fi
    if [[ $OSTYPE == linux* ]]
    then
      langset="no"
      for l in en_GB en_US.iso885915 en_US.iso88591 en_US
      do
        if [[ $langset == no && -d /usr/lib/locale/$l ]]
        then
          export LC_CTYPE="$l"
          langset="yes"
        fi
      done
      export LC_COLLATE="C"
      unset langset l
    fi
    stty erase '^?'
    print -P "${green}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"
    PS1='%{]1;%(#.#.$)$host]2;%(#.#.$)$host:%~%}'
    PS1="$PS1"'%{$pColor%}%1v%!)$host%(#.#.$)%{$fColor%} '
    RPS1='%{$pColor%} %~%{$fColor%}'
    ;;
  screen)
    print -P "${yellow}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"
    PS1='%{]1;%(#.#.$)$host]2;n %(#.#.$)$host!%~k$host%(#.#.$)%.\%}'
    PS1="$PS1"'%{$pColor%}%1v%!)$host%(#.#.$)%{$fColor%} '
    RPS1='%{$pColor%} %~%{$fColor%}'
    case "$OSTYPE" in
      solaris*)
        # Solaris' usual termcap entry for screen sucks, so don't use it.
        TERM=xterm
        ;;
    esac
    alias telnet='TERMCAP= telnet'
    ;;
  linux)
    stty erase '^?'
    print -P "${magenta}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"
    PS1='%{$pColor%}%1v%!)$host%(#.#.$)%{$fColor%} '
    RPS1='%{$pColor%} %~%{$fColor%}'
    export LANG="en_US.iso-8859-15"
    ;;
  *)
    stty erase '^H' kill '^U'
    print -P "%U%Szsh $ZSH_VERSION, .zshrc $rcvers%s%u"
    PS1='%U%1v%!)%(#..%u)$host%(#.#.$)%(#.%u.) '
    RPS1='%U%~%u'
    ;;
esac

if [[ "${DISPLAY#${HOST}:}" != "$DISPLAY" ]]
then
  DISPLAY="localhost:${DISPLAY#${HOST}:}"
fi

unset MAIL  # set it later in host specific portion
unset MAILCHECK

if [[ -n $PZSH ]]; then
  if [[ -n $PPWD && -d $PPWD ]]; then
    # cd to directory parent shell was in (see su function)
    cd $PPWD
    unset PPWD
  fi
  if grep '^aarons:' /etc/passwd > /dev/null 2>&1; then
    if [ -r ~aarons/.Zsh-hist.$host.$PZSH ]; then
      fc -R ~aarons/.Zsh-hist.$host.$PZSH
      rm -f ~aarons/.Zsh-hist.$host.$PZSH
    fi
  fi
fi

unset HISTFILE
HISTSIZE=250
export PS1 RPS1 HISTSIZE

path=()
manpath=()
ppath=(
  ~/bin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  /usr/X11R6/bin
  /usr/X11/bin
  /usr/share/bin
  /usr/openwin/bin
  /usr/local/pkg/guru
  /usr/local/pkg/dnvs
  /usr/local/adm/voyager
  /usr/local/adm/execpc
  /usr/adm/bin
  /usr/local/pilot/bin
  /usr/ccs/bin
  /usr/ccs/lib
)

for d in $ppath
do
  if [[ -d $d ]]
  then
    path=($path $d)
  fi

  m=${d%/bin}
  if [[ $d == $m ]]
    m="$m/man"
    if [[ -d $m ]]
    then
      manpath=($manpath $m)
    fi
  then
  fi
done
unset ppath d m
export PATH MANPATH

setopt \
  Always_Last_Prompt \
  All_Export \
  Always_to_End \
  Auto_cd \
  Auto_List \
  Auto_Menu \
  Auto_Param_Keys \
  Auto_Pushd \
  Auto_Remove_Slash \
  Auto_Resume \
  Correct \
  Extended_Glob \
  Glob_Complete \
  List_Types \
  Mail_Warning \
  Notify \
  Numeric_Glob_Sort \
  Print_Exit_Value \
  Prompt_Subst \
  rm_Star_Silent
unsetopt \
  Beep \
  Clobber \
  Correct_All \
  HUP \
  Ignore_EOF \
  Prompt_CR

if [[ "$ZSH_VERSION[1]" = "3" ]]; then
  setopt Equals Function_ArgZero Mult_IOs
else
  unsetopt No_Equals
fi

unlimit core

alias pwd=/bin/pwd
alias grep=egrep

export NULLCMD=:
export HISTORY=${ZDOTDIR:=$HOME}/.zsh-history
export CVS_RSH=ssh
export RSYNC_RSH=ssh
export MPAGE="-2m50t"
export COLORFGBG='default;default'
export WORDCHARS='*?_-.[]~/&|;!#$%^(){}<>,'
export HOST_DEFAULTS='-R'

export NNTPSERVER="news.execpc.com"

if [[ -d "/usr/local/lib/site_perl" ]]; then
  export PERL5LIB="/usr/local/lib/site_perl"
fi

EDITOR=$(whence color-vim)
EDITOR=${EDITOR:=$(whence vim)}
VISUAL=${EDITOR:=$(whence vi)}
export EDITOR VISUAL
alias vi=$VISUAL

GSED=$(whence gsed)
if [[ -n "$GSED" ]]; then
  alias sed=gsed
fi
unset GSED

GCC=$(whence gcc)
if [[ -z "$GCC" ]]; then
  alias gcc=cc
fi
unset GCC

if [[ $EDITOR == *vim* && -d $HOME/share/vim ]]
then
  export VIM=$HOME/share/vim
fi

FOO=$(whence lessfile)
FOO=${FOO:=$(whence lesspipe)}
if [ -n FOO ]; then
  eval $($FOO)
else
  PAGER=$(whence zless)
fi
unset FOO
PAGER=${PAGER:=$(whence less)}
if [ -n "$PAGER" ]; then
  PAGER="less"
  export LESS="-aCMj3"
  export LESSCHARSET=latin1
else
  PAGER="more"
  alias less=$PAGER
fi
alias les=less
alias lss=less

# Set aliases
LS=$(whence gnuls)
if [[ -n $LS ]]; then
  LS=gnuls
  alias ls=$LS
fi
if [[ "$TERM" == "emacs" || ( $OSTYPE == *bsd* || $OSTYPE == *darwin* && -z $LS ) ]]; then
  # Using colorls under emacs sucks
  # The standard BSD ls breaks with --color=tty, but doesn't give an error
  :
else
  if ${LS:=ls} --color=tty / >/dev/null 2>&1; then
    alias ls="$LS --color=tty"
    LS_COLORS="di=34:ex=32:ln=35:so=33:bd=0:cd=0"
    LS_COLORS="${LS_COLORS}:*.zip=33:*.rpm=33:*.tar=33:*.tgz=33:*.gz=33"
    LS_COLORS="${LS_COLORS}:*.bz2=33:*.Z=33"
    export LS_COLORS
  fi
fi
unset LS

export HOSTALIASES=~/.hostaliases

alias cls='clear'
alias f=finger
alias sz='sz -e'
alias l='ls -F'
alias la='ls -aF'
if [[ $OSTYPE == *bsd* ]]; then
  alias ll='ls -loF'
  alias lla='ls -Foal'
else
  alias ll='ls -lF'
  alias lla='ls -alF'
fi
alias bc='bc -ql'
alias trt=traceroute
alias screen='screen -a -A'

[ -x /usr/lib/sendmail ] && alias sendmail=/usr/lib/sendmail

# Tell rcsdiff to checkout revisions without putting in version numbers
alias rcsdiff='rcsdiff -kk'

gtar=`whence gtar`
if [ -n "$gtar" ]; then
  alias tar=$gtar
elif [ -x /usr/local/gnu/bin/tar ]; then
  alias tar=/usr/local/gnu/bin/tar
elif [ -x /usr/local/gnu/bin/gtar ]; then
  alias tar=/usr/local/gnu/bin/gtar
elif [ -x /usr/local/bin/tar ]; then
  alias tar=/usr/local/bin/tar
fi
unset gtar

if [[ $OSTYPE == solaris2* ]]; then
  alias ping='ping -s'
fi


# bind keys
bindkey \^p up-history
bindkey \^n down-history
bindkey "\e[A" up-line-or-search
bindkey "\eOA" up-line-or-search
bindkey "\eOD" backward-char
bindkey "\eOC" forward-char
bindkey "\M-;" copy-prev-word
bindkey "\e;" copy-prev-word
# space (with or without meta) is magic-space
bindkey    "\x20" magic-space
bindkey "\M-\x20" magic-space
bindkey "\e\x20" magic-space
# M-Q pushes all pending lines onto the stack, not just current line
bindkey "\M-q" push-input
bindkey "\eq" push-input

#  Run a few informative commands
if [ ! -f .hushlogin ]; then
  case "$OSTYPE" in
  linux*|*bsd*)
    :
    ;;
  *)
    if [ -s /etc/motd ]; then
      cat /etc/motd
    fi
    ;;
  esac
fi

umask 077
export PS1 PATH TERM

if [ -d /usr/share/zsh/functions ]; then
  fpath=( /usr/share/zsh/functions )
else
  fpath=()
fi

# shell functions
if [ -d $HOME/.fbin ]; then
  fpath=($fpath $HOME/.fbin)
  for AF in $HOME/.fbin/*(N); do
        typeset -fu $AF:t
  done
  unset AF
fi

pw () {
  grep $* /etc/passwd
}

precmd () {
  if jobs % >& /dev/null; then
    psvar[1]="*"
  else
    psvar[1]=""
  fi
}

MYSU=$(whence mysu)
su () {
  if [ $# -eq 0 ] ; then
        tmpfile=~aarons/.Zsh-hist.$host.$$
        fc -ln -10 -1 >! $tmpfile 2> /dev/null
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

tz () {
  local t
  t="$1"
  shift
  TZ="$t" "$@"
}

vdiff () {
  local cvs='' opt=''
  if [[ -d CVS ]]
  then
    if [[ "$1" == '!c' || "$1" == '!cvs' ]]
    then
      shift
    else
      cvs="cvs"
    fi
  fi
  if [[ "$cvs" == '' ]]
  then
    opt='-u'
  fi
  $cvs diff $opt "$@" > $TMPDIR/$host.$$.diff
  case "$?" in
    0)
      echo "No differences"
      ;;
    1)
      echo "\n\n\n\n\n\nvim: ft=diff" >> $TMPDIR/$host.$$.diff
      vi -R $TMPDIR/$host.$$.diff
      ;;
    *)
      ;;
  esac
  rm -f $TMPDIR/$host.$$.diff
}

fignore=(.o .bak .swp \~)
compctl -g '*' -x 'S[.]','C[0,*/.*]' -g '*(D)' -- rm
compctl -g '*(-/)' + -g '.*(-/)' + -k '(..)' cd rmdir
compctl -jP '%' kill fg bg disown
compctl -vP '$' echo

if [[ $OSTYPE == linux* && -r /lib/modules/`uname -r`/modules.dep ]]
then
  __modules=($(sed -n -e 's,^[^:]*/,,' -e 's,\.o:.*$,,p' /lib/modules/`uname -r`/modules.dep))
  compctl -k __modules insmod modprobe

  function __lsmod () {
    reply=($(lsmod | awk '{if (NR > 1) print $1}'))
  }
  compctl -K __lsmod rmmod
fi

function __chroot () {
  read -cA args
  
  reply=($(cd "$args[2]";
           find . -perm +0111 -print 2> /dev/null | sed 's:^./:/:' ))
}

compctl -x \
    'p[1]' -g '*(/)' - \
    'p[2]' -K __chroot - \
    'p[2,99]' -l '' -- \
  chroot

compctl -x \
    'p[1]' -g '*(/)' - \
    'p[2]' -u - \
    'p[3]' -K __chroot - \
    'p[3,99]' -l '' -- \
  chrootuid

compctl -k "(fsf fsfm bsf bsfm fsr bsr fss eod seod rewind \
             offline retension weof eof wset erase \
             status seek tell setpartition partseek mkpartition \
             load lock unlock setblk setdensity densities \
             drvbuffer compression stoptions stsetoptions \
             stclearoptions stwrthreshold defblksize defdensity \
             defdrvbuffer defcompression datcompression)" \
        -x 'c[-1,-f],s[-f]' -g '/dev/*(%c)' \
   -- mt

compctl -k '(if of conv ibs obs bs cbs files skip file seek count)' -S '=' \
        -x 's[if=] , s[of=]' -f \
        - 'C[0,conv=*,*] n[-1,,] , s[conv=]' -q -S , \
          -k '(ascii ebcdic ibm block unblock lcase ucase swap noerror sync)' \
        - 'n[-1,=]' -X '<number>' \
  -- dd

compctl -x \
   'p[1,1] C[0,*/*]' -g '/usr/share/zoneinfo/**/*(:s,/usr/share/zoneinfo/,,)' \
   - 'p[1,1]' -g '/usr/share/zoneinfo/*(:t)' \
   - 'p[2,99]' -l '' \
 -- tz

__groups=($(cut -d: -f1 /etc/group))
compctl -f -x 'C[-1,*chgrp][-1,-*] S[-]' \
                     -k "( -c -h -f -R -v --changes --no-dereference --silent
                           --quiet --recursive --verbose --help --version )" \
            - 'p[1],C[-1,-*]' -k __groups -- chgrp

function __conf () {
  reply=($(./configure --help |
          sed -n -e '/-\(FEATURE\|PACKAGE\)/d' \
                 -e 's/^[ 	]\+--\([^[ 	,=]*\)\(,[ 	]*\([^ 	,=]*\)\)\?.*/--\1 \3/p'))
                 #-e 's/^[ 	]\+--\([^[ 	,=]*\).*/--\1/p'))
}
compctl -qQS= -K __conf -x 'n[-1,=]' -f -- configure

if [ -x /usr/ucb/ps ] ; then
  alias ps=/usr/ucb/ps
fi

if [ "$host" = "earth" ]; then
  watch=(aarons ats lsm meek jake pfriedel bofh
         pfingst lungfish j_schrab root )

  # Limit username completion to users in $watch
  compctl -Tx  'C[0,*/*]' -f - 's[~]' -k watch -S/

  compctl -f -x 'C[-1,*chown][-1,-*] S[-]' \
                       -k "( -c -h -f -R -v --changes --no-dereference --silent
                             --quiet --recursive --verbose --help --version )" \
              - 'p[1] N[1,.:],C[-1,-*] N[1,.:]' -k __groups \
              - 'p[1],C[-1,-*]' -k watch -- chown

  # hash directories of friends so cd completion still works
  for u in $watch
  do
    hash -d $u=~$u
  done

  # cd/pushd completion based on $watch
  compctl -x 'S[/][~][./][../]' -g '*(-/)' - \
    'n[-1,/], s[]' -K __cdmatch -S '/' + -n -k watch -P'~' + -- cd pushd
elif [[ "$ZSH_VERSION[1]" = "3" ]]
then
  # cd/pushd completion for all users
  compctl -x 'S[/][~][./][../]' -g '*(-/)' - \
    'n[-1,/], s[]' -K __cdmatch -S '/' + -nuP'~' + -- cd pushd

  compctl -f -x 'C[-1,*chown][-1,-*] S[-]' \
                       -k "( -c -h -f -R -v --changes --no-dereference --silent
                             --quiet --recursive --verbose --help --version )" \
              - 'p[1] N[1,.:],C[-1,-*] N[1,.:]' -k __groups \
              - 'p[1],C[-1,-*]' -u -- chown

fi

mynames=(aarons bofh root)


if [[ $HOST == *.mx.voyager.net ]]
then
  function mailfile ()
  {
    for u in "$@"
    do
      findmail "$u"
    done
  }
  true
fi

case "$host" in
   "methos")
      path=($path ~slist/.bin)
      ;;

   "grok"|"lafe"|"tamara"|"tanstaafl")
      export http_proxy="http://lafe.schrab.com:3128/"
      export ftp_proxy="http://lafe.schrab.com:3128/"
      ;;

   "faboo")
      if [ -z "$STY" ] && \
        ifconfig | egrep 'inet addr:(169.207.53|192.168.42).' > /dev/null 2>&1
      then
        export http_proxy="http://lafe.schrab.com:3128/"
        export ftp_proxy="http://lafe.schrab.com:3128/"
      else
        unset http_proxy
        unset ftp_proxy
      fi

      export TRNINIT=~/.trn/rc
      export CVSROOT=/home/aarons/.cvsroot
      ;;

   "lazarus")
      export TAPE=/dev/nst0
      export CYRCS=/usr/bin/cyrcs
      export CYSTACKER=/dev/sgc
      export CYLIB=/var/backup/tapes
      ;;

   "pug"|"milamber")
      export TRNINIT=~/.trn/rc
      export CVSROOT=/home/aarons/.cvsroot

      compctl -K __ncftp ncftp
      ;;

   "fnord"|"fnord.guru")
      export TRNINIT=~/.trn/rc
      export CVSROOT=/usr/local/cvsroot

      __rhosts=(greaseslapper) 
      compctl -K __pmlist pm
      compctl -K __ncftp ncftp
      compctl -k __rhosts -x 's[-l],c[-1,-l]' -k mynames -- rlogin
      compctl -k __rhosts -x 'p[2,-1]' -l '' -- rsh
      ;;

   "earth")
      mesg n
      ttyctl -f

      MAIL=$(mailfile)

      alias quota='quota -v'
      alias help='/usr/local/adm/execpc/help'
      alias nx='nice -20 /usr/local/adm/execpc/nx'
      unalias ps   # ps wrapper accepts either BSD or SYSV style options if
                   # not given explicit path

      info=/usr/ftp/pub/info; hash -d info=$info
      mac=/usr/ftp/pub/mac; hash -d mac=$mac
      acct=/usr/local/adm/acct; hash -d acct=$acct
      execpc=/usr/local/adm/execpc; hash -d execpc=$execpc
      gurus=/usr/local/pkg/guru; hash -d gurus=$gurus

      watch=($watch info mac acct execpc gurus)
      ;;
esac

function __sshhosts () {
  local __sshfiles
  local __sshfiles2
  [ -f ~/.ssh/known_hosts ] && __sshfiles="$HOME/.ssh/known_hosts"
  [ -f ~/.ssh/known_hosts2 ] && __sshfiles2="$HOME/.ssh/known_hosts2"
  if [ -z "${__sshfiles}" -a -z "${__sshfiles2}" ]
  then
    reply=()
  else
    reply=( $(sed 's/[, ].*//' ${__sshfiles} ${__sshfiles2} ) )
  fi
}
compctl -K __sshhosts -x 'p[2,-1]' -l '' -- ssh
compctl -K __sshhosts -x 's[-l],c[-1,-l]' -k mynames -- slogin

function __scphosts () {
  local __sshfiles
  local __sshfiles2
  [ -f ~/.ssh/known_hosts ] && __sshfiles="$HOME/.ssh/known_hosts"
  [ -f ~/.ssh/known_hosts2 ] && __sshfiles2="$HOME/.ssh/known_hosts2"
  if [ -z "${__sshfiles}" -a -z "${__sshfiles2}" ]
  then
    reply=()
  else
    reply=( $(sed 's/[, ].*/:/' ${__sshfiles} ${__sshfiles2} ) )
  fi
}
function __scphostsandnames () {
  __scphosts "$@"
  reply=($reply ${^mynames}@)
}
function __scpcomp () {
  local a b h p u reply2
  read -cA a
  read -cn b
  h=${a[$b]%:*}
  p=${a[$b]#*:}
  if [[ ${h%@*} != $h ]]; then
    u="-l ${h%@*}"
  else
    u=""
  fi
  h=${h#*@}
  reply=(`ssh -o 'BatchMode yes' ${=u} $h ls -dF $p\*  2>/dev/null`)
  if [[ ${#reply} -eq 1 ]]; then
    reply2=(`ssh -o 'BatchMode yes' ${=u} $h ls -dF $p\*/\* 2>/dev/null`)
    if [[ ${#reply2} -ne 0 ]]; then
      reply=($reply2)
    fi
  fi
}
compctl -f -K __scphostsandnames \
  -x 'p[1,-1] n[1,:]' -K __scpcomp \
  - 'p[1,-1] n[1,@]' -K __scphosts \
 -- scp

function __hosts () {
  __sshhosts
  reply=($reply $(sed 's/^[0-9. 	]*//' /etc/hosts) )
}

function __ports () {
  reply=($(sed -e 's/#.*//' \
               -e 's,[ 	][0-9][0-9]*/[a-z][a-z]*[ 	], ,' \
             /etc/services))
}

compctl -x \
    'p[1]' -K __hosts - \
    'p[2]' -K __ports \
  -- telnet

compctl -K __hosts ping trt traceroute

compctl -x 'p[1]' -k '(add gencaches showpkg stats dump dumpavail unmet check search show depends pkgnames dotty)' -- apt-cache
compctl -K __debpkgs -x 'p[1]' -k \
  '(update upgrade install source dist-upgrade clean remove autoclean check)' \
  -- apt-get

function __debpkgs {
  if [ -d /var/lib/apt/lists ]
  then
    reply=(`sed -ne 's/^Package: //p' /var/lib/apt/lists/*_Packages`)
  else
    reply=(`sed -ne 's/^Package: //p' /var/state/apt/lists/*_Packages`)
  fi
}

function __cdmatch () {
# Start of cdmatch.
# Save in your functions directory and autoload, then do
# compctl -x 'S[/][~][./][../]' -g '*(-/)' - \
#         'n[-1,/], s[]' -K cdmatch -S '/' -- cd pushd
#
# Completes directories for cd, pushd, ... anything that knows about cdpath
# You do not have to include `.' in your cdpath.
#
# It works properly only if $ZSH_VERSION > 2.6-beta2. For erarlier versions
# it still works if RC_EXPAND_PARAM is not set or when cdpath is empty.
     
   local narg pref cdp
     
   read -nc narg
   read -Ac pref
     
   cdp=(. $cdpath)
   reply=( ${^cdp}/${pref[$narg]%$2}*$2(-/DN^M:t:gs/ /\\\\ /) )
     
   return
}
