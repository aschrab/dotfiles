#!/bin/zsh -f
# vim: fdm=marker

# reset signal handlers
trap -
bindkey -e
umask 022

export BAUD=0

rcvers='%Date%'
ZSH_MAJOR_VERSION="${${(s:.:)ZSH_VERSION}[0]}"

if [[ "$TERM" == "linux" ]]
then
  case "$OSTYPE:$HOST" in
    linux*:*)
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

# Try making directory, don't care if it fails (may be there already) {{{
mkdir "/tmp/$LOGNAME" >& /dev/null
# On some systems $LOGNAME stays the same across su, so check if TMPDIR for
# non-root user was created by root, and fix it if necessary
if [[ $EUID -eq 0 && "$LOGNAME" != root && -n "`echo /tm[p]/$LOGNAME(Nu0)`" ]]
then
  echo "TMPDIR owned by root, fixing" >&2
  chown "$LOGNAME" "/tmp/$LOGNAME"
fi
# Check the ownership, and make sure the permisisons are correct
if [[ `echo /tmp/$LOGNAME(Nu:$LOGNAME:)` == /tmp/$LOGNAME(/|) ]] &&
   chmod 0700 "/tmp/$LOGNAME" >& /dev/null
then
  export TMPDIR="/tmp/$LOGNAME"
  export TMP="$TMPDIR"
  export TMPPREFIX="$TMPDIR/zsh"
else
  echo "TMPDIR not secure" >&2
  echo "TMPDIR not secure" >&2
  echo "TMPDIR not secure" >&2
fi #}}}

if [[ ,$(grep -c "^$USERNAME:x:$GID:$" /etc/group 2> /dev/null), == ",1,"
      && ",`grep -c :$GID: /etc/passwd 2> /dev/null`," == ",1," ]]
then
  umask 002
fi

#  Set various shell variables
#export host=`print -P %m`

# Set $host by:
# - Split $HOST on '.'
# - Remove $stripdom - 1 portions from the end
# - Rejoin
if [[ "$HOST" = *.local ]]
then
  host=${HOST/.*/}
elif [[ "$HOST" = *.* ]]
then
  stripdom=3
  host=${(j:.:)${(s:.:)HOST}[1,-$stripdom]}
  if [[ -z "$host" ]]
  then
    host="$HOST"
  fi
else
  host="$HOST"
fi
export host

#[ "$USERNAME" = "aarons" -o "$USERNAME" = "root" ] && HOME=~aarons

if [[ -z "$normal" ]]
then
  export   black="%{$(echo -n '\e[0;30m')%}"
  export     red="%{$(echo -n '\e[0;31m')%}"
  export   green="%{$(echo -n '\e[0;32m')%}"
  export  yellow="%{$(echo -n '\e[0;33m')%}"
  export    blue="%{$(echo -n '\e[0;34m')%}"
  export magenta="%{$(echo -n '\e[0;35m')%}"
  export    cyan="%{$(echo -n '\e[0;36m')%}"
  export   white="%{$(echo -n '\e[0;37m')%}"
  export  normal="%{$(echo -n '\e[0;22m')%}"
fi

fColor=$normal
pColor=$green
case "$USERNAME" in
  aarons|ats|aschrab)
    pColor=$cyan
    ;;
  aaron)
    pColor=$magenta
    ;;
  michael|backup|lsm|bofh)
    pColor=$yellow
    ;;
  root|administrator)
    pColor=$red
    ;;
  *)
    pColor=$green
    ;;
esac

export pColor

alias stty='noglob stty'
alias wget='noglob wget'

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

setopt EXTENDED_GLOB

unset LC_CTYPE
# Check if we're on a Unicode terminal {{{
if [[ $ZSH_MAJOR_VERSION -ge 4 ]]; then
# Based on perl script by Jan-Pieter Cornet <johnpc@xs4all.nl>
# http://lists.debian.org/debian-mentors/2003/debian-mentors-200312/msg00144.html
# Converted to zsh with clues from promptnl script that comes with zsh

# Make sure there's no typeahead, or it'll confuse things.  Remove
# this block entirely to use this function in 3.0.x at your own risk.
# {{{
while read -t -k 1
do
  RECV=$RECV$REPLY
done
if [[ -n $RECV ]]
then
  print -z -r -- $RECV
  RECV=''
  REPLY=X
fi #}}}

# Send a sequence that's valid UTF8 and ISO8859-1
# then ask the terminal where the cursor is
stty -echo
print -b -n '\r\xC2\xA4\x1B[6n'

# Wait for reply {{{
integer WAIT=5
integer N=$SECONDS
while [[ $REPLY != R ]] && ((SECONDS - N <= WAIT))
do
    if read -t -k 1
    then
	((N=SECONDS))
	RECV=$RECV$REPLY
    fi
done #}}}

print -b -n '\r' # Clear the test sequence

# Parse the column number out of the terminal response
case ${${RECV#$(print -b -n '\x1B')\[[0-9]##;}%%R} in
2)
  echo "UTF terminal detected"
  LANG=en_US.UTF-8
  ;;
3)
  echo "Non-UTF terminal detected"
  LANG=en_US
  ;;
*)
  echo "Couldn\'t determine terminal encoding"
  ;;
esac
fi
#}}}
export LANG LC_COLLATE="C" LC_TIME="C"

esc=$(print -n "\E")
beep=$(print -n "\C-g")
tty=${TTY##/dev/}
export TTY

case "$TERM" in
  xterm|xtermc|xterm-debian|xterm-color|rxvt-unicode|rxvt|gnome|Eterm)
    if [[ $TERM == xterm && $OSTYPE == freebsd* ]]
    then
      TERM=xterm-color
    fi
    stty erase '^?'
    print -P "${green}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"
    PS1='%{${esc}]1;%(#.#.$)$host$DEBCHROOT${beep}${esc}]2;%(#.#.$)$host$DEBCHROOT($tty):%~${beep}%}'
    PS1="$PS1"'%{$pColor%}%1v%!)$host$DEBCHROOT%(#.#.$)%{$fColor%} '
    RPS1='%{$pColor%} %~%{$fColor%}'
    ;;
  screen*)
    print -P "${yellow}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"
    PS1='%{]1;%(#.#.$)$host$DEBCHROOT]2;n %(#.#.$)$host$DEBCHROOT($tty)!%~k$host$DEBCHROOT%(#.#.$)%.\%}'
    PS1="$PS1"'%{$pColor%}%1v%!)$host$DEBCHROOT%(#.#.$)%{$fColor%} '
    RPS1='%{$pColor%} %~%{$fColor%}'
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
    fColor=$normal
    stty erase '^?'
    print -P "${magenta}%Szsh $ZSH_VERSION, .zshrc $rcvers%s${fColor}"
    PS1='%{$pColor%}%1v%!)$host$DEBCHROOT%(#.#.$)%{$fColor%} '
    RPS1='%{$pColor%} %~%{$fColor%}'

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
  if [ -r $HOME/.Zsh-hist.$host.$PZSH ]; then
    fc -R $HOME/.Zsh-hist.$host.$PZSH
    rm -f $HOME/.Zsh-hist.$host.$PZSH 2> /dev/null
  fi
fi

unset HISTFILE
HISTSIZE=250
export RPS1 HISTSIZE

path=()
manpath=()
ppath=(
  ~/bin
  /usr/local/bin
  /sw/bin
  /sw/sbin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  /usr/X11R6/bin
  /usr/X11/bin
  /usr/share/bin
  /usr/local/pkg/guru
  /usr/local/pkg/dnvs
  /usr/local/adm/voyager
  /usr/local/adm/execpc
  /usr/adm/bin
  /usr/local/pilot/bin
  /usr/ccs/bin
  /usr/ccs/lib
  /usr/games
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

if [[ $ZSH_MAJOR_VERSION -ge 3 ]]; then
  setopt Equals Function_ArgZero Mult_IOs
else
  unsetopt No_Equals
fi

unlimit core

# Have `pwd` show both the real path and what the shell thinks it is {{{
function pwd () {
  local real=`builtin pwd -r`
  if [[ ! -t 1 ]]; then
    # Only output real path when used in backticks.
    echo $real
  elif [[ $real == $PWD ]]; then
    echo $PWD
  else
    echo "$PWD ($real)"
  fi
} #}}}
if egrep --color=auto . /etc/passwd > /dev/null 2>&1; then
	alias grep='egrep --color=auto'
else
	alias grep=egrep
fi
alias ack=ack-grep

export NULLCMD=:
export HISTORY=${ZDOTDIR:=$HOME}/.zsh-history
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
alias les=less
alias lss=less

case "$EDITOR" in
	vim|*/vim)
		alias -g L="| view -"
		;;
	*)
		alias -g L="| $PAGER"
		;;
esac

#export LESS="-aCMj3"
# Don't include -X in $LESS, remove smcups/rmcups settings from terminfo entry
export LESS="-aMej3"
case "$LANG" in
  *[Uu][Tt][Ff]*)
    LESSCHARSET="utf-8"
    ;;
  *)
    LESSCHARSET=latin1
    ;;
esac
export LESSCHARSET

if [[ -n "$(whence ri1.8)" ]]; then
  function ___ri () {
    # Locally tell less to:
    #   -F: quit if the entire file fits on the screen
    #   -f: not complain about binary files
    #   -R: pass through terminal control characters
    local -x LESS="${LESS:?-}FfR"
    ri1.8 -fansi "$@"
  }
  # Turn off globbing for arguments to ri, since glob characters are
  # common in names of ruby methods
  alias ri='noglob ___ri'
fi

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

[[ -z $(whence gcc)    ]] && alias gcc=cc
[[ -n $(whence gsed)   ]] && alias sed=gsed
#[[ -n $(whence gmake)  ]] && alias make=gmake
[[ -n $(whence pinfo)  ]] && alias info=pinfo
[[ -n $(whence screen) ]] && alias screen='screen -a -A'

export HOSTALIASES=~/.hostaliases

alias cls='clear'
alias f=finger
alias sz='sz -e'
alias l='ls -F'
alias la='ls -aF'
if [[ $OSTYPE == *bsd* ]]; then
  alias ll='ls -lhoF'
  alias lla='ls -Foalh'
else
  alias ll='ls -lhF'
  alias lla='ls -halF'
fi
alias bc='bc -ql'
alias trt=traceroute

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

# Change behaviour of insert-last-word widget
# $NUMERIC should be carried over between consecutive invocations
ins-last-word () {
  #echo $LASTWIDGET
  if [[ ${+NUMERIC} == 1 ]]
  then
    insertlastwordsavenumeric=$NUMERIC
  fi

  if [[ $LASTWIDGET == insert-last-word ]]
  then
    if [[ ${+insertlastwordsavenumeric} == 1 ]]
    then
      NUMERIC=${insertlastwordsavenumeric}
    fi
  else
    [[ ${+NUMERIC} == 1 ]] || unset insertlastwordsavenumeric
  fi

  zle .insert-last-word
}

# Add a zle widget to kill last N path components
kpathword () {
  local found neg inword post cur=$CURSOR num=$NUMERIC

  if [[ $num -lt 0 ]]
  then
    neg=1
    num=$((num * -1))
  fi

  while [[ $cur -ge 0 ]]
  do
    case $BUFFER[$cur] in
    ' '|'	')
      if [[ $inword -eq 1 ]]
      then
	break
      else
	post="$BUFFER[$cur]$post"
      fi
      ;;
    /)
      found=1
      if [[ "$inword" -eq 1 ]]
      then
	if [[ $((num -= 1)) -le 0 ]]
	then
	  #cur=$((cur - 1))
	  break
	fi
      fi
      ;;
    *)
      inword=1
      ;;
    esac

    cur=$((cur - 1))
  done

  if [[ $found -eq 1 ]]
  then
    if [[ $neg -eq 1 ]]
    then
      LBUFFER="${LBUFFER[0,$cur]}$post"
      #CURSOR=$((CURSOR - $#post))
    else
      #CURSOR=$((cur + 1))
      CURSOR=$cur
    fi
  fi
}

# bind keys
bindkey \^p up-history
bindkey \^n down-history
bindkey "\e[A" up-line-or-search
bindkey "\eOA" up-line-or-search
bindkey "\eOD" backward-char
bindkey "\eOC" forward-char
bindkey "\e[5D" backward-word  # ctrl + left-arrow
bindkey "\e[5C" forward-word   # ctrl + right-arrow
bindkey "\M-;" copy-prev-word
bindkey "\e;" copy-prev-word
# space (with or without meta) is magic-space
bindkey    "\x20" magic-space
bindkey "\M-\x20" magic-space
bindkey "\e\x20" magic-space
# M-Q pushes all pending lines onto the stack, not just current line
bindkey "\M-q" push-input
bindkey "\eq" push-input
# Autoconvert "~?" -> "~/" since I often hold down the shift key for too long
# when trying to type the latter.
bindkey -s '~?' '~/'

#  Run a few informative commands
if [[ ! -f .hushlogin && -n $PZSH ]]; then
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

export PATH TERM

pw () {
  grep $* /etc/passwd
}

precmd () {
  # Make sure the prompt begins on a new line
  print -nP "%{${red}\$${normal}${(pl:COLUMNS:: ::\r:)}%}"

  if jobs % >& /dev/null; then
    psvar[1]="*"
  else
    psvar[1]=""
  fi
}

ssh () {
  local foo
  local bar
  foo="$argv[$#]"
  # Make sure that keys are loaded into the agent before starting connection
  if [[ -n $SSH_AUTH_SOCK && -n "$(print -n $HOME/.ssh/ID*)" ]]; then
    ssh-add -l || ssh-add $HOME/.ssh/ID* < /dev/null
  fi > /dev/null 2>&1
  if [[ "$foo" = *.* ]]
  then
    stripdom=3
    bar=${(j:.:)${(s:.:)foo}[1,-$stripdom]}
    if [[ -z "$bar" ]]
    then
      bar="$foo"
    fi
  else
    bar="$foo"
  fi
  xtitle "$bar"
  screen-title "$bar"
  command ssh "$@"
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

tz () {
  local t
  t="$1"
  shift
  TZ="$t" "$@"
}

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

mcd () {
  mkdir "$@"
  cd "$argv[-1]"
}

fignore=(.o .bak .swp \~)
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

if [[ $ZSH_MAJOR_VERSION -ge 3 ]]
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

mynames=(ats aarons bofh root)

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
   "grok"|"gir"|"tamara"|"tanstaafl"|"zim")
      PGHOST="atlas"
      ;;
   "frell"|"pug")
      if [[ -n $SSH_CLIENT ]]; then
        echo m | fc -R /proc/self/fd/0
      fi
      ;;
  "psn1")
    PGHOST="verdande"
    PGUSER="enforcer"
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

if [[ ${ZSH_VERSION%%.*} -ge 4 ]]; then
  zle -N insert-last-word ins-last-word
  zle -N kpathword

  zstyle ':completion:*' auto-description 'specify: %d'
  zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _correct _approximate _prefix
  zstyle ':completion:*' completions 'NUMERIC==3'
  zstyle ':completion:*' format "${blue}%SCompleting %d%s${fColor}"
  zstyle ':completion:*' glob 'NUMERIC==1'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*' ignore-parents parent pwd
  zstyle ':completion:*' insert-unambiguous true
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
  zstyle ':completion:*' match-original both
  zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=** r:|=**'

  # Allow one error for every 3 characters typed.
  zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

  zstyle ':completion:*' menu select=10
  zstyle ':completion:*' original true
  zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
  zstyle ':completion:*' substitute 'NUMERIC==2'
  zstyle ':completion:*' ignored-patterns 'doc-base'
  zstyle :compinstall filename $HOME/zcomp

  autoload -U compinit
  compinit -u

  zstyle -e ':completion:*:hosts' hosts __hosts
  zstyle -e ':completion:*:complete:ssh:*:hosts' hosts __sshhosts
  #zstyle ':completion:*:my-accounts' users-hosts $my_accounts
  zstyle -e ':completion:*:my-accounts' users-hosts __ssh_users

  # Don't complete "CVS" or "lost+found" directories
  zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS' '(*/)#lost+found'
  zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS' '(*/)#lost+found'


  # Try to avoid completion functions when completing command names.
  zstyle ':completion:*:commands' ignored-patterns '_*'

  if [[ $USER == 'root' ]]; then
    # Display all processes
    zstyle ':completion:*:*:*:*:processes' 'command' 'ps ax'
  else # Display all of current user's processes.
    zstyle ':completion:*:*:*:*:processes' 'command' 'ps -u$USER'
  fi

  # Display list of processes even if there's only one match
  zstyle ':completion:*:*:*:*:processes' menu yes select
  zstyle ':completion:*:*:*:*:processes' force-list always

  # Color process list in ps completion
  zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

  __ssh_users () {
    local shosts
    local h
    __sshhosts
    shosts=( $reply )
    reply=( )
    for h in $shosts
    do
      reply=( $reply "ats@$h" )
    done
  }

  # doc function to display docs for a package, with completion
  if [[ -d /doc ]]; then
    doc() { cd /doc/$1 && ls }
    _doc() { _files -W /doc -/ }
  else
    doc() { cd /usr/share/doc/$1 && ls }
    _doc() { _files -W /usr/share/doc -/ }
  fi
  compdef _doc doc

  bindkey "\M-/" kpathword
  bindkey "\e/" kpathword
fi

if [[ -r ~/.zshrc.local ]]; then
  . ~/.zshrc.local
fi
