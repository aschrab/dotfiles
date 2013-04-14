typeset -g _LAST_ALERT=$HISTCMD

alert_preexec() {
  SECONDS=0
}
preexec_functions+='alert_preexec'

alert_precmd() {
  (( _LAST_ALERT < HISTCMD && SECONDS > 5 )) && echo -n '\a'
  _LAST_ALERT=$HISTCMD
}
precmd_functions+='alert_precmd'
