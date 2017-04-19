if ( $?prompt ) then
  set path = ($HOME/bin $path)
  bash -c : && exec env -u SHLVL SHELL=`which bash` bash -l
endif

# vim: ft=csh
