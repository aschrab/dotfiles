#!/bin/csh
# Above is to get ALE to use correct shell for syntax checking

# Check if shell is interactive
if ( $?prompt ) then
  # Add my bin directory to path
  set path = ($HOME/bin $path)

  # Check for better shells, prefer zsh but settle for bash
  foreach shell ( zsh bash )
    # Ask shell to run `:` (aka `true`) to see if its found and works.
    # If that succeeds, invoke it as a login shell to replace the csh process.
    # Unset $SHLVL and set $SHELL to point to the new binary.
    $shell -c : >& /dev/null && exec env -u SHLVL SHELL=`which $shell` $shell -l
  end
endif

# vim: ft=csh
