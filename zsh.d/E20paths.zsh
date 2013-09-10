typeset -aU path
path=(
  ~/bin
  /usr/software/bin
  /usr/software/rats/bin
  /usr/software/utils/bin
  /usr/kerberos/bin
  /usr/local/bin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  /usr/X11/bin
)

typeset -aU manpath
manpath=(
  /usr/software/man
  /usr/software/rats/man
  /usr/software/utils/man
  /usr/local/man
  /usr/X11/man
  /usr/share/man
)

export PATH MANPATH
