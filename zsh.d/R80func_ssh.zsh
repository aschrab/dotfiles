# vim: ft=zsh

ssh () {
  local foo
  local bar
  foo="$argv[$#]"
  # Make sure that keys are loaded into the agent before starting connection
  if [[ -n $SSH_AUTH_SOCK && -n "$(print -n $HOME/.ssh/ID*)" ]]; then
    ssh-add -l || ssh-add $HOME/.ssh/ID* < /dev/null
  fi > /dev/null 2>&1
  if [[ "$foo" = *.* ]]
  then
    stripdom=3
    bar=${(j:.:)${(s:.:)foo}[1,-$stripdom]}
    if [[ -z "$bar" ]]
    then
      bar="$foo"
    fi
  else
    bar="$foo"
  fi
  xtitle "$bar"
  screen-title "$bar"
  command ssh "$@"
}
