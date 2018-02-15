if ( $?prompt ) then
  set path = ($HOME/bin $path)
  foreach shell ( zsh bash )
    $shell -c : >& /dev/null && exec env -u SHLVL SHELL=`which $shell` $shell -l
  end
endif

# vim: ft=csh
