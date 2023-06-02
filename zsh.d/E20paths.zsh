typeset -aU path

function set_paths {
  path=(
    ~/bin
    ~/.bin
    ~/.local/bin
    ~/.gem/bin
    ~/.rbenv/shims
    ~/.nodenv/shims
    ~/opt/*/default/bin(/N)
    /opt/homebrew/bin
    /usr/local/lib/ruby/gems/2.5.0/bin
    /usr/local/opt/ruby/bin
    /usr/local/bin
    /usr/kerberos/bin
    /usr/bin
    /bin
    /usr/local/sbin
    /usr/sbin
    /sbin
    /usr/X11/bin
    /usr/games
  )
  export PATH

  if [[ $OSTYPE != darwin* ]]; then
    typeset -aU manpath
    manpath=(
      /usr/local/share/man
      /usr/local/man
      /usr/software/man
      /usr/software/rats/man
      /usr/software/utils/man
      /usr/X11/man
      /usr/share/man
    )
    export MANPATH
  fi

  typeset -TUx LD_LIBRARY_PATH ld_library_path
  ld_library_path=()
}

[[ $SHLVL = 1 ]] && set_paths
:
