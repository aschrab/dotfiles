typeset -aU path

function set_paths {
  path=(
    ~/bin
    ~/.bin
    ~/.local/bin
    ~/.gem/bin
    ~/.rbenv/shims
    ~/.nodenv/shims
    ~/.cargo/bin
    ~/.pyenv/bin
    ~/opt/*/default/bin(/N)
    /opt/homebrew/bin
    /Applications/Xcode.app/Contents/Developer/usr/bin
    /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin
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

  typeset -TUx LD_LIBRARY_PATH ld_library_path
  ld_library_path=()
}

[[ $SHLVL = 1 ]] && set_paths
:
