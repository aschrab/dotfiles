alias g=git
alias gi=git
alias stty='noglob stty'
alias wget='noglob wget'

for v in ri ri1.8 ri1.9; do
  if [[ -n "$(whence $v)" ]]; then
    alias $v='LESS="$LESS -fR"'" noglob command $v -fansi"
  fi
done

# Avoid epoll bug in libevent
# Without this commands where stderr is redirected to /dev/null hang
# http://sourceforge.net/mailarchive/message.php?msg_id=28004727
# But with versions of libevent < 2.0 this exposes an even worse bug
if [[ -n $(whence tmux) ]] && ! ldd =tmux | fgrep -q libevent-1.
then
  alias tmux="EVENT_NOEPOLL=1 command tmux"
fi

case "$EDITOR" in
	vim|*/vim)
		alias -g L="| view -"
		;;
	*)
		alias -g L="| $PAGER"
		;;
esac

alias les=less
alias lss=less

if egrep --color=auto . /etc/passwd > /dev/null 2>&1; then
	alias grep='egrep --color=auto'
else
	alias grep=egrep
fi
alias ack=ack-grep

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
[ -x /usr/ucb/ps ] && alias ps=/usr/ucb/ps

[[ -z $(whence gcc)    ]] && alias gcc=cc
[[ -n $(whence gsed)   ]] && alias sed=gsed
#[[ -n $(whence gmake)  ]] && alias make=gmake
[[ -n $(whence pinfo)  ]] && alias info=pinfo
[[ -n $(whence screen) ]] && alias screen='screen -a -A'
[[ -n $(whence htop) ]] && alias top=htop

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

# Tell rcsdiff to checkout revisions without putting in version numbers
alias rcsdiff='rcsdiff -kk'

if [[ $OSTYPE == solaris2* ]]; then
  alias ping='ping -s'
fi

# Version of vared to edit array variables with each element on a separate line
alias lvared="IFS=\$'\n' vared"
