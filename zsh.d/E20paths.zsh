typeset -aU path

path=(
  ~/bin
  ~/.gem/bin
  ~/.rbenv/shims
  ~/.ndenv/shims
  /usr/local/bin
  /usr/kerberos/bin
  /usr/bin
  /bin
  /usr/local/sbin
  /usr/sbin
  /sbin
  /usr/X11/bin
)
export PATH

if [[ $OSTYPE != darwin* ]]; then
  typeset -aU manpath
  manpath=(
    /usr/local/share/man
    /usr/local/man
    /usr/X11/man
    /usr/share/man
  )
  export MANPATH
fi

typeset -TUx LD_LIBRARY_PATH ld_library_path
ld_library_path=()
