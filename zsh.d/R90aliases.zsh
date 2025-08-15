() {
  local git=git
  if (( $+commands[hub] )); then
    git=hub
    alias git=hub
  fi
  alias g=$git
  alias gi=$git
}
alias stty='noglob stty'
alias wget='noglob wget'
alias man='noglob man'

() {
  local v
  for v in ri ri1.8 ri1.9; do
    if [[ -n "$(whence $v)" ]]; then
      alias $v='LESS="$LESS -fR"'" noglob command $v -fansi"
    fi
  done
}

# Only the initial arguments to `find` should use globbing.
#
# Use alias to turn off globbing, then use function to explicitly do globbing
# on arguments before the first one that starts with a dash.
#
# This allows using patterns to specify paths to search, but doesn't require
# pattern characters to be quoted in the match criteria.
alias find='noglob find'
'find'() {
  integer i=${argv[(i)(\(|-*)]}
  command find ${~argv[1,i-1]} "${(@)argv[i,-1]}"
}

case "$EDITOR" in
  (*/|)(n|)vim(x|))
    alias page="view -"
    ;;
  *)
    alias page="$PAGER"
    ;;
esac
alias p=page

alias les=less
alias lss=less

if egrep --color=auto . /etc/passwd > /dev/null 2>&1; then
	alias grep='egrep --color=auto'
else
	alias grep=egrep
fi

if (( $+commands[ack-grep] )); then
  if (( $+commands[ack] )) && [[ $(ack) == *PATTERN* ]]; then
    :
  else
    alias ack=ack-grep
  fi
fi

alias cls='clear'
alias sz='sz -e'
alias l='ls -HF'
alias la='ls -aHF'
case "$OSTYPE" in
  (*bsd*|darwin*)
    alias ll='ls -lhoF'
    alias lla='ls -Foalh'
    ;;
  (*)
    alias ll='ls -lhF'
    alias lla='ls -halF'
    ;;
esac
alias bc='/usr/bin/bc -ql'
alias trt=traceroute

[ -x /usr/lib/sendmail ] && alias sendmail=/usr/lib/sendmail
[ -x /usr/ucb/ps ] && alias ps=/usr/ucb/ps

[[ -z $(whence gcc)    ]] && alias gcc=cc
[[ -n $(whence gsed)   ]] && alias sed=gsed
#[[ -n $(whence gmake)  ]] && alias make=gmake
[[ -n $(whence pinfo)  ]] && alias info=pinfo
[[ -n $(whence screen) ]] && alias screen='screen -a -A'
[[ -n $(whence htop) ]] && alias top=htop

() {
  local LS
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
}

() {
  # Prefer GNU versions of some commands
  local cmds=(
    ln # for --relative
    rmdir # for --parents & --ignore-fail-on-non-empty
    date # Default Mac OS version of this is awful
    tar
  )
  local cmd
  for cmd in $cmds; do
    if ! alias "$cmd" >/dev/null; then
      command -v "g$cmd" >/dev/null && alias $cmd="g$cmd"
    fi
  done
}

# Tell rcsdiff to checkout revisions without putting in version numbers
alias rcsdiff='rcsdiff -kk'

if [[ $OSTYPE == solaris2* ]]; then
  alias ping='ping -s'
fi

# Version of vared to edit array variables with each element on a separate line
alias lvared="IFS=\$'\n\n' vared"

alias magit="vim -c MagitOnly"

(( $+commands[http] )) && alias https='http --default-scheme=https'

alias be='bundle exec'
alias pnpmx='pnpm dlx'

if (( $+commands[git] )); then
  alias diff='git diff --no-index -W --no-prefix'
else
  alias diff='diff -u'
fi
