#!/bin/zsh -f

# reset signal handlers
trap -
bindkey -em
umask 077

export BAUD=0

rcvers='$Revision: 1.10 $'
rcvers=$rcvers[(w)2]

if [[ "$TERM" == "linux" ]]
then
  case "$OSTYPE:$HOSTNAME" in
    linux:*.schrab.com)
      ;;
    linux:fnord.guru.execpc.com)
      ;;
    *)
      TERM=vt100
      ;;
  esac
fi

# Try making directory, don't care if it fails (may be there already
mkdir "/tmp/$LOGNAME" >& /dev/null
# Now try changing the permissions; if this works, it should be safe
if chown "$LOGNAME" "/tmp/$LOGNAME" >& /dev/null &&
   chmod 0700 "/tmp/$LOGNAME" >& /dev/null
then
  export TMPDIR="/tmp/$LOGNAME"
  TMPPREFIX="$LOGNAME/zsh"
else
  echo "TMPDIR not secure" >&2
  echo "TMPDIR not secure" >&2
  echo "TMPDIR not secure" >&2
fi

#  Set various shell variables
export host=`print -P %m`
# if [[ ${#host} -le 4 && $host != grok ]]
# then
#   host=${(M)HOST##[a-z0-9-]##.[a-z0-9-]##}
# fi

[ "$USERNAME" = "aarons" -o "$USERNAME" = "root" ] && HOME=~aarons

if [[ -z "$pColor" ]]
then
  export red="%{$(echo -n '\e[0;31m')%}"
  export white="%{$(echo -n '\e[0;37m')%}"
  export blue="%{$(echo -n '\e[0;34m')%}"
  export green="%{$(echo -n '\e[0;32m')%}"
  export yellow="%{$(echo -n '\e[0;33m')%}"
  export magenta="%{$(echo -n '\e[0;35m')%}"
  export cyan="%{$(echo -n '\e[0;36m')%}"
fi

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
  xterm|xtermc|xterm-color)
    TERM=xterm
    stty erase '^H'
    print -P "${green}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${white}"
    PS1='%{]1;%(#.#.$)$host]2;%(#.#.$)$host:%~%}'
    PS1="$PS1"'%{$pColor%}%1v%!)$host%(#.#.$)%{$white%} '
    RPS1='%{$pColor%} %~%{$white%}'
    ;;
  linux)
    stty erase '^?'
    print -P "${magenta}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${white}"
    PS1='%{$pColor%}%1v%!)$host%(#.#.$)%{$white%} '
    RPS1='%{$pColor%} %~%{$white%}'
    ;;
  *)
    stty erase '^H' kill '^X'
    print -P "%U%Szsh $ZSH_VERSION, .zshrc $rcvers%s%u"
    PS1='%U%1v%!)%(#..%u)$host%(#.#.$)%(#.%u.) '
    RPS1='%U%~%u'
    ;;
esac

unset MAIL  # set it later in host specific portion
unset MAILCHECK

if [[ -n $PZSH ]]; then
  if [[ -n $PPWD && -d $PPWD ]]; then
    # cd to directory parent shell was in (see su function)
    cd $PPWD
  fi
  if grep '^aarons:' /etc/passwd > /dev/null 2>&1; then
    if [ -r ~aarons/.Zsh-hist.$host.$PZSH ]; then
      fc -R ~aarons/.Zsh-hist.$host.$PZSH
      rm -f ~aarons/.Zsh-hist.$host.$PZSH
    fi
  fi
fi

HISTSIZE=250
manpath=(/usr/man /usr/local/man/ /usr/X11/man $HOME/man)
export PS1 RPS1 HISTSIZE

path=()
ppath=(
  ~/bin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  /etc
  /usr/ccs/bin
  /usr/ccs/lib
  /usr/X11R6/bin
  /usr/X11/bin
  /usr/openwin/bin
  /usr/local/pkg/guru
  /usr/local/pkg/dnvs
  /usr/local/adm/execpc
  /usr/adm/bin
)

for d in $ppath
do
  if [[ -d $d ]]
  then
    path=($path $d)
  fi
done
unset ppath d

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

export NULLCMD=:
export HISTORY=${ZDOTDIR:=$HOME}/.zsh-history
export EDITOR=$(whence vim)
export VISUAL=${EDITOR:=$(whence vi)}
export CVS_RSH=ssh
export MPAGE="-2m50t"
export COLORFGBG='default;default'

if [ -r /etc/libsocks5.conf ]; then
  export NNTPSERVER=socks.execpc.com
else
  export NNTPSERVER=news.execpc.com
fi

PAGER=$(whence less)
if [ -n "$PAGER" ]; then
  PAGER="less"
  export LESS="-aCMj3"
else
  PAGER="more"
fi
alias less=$PAGER

# Set aliases
if [[ "$TERM" != "emacs" && $OSTYPE != *bsd* ]]; then
  if ls --color=tty / >/dev/null 2>&1; then
    alias ls='ls --color=tty'
    LS_COLORS="di=34:ex=32:ln=35:so=33:bd=0:cd=0"
    LS_COLORS="${LS_COLORS}:*.zip=33:*.rpm=33:*.tar=33:*.tgz=33:*.gz=33"
    LS_COLORS="${LS_COLORS}:*.bz2=33:*.Z=33"
    export LS_COLORS
  fi
fi

export HOSTALIASES=~/.hostaliases

alias cls='clear'
alias f=finger
alias sz='sz -e'
alias l='ls -F'
alias ll='ls -lF'
alias la='ls -aF'
alias lla='ls -alF'
alias trt=traceroute

alias vi=$VISUAL

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

if [[ -n $(whence rtraceroute) ]]; then
  alias ro=rtraceroute
else
  alias ro=traceroute
fi

if [[ $OSTYPE == solaris2* ]]; then
  alias ping='ping -s'
fi


# bind keys
bindkey \^p up-history
bindkey \^n down-history
bindkey '\e[A' up-line-or-search
bindkey '\M-i' copy-prev-word
# space (with or without meta) is magic-space
bindkey    '\x20' magic-space
bindkey '\M-\x20' magic-space

#  Run a few informative commands
if [ ! -f .hushlogin ]; then
  case "$OSTYPE" in
  linux|openbsd*)
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

# shell functions
if [ -d $HOME/.fbin ]; then
  fpath=($HOME/.fbin)
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

su () {
  if [ $# -eq 0 ] ; then
        tmpfile=~aarons/.Zsh-hist.$host.$$
        fc -ln -10 -1 >! $tmpfile 2> /dev/null
        export PPWD=$PWD  # Save current directory,
        cd /              # cd to / so su isn't running in a mounted filesystem
        if [[ $OSTYPE == solaris* ]] ; then
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

fignore=(.o .bak .swp \~)
compctl -g '*' -x 'S[.]','C[0,*/.*]' -g '*(D)' -- rm
compctl -g '*(-/)' + -g '.*(-/)' + -k '(..)' cd rmdir
compctl -jP '%' kill fg bg disown
compctl -vP '$' echo
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

compctl -f -x 'C[-1,*chown][-1,-*] S[-]' \
                     -k "( -c -h -f -R -v --changes --no-dereference --silent
                           --quiet --recursive --verbose --help --version )" \
            - 'N[1,.:]' -k __groups \
            - 'p[1],C[-1,-*]' -u -- chown

if [ -x /usr/ucb/ps ] ; then
  alias ps=/usr/ucb/ps
fi

if [ "$host" = "earth" ]; then
  watch=(aarons meek jake mitch pfriedel bofh
         pfingst lungfish j_schrab chilli)

  # Limit username completion to users in $watch
  compctl -Tx  'C[0,*/*]' -f - 's[~]' -k watch -S/

  # hash directories of friends so cd completion still works
  for u in $watch; hash -d $u=~$u

  # cd/pushd completion based on $watch
  compctl -x 'S[/][~][./][../]' -g '*(-/)' - \
    'n[-1,/], s[]' -K __cdmatch -S '/' + -n -k watch -P'~' + -- cd pushd
elif [[ "$ZSH_VERSION[1]" = "3" ]]
then
  # cd/pushd completion for all users
  compctl -x 'S[/][~][./][../]' -g '*(-/)' - \
    'n[-1,/], s[]' -K __cdmatch -S '/' + -nuP'~' + -- cd pushd
fi

mynames=(aarons bofh root)


case "$host" in
   "methos")
      path=($path ~slist/.bin)
      ;;

   "lazarus")
      export TAPE=/dev/nst0
      export CYRCS=/usr/bin/cyrcs
      export CYSTACKER=/dev/sgc
      export CYLIB=/var/backup/tapes
      ;;

   "fnord"|"fnord.guru")
      export TRNINIT=~/.trnrc
      export CVSROOT=/usr/local/cvsroot

      __rhosts=(greaseslapper) 
      compctl -K __pmlist pm
      compctl -K __ncftp ncftp
      compctl -k __rhosts -x 's[-l],c[-1,-l]' -k mynames -- rlogin
      compctl -k __rhosts -x 'p[2,-1]' -l '' -- rsh

      if [ "$USERNAME" = "root" ]; then
         alias ipxon='ipx_interface add -p eth0 802.2'
         alias ipxoff='ipx_interface delall'
      fi
      ;;

   "earth")
      mesg n
      stty erase '^H'
      ttyctl -f

      MAIL=$(mailfile)

      alias quota='quota -v'
      alias help='/usr/local/adm/execpc/help'
      alias nx='nice -20 /usr/local/adm/execpc/nx'
      alias lu=lookup
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
  reply=( $(awk '{ print $1 }' ~/.ssh/known_hosts) )
}
compctl -K __sshhosts -x 'p[2,-1]' -l '' -- ssh
compctl -K __sshhosts -x 's[-l],c[-1,-l]' -k mynames -- slogin

function __scphosts () {
  reply=( $(awk '{ print $1 ":" }' ~/.ssh/known_hosts) )
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
