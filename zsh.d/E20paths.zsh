typeset -aU path

# Hack, on this host need to use /usr/bin/vim because one in /usr/software/bin
# is broken.  But on other hosts, copy in /usr/bin is hopelessly outdated.
[[ $host == scmrtp02 ]] && early_usr_bin=/usr/bin

path=(
  ~/bin
  ~/.gem/bin
  /usr/local/bin
  $early_usr_bin
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

unset early_usr_bin

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
