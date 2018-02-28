typeset -g _LAST_ALERT=$HISTCMD

alert_preexec() {
  SECONDS=0
}
preexec_functions+='alert_preexec'

alert_precmd() {
  local last_cmd skip_alert

  if (( _LAST_ALERT < HISTCMD && SECONDS > 5 )); then
    last_cmd=(${(z)history[$[HISTCMD-1]]})
    skip_alert=n

    # Don't beep for commands where exiting is uninteresting
    if [[ $last_cmd[1] == ssh ]] && [[ $#last_cmd = 2 ]]; then
      # Ignore just ssh to host
      skip_alert=y
    elif [[ $last_cmd[1] == sudo ]]; then
      if [[ $#last_cmd == 1 ]]; then
        # No arguments
        skip_alert=y
      elif [[ $#last_cmd == 3 ]] && [[ $last_cmd[2] == -u ]]; then
        # Just specifying user
        skip_alert=y
      fi
    fi

    if [[ $skip_alert == n ]]; then
      echo -n '\a'
    fi
  fi
  _LAST_ALERT=$HISTCMD
}
precmd_functions+='alert_precmd'
