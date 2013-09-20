typeset -aU path
path=(
  ~/bin
  ~/.gem/bin
  /usr/local/bin
  /usr/software/bin
  /usr/software/rats/bin
  /usr/software/utils/bin
  /usr/kerberos/bin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  /usr/X11/bin
)

typeset -aU manpath
manpath=(
  /usr/local/man
  /usr/software/man
  /usr/software/rats/man
  /usr/software/utils/man
  /usr/X11/man
  /usr/share/man
)

if [[ -d /usr/software/lib ]]
then
  typeset -TUx LD_LIBRARY_PATH ld_library_path
  ld_library_path=(
    /usr/software/lib
  )
fi

export PATH MANPATH
