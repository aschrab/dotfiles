PROFILE_ZSH_START=no
if [[ "${PROFILE_ZSH_START}" == yes ]]; then
  zmodload zsh/datetime
  setopt PROMPT_SUBST
  PS4='+$EPOCHREALTIME %N:%i> '
  logfile=$(mktemp zsh_profile.XXXXXXXX)
  echo "Logging to $logfile"
  exec 3>&2 2>$logfile
  setopt XTRACE
fi

for zshrc_snipplet in $zshrc_dir/R[0-9][0-9]*.zsh ; do
  source $zshrc_snipplet
done

[ -r $HOME/.zshrc.local ] && source $HOME/.zshrc.local

if [[ "${PROFILE_ZSH_START}" == yes ]]; then
  unsetopt XTRACE
  exec 2>&3 3>&-
fi
